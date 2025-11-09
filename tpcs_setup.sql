
-- tpcds_setup.sql
--
-- user 1
H:\duckdb\user1-token.bat
duckdb -init H:\duckdb\duck1_init md:
create database tpcds;
use tpcds;
CALL dsdgen(sf = 30);
create share;
.exit
cd H:\duckdb\tpcds
%py% tpcds_read_th.py md:tpcds


-- user 2
H:\duckdb\user2-token.bat
duckdb -init H:\duckdb\duck2_init md:
create database tpcds;
use tpcds;
CALL dsdgen(sf = 30);
create share;
.exit
cd H:\duckdb\tpcds
%py% tpcds_read_th.py md:tpcds

-- user 3 attaches to user 1
H:\duckdb\user3-token.bat
duckdb -init H:\duckdb\duck3_init md:
attach 'md:_share/tpcds/beeb1ee5-ffe1-40e0-a23c-bcb86d14f0af';
use tpcds;
.exit
cd H:\duckdb\tpcds
%py% tpcds_read_th.py md:tpcds

-- user 4 attaches to user 2
H:\duckdb\user4-token.bat
duckdb -init H:\duckdb\duck4_init md:
attach 'md:_share/tpcds/76e23c34-d0cf-4afc-82e6-d1b11bc47116';
use tpcds;
.exit
cd H:\duckdb\tpcds
%py% tpcds_read_th.py md:tpcds

