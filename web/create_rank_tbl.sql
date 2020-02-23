set names utf8;
use genelogdb;
create table rank_tbl(
    article_no varchar(10),
    hit_cnt varchar(20),
    favorite_cnt varchar(20),
    primary key(article_no)
);
