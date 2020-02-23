set names utf8;
use genelogdb;
create table archive_tbl(
    archive_no SERIAL,
    user_no varchar(10),
    article_no varchar(10),
    insert_time timestamp not null default current_timestamp,
    action varchar(1),
    primary key(archive_no)
);