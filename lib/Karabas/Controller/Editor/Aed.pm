package Karabas::Controller::Editor::Aed;
use Mojo::Base 'Karabas::Controller::Editor::Base';
use Mojo::JSON qw(from_json);

sub get {
    my ($self, $c, $params, $cp) = @_;
    my $var = +{};
    
    my($key_column, $editor, $table) = split(/,/,$cp->{editor});
    if(!$table){ $c->err('Не указана таблица (3-й параметр поля editor)'); return; }

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
    $var->{auto_increment} = $c->model($cp->{dsn})->get_auto_increment($table, $cp->{dsn});
    
    my $data = $c->model($cp->{dsn})->get_table_row( $table, $key_column, $params->{i}, $cp->{dsn} );
    if(defined $data->{error}){ $c->err($data->{error}); return; }

    
    $c->stash(params => $params);   
    $c->stash(var => $var);   
    $c->stash(cp => $cp);   
    $c->stash(result => $data);
    $c->render('aed');
    return 0;
}

sub post {
    my ($self, $c, $params, $cp) = @_;
    my $acl = $c->session('acl');
    my $var = +{}; my $i_id = 0; my $log=''; my $log_str='';
    
    if ( $cp->{var} =~ /^\"/ ){
        eval { $var = from_json "{ $cp->{var} }" };
        $var = +{error => $@->message} if ref $@;
    }
    
    if ( $cp->{log} && defined $c->cfg->{log_table}) { $log = $c->cfg->{log_table}; $log = $var->{logtable} if defined $var->{logtable}; }
    
    my($key_column, $editor, $table) = split(/,/,$cp->{editor});
    if(!$table){ $c->err('Не указана таблица (3-й параметр поля editor)'); return; }


    my @cl=(); my $cont=0;
    if ($params->{quetype} eq "1"){
        my $old_data = $c->model($cp->{dsn})->get_old_row_data($table, $key_column, $params->{i}, $cp->{dsn});

        if( $cp->{a_update}==0 || ($cp->{a_update}>1 && $acl<3) || ($cp->{a_update}>2 && $acl<4) ){
            $c->achtung("У вас нет доступа на изменение данных");
            $c->log->warn( "Update attempt is rejected: user:".$c->session('id').", chapter:$cp->{id}" );
            return;
        }        
        
        $log_str = $c->model($cp->{dsn})->update_table_row(
                                                      table      => $table,
                                                      params     => $params,
                                                      old_data   => $old_data,
                                                      key_column => $key_column,
                                                      dsn        => $cp->{dsn},
                                                      log        => $log
                                                    );
        if ($var->{debug} || $log_str =~/^ABORT/){ $c->err( $log_str, 1 ); return; }
        $i_id = $params->{i};
    }
    else {
        if( $cp->{a_insert}==0 || ($cp->{a_insert}>1 && $acl<3) || ($cp->{a_insert}>2 && $acl<4) ){
            $c->achtung("У вас нет доступа на добавление данных");
            $c->log->warn( "Insert attempt is rejected: user:".$c->session('id').", chapter:$cp->{id}" );
            return;
        }
        
        ($i_id, $log_str) = $c->model($cp->{dsn})->insert_table_row(
                                                      table      => $table,
                                                      params     => $params,
                                                      key_column => $key_column,
                                                      dsn        => $cp->{dsn},
                                                      log        => $log
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
    $c->render('aed_w');
    return 0;
}

1;
