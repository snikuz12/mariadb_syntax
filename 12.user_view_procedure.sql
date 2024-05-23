-- 사용자관리
-- 사용자 목록 조회
select * from mysql.user;

-- 사용자 생성
-- %는 원격 포함한 anywhere 접속
create user 'test1'@'localhost' identified by '4321';

-- 사용자에게 select 권한 부여
grant select on board.author to 'test1'@'localhost';

-- 사용자 권한 회수
revoke select on board.author from 'test1'@'localhost';

-- 환경설정을 변경 후 확정
flush privileges;

-- test1으로 로그인 후에
select * from board.author;

-- 권한 조회
show grants for 'test1'@'localhost';

-- 사용자 계정 삭제
drop user 'test1'@'localhost';


-- view
-- view 생성
create view author_for_marketing_team as
select name age, role from author;

-- view 조회
select * from author_for_marketing_team;

-- view에 권한부여
grant select on board.author_for_marketing_team TO ...;


-- view 변경(대체)
create or replace view author_for_marketing_team as
select name, email, age, role from author;

-- view 삭제
drop view author_for_marketing_team

-- 프로시저 생성
DELIMITER //
create procedure test_procedure()
begin
    select 'hello world';

end
// DELIMITER ;

-- 프로시저 호출
call test_procedure();

-- 프로시저 삭제
drop procedure test_procedure;

-- 게시글목록조회 프로시저 생성
DELIMITER //
create procedure 게시글목록조회()
begin
    select * from post;

end
// DELIMITER ;

call 게시글목록조회();

-- 게시글 단건 조회
DELIMITER //
create procedure 게시글단건조회(in postId int)
begin
    select * from post where id = postId ;

end
// DELIMITER ;

call 게시글목록조회(3);
--------------------------------------------

DELIMITER //
create procedure 게시글단건조회(in postId int, in 제목 varchar(255))
begin
    select * from post where author_id = 저자id and title = 제목 ;

end
// DELIMITER ;


call 게시글단건조회(4,'hello');

-- 글쓰기 : title, contents, 저자ID
DELIMITER //
create procedure 글쓰기(in titleInput varchar(255), in contentsInput varchar(3000), in 저자ID int)
begin
    insert into post( title, contents, author_id) values ( titleInput,contents, 저자ID);

end
// DELIMITER ;

call 글쓰기('점심','먹고싶다', 99);

-- 글쓰기2 : title,contents, email
DELIMITER //
create procedure 글쓰기2(in titleInput varchar(255), in contentsInput varchar(3000), in emailInput varchar(255))
begin
    declare authorId int;
    select id into authorId from author where email = emailInput;
    insert into post( title, contents, author_id) values ( titleInput,contentsInput, authorId);
end
// DELIMITER ;

call board.글쓰기2('제목', '컨텐츠', 'test@test.com');

-- sql에서 문자열 합치는 concat('hello', 'world');
-- 글상세조회 : input 값이 postId
-- title, contents, '홍길동' + '님'
-- SET email = CONCAT('yohan', i, '@naver.com');

DELIMITER //
create procedure 글상세조회(in postId int)
begin
	declare authorName varchar(255);
    select name into authorName from author where id = (select author_id from post where id = postId);
    set authorName = concat(authorName, '님');
    select title, contents, authorName from post where id = postId;
end
// DELIMITER ;

-- 등급조회
-- 글을 100개 이상 슨 사용자는 고수입니다. 출력
-- 10개 이상 100개 미안이면 중수입니다.
-- 그외는 초보입니다
-- input값 : email

DELIMITER //
create procedure 등급조회(in email varchar(255))
begin
	declare authorId int;
    declare count int;
    select id into authorId from author where email = email;
    select count(*) into count from post where author_id = author_id;
    if count >= 100 then
        select '고수입니다.' ;
    elslf count >= 10 and count < 100 then
        select '중수입니다.' ;
    else
        select '초보입니다.' ;
    end if;
end
// DELIMITER ;

call board.등급조회('abc@ttest.com');


-- 반복을 통해 post 대량생성
-- 사용자가 입력한 반복 횟수에 따라 글이 도배되는데, title은 '안녕하세요
DELIMITER //
CREATE procedure 글도배(in count int)
begin
    declare countValue int default 0;
    while countValue < count DO
        insert into post(title) values('안녕하세요');
        set countValue = countValue + 1;
    end while;
end
// DELIMITER ;

-- 프로시저 권한 부여
show create procedure 프로시저명;

-- 프로시저 권한 부여
grant excute on board.글도배 to 'test1'@'localhost';