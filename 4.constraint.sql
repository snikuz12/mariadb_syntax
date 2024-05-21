-- not null 조건 추가
alter table 테이블명 modify column 컬럼명 타입 not null;

-- auto_incerment
alter table author modify column id bigint auto_increment; 
alter table post modify column id bigint auto_increment; 

-- post에서 author.id 에서 제약조건을 가지고 있다보니 author.id에 새로운 제약조건을  추가하는 부분에서 문제발생
Error Code: 1833. Cannot change column 'id': used in a foreign key constraint 'post_ibfk_1' of table 'board.post'

-- fk 먼저 제거 이후에 author.id에 제약조건 추가

-- 제약조건 조회
SELECT * FROM INFORMATION_SCHEMA.KEY_COLUMN_USAGE WHERE TABLE_NAME = 'post' ;

-- 삭제
alter table post drop foreign key post_ibfk_1;

-- 삭제된 제약조건 다시 추가
alter table post add constraint post_ibfk_1 foreign key(author_id) references author(id);

-- uuid
alter table post add column user_id char(36) not null default (UUID());

-- unique 제약조건
alter table author modify column email varchar(255) unique;

-- on delete cascade 테스트 -> 부모테이블의 id 수정 x
SELECT * FROM INFORMATION_SCHEMA.KEY_COLUMN_USAGE WHERE TABLE_NAME = 'post' ;
alter table post drop foreign key post_ibfk_1 foreign key(author_id) references author(id) on delete cascade;

-- 삭제
alter table post drop foreign key post_author_fk;
alter table post add constraint post_author_fk foreign key(author_id)

-- 실습 delete는 set null, update cascade
