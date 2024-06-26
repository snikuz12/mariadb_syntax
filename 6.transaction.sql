-- author 테이블에 post_count 라고 컬럼(int) 추가
ALTER TABLE author ADD column post_count int;
ALTER TABLE author modify column post_count int default 0; -- post_count default 0으로 변경

-- post에 글쓴 후에 author 테이블에 post_count 값에 +1 => 트랜잭션
-- 두 쿼리를 하나로 묶으려면 start transaction 사용
start transaction;
update author set post_count = post_count + 1 where id = 1; -- 구문1만 성공, 임시저장된 상태로update
insert into post( title, author_id) values('hello world java', 13); --구문2 실패
-- id 1~12 까지 있음
-- 위 쿼리들이 정상실행됐으면 x, 
commit;
-- 또는
rollback;

-- stored 프로시저를 활용한 트랜잭션 테스트
-- stored 프로시저를 활용한 트랜잭션 테스트
DELIMITER //
CREATE PROCEDURE InsertPostAndUpdateAuthor()
BEGIN
    DECLARE exit handler for SQLEXCEPTION
    BEGIN
        ROLLBACK;
    END;
    -- 트랜잭션 시작
    START TRANSACTION;
    -- UPDATE 구문
    UPDATE author SET post_count = post_count + 1 where id = 1;
    -- INSERT 구문
    insert into post(title, author_id) values('hello world java', 5);
    -- 모든 작업이 성공했을 때 커밋
    COMMIT;
END //
DELIMITER ;

-터미널에서 아래 insert문 실행
insert into author(name, email) values('hwang', 'hwang@test.com');

-- lost update 이슈를 해결하기 위한 공유락(shard lock)
-- 워크벤치에서 아래 코드실행
start transaction;
select post_count from author where id=1 lock in share mode;
do sleep(15)
select post_count from author where id=1 lock in share mode;
commit;

-- 터미널에서 실행
select post_count from author where id=1 lock in share mode;
update author set post_count=0 where id=1;

-- 베타적 잠금(exclusive lock) : select for update
-- select 부터 lock
start transaction;
select post_count from author where id=1 for update;
do sleep(15)
select post_count from author where id=1 for update;
commit;

select post_count from author where id=1 for update;
update author set post_count=0 where id=1;