package Karabas;
use Mojo::Base 'Mojolicious';
use Mojo::Log;
use utf8;

use Karabas::Model;
use Karabas::Controller::Editor;

use POSIX 'locale_h';
setlocale(LC_CTYPE, 'ru_RU.UTF8');

our $VERSION = 'v0.0.3';

sub startup {
    my $self = shift;
  
    my $cfg = $self->plugin( 'Config' => {file => 'etc/karabas.conf'} );
    $self->helper(
        cfg => sub {
            my ($self) = @_;
            return $cfg;
        }
    );
    
    $self->secrets(['RVFtfvgfgfvh23dbjhg238e2nHJHNh-8=738FRF'.'ValiD62gh4bvrj374387bJBJY7GJHBNB9894-RFRE=0']);
    $self->sessions->cookie_name('kar');
    #$self->sessions->cookie_path('/is');
    $self->sessions->default_expiration($cfg->{session_expiration});
    
    my $log = Mojo::Log->new();
    $log->path( $cfg->{logger_path} ); $log->level( $cfg->{logger_level} );
    $self->helper(
        log => sub {
            my ($self) = @_;
            return $log;
        }
    );
    $log->info('Karabas is coming!');
    
    my $model = Karabas::Model->new(app => $self);
    $self->helper(
        model => sub {
            my ($self, $dsn_name) = @_;
            $dsn_name = 'base' if ! defined $dsn_name;
            my $model_name = $cfg->{dsn}{$dsn_name}{db_type} ? $cfg->{dsn}{$dsn_name}{db_type} : $cfg->{dsn}{base}{db_type};
            return $model->get_model( $model_name );
        }
    );
    
    $self->helper(
        dbi => sub {
            my ($self, $dsn_name) = @_;
            $dsn_name = $dsn_name ? $dsn_name : 'base';
            return $model->get_dbh( $dsn_name );
        }
    );
    
    my $editor = Karabas::Controller::Editor->new(app => $self);
    $self->helper(
        editor => sub {
            my ($self, $ed_name) = @_;
            return $editor->get_editor( $ed_name );
        }
    );
    
    # Router
    my $r = $self->routes;
    
    # Normal route to controller
    $r->get('/')->to('main#show_main_menu');
    $r->get('/chapter')->to('main#show_chapter');
    $r->any('/auth')->to('auth#auth');
    $r->any('/edit')->to('editor#get');
    $r->post('/write')->to('editor#post');
    $r->any('/subed')->to('editor#sub_get');
    $r->post('/subwr')->to('editor#sub_post');
    $r->any('/xed')->to('editor#x_get');
    
    $r->get('/*')->to('main#achtung');
}

1;
