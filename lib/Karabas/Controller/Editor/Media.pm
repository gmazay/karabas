package Karabas::Controller::Editor::Media;
use Mojo::Base 'Karabas::Controller::Editor::Base';

sub get {
    my ($self, $c, $params) = @_;
    my $media_dir = $self->cfg->{media_dir};                 # relative path from the 'public' directory
    #my $filesize = -s "$media_dir/$params->{f}";
    
    if ( !defined $c->session('acl') || $c->session('acl') < 2 ){
        $c->render (text=>"Permission denied"); return;
    }
    
    if ( $params->{f} =~/\// ){
        $c->render (text=>"Bad filename: $params->{f}!"); return;
    }

    
    if( defined $params->{download} ) {
        $c->res->headers->content_disposition("filename=$params->{f}");
        #$c->res->headers->content_length($filesize);
        $c->res->headers->content_type('application/force-download');
    }
    else{
        $c->res->headers->content_type('audio/x-wav');
    }    
    $c->reply->static ( "$media_dir/$params->{f}" );
}


1;