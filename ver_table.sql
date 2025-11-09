-- ver_table.sql

create table ver(
 verno        INTEGER default 1,    
 tod          timestamp default current_timestamp,
 diff         float default 0.0,
 vertime      TIMEstamp  default current_timestamp,
 pgm          VARCHAR default '',
 verdate      DATE  default current_date
);
