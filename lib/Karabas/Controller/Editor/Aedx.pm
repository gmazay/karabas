package Karabas::Controller::Editor::Aedx;
use Mojo::Base 'Karabas::Controller::Editor::Base';
use Mojo::JSON 'from_json';

#use Data::Dumper;

sub get {
    my ($self, $c, $params, $cp) = @_;
    my $var = +{}; my $data = +{};
    
    my($key_column, $editor, $table) = split(/,/,$cp->{editor});
    
    my $xep = $c->model->get_aedx_params( $cp->{id} );
  
    # extract columns from query 'q_select'
    my $cln =$1 if $xep->{q_select} =~ /select(.+?)from.+/igs;
    $cln=~s/as\s\w+[,\s]|distinct//igs;
    @{$data->{names}} = $cln =~ /[,\s]([\.\w\(\)-]+?)[,\s]/gs; 

    $cp->{colnames} = [ split(',',$cp->{colnames}) ] if $cp->{colnames};
    
    if ( $cp->{var} =~ /^\"/ ){
        eval { $var = from_json "{ $cp->{var} }" };
        $var = +{error => $@->message} if ref $@;
        
        if ( defined $var->{select_fields} ){
            foreach my $sf ( keys %{$var->{select_fields}} ){
                $var->{select_fields}->{$sf}->{data} = $c->model($cp->{dsn})->get_table_columns( $var->{select_fields}->{$sf}, $cp->{dsn} );
            }
        }
    }
    
    if ( $xep->{var} =~ /^\"/ ){
        my $xvar = +{};
        eval { $xvar = from_json "{ $xep->{var} }"; %$var = ( %$var, %$xvar ); };
        $var = +{error => $@->message} if ref $@;        
    }
    
    $var->{auto_increment} = $c->model($cp->{dsn})->get_auto_increment($table, $cp->{dsn});
   
    $data->{data} = $c->model($cp->{dsn})->get_query_row_array( $xep->{q_select}, $params->{i}, $cp->{dsn} );
    if(ref $data->{data} eq 'HASH'){ $c->err($data->{data}->{error}); return; }
    
    if( defined $var->{subquery} ){
        $data->{sq} = $c->model($cp->{dsn})->get_subqueryes( $cp->{id}, $params->{i}, undef, $cp->{dsn} );
        if (defined $data->{sq}->[0]->{error} ){ $c->err( $data->{sq}->[0]->{error}); return; }
    }
    
    $data->{uid} = $c->session('id');

    
    $c->stash(params => $params);  # params
    $c->stash(var => $var);        # variables (from json)
    $c->stash(cp => $cp);          # chapter parameters
    $c->stash(xep => $xep);        # extended editor parameters
    $c->stash(result => $data);    # row from chapter data (@names,@data)
    $c->render('aedx');
    return 0;
}

sub post {
    my ($self, $c, $params, $cp) = @_;
    my $acl = $c->session('acl');
    my $uid = $c->session('id');
    my $var = +{}; my $i_id = 0; my $log=''; my $log_str='';
    
    my $xep = $c->model->get_aedx_params( $cp->{id} );
    
    if ( $cp->{var} =~ /^\"/ ){
        eval { $var = from_json "{ $cp->{var} }" };
        $var = +{error => $@->message} if ref $@;
    }
    if ( $xep->{var} =~ /^\"/ ){
        my $xvar = +{};
        eval { $xvar = from_json "{ $xep->{var} }"; %$var = ( %$var, %$xvar ); };
        $var = +{error => $@->message} if ref $@;        
    }
    
    if ( $cp->{log} && defined $c->cfg->{log_table}) { $log = $c->cfg->{log_table}; $log = $var->{logtable} if defined $var->{logtable}; }
    
    my ($key_column, $editor, $table) = split(/,/,$cp->{editor});

    my @qins; my @qdel=(); my @qchk=();    
    if ( defined $xep->{q_insert} ){
        $xep->{q_insert} =~ s/\$ID/$params->{i}/g;
        $xep->{q_insert} =~ s/\$MODERID/$uid/g;
        $xep->{q_insert} =~ s/\$QID/$params->{qid}/g;
        $xep->{q_insert} =~ s/\$MODERID/$uid/g;
        @qins = split( /;[\s\n\r]*/, $xep->{q_insert} ) ;    
    }
    if ( defined $xep->{q_delete} ){    
        $xep->{q_delete} =~ s/\$ID/$params->{i}/g;
        @qdel = split( /;[\s\n\r]*/, $xep->{q_delete} );
    }
    if ( defined $xep->{q_check} ){    
        $xep->{q_check} =~ s/\$ID/$params->{i}/g;    
        @qchk = split( /;[\s\n\r]*/, $xep->{q_check} );
    }


    my @cl=(); my $cont=0;
    if ( $params->{quetype} eq "1" ){
        
        $xep->{q_update} =~ s/\$ID/$params->{i}/g;
        my @qupd = split( /;[\s\n\r]*/, $xep->{q_update} );
        
        my $old_data = $c->model($cp->{dsn})->get_old_query_data($xep->{q_select}, $params->{i}, undef, $cp->{dsn});

        if( $cp->{a_update}==0 || ($cp->{a_update}>1 && $acl<3) || ($cp->{a_update}>2 && $acl<4) ){
            $c->err("У вас нет доступа на изменение данных");
            $c->log->warn( "Update attempt is rejected: user:".$c->session('id').", chapter:$cp->{id}" );
            return;
        }
        
        $log_str = $c->model($cp->{dsn})->aedx_update(
                                                      queryes_upd => \@qupd,
                                                      queryes_ins => \@qins,
                                                      queryes_del => \@qdel,
                                                      queryes_chk => \@qchk,
                                                      old_data    => $old_data,
                                                      key_column  => $key_column,
                                                      params      => $params,
                                                      var         => $var,
                                                      dsn         => $cp->{dsn},
                                                      log         => $log
                                                    );
        
        if ($var->{debug} || $log_str =~/^ABORT/){ $c->err( $log_str, 1 ); return; }

        $i_id = $params->{i};
    }
    else {
        if( $cp->{a_insert}==0 || ($cp->{a_insert}>1 && $acl<3) || ($cp->{a_insert}>2 && $acl<4) ){
            $c->err("У вас нет доступа на добавление данных");
            $c->log->warn( "Insert attempt is rejected: user: $uid, chapter: $cp->{id}" );
            return;
        }
        
        ($i_id, $log_str) = $c->model($cp->{dsn})->aedx_insert(
                                                      queryes_ins => \@qins,
                                                      queryes_del => \@qdel,
                                                      queryes_chk => \@qchk,
                                                      key_column  => $key_column,
                                                      params      => $params,
                                                      var         => $var,
                                                      dsn         => $cp->{dsn},
                                                      log         => $log
                                                    );
        
        if ($var->{debug} || $log_str =~/^ABORT/){ $c->err( $log_str, 1 ); return; }

    }
   
    my $new_row = $c->model($cp->{dsn})->get_qdb_row_array(
                                                      qdb        => $cp->{qdb},
                                                      table      => $table,
                                                      key_column => $key_column,
                                                      i_id       => $i_id,
                                                      dsn        => $cp->{dsn}
                                                    );
    
    $c->model($cp->{dsn})->write_log(
                                                      log_table  => $log,
                                                      log_str    => $log_str,
                                                      i_id       => $i_id,
                                                      qid        => $cp->{id},
                                                      uid        => $c->session('id')
                                    ) if $log_str;
    $c->log->info( "user:".$c->session('id').", chapter:$cp->{id}, action:$log_str" ) if $log_str;
    
    $c->stash(result => $new_row);
    $c->render('aedx_w');
    return 0;
}

1;
