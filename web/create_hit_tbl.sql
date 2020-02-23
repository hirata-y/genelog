set names utf8;
use genelogdb;
create table hit_tbl(
    article_no varchar(10),
    hit_time timestamp not null default current_timestamp ,
    hit_cnt varchar(20),
    primary key(article_no)
);
