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

-- blob 바이너리 데이터 실습
-- author 테이블에 profile_image 컬럼 blob 형식으로 추가
alter table author add column profile_image blob;
alter table author modify column profile_image longblob;
-- c드라이브 바로 아래 png/jpg사진 저장 
insert into author(id, email, profile_image) values(8, 'abc@naver.com', LOAD_FILE('C:\abc.png'));

-- enum : 삽입될 수 있는 데이터의 종류를 한정하는 데이터 타입
-- role 컬럼
alter table author add column role varchar(10);
-- role에 user와 admin 도메인값으로 제한을 걸겠다 
-- not null로 주면 default 옵션 없이 제일 첫번째꺼가 기본으로 들어감 
alter table author add column role enum('user', 'admin') not null;
-- default 옵션 사용 
alter table author add column role enum('user', 'admin') not null default 'user';

-- data 타입
-- author 테이블에 birth_day 칼럼을 date로 추가
-- 날짜 타입의 insert는 문자열 형식으로 insert
alter table author add column birth_day date;
insert into author (id, email, birth_day) values(13, 'hello@world.com', '1998-04-11');

-- datetime 타입
-- author, post 둘다 datetime으로 created_time 컬럼추가
alter table author add column created_time datetime;
alter table post add column created_time datetime;
insert into author (id, email,created_time) values(14, 'test@test.com', '2024-05-17');
insert into post (id, title, contents, created_time) values(77, 'asd', 'contents', '2024-05-17 12:12:12');


alter table author modify column created_time datetime default current_timestamp;
insert into author(id, email) values(15,'hello@test.com');
alter table post modify column created_time datetime default current_timestamp;
insert into post(id, title) values(12,'hello'); 

-- 비교연산자
-- and 또는 && , or 또는 ||, not 또는 !
select * from post where id >=2 and id<=4;
select * from post where id between 2 and 4;
select * from post where not(id >40 or id < 20;)

-- null인지 아닌지
select * from post where contents is null;
select * from post where contents is not null;

-- in(리스트 형태), not in()
select * from post where id in(1,2,3,4);
select * form post where id not in(1,2,3,4);

-- like : 특정 문자를 포함하는 데이터를 조회하기 위해 사용하는 키워드
select * from post where title like '%o' --o로 끝나느 title 검색
select * from post where title like '%k' --k로 끝나는 title 검색

select * from post where title not like '%o'  --o로 끝나는 title 이 아닌 title검색

-- ifnull(a,b) : 만약에 a가 null이면 b반환, null이 아니면 a반환
select title, contents, ifnull(author_id, '익명')as writer from post;

-- REGEXP : 정규표현식을 활용한 조회
select * from author where name regexp '[a-z]';

-- 날짜 변환 : 숫자 -> 날짜, 문자 -> 날짜
-- CAST 와 CONVERT
select CAST(20200101 as date);
select cast('20200101' as date );
select convert(202001011,date);
select convert('20200101', date);

-- datetime  조회방법
select * from post where created_time like '2024%';
select * from post where created_time <= '2024-01-01' and created_time >= '1999-01-01';
select * from post where created_time <= between '2024-01-01' and '1999-01-01';

-- date_format
select date_format(created_time, '%Y-%m') from post;

-- post를 조회할때 date_format 활용하여 2024년 데이터 조회
select * from post where date_format(created_time, '%Y') = '2024';

-- 오늘 날짜
select now();
