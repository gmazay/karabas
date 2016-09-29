package Karabas::Controller::Editor::Subed;
#use lib 'lib';
use Mojo::Base 'Karabas::Controller::Editor::Base';
use Mojo::JSON 'from_json';

sub get {
    my ($self, $c, $params, $cp, $data) = @_;
    my $var = +{};
    
    if ( $data->{var} =~ /^\"/ ){
        my $xvar = +{};
        eval { $xvar = from_json "{ $data->{var} }"; };
        $var = +{error => $@->message} if ref $@;
        
         if ( defined $xvar->{select_fields} ){
            foreach my $sf ( keys %{$xvar->{select_fields}} ){
                $xvar->{select_fields}->{$sf}->{data} = $c->model($cp->{dsn})->get_table_columns( $xvar->{select_fields}->{$sf}, $cp->{dsn} );
            }
        }
       %$var = ( %$var, %$xvar );
    }
    
    $data->{uid} = $c->session('id');

    
    $c->stash(params => $params);  # params
    $c->stash(var => $var);        # variables (from json)
    $c->stash(cp => $cp);          # chapter parameters
    $c->stash(result => $data);    # hashref: sq parameters + (@names, @inames, @data)
    $c->render('subed');
    return 0;
}

sub post {
    my ($self, $c, $params, $cp, $data) = @_;
    my $acl = $c->session('acl');
    my $uid = $c->session('id');
    my $var = +{}; my $i_id = 0; my $log=''; my $log_str='';
    
    if ( $cp->{log} && defined $c->cfg->{log_table}) { $log = $c->cfg->{log_table}; $log = $var->{logtable} if defined $var->{logtable}; }
    
    if ( $data->{var} =~ /^\"/ ){
        my $xvar = +{};
        eval { $xvar = from_json "{ $data->{var} }"; };
        $var = +{error => $@->message} if ref $@;
        
         if ( defined $xvar->{select_fields} ){
            foreach my $sf ( keys %{$xvar->{select_fields}} ){
                $xvar->{select_fields}->{$sf}->{data} = $c->model($cp->{dsn})->get_table_columns( $xvar->{select_fields}->{$sf}, $cp->{dsn} );
            }
        }
       %$var = ( %$var, %$xvar );
    }
    
    my @qins; my @qdel=(); my @qchk=();
    
    if (defined $data->{q_insert} ){
        $data->{q_insert} =~ s/\$ID/$params->{i}/g;
        $data->{q_insert} =~ s/\$QID/$params->{qid}/g;
        $data->{q_insert} =~ s/\$MODERID/$uid/g;
        @qins = split( /;[\s\n\r]*/, $data->{q_insert} ) ;    
    }
    if (defined $data->{q_delete} ){    
        $data->{q_delete} =~ s/\$ID/$params->{i}/g;
        @qdel = split( /;[\s\n\r]*/, $data->{q_delete} );
    }
    if (defined $data->{q_check} ){    
        $data->{q_check} =~ s/\$ID/$params->{i}/g if defined $data->{q_check};    
        @qchk = split( /;[\s\n\r]*/, $data->{q_check} ) if defined $data->{q_check};
    }

    my @cl=(); my $cont=0;
    if ( $params->{rid} ) {        
        $data->{q_update} =~ s/\$ID/$params->{i}/g;
        $data->{q_update} =~ s/\$QID/$params->{qid}/g;
        $data->{q_update} =~ s/\$MODERID/$uid/g;
        my @qupd = split( /;[\s\n\r]*/, $data->{q_update} );
        
        my $qdb = $data->{query_s} ? $data->{query_s} : $data->{query};
        my $old_data = $c->model($cp->{dsn})->get_old_query_data( $qdb, $params->{i}, $params->{rid}, $cp->{dsn} );

        if( $cp->{a_update}==0 || ($cp->{a_update}>1 && $acl<3) || ($cp->{a_update}>2 && $acl<4) ){
            $c->err("You do not have access to update this chapter!");
            $c->log->warn( "Update attempt is rejected: user:".$c->session('id').", chapter:$cp->{id}" );
            return;
        }
        
        $log_str = $c->model($cp->{dsn})->aedx_update(
                                                      queryes_upd => \@qupd,
                                                      queryes_ins => \@qins,
                                                      queryes_del => \@qdel,
                                                      queryes_chk => \@qchk,
                                                      old_data    => $old_data,
                                                      key_column  => $params->{rid},
                                                      params      => $params,
                                                      var         => $var,
                                                      dsn         => $cp->{dsn},
                                                      log         => $log
                                                    );
        if ($var->{debug} || $log_str =~/^ABORT/){ $c->err( $log_str ); return; }

        $i_id = $params->{i};
    }
    else {
        if( $cp->{a_insert}==0 || ($cp->{a_insert}>1 && $acl<3) || ($cp->{a_insert}>2 && $acl<4) ){
            $c->err("You do not have access to insert into this chapter!");
            $c->log->warn( "Insert attempt is rejected: user: $uid, chapter: $cp->{id}" );
            return;
        }
        
        ($i_id, $log_str) = $c->model($cp->{dsn})->aedx_insert(
                                                      queryes_ins => \@qins,
                                                      queryes_del => \@qdel,
                                                      queryes_chk => \@qchk,
                                                      key_column  => $params->{rid},
                                                      params      => $params,
                                                      var         => $var,
                                                      dsn         => $cp->{dsn},
                                                      log         => $log
                                                    );
        if ($var->{debug} || $log_str =~/^ABORT/){ $c->err( $log_str ); return; }

    }
    
    $c->model($cp->{dsn})->write_log(
                                                      log_table  => $log,
                                                      log_str    => $log_str,
                                                      i_id       => $i_id,
                                                      qid        => $cp->{id},
                                                      uid        => $c->session('id')
                                    ) if $log_str;
    $c->log->info( "SQ-$params->{sq_id}: user:$uid, chapter:$cp->{id}, $log_str" ) if $log_str;
    
    $params->{rid} = '';    
    $data = $c->model($cp->{dsn})->get_subqueryes( $cp->{id}, $params->{i}, $params->{sq_id}, $cp->{dsn} );
    
    $c->stash(params => $params);    # params
    $c->stash(var    => $var);       # variables (from json)
    $c->stash(cp     => $cp);        # chapter parameters
    $c->stash(result => $data->[0]); # hashref: sq parameters + (@names, @inames, @data)
    $c->render('subed');
    return 0;
}

1;
