package Github;

use GITHUB_API qw(api_call);

use base qw(Exporter);
our @EXPORT = qw();

# Example Call
sub dummy_get{

    my ( $arg ) = @_;
    my $res = api_call("GET", "my/endpoint/$arg");
    return $res;

}

# Example Data JSON post
sub dummy_post{

    my ( $arg1, $arg2) = @_;
    my $data = "{ \\\"parent_key\\\" : { \\\"child_key\\\" : { \\\"grandchild_key\\\" : \\\"$arg1\\\" }}}";
    my $res = api_call("POST", "endpoint/foo/$arg2", $data);
    return $res; 

}
