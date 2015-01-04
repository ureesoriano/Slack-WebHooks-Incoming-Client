Description
============
Perl client for Slack incoming webhooks

Synopsis
============
```perl
my $slack   = Slack::WebHooks::Incoming::Client->new($your_webhook_url);
my $channel = '@general';
my $message = 'Hello world!';
my $res = $slack->say($channel, $message);
die $res->{reason}  unless($res->{success});
```
Usage
============
### Slack::WebHooks::Incoming::Client->new ###
Arguments: webhook url (required).

For convenience, Slack's *webhook url can be passed via environment by setting $ENV{slack_webhook_incoming_url}*.
Upon creation, if no argument is passed to new, $ENV{slack_webhook_incoming_url} will be checked. 

### Slack::WebHooks::Incoming::Client->say ###
Arguments: channel (required), message (required).

