package Karabas::Model;

use Mojo::Loader;
use Mojo::Base -base;
#use Karabas::Model::Mysql;
#use Carp qw/ croak /;
#use Data::Dumper;
use utf8;

has modules => sub { {} };
has dbh => sub { {} };

sub new {
    my ($class, %args) = @_;
    my $self = $class->SUPER::new(%args);

    my $u = +{};
	foreach my $dsn_name ( keys %{$args{app}->cfg->{dsn}} ){
		my $dsn = $args{app}->cfg->{dsn}->{$dsn_name};
        next if defined $dsn->{off};
        
        # Load DB drivers
        if ( !defined $u->{ $dsn->{db_type} } ){
            my $fpm = "Karabas::Model::$dsn->{db_type}";
            my $e = Mojo::Loader::load_class($fpm);
            die "Loading '$fpm' failed: $e" if ref $e;
            $self->modules->{$dsn->{db_type}} = $fpm->new(%args);
        }
        $u->{$dsn->{db_type}} = $dsn->{db_type};
        
        # Create DB connections
        print "Connect DSN $dsn_name ($dsn->{db_type}) ...\n";
        $self->dbh->{$dsn_name} = $self->modules->{$dsn->{db_type}}->db_connect( $dsn );
        die "Fatal error: Can't connect to base!\n" if ( !ref $self->dbh->{$dsn_name} && $dsn_name eq 'base' );
    }
	
    return $self;
}

sub get_model {
    my ($self, $model) = @_;
    return $self->modules->{$model} || die "Unknown model '$model'";
}

sub get_dbh {
    my ($self, $dsn_name) = @_;
    return $self->dbh->{$dsn_name} || die "Unknown dbh '$dsn_name'";
}

1;