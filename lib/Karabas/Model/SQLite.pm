package Karabas::Model::SQLite;

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
	    $dbh=DBI->connect( "dbi:SQLite:".$dsn->{db_database}, undef, undef, { RaiseError => 1, enable_utf8 => 1, sqlite_unicode => 1 } )
	};
	if ($@){ $self->app->log->error( "Connection attempt failed: ".$@ ); return; };
	
    $dbh->do("attach database '$dsn->{db_database}' as '$1'") if  $dsn->{db_database} =~ /(\w+)\.db$/;
	
	return $dbh;
}

sub get_auto_increment {
	my ($self, $table, $dsn) = @_;
	my $ai;
	eval { $ai = $self->app->dbi($dsn)->selectrow_array( "select id+1 from $table order by id desc limit 1" ); };
	$self->app->log->error($@) if $@;
	return $ai;
}

sub get_table_colnames {
	my ($self, $table, $dsn) = @_;
	my $column_names;
	eval {
		my $sth = $self->app->dbi($dsn)->prepare("select * from $table limit 0");
		$sth->execute() || die $sth->errstr;
		$column_names = $sth->{NAME};
		$sth->finish;
	};
	$self->app->log->error($@) if $@;
	
	return $column_names;
}

sub last_insert_rowid {
	my ($self, $table, $dsn) = @_;
	return $self->app->dbi($dsn)->selectrow_array("select last_insert_rowid()");
}



1;