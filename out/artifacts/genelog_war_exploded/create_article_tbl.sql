set names utf8;
use genelogdb;
create table article_tbl(
    article_no SERIAL,
    user_no varchar(20),
    title varchar(200),
    text varchar(1500),
    term varchar(100),
    address varchar(200),
    design varchar(20),
    primary key(article_no)
);
