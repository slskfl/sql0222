use sqldb;

-- 회원 테이블 생성하기
create table usertbl( -- 회원테이블
	userID	char(8) not null primary key, -- 사용자 아이디(PK)
    name varchar(10) not null, -- 이름
    birthYear int not null, -- 출생년도
    addr char(2) not null, -- 지역(경기, 서울 식으로 2글자만 입력)
    mobile1 char(3),-- 휴대폰 국번( 011, 016,017,018, 010 등)
    mobile2 char(8), -- 휴대폰의 나머지 전화번호
    height smallint, -- 키
    mDate date -- 회원가입일
);

-- 회원 구매 테이블 생성하기
create table buytbl(
	num int auto_increment not null primary key, -- 순번(PK)
    userID char(8) not null, -- 아이디(FK)
    prodName char(6) not null, -- 물품명
    groupName char(4), -- 분류
    price int not null, -- 단가
    amount smallint not null, -- 수량
    foreign key(userID) references usertbl(userID) 
);

use sqldb;
-- 회원 테이블 레코드 삽입하기 
INSERT INTO usertbl VALUES('LSG', '이승기', 1987, '서울', '011', '1111111', 182, '2008-8-8');
INSERT INTO usertbl VALUES('KBS', '김범수', 1979, '경남', '011', '2222222', 173, '2012-4-4');
INSERT INTO usertbl VALUES('KKH', '김경호', 1971, '전남', '019', '3333333', 177, '2007-7-7');
INSERT INTO usertbl VALUES('JYP', '조용필', 1950, '경기', '011', '4444444', 166, '2009-4-4');
INSERT INTO usertbl VALUES('SSK', '성시경', 1979, '서울', NULL , NULL , 186, '2013-12-12');
INSERT INTO usertbl VALUES('LJB', '임재범', 1963, '서울', '016', '6666666', 182, '2009-9-9');
INSERT INTO usertbl VALUES('YJS', '윤종신', 1969, '경남', NULL , NULL , 170, '2005-5-5');
INSERT INTO usertbl VALUES('EJW', '은지원', 1972, '경북', '011', '8888888', 174, '2014-3-3');
INSERT INTO usertbl VALUES('JKW', '조관우', 1965, '경기', '018', '9999999', 172, '2010-10-10');
INSERT INTO usertbl VALUES('BBK', '바비킴', 1973, '서울', '010', '0000000', 176, '2013-5-5');

-- 회원테이블 레코드 확인하기
select* from usertbl;

use sqldb;
-- 구매 테이블 레코드 삽입
INSERT INTO buytbl VALUES(NULL, 'KBS', '운동화', NULL, 30, 2);
INSERT INTO buytbl VALUES(NULL, 'KBS', '노트북', '전자', 1000, 1);
INSERT INTO buytbl VALUES(NULL, 'JYP', '모니터', '전자', 200, 1);
INSERT INTO buytbl VALUES(NULL, 'KBS', '청바지', '의류', 50, 3);
INSERT INTO buytbl VALUES(NULL, 'BBK', '메모리', '전자', 80, 10);
INSERT INTO buytbl VALUES(NULL, 'SSK', '책' , '서적', 15, 5);
INSERT INTO buytbl VALUES(NULL, 'EJW', '책' , '서적', 15, 2);
INSERT INTO buytbl VALUES(NULL, 'EJW', '청바지', '의류', 50, 1);
INSERT INTO buytbl VALUES(NULL, 'BBK', '운동화', NULL, 30, 2);
INSERT INTO buytbl VALUES(NULL, 'EJW', '책' , '서적', 15, 1);
INSERT INTO buytbl VALUES(NULL, 'BBK', '운동화', NULL, 30, 2);

-- 구매테이블 레코드 확인하기
select* from buytbl;

-- 이름이 '김경호'인 회원을 조회하시오
select * from usertbl where name='김경호';

-- 1970년 이후에 출생하고 신장이 182이상인 사람의 아이디와 이름을 조회하시오.
select userID, name from usertbl where birthYear>=1970 and height>=182;

-- 키가 180~183인 사람을 조회하시오.
select name, height from usertbl where 180<=height and height<=183;

select name, height from usertbl where height between 180 and 183;

-- 지역이 ‘경남’, ‘전남’, ‘경북’, 인 사람의 이름, 주소를 조회하시오
use sqldb;
select name, addr from usertbl where addr='경남' or addr='전남' or addr='경북';
select name, addr from usertbl where addr in ('경남', '전남', '경북');


-- 성이 ‘김’씨인 사람의 이름과 키를 조회하시오
use sqldb;
select name, height from usertbl where name like'김%';

-- 성을 제외한 이름이 '종신‘인 사람의 이름 ( 성 포함)과 신장을 조회하시오
select name, height from usertbl where name like '_종신';

select name, height from usertbl where name like '%종신';

-- 이름이 ‘김경호’보다 키가 크거나 같은 사람의 이름과 키를 조회하시오
select name, height from usertbl 
where height>=( select height from usertbl where name='김경호');

-- 지역이 ‘경남’인 사람의 신장보다 크거나 같은 사람을 조회하시오.

-- ‘경남’인 사람이 두명 존재( 에러 )
select name, addr, height from usertbl 
where height>=( select height from usertbl where addr='경남');
-- any 구문 사용
select name, addr, height from usertbl 
where height>=any( select height from usertbl where addr='경남');
-- all 구문 사용
select name, addr, height from usertbl 
where height>=all( select height from usertbl where addr='경남');
-- any 구문 사용
select name, addr, height from usertbl 
where height=any( select height from usertbl where addr='경남');
-- in 구문 사용
select name, addr, height from usertbl 
where height in( select height from usertbl where addr='경남');
