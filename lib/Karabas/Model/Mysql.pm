package Karabas::Model::Mysql;

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
		$dbh = DBI->connect( "DBI:mysql:$dsn->{db_database}:$dsn->{db_host}", $dsn->{db_user}, $dsn->{db_passwd},
		    { RaiseError => 1, mysql_enable_utf8 => 1, mysql_auto_reconnect => 1, on_connect_do => [ "SET NAMES 'utf8'"] }
		);
	};
    $self->app->log->error( "Connection attempt failed: ".$@ ) if $@;
	return $dbh;
}

sub get_auto_increment {
	my ($self, $table) = @_;
	my $qdb;
	if($table =~ /\./){
		my($db,$tb)=split(/\./,$table);
		$qdb="show table status from $db like '$tb'";
	}
	else{ $qdb="show table status like '$table'"; }
	my $t_status;
	eval { $t_status = $self->app->dbi->selectrow_hashref( $qdb ); };
	return $@ if $@;
	#print Dumper $t_status;
	return $t_status->{Auto_increment};
}

sub get_table_colnames {
	my ($self, $table, $dsn) = @_;
	return $self->app->dbi($dsn)->selectcol_arrayref ("SHOW COLUMNS FROM $table");
}

sub last_insert_rowid {
	my ($self, $table, $dsn) = @_;
	return $self->app->dbi($dsn)->{mysql_insertid};
}




1;