-- PARKING

CREATE TABLE USER (
    user_code VARCHAR(20) constraint pk_user_usercode PRIMARY KEY,
    user_Id VARCHAR(20),
    user_pw VARCHAR(20),
    email VARCHAR(20),
    phone VARCHAR(20),
    user_name VARCHAR(20),
    user_addr VARCHAR(50),
    last_logged DATETIME,
    created_date DATETIME,
    receive_sms CHAR(1) constraint chk_user_receivesms CHECK (receive_sms in ('Y','N')),
    receive_email CHAR(1) constraint chk_user_receiveemail CHECK (receive_email in ('Y','N'))
);

CREATE TABLE USER_HISTORY(
    user_code VARCHAR(20) constraint fk_userhistory_usercode REFERENCES USER(user_code),
    latitude FLOAT(3,2),
    longitude FLOAT(3,2),
    parking_addr VARCHAR(50),
    parking_name VARCHAR(50)
);

[VEHICLE]
user_code VARCHAR(20)
car_capcity INT
car_type VARCHAR(20)
car_model VARCHAR(20)

[PURCHASE_HISTORY]
user_code FK
purchase_date DATE
parking_name VARCHAR(50)
parking_addr VARCHAR(50)
purchase_amount NUMBER
instt_name VARCHAR(20)
instt_phone VARCHAR(20)

[REVIEW]
user_code VARCAHR2(20) FK
parking_name VARCHAR(50)
parking_addr VARCHAR(50)
longitude NUMBER
latitude NUMBER
cre_title VARCHAR(50)
cre_content VARCHAR(50)
created_date DATE
cre_score INT CHECK score in (1,2,3,4,5)
index 

[QNA_BOARD]
user_code VARCHAR(20)
qna_title VARCHAR(20)
qna_content VARCHAR(50)
created_date DATE
index INT

[notice]
user_code VARCHAR(20)
notice_title VARCHAR(50)
notice_content VARCAHR2(50)
created_date DATE
view_count INT
index

[USER_BOOKMARK]
user_code FK VARCHAR(20)
parking_name VARCHAR(20)
parking_addr VARCHAR(50)
longitude NUMBER
latitude NUMBER

[COUPON]
user_code VARCHAR(20)
coupon_code CHAR(16) 
expired CHAR(1) CHECK expired in('Y', 'N')


