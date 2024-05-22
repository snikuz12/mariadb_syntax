# linux에 db를 설치 -> local의 dump 작업 후 sql 쿼리 생성 -> github에 updload -> git clone ->linux에서 해당 쿼리 실행
# local에서 sql 덤프파일 생성
mysqldump -u root -p  board > dumpfile.sql
# 한글깨질때
mysqldump -u root -p board -r dumpfile.sql

# dump 파일을 github에 업로드