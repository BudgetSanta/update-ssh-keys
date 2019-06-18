package GITHUB_API;

use base qw(Exporter);
our @EXPORT = qw(api_call);

# URL
my $url = "https://github.com/MY/API/STUFF"

# TOKEN
my $token_name = "github_token.txt"
my $token_dir = ""                  # relative dir change if token not in current dir

my $token_loc = $token_dir . $token_name;
die "ERROR: Token not found at $token_loc\n" if not -f $token_loc;
open F, "<", $token_loc;
$token=<F>;
chomp $token;
close F;

# Takes in API Response and gives human readable error if needed
# $res : string : api response text
sub check_api_error { my ( $res ) = @_; 
    if ($res =~ /errorCode":/) {
        my $error_code = $res;
        my $error_summary = $res;
        # TODO: Change to make work with Github
        #$error_code =~ s/^.*"errorCode":"(E[0-9]+)".*$/$1/;
        #$error_summary =~ s/^.*"errorSummary":"([^"]+)".*$/$1/;
        #die "Error [$error_code]: $error_summary\n";
    }

    return $res;
}

# Generic API Call
# $method : string : API Call method, ie GET, POST, DELETE, etc
# $endpoint : string : URL endpoint that goes after the base URL
# $data (optional) : string : JSON formatted string with data payload in call
sub api_call {

    my ( $method, $endpoint, $data ) = @_;
    $endpoint =~ s/^$url//; # removes base url if present
    $endpoint =~ s/^\///;   # removes leading slash if present
    
    # Setting up the headers
    my $call = "curl --silent -X $method \\
    -H \"Accept: application/json\" \\
    -H \"Content-Type: application/json\" \\
    -H \"Authorization: SSWS $token\" \\\n";
    
    # If data payload provided, include
    if (defined $data) {
        $call .= "-d \"$data\" \\\n"
    }

    # Add URL on to the call
    $call .= "$url/$endpoint";
    
    my $res = `$call`;
    check_api_error($res);
    return $res;

}

return 1;
