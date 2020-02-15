set names utf8;
use genelogdb;
create table user_tbl(
    user_no SERIAL,
    user_name varchar(20),
    user_pass varchar(20),
    user_mail varchar(100),
    user_birth date,
    user_sex varchar(1),
    primary key(user_no)
);
