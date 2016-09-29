package Karabas::Controller::Editor;
use Mojo::Base 'Mojolicious::Controller';
use Mojo::Loader;
use Mojo::JSON qw(from_json);
use utf8;
#use POSIX 'locale_h';
#setlocale(LC_CTYPE, 'ru_RU.UTF8');
#use Data::Dumper;


has modules => sub { {} };

sub new {
    my ($class, %args) = @_;
    my $self = $class->SUPER::new(%args);

    my $modules = $args{app}->cfg->{editors};
	
	foreach my $pm (@$modules){
		my $fpm = "Karabas::Controller::Editor::$pm";
		my $e = Mojo::Loader::load_class($fpm);
		die "Loading '$fpm' failed: $e" if ref $e;
		$self->modules->{$pm} = $fpm->new(%args);
	}
    return $self;
}

sub get_editor {
    my ($self, $editor) = @_;
    return $self->modules->{$editor} || die "Unknown editor '$editor'";
}

sub get {
	my $c = shift;
    unless ( defined $c->session('id') ){ $c->redirect_to('auth'); return; }
  
    my $params = $c->req->params->to_hash;
	my $cp = $c->model->get_chapter_params({id=>$params->{qid}});
    my ($fid,$ed_name) = split(/,/,$cp->{editor});
    if( defined $ed_name && ! grep( $ed_name eq $_, @{$c->cfg->{editors}} ) ){ $c->err("Editor '$ed_name' is not available. Please, check config."); return; }
	#$ed_name = 'Aed' if !$ed_name;
    $c->editor($ed_name)->get($c, $params, $cp);
}

sub post {
	my $c = shift;
    unless ( defined $c->session('id') ){ $c->redirect_to('auth'); return; }

    my $params = $c->req->body_params->to_hash;
	my $cp = $c->model->get_chapter_params({id=>$params->{qid}});
    my ($fid,$ed_name) = split(/,/,$cp->{editor});
    my $data = $c->editor($ed_name)->post($c, $params, $cp);
}

sub sub_get {
	my $c = shift;
    unless ( defined $c->session('id') ){ $c->redirect_to('auth'); return; }
  
    my $params = $c->req->params->to_hash;
	my $cp = $c->model->get_chapter_params({id=>$params->{qid}});
    
	my $data = $c->model($cp->{dsn})->get_subqueryes( $cp->{id}, $params->{i}, $params->{sq_id}, $cp->{dsn} );
    
    my $ed_name = 'Subed'; $ed_name = $data->[0]->{editor} if exists $data->[0]->{editor};
    
    if( defined $ed_name && ! grep( $ed_name eq $_, @{$c->cfg->{editors}} ) ){ $c->err("Editor '$ed_name' is not available. Please, check config."); return; }
    
    $c->editor($ed_name)->get($c, $params, $cp, $data->[0]);
}

sub sub_post {
	my $c = shift;
    unless ( defined $c->session('id') ){ $c->redirect_to('auth'); return; }
  
    my $params = $c->req->params->to_hash;
	my $cp = $c->model->get_chapter_params({id=>$params->{qid}});
    
	my $data = $c->model($cp->{dsn})->get_subqueryes( $cp->{id}, $params->{i}, $params->{sq_id}, $cp->{dsn} );
    
    my $ed_name = 'Subed'; $ed_name = $data->[0]->{editor} if exists $data->[0]->{editor};
    
    if( defined $ed_name && ! grep( $ed_name eq $_, @{$c->cfg->{editors}} ) ){ $c->err("Editor '$ed_name' is not available. Please, check config."); return; }
    
    $c->editor($ed_name)->post($c, $params, $cp, $data->[0]);
}

sub x_get {
	my $c = shift;
    unless ( defined $c->session('id') ){ $c->redirect_to('auth'); return; }
    my $params = $c->req->params->to_hash;
    my $ed_name = $params->{edn};
    if( defined $ed_name && ! grep( $ed_name eq $_, @{$c->cfg->{editors}} ) ){ $c->err("Editor '$ed_name' is not available. Please, check config."); return; }
    $c->editor($ed_name)->get($c, $params);
}

sub err {
    my ($c, $message, $abs) = @_;
	$c->stash(abs => $abs);
	$c->stash(result => $message);
	$c->render('editor');
}


1;