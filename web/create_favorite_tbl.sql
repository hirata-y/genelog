set names utf8;
use genelogdb;
create table favorite_tbl(
    favorite_no SERIAL,
    user_no varchar(10),
    article_no varchar(10),
    primary key(favorite_no)
);