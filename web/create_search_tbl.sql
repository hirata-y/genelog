set names utf8;
use genelogdb;
create table search_tbl(
    word varchar (20),
    search_time timestamp not null default current_timestamp ,
    search_cnt varchar (10),
    primary key (word)
);
