package Karabas::Controller::Main;
use Mojo::Base 'Mojolicious::Controller';
use Mojo::JSON qw(from_json);
use utf8;
use POSIX 'locale_h';
setlocale(LC_CTYPE, 'ru_RU.UTF8');

#use Data::Dumper;

sub show_main_menu {
    my $c = shift;
    unless ( defined $c->session('id') ){ $c->redirect_to('auth'); return; }
    
    my $params = $c->req->params->to_hash;

    my $uid = $c->session('id'); my $acl = $c->session('acl');
    
    my $data = $c->model->get_main_menu_data($params);
    @$data = grep( (!$_->[3] || $_->[3]=~/\($uid\)||\{$acl\}/)&&(!$_->[8] || $_->[8]=~/\($uid\)||\{$acl\}/), @$data ); # access filter
    #print "============= $params->{gr} ===\n";
    $c->stash(group => $params->{gr});   
    $c->stash(result => $data);
    $c->render('main_menu');
}


sub show_chapter {
    my $c = shift;
    unless ( defined $c->session('id') ){ $c->redirect_to('auth'); return; }
    
    my $params = $c->req->params->to_hash;
    my $uid = $c->session('id'); my $acl = $c->session('acl');
    
    $params->{limit} = $c->cfg->{limit} if !$params->{limit} || $params->{limit} > $c->cfg->{limit};
    
    my $cp = $c->model->get_chapter_params($params);
    my $var = +{};
    if ($cp->{var}=~/^\"/){
        eval { $var = from_json "{ $cp->{var} }" };
        $var = +{error => $@->message} if $@;        
        
        if ( defined $var->{key2val} ){
            foreach my $k2v ( keys %{$var->{key2val}} ){
                $var->{key2val}->{$k2v}->{data} = $c->model($cp->{dsn})->get_table_columns_as_hash( $var->{key2val}->{$k2v}, $cp->{dsn} );
            }
        }
    }
    #print  Dumper $params;
    
    if (!$cp->{id} || ($cp->{users} && $cp->{users}!~/(?:\($uid\))||(?:\{$acl\})/)){ $c->achtung("Сюда не ходи!"); return; }
    if ( $cp->{grusers} && $cp->{grusers}!~/(?:\($uid\))||(?:\{$acl\})/ ){ $c->achtung("Доступ в этот раздел запрещен!"); return; }
    #print $cp->{dsn}."===666==\n";
    
    my $cd = $c->model($cp->{dsn})->get_chapter_data( $cp, $params );
    if ( defined $cd->{error} ) {$c->achtung( $cd->{error}); return; }
    
    my $grmenu;
    if ($var->{grmenu}){                                                         # Group Menu
        $grmenu = $c->model->get_grmenu_data( $cp->{grp}, $cp->{id} ) ;
        #if ( defined $grmenu->{error} ) {$c->achtung( $grmenu->{error} ); return; }
    }
    $c->stash( grmenu => $grmenu );
    
    $c->stash(params => $params);   
    $c->stash(var => $var);   
    $c->stash(cp => $cp);
    $c->stash(result => $cd);
    if ( defined $var->{tree} && !$params->{nt} ) {
        $c->render('chapter_tree');
    }
    else { $c->render('chapter') }
}

sub achtung {
    my ($c, $message) = @_;
    $message = "<h1>404</h1>" if !defined $message;
    $c->stash(result => $message);
    $c->render('index');
}





1;