-- insert into : 데이터 삽입
insert into 테이블명(컬럼1, 컬럼2, 컬럼3) values(데이터1, 데이터2, 데이터3);

-- id, name, email -> author
insert into author(id , name , email ) values(1, 'yohan', 'snikuz12@naver.com');

-- select : 데이터 조회, * : 모든 컬럼 조회
select * from author;

-- id, title, content, author_id -> post에 1건 추가
insert into posts(id, title, content, author_id) values (1, 'hungry', 'lunch');
select * from posts;

-- 테이블 제약조건 조회  
select * from information_schema.key_column_usage where table_name = 'posts';