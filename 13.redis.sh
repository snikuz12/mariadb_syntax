sudo apt-get update
sudo apt-get install -y redis-server
redis-server --version

# 접속
# cli : commandline interface
redis-cli

# redis는 0~15번까지의 database 구성
# 데이타베이스 선택
select 번호(0번 디폴트)

# 데이터 베이스내 모든 키 조회
keys *

# 일반 string 자료구조
# key:value 값 세팅
set key(키) value(값)
set test_key1 test_value1
set user:email:1 yohan@test.com
# set할때 key값이 이미 존재하면 덮어쓰기 되는 것이 기본 
# 맵 저장소에서 key값은 유일하게 관리가 되므로
# nx : not exit set할때 key값이 이미 존재하면 덮어쓰기 X
set user:email:1 yohan@test.com nx
# ex(만료시간-초단위) - ttl(time to live)
set user:email:1 yohan@test.com ex 20


# get을 통해 value값 얻기
get test_key1

# 특정 key 삭제
del user:email:1

# 현재 데이터베이스 모든 key 값 삭제
flushdb

# 좋아요 기능 구현
set likes:posting:1 0
incr likes:posting:1 #특정 key값의 value를 1만큼 증가
decr likes:posting:1
get likes:posting:1

# 재고 기능 구현
set product:stock:1 100
decr product:stock:1
get product:stock:1
#bash쉘을 활용하여 재고감소 프로그램 작성