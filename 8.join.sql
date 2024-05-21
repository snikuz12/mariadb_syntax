-- inner join
-- 두 테이블 사이에 지정된 조건에 맞는 레코드만 반환. on 조건을 통해 교집합 찾기
select * from author inner join post on author.id=post.author_id;
select * from author a inner join post p on a.id = p.author_id;

-- 글쓴이가 있는 글 목록과 글쓴이의 이메일을 출력하시오.
select p.id, p.title, p.email from post p inner join author a on p.author_id = a.id; -- 익명글은 다 날라감.

-- 모든 글목록을 출력하고, 만약에 글쓴이가 있다면 이메일을 출력
select p.id, p.title, p.contents, a.email from post p left outer join author a on p.author_id = a.id; -- 왼쪽 테이블 데이터 모두 나옴

-- join된 상황에서의 where 조건 : on 뒤에 where 조건이 나옴
-- 1)글쓴이가 있는 글 중에 글의 title과 저자의 email을 출력, 저자의 나이는 25에 이상인 글만
-- 2)모든 글 목록 중에 글의 title 과 저자가 있다면 email을  출력, 2024-05-01 이후에 만들어진 글만 출력
-- on 조건은 JOIN 사용할 때, where 전반적으로 사용
SELECT p.title, a.email FROM post p JOIN author a ON p.author_id = a.id WHERE a.age >= 25;
-- inner join 이기 때문에 post p 와 author a 순서 상관 X 
select p.title, ifnull(a.email, '익명')  from post p left outer join author a on a.id=p.author_id where p.title is not null and p.created_time > 2024-05-01;
-- join은 on과 콤보


-- 실습 조건에 맞는 도서와 저자 리스트 출력


-- union : 중복제외한 두 테이블의 select을 결합
-- 컬럼의 개수와 타입이 같아야함에 유의
-- union all : 중복포함
select 컬럼1, 컬럼2 from table1 union select 컬럼1, 컬럼2 from table2;
-- author 테이블의 name, email 그리고 post테이블의 title, contents union
select name, email from author union select title, contents from post;

-- 서브쿼리 : select문 안에 또다른 select문을 서브쿼리라 한다.

-- select절 안에 서브쿼리
-- author email과 해당 author 가 쓴 글의 개수를 출력
select email, (select count(*) from post p where p.author_id = a.id) as count from author a;

-- from절 안에 서브 쿼리
select a.name from (select * from author) as a;

-- where절 안에 서브쿼리
-- 글을 쓴적이 있는 author만 조회
select a.* from author a inner join post in a.id = p.author_id;
select * from author where id in (select author_id from post);

-- 없어진 기록 찾기 문제 : 
-- join으로 풀 수 있는 문제, subquery로도 풀어주면 좋음

-- 집계함수
select count(*) from author;
select sum(price) from post;
select round(avg(price),0) from post;

-- group by와 집계함수
select author_id from post group by author_id;
select author_id, count(*) from post group by author_id
select author_id, count(*), sum(price), round(avg(price), 0),min(price), max(price) from post group by author_id;

-- 저자 email, 해당저자가 작성한 글 수를 출력

select a.id, if(p.id is null, 0, count(*)) from author a left join post p on a.id = p.author_id group by a.id;

-- where 와 group by
-- 연도별 post 글 출력, 연도가 null인 데이터는 제외
select date_format(created_time, '%Y') as year, count(*)
from post
where created_time is not null
group by year;

-- 자동차 종류 별 특정 옵션이 포함된 자동차 수 구하기

-- 입양 시각 구하기

-- having : group by 를 통해 나온 통계에 대한 조건
select author_id, count(*) from post group by author_id;
-- 글을 2개 이상 쓴 사람에 대한 통계 정보
select author_id, count(*) as count from post group by author_id having count >=2;
-- 실습 포스팅price가 2000원이상인 글을 대상으로,
-- 작성자별로 몇건인지와 평균price를 구하되,
-- 평균 price가 3000원 이상인 데이터를 대상으로만 통계 출력
select author_id, avg(price)as avg_price from post
where price >=2000
group by author_id having avg_price >= 3000;

-- 동명 동물 수 찾기

-- 실습2) 2건 이상의 글을 쓴 사람의 id와 email을 구할건데
-- 나이는 25세 이상인 사람만 통계에 사용하고 결과 반환 
select  a.id, count(a.id) as cnt, a.email
from author a
inner join post p
    on a.id=p.author_id
where a.age>=25 
group by a.id
having cnt >= 2;

select  a.id, count(a.id) as cnt, a.email
from author a
inner join post p
    on a.id=p.author_id
where a.age>=25 
group by a.id
having cnt >= 2
order by max(a.age) desc limit 1; -- order by 추가한 버전

-- 다중열 group by
select author_id, title, count() as cnt -- 두번 grouping 한 것의 카운트 
from post
group by author_id, title;

-- 재구매가 일어난 상품과 회원 리스트 구하기
select USER_ID, PRODUCT_ID
from ONLINE_SALE
group by USER_ID, PRODUCT_ID
having count(*) >= 2 -- 재구매한 횟수 
order by USER_ID asc, PRODUCT_ID desc;
