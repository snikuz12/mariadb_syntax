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


캐싱 기능 구현
1번 author 회원 정보 조회
select name, email,age from author where id=1; (sql)
위 데이터의 결과값을 redis로 캐싱 : json 데이터 형식으로 저장
redis에서 {}사용할 때 -> 양쪽을 ""처리
set user:1:detail "{"name":"hong", "email":"hong@test.com", "age":30}"

================================list================================
list
redis의 list는 자바의 deque와 같은 구조임 (double-ended queue 양방향 가넝)
# 데이터 왼쪽 삽입
LPUSH key value 
# 데이터 오른쪽 삽입
RPUSH key value
# 데이터 왼쪽부터 꺼내기
LPOP key
# 데이터 오른쪽부터 꺼내기
RPOP key 

# 어떤 목적으로 활용가능 ?
# 최근 방문한 페이지 조회 / 최근 본 상품 목록
# 반대로 오래된 방문 페이지 조회 / 오래된 상품 목록 조회
lpush hongildongs hong1 # hongildongs가 list명
lpush hongildongs hong2
lpush hongildongs hong3
hong3 hong2 hong1 (위 순서)
lpop hongildongs # hong3출력
rpop hongildongs # hong1 출력 

#꺼내서 없애는게 아니라, 꺼내서 보기만
lrange key -1 -1

#데이터 개수 조회 (list)
llen key
llen names

#list의 요소 조회시, 범위 지정
lrange key start end # start, end 모두 포함 
lrange hongildongs 0 -1 # 처음부터 끝까지 

# list에 ttl 주기 (제한시간)
expire key time 
expire hongildongs 30
ttl 조회
ttl key 
ttl hongildongs

# pop과 push를 동시
rpoplpush a_list b_list # a_list에서 rpop을 하고 b_list에 lpush
# 페이지 뒤로 갔다 앞으로 갔다
# 최근 방문한 페이지
#5개 데이터 push -> 최근 방문한 페이지 3개정도 보여주기
rpush page www.naver1.com
rpush page www.naver2.com
rpush page www.naver3.com
rpush page www.naver4.com
rpush page www.naver5.com

rpop page
rpop page
rpop page 
lrange 활용
lrange page 2 -1 # 가능하긴 한데 갯수를 아는 경우에만 가능함 (적절하진 않음)

# rpoplpush 활용 실습
위 방문 페이지 (page) 리스트에서 뒤로가기 앞으로가기 구현
뒤로가기 페이지를 누르면 뒤로가기 페이지가 뭔지 출력
다시 앞으로가기 누르면 앞으로간 페이지가 뭔지 출력
실패한 실습 [lpoprpush가 없어서]
lrange page -1 -1 # 마지막 페이지 조회 
rpoplpush page page2
lrange page2  0 0
lrange page2 -1 -1 # 마지막 페이지 조회 
lpoprpush page2 page # rpoplpush만 존재 ㅜㅜ lpoprpush는 없음

# set 자료구조
# set 자료구조 멤버추가
sadd members member1
sadd members member2
sadd members member1

# set 조회
smembers members
# set 에서 멤버 삭제
srem members member2
# set 멤버 개수 반환
scard members
# 특정 멤버가 set안에 있는지 존재 여부 확인
sismember members member3

# 매일 방문자수 계산
sadd visit:2024-05-27 yohan@test.com

# zset(sorted set)
zadd zmembers 3 member1
zadd zmembers 4 member2
zadd zmembers 1 member3
zadd zmembers 2 member4

# score 기준 오름차순 정렬
zrange zmembers 0 -1

# score 기준 내림차순 정렬
zrevrange zmembers 0 -1

# zset 삭제
zrem zmembers member2
# zrank는 해당 멤버가 index몇번째인지 출력
zrank zmembers member2

# 최근 본 상품목록 => sorted set (zset) 울 활용하는 것이 적절
zadd recent:products 192411 apple
zadd recent:products 192415 banana
zadd recent:products 192420 orange
zadd recent:products 192425 apple
zadd recent:products 192430 apple

=> 덮어쓰기 되겠지  zadd recent:products 192413 apple
# 이런 식으로 시간순으로 집어넣으면 마지막꺼만 남아있을 것 같다.
zrevrange recent:products 0 2

# hashes
# 해딩 자료구조에서는 문자, 숫자가 구분
hset product : 1 name "apple" price 1000 stock 50
hget product : 1 proce
# 모든 객체값 get
hgetall product:1
# 특정 요소값 수정
hset product:1 stock 40

# 특정 요소의 값을 증가
hincrby product:1 stock -5
hget product:1 stock