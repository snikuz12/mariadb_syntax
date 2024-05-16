-- 데이터베이스 접속
mariadb -u root -p

-- 스키마(database) 목록조회
show databases; 

-- board (스키마)데이터베이스 생성
CREATE DATABASE board;

-- (스키마)데이터베이스 삭제
drop board;

-- 데이터베이스 선택
use board;

-- 테이블 조회
show tables;

-- author 테이블 생성
create table author(id INT PRIMARY KEY,
 name VARCHAR(255),
 email VARCHAR(255),
 password VARCHAR(255)
 );

-- 테이블 컬럼 조회
describe author;

-- 컬럼 상세 조회
show full columns from author;

-- 테이블 생성문 조회
show create table author;

-- posts테이블 신규 생성(id, title, content, author_id)
create table posts(id int PRIMARY KEY,
 title VARCHAR(255), 
 content VARCHAR(255), 
 author_id INT,
 foreign key(author_id) references author(id)
 );

-- 테이블 index 조회
show index form author;
show index from posts;