-- tinyint 는 -128~127까지 표현
-- author테이블에 age컬럼 추가

alter table add column age tinyint

--insert 시에 age : 200 -> 125
insert into author(id, email, age) value(5, "hello@test.com", 120);

-- unsigned 시에 255까지 표현범위 확대
alter table author modify column ahe tinyint unsigned;

-- decimal 실습
alter table post add column price decimal(10,3);

-- decial 소수점 초과 값 입력 후 짤림 확인
insert into post(id,title,price) value(10,'hello', 3.123123);

-- update : price를 1234.1 -> 1234.100으로 3자리 맞춰서 나옴
update post set price=1234.1 where id=10;