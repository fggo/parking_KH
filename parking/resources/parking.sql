-- DATABASE
DROP DATABASE if exists parkingdb;
CREATE DATABASE if not exists parkingdb;
USE parkingdb;


-- TABLE
DROP TABLE USER;
CREATE TABLE USER (
    user_code VARCHAR(20) NOT NULL COMMENT '회원코드',
    email VARCHAR(20) NOT NULL COMMENT '이메일',
    pw VARCHAR(20) NOT NULL COMMENT '비밀번호',
    phone VARCHAR(20) NOT NULL COMMENT '폰번호',
    user_name VARCHAR(20) NOT NULL COMMENT '회원이름',
    user_addr VARCHAR(50) NOT NULL COMMENT '회원주소',
    -- modification_time DATETIME ON UPDATE CURRENT_TIMESTAMP
    created_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '가입날짜',
    login_date DATETIME COMMENT '최근 로그인날짜',
    sms_yn CHAR(1) NOT NULL COMMENT '문자 수신여부(Y/N)',
    email_yn CHAR(1) NOT NULL COMMENT '이메일 수신여부(Y/N)',

    CONSTRAINT pk_user_usercode PRIMARY KEY(user_code),
    CONSTRAINT chk_user_sms CHECK (sms_yn in ('Y','N')),
    CONSTRAINT chk_user_email CHECK (email_yn in ('Y','N'))
);

desc user;

INSERT INTO USER VALUES(
    '02201', 'taese@ml.com', 'tetpw', '010-t-11',
    '댕댕이2', '경기도2', DEFAULT, DEFAULT, 'N', 'y'
);

select * from user;

SHOW CREATE TABLE USER;
-- ALTER TABLE USER MODIFY COLUMN user_code VARCHAR(20) COMMENT '회원 코드';
-- ALTER TABLE USER MODIFY COLUMN id VARCHAR(20) COMMENT '아이디';
-- ...
-- ALTER TABLE USER MODIFY COLUMN email_yn CHAR(1) COMMENT '이메일 수신여부(Y/N)';

DROP TABLE USERHISTORY;
CREATE TABLE USERHISTORY(
    user_code VARCHAR(20) NOT NULL COMMENT '회원코드',
    latitude FLOAT(8,5) UNSIGNED NOT NULL COMMENT '위도(0~90)',
    longitude FLOAT(8,5) UNSIGNED NOT NULL COMMENT '경도(0~180)',
    parkinglot_name VARCHAR(50) NOT NULL COMMENT '주차장이름',
    parkinglot_addr VARCHAR(50) NOT NULL COMMENT '주차장주소',

    CONSTRAINT fk_userhistory_usercode FOREIGN KEY(user_code) REFERENCES USER(user_code)
);

DROP TABLE CAR;
CREATE TABLE CAR(
    user_code VARCHAR(20) NOT NULL COMMENT '회원코드',
    capcity SMALLINT NOT NULL DEFAULT 0 COMMENT '차량 인승',
    car_type VARCHAR(50) NOT NULL DEFAULT 'NO DATA' COMMENT '차량종류',
    model VARCHAR(20) NOT NULL DEFAULT 'NO DATA' COMMENT '차량모델명',

    CONSTRAINT fk_car_usercode FOREIGN KEY(user_code) REFERENCES USER(user_code)
);

DROP TABLE PARKINGHISTORY;
CREATE TABLE PARKINGHISTORY(
    user_code VARCHAR(20) NOT NULL COMMENT '회원코드',
    parking_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '주차날짜',
    parkinglot_name VARCHAR(50) NOT NULL COMMENT '주차장이름',
    parkinglot_addr VARCHAR(50) NOT NULL COMMENT '주차장주소',
    purchase_amount MEDIUMINT NOT NULL DEFAULT 0 COMMENT '주차정산요금',
    instt_name VARCHAR(50) NOT NULL COMMENT '관리기관명',
    instt_phone VARCHAR(50) COMMENT '관리기관 연락처',

    CONSTRAINT fk_parkinghistory_usercode FOREIGN KEY(user_code) REFERENCES USER(user_code)
);

DROP TABLE REVIEW;
CREATE TABLE REVIEW(
	idx SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '리뷰글번호',
    user_code VARCHAR(20) NOT NULL COMMENT '회원코드',
    latitude FLOAT(8,5) NOT NULL COMMENT '위도(0~90)',
    longitude FLOAT(8,5) NOT NULL COMMENT '경도(0~180)',
    parkinglot_name VARCHAR(50) NOT NULL COMMENT '주차장이름',
    parkinglot_addr VARCHAR(50) NOT NULL COMMENT '주차장주소',
    review_title VARCHAR(50) NOT NULL COMMENT '리뷰 제목',
    review_content VARCHAR(50) NOT NULL COMMENT '리뷰 작성글',
    created_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '작성날짜',
    rating TINYINT(1) UNSIGNED NOT NULL COMMENT '평점(1~5 정수)',
    
    CONSTRAINT pk_review_idx PRIMARY KEY(idx),
    CONSTRAINT fk_review_usercode FOREIGN KEY(user_code) REFERENCES USER(user_code),
    CONSTRAINT chk_review_rating CHECK (rating in (1,2,3,4,5))
);
-- Error Code: 1075. Incorrect table definition; 
-- there can be only one auto column and it must be defined as a key	0.000 sec
DROP TABLE QNABOARD;
CREATE TABLE QNABOARD(
    idx SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '문의글번호',
    user_code VARCHAR(20) NOT NULL COMMENT '회원코드',
    qna_title VARCHAR(50) NOT NULL COMMENT '문의글 제목',
    qna_content VARCHAR(50) NOT NULL COMMENT '문의글 내용',
    created_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '작성날짜',

    CONSTRAINT pk_qnaboard_idx PRIMARY KEY(idx),
    CONSTRAINT fk_qnaboard_usercode FOREIGN KEY(user_code) REFERENCES USER(user_code)
);

DROP TABLE NOTICE;
CREATE TABLE NOTICE(
    idx SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '공지사항글번호',
    user_code VARCHAR(20) NOT NULL COMMENT '회원코드',
    notice_title VARCHAR(50) NOT NULL COMMENT '공지사항 제목',
    notice_content VARCHAR(50) NOT NULL COMMENT '공지사항 내용',
    created_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '작성날짜',
    view_count SMALLINT UNSIGNED COMMENT '조회수',

    CONSTRAINT pk_notice_idx PRIMARY KEY(idx),
    CONSTRAINT fk_notice_usercode FOREIGN KEY(user_code) REFERENCES USER(user_code)
);

DROP TABLE BOOKMARK;
CREATE TABLE BOOKMARK(
    user_code VARCHAR(20) NOT NULL COMMENT '회원코드',
    parkinglot_name VARCHAR(50) NOT NULL COMMENT '주차장이름',
    parkinglot_addr VARCHAR(50) NOT NULL COMMENT '주차장주소',
    latitude FLOAT(8,5) UNSIGNED NOT NULL COMMENT '위도(0~90)',
    longitude FLOAT(8,5) UNSIGNED NOT NULL COMMENT '경도(0~180)',

    CONSTRAINT fk_bookmark_usercode FOREIGN KEY(user_code) REFERENCES USER(user_code)
);

DROP TABLE COUPON;
CREATE TABLE COUPON(
    user_code VARCHAR(20) NOT NULL COMMENT '회원코드',
    coupon_code CHAR(16) NOT NULL COMMENT '쿠폰번호',
    expired CHAR(1),
    
    CONSTRAINT pk_coupon_code PRIMARY KEY(coupon_code),
    CONSTRAINT chk_coupon_expired CHECK (expired in('Y', 'N'))
);
