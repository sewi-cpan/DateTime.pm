use strict;

use Test::More tests => 25;

use DateTime;


# tests using UTC times

# 1971-12-31T23:58:20 UTC
my $t = DateTime->new( year => 1971, month => 12, day => 31,
                       hour => 23, minute => 58, second => 20,
                       time_zone => 'UTC',
                     );
my $t1 = $t->clone;

# 1971-12-31T23:59:20 UTC
$t->add( seconds => 60 );
is( $t->minute, 59, "min");
is( $t->second, 20, "sec");

# 1972-01-01T00:00:19 UTC
$t->add( seconds => 60 );
is( $t->minute, 0, "min");
is( $t->second, 19, "sec");

# 1971-12-31T23:59:60 UTC
$t->subtract( seconds => 20 );
is( $t->minute, 59, "min");
is( $t->second, 60, "sec");
is( $t->{utc_rd_secs} , 86400, "rd_sec");


# subtract_datetime

my $t2 = DateTime->new( year => 1972, month => 1, day => 1,
                       hour => 0, minute => 0, second => 20,
                       time_zone => 'UTC',
                     );
my $dt = $t2 - $t1;
is( $dt->minutes, 2, "min duration");
is( $dt->seconds, 1, "sec duration");


# tests using floating times
# a floating time has no leap seconds

$t = DateTime->new( year => 1971, month => 12, day => 31,
                       hour => 23, minute => 58, second => 20,
                       time_zone => 'floating',
                     );
$t1 = $t->clone;

$t->add( seconds => 60);
is( $t->minute, 59, "min");
is( $t->second, 20, "sec");

$t->add( seconds => 60);
is( $t->minute, 0, "min");
is( $t->second, 20, "sec");

# subtract_datetime, using floating times

my $t2 = DateTime->new( year => 1972, month => 1, day => 1,
                       hour => 0, minute => 0, second => 20,
                       time_zone => 'floating',
                     );
my $dt = $t2 - $t1;
is( $dt->minutes, 2, "min duration");
is( $dt->seconds, 0, "sec duration");


# tests using time zones
# leap seconds occur during _UTC_ midnight

# 1971-12-31 20:58:20 -03:00 = 1971-12-31 23:58:20 UTC
$t = DateTime->new( year => 1971, month => 12, day => 31,
                       hour => 20, minute => 58, second => 20,
                       time_zone => 'America/Sao_Paulo',
                     );
# $t1 = $t->clone;

$t->add( seconds => 60 );
is( $t->datetime, '1971-12-31T20:59:20', "normal add");
is( $t->minute, 59, "min");
is( $t->second, 20, "sec");

$t->add( seconds => 60 );
is( $t->datetime, '1971-12-31T21:00:19', "add over a leap second");
is( $t->minute, 0, "min");
is( $t->second, 19, "sec");

$t->subtract( seconds => 20 );
is( $t->datetime, '1971-12-31T20:59:60', "subtract over a leap second");
is( $t->minute, 59, "min");
is( $t->second, 60, "sec");
is( $t->{utc_rd_secs} , 86400, "rd_sec");
