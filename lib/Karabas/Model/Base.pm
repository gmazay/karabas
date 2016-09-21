package Karabas::Model::Base;

use Mojo::Base -base;
use Mojo::Util 'md5_sum';
use Text::Diff;
use utf8;
use open qw(:std :utf8);
use POSIX 'locale_h';
setlocale(LC_CTYPE, 'ru_RU.UTF8');

#use Data::Dumper;

has 'app';



sub db_connect {
    return {};
}

sub get_row_hashref {
    my ($self, $qdb, $id) = @_;
    my $rv = +{};
    eval { $rv = $self->app->dbi->selectrow_hashref( $qdb, undef, $id ); };
     if ($@){ $rv->{error} = $@; $self->app->log->error($@); }

    return $rv;
}

sub get_main_menu_data {
    my ($self, $params) = @_;
    my $gr='';    $gr="and queryes.grp='$params->{gr}'" if $params->{gr};
    my $qdb = <<___;
SELECT
 queryes.id, queryes.name, query_groups.name, queryes.users,
 queryes.tail, queryes.icon, queryes.grp, query_groups.tail,
 queryes.ed_tail, query_groups.users
FROM queryes, query_groups
WHERE
 queryes.grp=query_groups.id AND
 queryes.active>0 $gr
ORDER BY query_groups.order_id, queryes.order_id
___
    my $rv = $self->app->dbi->selectall_arrayref( $qdb );
    
    return $rv;
}

sub get_table_row {
    my ($self, $table, $key_column, $id, $dsn) = @_;
    my $rv = +{}; my $sth;
    my $qdb = "select * from $table where $key_column=?";
    
    eval{
        $sth = $self->app->dbi($dsn)->prepare($qdb);
        $sth->execute($id);
        $rv->{names} = $sth->{NAME};
        @{$rv->{data}} = $sth->fetchrow_array;
        $sth->finish;
    };
    $rv->{error} = $@ if $@;

    return $rv;
}

sub get_table_columns {
    my ( $self, $param, $dsn ) = @_;
    my ( $table, $col_id, $col_value, $query_postfix ) = @$param{ qw/table col_id col_value query_postfix/ };
    $query_postfix = '' if not defined $query_postfix;
    my $qdb = "select $col_id, $col_value from $table $query_postfix";
    my $rv;
    eval { $rv = $self->app->dbi($dsn)->selectall_arrayref($qdb); };
    $rv->{error} = $@ if $@;

    return $rv;
}

sub get_table_columns_as_hash {
    my ( $self, $param, $dsn ) = @_;
    my ( $table, $col_id, $col_value, $query_postfix ) = @$param{ qw/table col_id col_value query_postfix/ };
    $query_postfix = '' if not defined $query_postfix;
    my $qdb = "select $col_id, $col_value from $table $query_postfix";
    my $rv = +{};
    eval {
        my $sth = $self->app->dbi($dsn)->prepare($qdb);
        $sth->execute;
        while ( my ($k,$v) = $sth->fetchrow_array ){ $rv->{$k} = $v; }
        $sth->finish;      
    };
    $rv->{error} = $@ if $@;

    return $rv;
}

sub get_chapter_params {
    my ($self, $params) = @_;
    my $qdb = <<___;
SELECT
  queryes.id, queryes.name,
  queryes.qdb, queryes.f_lenghts, queryes.editor, queryes.colnames, queryes.dsn, queryes.active, queryes.focus,
  queryes.sum, queryes.users, queryes.a_update, queryes.a_insert, queryes.var, queryes.ed_tail,
  query_groups.name as grname, queryes.grp, query_groups.users as grusers, queryes.log
FROM queryes, query_groups
WHERE queryes.grp=query_groups.id AND queryes.id=?
___
    my $rv = $self->app->dbi->selectrow_hashref( $qdb, undef, $params->{id} );

    return $rv;
}

sub get_chapter_data {
    my ($self, $cp, $params) = @_;
    my $rv = +{};
    my @row = (); my ($i,$j) = (0,0);
    
    my $qdb = $self->make_query( $cp->{qdb}, $params );
    $qdb.=" limit $params->{limit}" if $qdb!~/limit/;

    my $sth;
    eval {
        $sth = $self->app->dbi($cp->{dsn})->prepare($qdb);
        $sth->execute;
        $rv->{names} = $sth->{NAME};
        foreach (@{$rv->{names}}) { utf8::decode($_); }
        $rv->{max_id} = 0;
        while (@row = $sth->fetchrow_array) {
            for $j ( 0 .. $#row){ $rv->{data}->[$i][$j] = $row[$j]; }
            $rv->{max_id} = $rv->{data}->[$i][0] if $rv->{max_id} < $rv->{data}->[$i][0] ;
            $i++;
        }
        $sth->finish;
    };
    if($@){
        $self->app->log->error('Error: '. $@ );
        $rv->{error} = "Error: ". $@ . "\n $qdb";
    }
    return $rv;
}

sub get_grmenu_data {
    my ($self, $gr_id, $id ) = @_;
    my $rv = [];
    
    my $qdb = <<___;
SELECT id, name, tail, icon
FROM queryes
WHERE active>0 AND grp=? AND id!=?
ORDER BY order_id
___
    eval {
        my $sth = $self->app->dbi->prepare($qdb);
        $sth->execute($gr_id, $id);
        while( my $r = $sth->fetchrow_hashref ){ push( @$rv, $r ) };
        $sth->finish;
    };
    if($@){
        $self->app->log->error('Error: '. $@ );
        $rv->{error} = "Error: ". $@ . "\n $qdb \n($gr_id, $id)"
    }
    
    return $rv;
}

sub auth_login {
    my ($self, $params) = @_;    #, md5(?) as enc_pa
    my $rv = +{};
    my $qdb = <<___;
SELECT
 id, password, moder as acl, fio
FROM
 moderators
WHERE login=? and status=0
___
    eval{
        $rv = $self->app->dbi->selectrow_hashref( $qdb, undef, $params->{lo} ); #$params->{pa},
    };
    if($@){ $self->app->log->error('Error: '. $@ . " Auth query error for $params->{lo}"); }
    return $rv;
}

# Aed /write ##############################################################################################
sub get_old_row_data {
    my ($self, $table, $key_column, $id, $dsn) = @_;
    my $rv = +{};
    my $qdb="select * from $table where $key_column=?";
    #print "$qdb -- get_old_row_data --\n";
    eval{
        $rv = $self->app->dbi($dsn)->selectrow_hashref( $qdb, undef, $id );
    };
    if($@){ $rv->{error} = 'ABORT: '. $@ . "\n $qdb \n($id)"; }
    return $rv;
}

sub update_table_row {
    my ($self, %args) = @_;
    my ($table, $params, $old_data, $key_column, $dsn, $log) = @args{ qw/table params old_data key_column dsn log/ };
    my $log_str = '';
    my @values; my $qdb = "UPDATE $table SET ";
    foreach my $name (keys %$old_data){
        if ( defined $params->{$name} ){
            $qdb .= " $name = ?,"; push @values, $params->{$name};
            
            if( $log && $old_data->{$name} ne $params->{$name} ) {
                my $diff;
                if(length($params->{$name})>120){
                    $diff=diff \$old_data->{$name}, \$params->{$name};
                }
                else{$diff="$old_data->{$name} -> $params->{$name}";}
                $log_str.="$name\{$diff\}; " if $diff;
            }
        }
    }
    eval{
        $qdb=substr($qdb,0,-1);
        $qdb.=qq( WHERE $key_column=?);
        push @values, $params->{i};
        $self->app->dbi($dsn)->do( $qdb, undef, @values );
    };
    if($@){ $log_str = 'ABORT: '. $@ . "\n $qdb \n".join(',',@values); }
    return $log_str;
}

sub insert_table_row {
    my ($self, %args) = @_;
    my ($table, $params, $key_column, $dsn, $log) = @args{ qw/table params key_column dsn log/ };
    my $log_str = ''; my $inserted_id; my $qdb;
    my @values; my @names;
    
    eval{
        # get column names
        #my $column_names = $self->get_table_colnames($table, $dsn);
        my $sth = $self->app->dbi($dsn)->prepare("SELECT * FROM $table limit 0");
        $sth->execute() || die $sth->errstr;
        my $column_names = $sth->{NAME};
        $sth->finish;
      
        foreach my $name (@$column_names){
            if ( defined $params->{$name} ){
                push @names, $name; push @values, $params->{$name};
                if( $log ){ $log_str .= "$params->{$name},";}
            }
        }
        my $names = join ',',@names;
        my $values = '?,' x scalar @values;
        $values=substr($values,0,-1);
        $qdb = "INSERT into $table($names) values($values)";
    
        if( $log ){ $log_str = "$qdb-($log_str)";}
        $self->app->dbi($dsn)->do( $qdb, undef, @values );
        $inserted_id = $self->last_insert_rowid( $table, $dsn );
    };
    if($@){ $log_str = 'ABORT: '. $@ . "\n $qdb \n".join(',',@values); }
    
    return ($inserted_id, $log_str);
}

sub get_qdb_row_array {
    my ($self, %args) = @_;
    my ($qdb, $table, $key_column, $id, $dsn) = @args{ qw/qdb table key_column i_id dsn/ };
    
    if ($qdb =~ /order\s+by/i) { $qdb =~ s/order\s+by.*//i; }
    if ($qdb =~ /where/i) { $qdb .= qq( and $table.$key_column=?); }
    else { $qdb .= qq( where $table.$key_column=?); }
    
    my $rv;
    eval{
        $rv = $self->app->dbi($dsn)->selectrow_arrayref( $qdb, undef, $id );
    };
    if($@){ $rv->{error} = 'ABORT: '. $@ . "\n $qdb \n ($id)"; }
    
    return $rv;
}

sub write_log {
    my ($self, %args) = @_;
    my ($log_table, $log_str, $i_id, $qid, $uid) = @args{ qw/log_table log_str i_id qid uid/ };
    $i_id = 0 if !defined $i_id;
    
    my $qdb = "INSERT INTO $log_table (qid,uid,rec_id,record) VALUES (?,?,?,?)";
    #print "$qdb -+- ($qid, $uid, $i_id, $log_str)\n";
    $self->app->dbi->do($qdb, undef, $qid, $uid, $i_id, $log_str);
    
}

#######################################################################################################

# Aedx ################################################################################################
sub get_aedx_params {
    my ($self, $qid) = @_;
    my $qdb = <<___;
SELECT
 name, q_select, q_update, q_insert, var, check_form_js, form_template
FROM ed
WHERE query_id=?
___
    my $rv = $self->app->dbi->selectrow_hashref( $qdb, undef, $qid );
    #print "$qdb=$qid\n";

    return $rv;
}

sub get_query_row_array {
    my ($self, $qdb, $id, $dsn) = @_;
    
    $qdb =~ s/\$ID/\?/;
    #print "-- $qdb --qdb--\n";
    return $self->app->dbi($dsn)->selectrow_arrayref( $qdb, undef, $id );
    
}

sub get_subqueryes { # get subqueryes parameters and data as arrayref of hashref
    my ($self, $qid, $id, $se_id, $dsn) = @_;    
    my $rv = [];
    
    if (!$se_id){
        my $qdb="SELECT * FROM ed_subquery WHERE status>0 AND query_id=?";
        my $sth = $self->app->dbi($dsn)->prepare($qdb);
        $sth->execute($qid);    
        while ( my $row = $sth->fetchrow_hashref ){
            push(@$rv, $row);        
        };
        $sth->finish;
    }
    else {
        $rv->[0] = $self->app->dbi($dsn)->selectrow_hashref( "SELECT * FROM ed_subquery WHERE status>0 AND id=?", undef, $se_id );
    }    
    
    foreach my $row ( @$rv ) {
        my $qdb = ($se_id && $row->{query_s}) ? $row->{query_s} : $row->{query};
        $qdb =~ s/\$ID/?/g;
        #print $row->{query};
        eval {
            my $sth = $self->app->dbi($dsn)->prepare( $qdb );
            $sth->execute($id);        
            $row->{names} = $sth->{NAME};                                                           # names: sq data wiev colnames
            $sth->finish;
            foreach (@{$row->{names}}) { utf8::decode($_); }
        
            my $clmn = $1 if $qdb =~ /select(.+?)from.+/igs;
            $clmn =~ s/as\s\w+[,\s]|distinct//igs;
            @{$row->{inames}} = $clmn =~ /[,\s]([\.\w\(\)]+?)[,\s]/gs;                              # inames: colnames from query
            $row->{data} = $self->app->dbi($dsn)->selectall_arrayref( $qdb, undef, $id );           # data: sq data
        };
        if($@){ $rv->[0]->{error} = 'ABORT: '. $@ . "\n $qdb \n($id)"; return $rv; }
    }
    
    return $rv;    
}
# write #################################

sub get_old_query_data {
    my ($self, $qdb, $id, $rid, $dsn) = @_;
    my $rv = +{}; my @row;
    
    $qdb =~ s/\$ID/?/g;
    #print "$qdb -- get_old_query_data --\n";
    my $clmn = $1 if $qdb =~ /select(.+?)from.+/igs;
    $clmn =~ s/as\s\w+[,\s]|distinct//igs;
    my @cnr = $clmn =~ /[,\s]([\.\w\(\)]+?)[,\s]/gs;
    
    eval{
        $qdb =~ s/where/where $cnr[0]='$rid' and /ig if defined $rid;
        @row = $self->app->dbi($dsn)->selectrow_array( $qdb, undef, $id );
    };
    if($@){ $rv->{error} = 'ABORT: '. $@ . "\n $qdb \n($id)"; return $rv; }
    
    for my $j ( 0 .. $#row){
        $rv->{$cnr[$j]} = $row[$j];
    }
    
    return $rv;
}

sub aedx_update {
    my ($self, %args) = @_;
    my ($queryes_upd, $queryes_ins, $queryes_del, $queryes_chk, $old_data, $key_column, $params, $var, $dsn, $log) =
        @args{ qw/queryes_upd queryes_ins queryes_del queryes_chk old_data key_column params var dsn log/ };
    my $log_str = '';
    my @insid = ();
    
    if( scalar @$queryes_chk >0 ){                                 # Check queryes
        my $check_res = '';
        for my $i ( 0..$#$queryes_chk ){
            my $qd = $queryes_chk->[$i];
            my @bv = $qd =~ /\$(.+?)\$/gs;
            foreach( @bv ){ $_ = $params->{$_}; }

            $qd =~ s/\$(.+?)\$/?/g;
            if($var->{debug}){ $log_str .= "$qd ". join(",",@bv)."\n"; }
            else{
                my $sth = $self->app->dbi($dsn)->prepare($qd);
                $sth->execute(@bv);
                $check_res .= $sth->fetchrow_array;
                $sth->finish;
            }
        }
        if($check_res){ return 'ABORT: '.$check_res; }
    }
    
    for my $i ( 0 .. $#$queryes_upd ){
        my $qd = $queryes_upd->[$i];
        my @bv = $qd =~ /\$([\.\w\-\(\)]+?)\$/gs;
        #foreach( @bv ){ $_ = $params->{$_}; }
        foreach my $f ( @bv ){                                  # using perl function md5_sum() in query
            if ($f =~ /md5_sum\((.+)\)/ ){
                $f = md5_sum( $params->{$1} );
            } else {
                $f = $params->{$f};
            }
        }
        $qd =~ s/\#(.+?)\#/$old_data->{$1}/g;
        $qd =~ s/\$([\.\w\-\(\)]+?)\$/?/g;
        if ($var->{debug}){ $log_str .= "$qd ". join(",",@bv)."\n"; }
        else {
            if( defined $queryes_del->[$i] && $queryes_del->[$i] =~ /IF_NULL\((.+)\)/ ) { # Delete if any listed fields is empty
                my @dc = $1 =~ /\$(.+?)\$/gs;
                foreach(@dc){
                    if( !$params->{$_} ) {
                        $queryes_del->[$i] =~ s/IF\_NULL\(.+\)[\s\n\r]*//;
                        if ( !$old_data->{$_} ){ $qd = ''; last; }
                        $qd = $queryes_del->[$i];
                        @bv = $qd =~ /\$([\.\w\-\(\)]+?)\$/gs;
                        $qd =~ s/\$([\.\w\-\(\)]+?)\$/?/g;
                        foreach( @bv ){ $_=$params->{$_}; }
                    }
                }
            }
            next if !$qd;
            my $rws;
            eval {
                my $sth = $self->app->dbi($dsn)->prepare($qd);
                my $rws = $sth->execute(@bv);
                $sth->finish;
            };
            if($@){ return 'ABORT: '. $@ . "\n $qd \n".join(',',@bv); }

            if(defined $rws && $rws eq '0E0'){                                             # insert if no record for update
                $qd = $queryes_ins->[$i];
                if($qd =~ /\$INSERTID(\d)/){
                    $qd =~ s/\$INSERTID\d/$insid[$1]/;
                }
                eval{
                    my ($table) = $qd =~ /into\s+(\w+)\s/i;
                    my @bv = $qd =~ /\$([\.\w\-\(\)]+?)\$/gs;
                    foreach(@bv){$_=$params->{$_};}
                    # print "<pre>$qd</pre> @bv --<hr>";
                    $qd=~s/\$([\.\w\-\(\)]+?)\$/?/g;
                    my $sth = $self->app->dbi($dsn)->prepare($qd);
                    my $rws = $sth->execute( @bv );
                    #my $ins=$dbh->{mysql_insertid}; push(@insid,$ins);
                    my $ins = $self->last_insert_rowid($table); push(@insid,$ins);
                    $sth->finish;
                };
                if($@){ return 'ABORT: '. $@ . "\n $qd \n".join(',',@bv); }
                #if($log){$str.=" SQ-$sqe->{'id'}{".$qd.join(',',@bv).")}<br>";}
            }
            if($log){
                if( $qd =~ /insert/i ) { $log_str.="insert {".join(',',@bv)."}"; }
                if( $qd =~ /delete/i ) { $log_str.="delete {".join(',',%$old_data)."}"; }
                elsif(!defined $rws || $rws ne '0E0'){
                    my $stri='';
                    foreach ( keys %$old_data ) {
                        if( defined $params->{$_} && $old_data->{$_} ne $params->{$_} ) {
                             $stri.="$_: $old_data->{$_} -> $params->{$_}, ";
                        }
                    }
                    if($stri){
                        $stri = substr($stri,0,-2);
                        $log_str .= "update {$stri}";
                    }
                }
            }
        }
    }    
    
    return $log_str;
}

sub aedx_insert {
    my ($self, %args) = @_;
    my ($queryes_ins, $queryes_del, $queryes_chk, $key_column, $params, $var, $dsn, $log) =
        @args{ qw/queryes_ins queryes_del queryes_chk key_column params var dsn log/ };
    my $log_str = '';    
    my @insid;
    
    if( scalar @$queryes_chk >0 ){                             # Check queryes
        my $check_res = '';
        for my $i ( 0..$#$queryes_chk ){
            my $qd = $queryes_chk->[$i];
            my @bv = $qd =~ /\$(.+?)\$/gs;
            #foreach( @bv ){ $_ = $params->{$_}; }
            foreach my $f ( @bv ){                             # using perl function md5_sum() in query
                if ($f =~ /md5_sum\((.+)\)/ ){
                    $f = md5_sum( $params->{$1} );
                } else {
                    $f = $params->{$f};
                }
            }
            $qd =~ s/\$(.+?)\$/?/g;
            if($var->{debug}){ $log_str .= "$qd ". join(",",@bv)."\n"; }
            else{
                eval{
                    my $sth = $self->app->dbi($dsn)->prepare($qd);
                    $sth->execute(@bv);
                    $check_res .= $sth->fetchrow_array;
                    $sth->finish;
                };
                if($@){ return 'ABORT: '. $@ . "\n $qd \n".join(',',@bv); }
            }
        }
        if($check_res){ return ( undef, 'ABORT: '.$check_res ); }
    }
    
    for my $i ( 0 .. $#$queryes_ins ){
        my $qd = $queryes_ins->[$i];
        my ($table) = $qd =~ /into\s+(\w+)\s/i;

        if($queryes_del->[$i]=~/IF_NULL\((.+)\)/){            # No insert if any listed fields is empty
            my @dc = $1=~/\$([\.\w\-\(\)]+?)\$/gs;
            foreach(@dc){
                if(!$params->{$_}){
                    $qd=''; last;
                }
            }
        }
        next if !$qd;

        my @bv = $qd =~ /\$([\.\w\-\(\)]+?)\$/gs;
        foreach( @bv ){ $_ = $ params->{$_}; }
        $qd =~ s/\$([\.\w\-\(\)]+?)\$/?/g;
        
        if ($var->{debug}){ $log_str .= "$qd ". join(",",@bv)."\n"; }
        else{
            if($qd =~ /\$INSERTID(\d)/){
                $qd =~ s/\$INSERTID\d/$insid[$1]/;
            }
            eval{
                my $sth = $self->app->dbi($dsn)->prepare($qd);
                $sth->execute(@bv);
            
                my $ins = $self->last_insert_rowid($table); push(@insid,$ins);
                $sth->finish;
            };
            if($@){ return 'ABORT: '. $@ . "\n $qd \n".join(',',@bv); }
            
            if($log){ $log_str.="insert {".join(',',@bv)."}"; }
        }
    }
    my $inserted_id = $insid[0];
    
    return ($inserted_id, $log_str);
}


################################################################

sub make_query{
    my ($self, $qdb, $params) = @_;
    
    my $qq=$qdb; my ($q1,$q2)=('',''); my $k=0;
    $qq=~s/\n/ /g;
    $qq=~s/\(S.*1\)/0/g; #remove inner select from columns
    $qq=~s/select(.+)from\ .+/$1/ig;
    $qq=~s/distinct//ig;
    $qq=~s/as\s'.+?'//ig;
    $qq=~s/as\s[^,^\s]+//ig;
    my @cc= split(/,\s*/,$qq);
    
    #my ($q1,$q2)=('',''); my $k=0;
    #my $clmn = $1 if $qdb =~ /select(.+?)from.+/igs;
    #$clmn =~ s/\(select.+limit\s1\)/0/ig;    # replace inner select to 0
    #$clmn =~ s/as\s\w+[,\s]|distinct//igs;
    #my @cc = $clmn =~ /[,\s]([\.\_\w\(\)]+?)[,\s]/gs;
    
    for my $i(0..$#cc){
        if (defined $params->{"c$i"} && $params->{"c$i"} ne ''){
            if ($cc[$i]=~/max\(/i){
                $cc[$i]=~s/max\((.*)\)/$1/ig;
            }

            if ($params->{"c$i"}=~/\|\|/){
                my @ccc=split(/\|\|/,$params->{"c$i"});
                $q1.=' and ('._mkfilter($cc[$i],$ccc[0]);
                for $k(1..$#ccc){
                    $q1.=' or '._mkfilter($cc[$i],$ccc[$k]);
                }
                $q1.=')';
            }
            elsif ($params->{"c$i"}=~/\&\&/){
                my @ccc=split(/\&\&/,$params->{"c$i"});
                $q1.=' and ('._mkfilter($cc[$i],$ccc[0]);
                for $k(1..$#ccc){
                    $q1.=' and '._mkfilter($cc[$i],$ccc[$k]);
                }
                $q1.=')';
            }
            else{
                $q1.=' and '._mkfilter($cc[$i],$params->{"c$i"});
            }
        }
    }
    if(exists $params->{'o'} && $qdb=~/order\s+by/i){
        $qdb=~s/order\ by.*//ig;
    }
    if($q1){
        if($qdb=~/group\ by/i){
            ($qdb,$q2)=split(/group/i,$qdb); $q2=' group'.$q2;
            if($params->{'o'} || $params->{'o'} eq '0'){$q2=~s/order\s+by.*//ig;}
        }
        if($qdb=~/order\s+by/i){
            $qdb=~s/order\ by.*//ig;
        }
        if($qdb=~/where/i){
            $qdb.=$q1;
        }
        else{
            $qdb.=" where".substr($q1,4);
        }
    }
    $qdb.=$q2;
    
    if( defined $params->{'o'} && $params->{'o'} =~/-/ ){
        my $order=" order by ".$cc[substr($params->{'o'},1)]." desc";
        $qdb.=$order;
    }
    elsif( exists $params->{'o'} && $params->{'o'} =~/^[-\d]+$/){
        my $order=" order by $cc[$params->{'o'}]";
        $qdb.=$order;
    }
    
    return $qdb;
}

sub _mkfilter {
    my ( $name, $cont ) = @_;
    if ($cont=~/^[<>]/){
        return qq($name $cont);
    }
    elsif ($cont=~/^=/){
        if ($cont!~/\'/){
            $cont=substr($cont,0,1)."'".substr($cont,1)."'";
        }
        return qq($name $cont);
    }
    elsif ($cont=~/^!=/){
        if ($cont!~/\'/){
            $cont=substr($cont,0,2)."'".substr($cont,2)."'";
        }
        return qq($name $cont);
    }
    elsif ($cont=~/^!~/){
        return qq($name not like '%).substr($cont,2).qq(%');
    }
    elsif ($cont=~/%/){
        return qq($name like '$cont');
    }
    elsif ($cont=~/^\d+,\d+$/){
        my($b, $e) = split(/,/,$cont); $b=~ s/-/''/eg;$e=~ s/-//g;
        return qq($name>=$b and $name<=$e);
    }
    else { return qq($name like '%$cont%'); }
}

1;
