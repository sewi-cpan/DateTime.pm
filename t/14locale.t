use strict;

use Test::More tests => 6;

use DateTime;

eval { DateTime->new( year => 100, locale => 'en_US' ) };
ok( ! $@, 'make sure constructor accepts locale parameter' );

eval { DateTime->now( locale => 'en_US' ) };
ok( ! $@, 'make sure constructor accepts locale parameter' );

eval { DateTime->today( locale => 'en_US' ) };
ok( ! $@, 'make sure constructor accepts locale parameter' );

eval { DateTime->from_epoch( epoch => 1, locale => 'en_US' ) };
ok( ! $@, 'make sure constructor accepts locale parameter' );

eval { DateTime->last_day_of_month( year => 100, month => 2, locale => 'en_US' ) };
ok( ! $@, 'make sure constructor accepts locale parameter' );

{
    package DT::Object;
    sub utc_rd_values { ( 0, 0 ) }
}

eval { DateTime->from_object( object => (bless {}, 'DT::Object'), locale => 'en_US' ) };
ok( ! $@, 'make sure constructor accepts locale parameter' );
