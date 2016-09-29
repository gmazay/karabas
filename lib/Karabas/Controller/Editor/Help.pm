package Karabas::Controller::Editor::Help;
use Mojo::Base 'Karabas::Controller::Editor::Base';

sub get {
    my ($self, $c, $params) = @_;

    my $qdb = "SELECT * FROM query_help WHERE status=1 AND chapter=?";  
    my $rh = $c->model->get_row_hashref($qdb, $params->{id});
    
    my $result = "<h3>К сожалению, инструкции к данному разделу ($params->{id}) пока не написано.</h3>";
    if (defined $rh->{body}){
        $result = "<h2>$rh->{head}</h2> $rh->{body}";
        $result =~ s/\n/<br>/g;
    }
    
    my $close_btn = qq{<img src="/pic/cl.gif" title="Закрыть" onclick="javascript: xShut('$params->{target}')" style="position: absolute; cursor: pointer; right: 2px;top:2px" border="0">};
    
    $c->render(text => $close_btn.$result);
}


1;