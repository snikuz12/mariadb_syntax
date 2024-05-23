# linux에 db를 설치 -> local의 dump 작업 후 sql 쿼리 생성 -> github에 updload -> git clone ->linux에서 해당 쿼리 실행
# local에서 sql 덤프파일 생성
mysqldump -u root -p  board > dumpfile.sql
# 한글깨질때
mysqldump -u root -p board -r dumpfile.sql

# dump 파일을 github에 업로드

# 리눅스에서 mariab 서버 설치
sudo apt-get install mariadb-server

# mariadb 서버 시작
sudo systemctl start mariadb

# mariadvb 접속 테스트
sudo mariadb -u root -p

# git 설피 
sudo apt install git

# git을 통해 repo clone
git clone 레파지토리주소

mysql -u root -p board < dumpfile.sql

use board;

select * from author;