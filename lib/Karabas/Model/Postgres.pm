package Karabas::Model::Postgres;

use Mojo::Base 'Karabas::Model::Base';
use DBI;
use utf8;
use POSIX 'locale_h';
setlocale(LC_CTYPE, 'ru_RU.UTF8');
#use Data::Dumper;


sub db_connect {
	my ($self, $dsn) = @_;
	my $dbh;
	eval {
		$dbh = DBI->connect( "DBI:Pg:dbname=$dsn->{db_database};host=$dsn->{db_host}", $dsn->{db_user}, $dsn->{db_passwd},
		    { RaiseError => 1, pg_enable_utf8 => 1, ShowErrorStatement => 1, InactiveDestroy => 1 }
		);
	};
    print "Error conect: ".$@ if $@;
	return $dbh;
}

sub get_auto_increment {
    my ($self, $table, $dsn) = @_;
	my $ai;
	eval { $ai = $self->app->dbi($dsn)->selectrow_array( "select last_value from auto_id_$table" ); };
	print $@ if $@;
	return $ai;
}

sub get_table_colnames {
	my ($self, $table, $dsn) = @_;
	return $self->app->dbi($dsn)->selectcol_arrayref ("SHOW COLUMNS FROM $table");
}

sub last_insert_rowid {
	my ($self, $table, $dsn) = @_;
	return $self->app->dbi($dsn)->last_insert_id(undef, undef, $table, undef);
}




1;