package Okta;

use OKTA_API qw(api_call);

use base qw(Exporter);
our @EXPORT = qw(clear_user_sessions set_user_password deactivate random_password expire_password get_user get_user_id get_me);

# Clear user sessions
# $id : string : user id
sub clear_user_sessions {

    my ( $id ) = @_;
    my $res = api_call("DELETE", "users/$id/sessions");
    return $res;

}

# Sets user password
# $id : string : user id
# $pass : string : password to set on user's account
sub set_user_password {

    my ( $id, $pass ) = @_;
    my $data = "{ \\\"credentials\\\" : { \\\"password\\\" : { \\\"value\\\" : \\\"$pass\\\" }}}";
    my $res = api_call("POST", "users/$id", $data);
    return $res; 

}

# Deactivates User
# $deactivate_url : string : user specific deactivation url endpoint
sub deactivate {

    my ( $deactivate_url ) = @_;
    my $res = api_call("POST", $deactivate_url);
    return $res;

}

# Random Password String
# $len (optional, default 25) : int : number of characters in the password
# RETURN : string : randomly generated string 
sub random_password {
    
    my ( $len ) = @_;
    if (not defined $len) {
        $len = 25;
    }
    
    my @chars = ("A".."Z", "a".."z", "0".."9", " "); 
    my $password;
    $password .= $chars[rand @chars] for 1..$len;

    return $password;

}

# Expire user password
# $id : string : user id
sub expire_password {
    
    my ( $id ) = @_;
    my $res = api_call("POST", "users/$id/lifecycle/expire_password");
    return $res;

}

# Takes username and returns the user id
# $username : string : username
# RETURN : string : Corresponding user id
sub get_user_id {

    my ( $username ) = @_;
    my $id = get_user($username);
    $id =~ s/^.*"id":"([a-zA-Z0-9]+)",.*$/$1/;
    return $id;

}

# Takes username and returns user object
# $username : string : Username
# RETURN : string : json user object as string
sub get_user {

    my ( $username ) = @_;
    my $res = api_call("GET", "users/$username");
    return $res;

}

# Gets the details of the currently authenticated user
# RETURN : string : json user object as string
sub get_me {

    my $res = api_call("GET", "users/me");
    return $res;

}
