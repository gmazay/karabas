package Karabas::Tmpl;
use Exporter();
@ISA = qw(Exporter);
@EXPORT = qw(&select_field);
use strict;

sub select_field {
    my ($f, $name, $value, $val_by_key) = @_;
    my $rv = "<select name='$name' class='field0'>";

    for my $i( 0..$#{$f->{data}} ){
        if ($value eq $f->{data}->[$i][0]){
            return $f->{data}->[$i][1] if defined $val_by_key && $val_by_key;
            $rv .= "<option selected='selected' value='$f->{data}->[$i][0]'>$f->{data}->[$i][1]</option>";
        }
        else{
            $rv .= "<option value=$f->{data}->[$i][0] >$f->{data}->[$i][1]</option>";
        }
    }
    $rv.="</select>";
    
    return $rv;
}









1;
