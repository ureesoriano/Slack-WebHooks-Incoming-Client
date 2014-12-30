package Slack::WebHooks::Incoming::Client;
# ABSTRACT: Perl client for Slack incoming webhooks

use Moo;
use JSON;
use Carp;
use HTTP::Tiny;


has hook_url => (
    is       => 'ro',
    builder  => '_build_hook_url',
    required => 1,
);


sub _build_hook_url {
    my ($self, $arg) = @_;
    my $url = $arg
        ? $arg
        : $ENV{slack_webhook_incoming_url};
    die 'Please specify a Slack WebHook URL'  unless($url);
    return $url;
}

sub say {
    my($self, $channel, $message) = @_;
    die "'channel' is a required argument"  if(!$channel);
    die "'message' is a required argument"  if(!$message);

    my $payload = {
        text    => $message,
        channel => $channel,
    };
    my $res = HTTP::Tiny->new->request('POST', $self->hook_url, {
        content => encode_json $payload,
    });

    return $res->{success} 
        ? {success => 1}
        : {success => 0, reason => "$res->{status} - $res->{reason}: $res->{content}"};
}


1;
