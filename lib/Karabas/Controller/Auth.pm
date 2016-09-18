package Karabas::Controller::Auth;
use Mojo::Base 'Mojolicious::Controller';
use POSIX 'locale_h';
setlocale(LC_CTYPE, 'ru_RU.UTF8');
#use Digest::MD5 'md5_hex';
use Mojo::Util 'md5_sum';
#use Data::Dumper;

use lib 'lib';



sub auth {
	my $c = shift;
	my $data = +{};
	my $logged_in = 0;
    my $params = $c->req->params->to_hash;

   #print "#$params->{exit} = $logged_in == ".$c->session('id')." ========= ".Dumper( $c->session)." ===\n";
	
	if( $params->{exit} ) {
		$c->session(expires => 1);
	}
    elsif ( $c->session('id') ){
		$logged_in = 1;
	}
	elsif ( $params->{lo} ) {
		$data = $c->model->auth_login($params);
				
		if( $data->{password} && $data->{password} eq md5_sum($params->{pa}) ){ #data->{enc_pa}
			$c->session(id => $data->{id}, login => $params->{lo}, acl => $data->{acl} );
			$logged_in = 1;
		}
		elsif( $params->{pa} ) {
			$c->session(expires => 1);
		}
	}


	$c->stash(logged_in => $logged_in);
	$c->stash(fio => $c->session->{login});# if defined $data->{fio};
	
	#if ( $logged_in && $ENV{'HTTP_REFERER'} !~/auth/ ){
	#	$c->redirect_to( $ENV{'HTTP_REFERER'} ); last;
	#}
	
	$c->render('auth');
} 