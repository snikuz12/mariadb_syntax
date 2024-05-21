-- dirty raed 실습
-- 워크벤츠에서 auto_commit 해제 후 update 상향 ->   commit 이 안된상태
-- 터미널을 열어서 select 했을때 변경사항이 변경됐는지 확인

-- phantom read 동시성 이슈 실습
-- 워크벤치에서  시간을 두고 2번 delect가 이뤄지고
-- 터미널에서 중간에 insert 실행 -> 2번의 selet 결과값이 동일한지 확인
START TRANSACTION
select * from author;
do sleep(15);
select * from author;
commit;
-- 터미널에서 아래 insert문 실행
insert into author(name, email) values('hwang', 'hwang@test.com');