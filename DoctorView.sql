-- == DOCTORVIEW 계정 생성 ==
-- 계정 생성
-- alter session set "_ORACLE_SCRIPT"=true;
-- create user doctorview identified by 1234;
-- grant connect, resource, unlimited tablespace to doctorview;




-- == 테이블과 시퀀스 삭제 ==
drop table emoji;
drop sequence seq_emoji_idx;
drop table store;
drop sequence seq_store_idx;
drop table chat;
drop sequence seq_chat_idx;
drop table appointment;
drop sequence seq_appointment_idx;

drop table likes;
drop sequence seq_likes_idx;
drop table hashtag;
drop sequence seq_hashtag_idx;
drop table comments;
drop sequence seq_comments_idx;
drop table board;
drop sequence seq_board_idx;
drop table dreview;
drop sequence seq_dreview_idx;
drop table hreview;
drop sequence seq_hreview_idx;
drop table hours;
drop sequence seq_hours_idx;
drop table doctor;
drop sequence seq_doctor_idx;
drop table detail;
drop sequence seq_detail_idx;
drop table member;




-- == MEMBER 테이블 ==
-- 회원 테이블 삭제
drop table member;
-- 회원 테이블 생성
create table member (
    id varchar2(15) primary key, -- 아이디
    password varchar2(100) not null, -- 비밀번호
    name varchar2(30) not null, -- 이름
    nickname varchar2(30), -- 닉네임
    tel varchar2(15), -- 연락처
    address varchar2(100), -- 주소
    rrn varchar2(20), -- 주민등록번호
    point number default 0, -- 포인트
    emoji varchar2(10), -- 칭호
    taxid varchar2(15), -- 사업자번호
    department varchar2(30), -- 진료 과목
    visitcount number default 0, -- 조회수
    photo varchar2(200), -- 병원 사진
    enable number(1) default 1 not null, -- 활성화 여부
    auth varchar2(15) not null -- 권한
);
-- 더미데이터 생성
-- 관리자 회원
insert into member (id, password, name, enable, auth) values ('admin', '1234', '관리자', 1, 'ROLE_ADMIN');
-- 일반 사용자 회원
insert into member (id, password, name, nickname, tel, address, rrn, emoji, enable, auth)
    values ('harim', '1234', '정하림', '하림', '010-0000-0000', '경기도 의정부시', '001104-4000000', '(-.-)', 1, 'ROLE_USER');
insert into member (id, password, name, nickname, tel, address, rrn, emoji, enable, auth)
    values ('dayeong', '1234', '부다영', '다영', '010-1111-1111', '서울시', '021209-4000000', '(>_<)', 1, 'ROLE_USER');
insert into member (id, password, name, nickname, tel, address, rrn, emoji, enable, auth)
    values ('leehr', '1234', '이회리', '회리', '010-2222-2222', '경기도 의정부시', '010102-4000000', '(*_*)', 1, 'ROLE_USER');
insert into member (id, password, name, nickname, tel, address, rrn, enable, auth)
    values ('cat', '1234', '고양이', '야옹', '010-3333-3333', '경기도 포천시', '090403-3000000', 1, 'ROLE_USER');
insert into member (id, password, name, nickname, tel, address, rrn, emoji, enable, auth)
    values ('rabbit', '1234', '토끼', '깡총', '010-4444-4444', '서울시', '931204-1000000', '★', 1, 'ROLE_USER');
insert into member (id, password, name, nickname, tel, address, rrn, emoji, enable, auth)
    values ('tiger', '1234', '호랑이', '어흥', '010-5555-5555', '경기도 수원시', '990212-2000000', '★', 0, 'ROLE_USER');
-- 병원 회원
insert into member (id, password, name, nickname, tel, address, taxid, department, enable, auth)
    values ('hospital1', '1234', '병원1', '병원1', '010-6666-6666', '서울시', '666-666-6666', '내과', 1, 'ROLE_HOSP');
insert into member (id, password, name, nickname, tel, address, taxid, department, enable, auth)
    values ('hospital2', '1234', '병원2', '병원2', '010-7777-7777', '경기도 의정부시', '777-777-7777', '신경외과', 1, 'ROLE_HOSP');  
insert into member (id, password, name, nickname, tel, address, taxid, department, enable, auth)
    values ('hospital3', '1234', '병원3', '병원3', '010-8888-8888', '경기도 포천시', '888-888-8888', '정형외과', 1, 'ROLE_HOSP');
insert into member (id, password, name, nickname, tel, address, taxid, department, enable, auth)
    values ('hospital4', '1234', '병원4', '병원4', '010-9999-9999', '경기도 수원시', '999-999-9999', '산부인과', 1, 'ROLE_HOSP');
insert into member (id, password, name, nickname, tel, address, taxid, department, enable, auth)
    values ('hospital5', '1234', '병원5', '병원5', '010-1010-1010', '서울시', '6101-010-1010', '피부과', 0, 'ROLE_HOSP');
commit;




-- == DETAIL 테이블 ==
-- 병원 상세정보 테이블 삭제
drop table detail;
-- 병원 상세정보 테이블 생성
create table detail (
    idx number primary key, -- 일련번호
    introduce varchar2(100), -- 소개글
    traffic varchar2(100), -- 교통편
    parking varchar2(20), -- 주차 가능 여부
    pcr varchar2(20), -- PCR 검사 가능 여부
    hospitalize varchar2(20), -- 입원 가능 여부
    system varchar2(20), -- 예약제 유무
    hosp_ref varchar2(15) not null -- 병원
);
-- 병원 상세정보 테이블 외래키 삭제
alter table detail drop constraint const_detail_member;
-- 병원 상세정보 테이블 외래키 설정
alter table detail
    add constraint const_detail_member foreign key(hosp_ref)
    references member(id) on delete cascade;
-- 병원 상세정보 테이블 시퀀스 삭제
drop sequence seq_detail_idx;
-- 병원 상세정보 테이블 시퀀스 생성
create sequence seq_detail_idx
    increment by 1
    start with 1
    minvalue 1
    nomaxvalue
    nocycle
    nocache;
-- 더미테이터 생성
insert into detail values (seq_detail_idx.nextval, '병원1에 오신걸 환영합니다', '서울역 1번 출구에서 100m', '주차 가능', '검사 가능', '입원 가능', '예약제', 'hospital1');
insert into detail values (seq_detail_idx.nextval, '병원4에 오신걸 환영합니다', '수원역 2번 출구에서 400m', '주차 가능', '검사 불가', '입원 불가', '예약제', 'hospital4');
insert into detail values (seq_detail_idx.nextval, '병원5에 오신걸 환영합니다', '서울역 3번 출구에서 200m', '주차 불가', '검사 불가', '입원 불가', '비예약제', 'hospital5');
commit;




-- == DOCTOR 테이블 ==
-- 의사 테이블 삭제
drop table doctor;
-- 의사 테이블 생성
create table doctor (
    doc_idx number primary key, -- 일련번호
    name varchar2(30) not null, -- 이름
    major varchar2(30) not null, -- 전공
    career varchar2(30) not null, -- 경력
    photo varchar2(200), -- 사진
    hours varchar2(50) not null, -- 진료 요일 및 시간
    hosp_ref varchar2(15) not null -- 소속 병원
);
-- 의사 테이블 외래키 삭제
alter table doctor drop constraint const_doctor_member;
-- 의사 테이블 외래키 설정
alter table doctor
    add constraint const_doctor_member foreign key(hosp_ref)
    references member(id) on delete cascade;
-- 의사 테이블 시퀀스 삭세
drop sequence seq_doctor_idx;
-- 의사 테이블 시퀀스 생성
create sequence seq_doctor_idx
    increment by 1
    start with 1
    minvalue 1
    nomaxvalue
    nocycle
    nocache;
-- 더미데이터 추가
insert into doctor (doc_idx, name, major, career, hours, hosp_ref) values (seq_doctor_idx.nextval, '의사1-1', '내과', '3년', '월-금 09:00-15:00', 'hospital1');
insert into doctor (doc_idx, name, major, career, hours, hosp_ref) values (seq_doctor_idx.nextval, '의사1-2', '내과', '6년', '월-금 09:00-15:00','hospital1');
insert into doctor (doc_idx, name, major, career, hours, hosp_ref) values (seq_doctor_idx.nextval, '의사2-1', '신경외과', '1년', '화-수 09:00-15:00','hospital2');
insert into doctor (doc_idx, name, major, career, hours, hosp_ref) values (seq_doctor_idx.nextval, '의사2-2', '신경외과', '3년', '월-금 09:00-15:00','hospital2');
insert into doctor (doc_idx, name, major, career, hours, hosp_ref) values (seq_doctor_idx.nextval, '의사2-3', '신경외과', '4년', '월-금 09:00-15:00','hospital2');
insert into doctor (doc_idx, name, major, career, hours, hosp_ref) values (seq_doctor_idx.nextval, '의사2-4', '신경외과', '6년', '금-토 09:00-15:00','hospital2');
insert into doctor (doc_idx, name, major, career, hours, hosp_ref) values (seq_doctor_idx.nextval, '의사3-1', '정형외과', '1년', '월-금 09:00-15:00','hospital3');
insert into doctor (doc_idx, name, major, career, hours, hosp_ref) values (seq_doctor_idx.nextval, '의사4-1', '피부과', '4년', '월-금 09:00-15:00','hospital4');
insert into doctor (doc_idx, name, major, career, hours, hosp_ref) values (seq_doctor_idx.nextval, '의사4-2', '피부과', '3년', '월-금 09:00-15:00','hospital4');
insert into doctor (doc_idx, name, major, career, hours, hosp_ref) values (seq_doctor_idx.nextval, '의사4-3', '피부과', '3년', '월-수 09:00-15:00','hospital4');
insert into doctor (doc_idx, name, major, career, hours, hosp_ref) values (seq_doctor_idx.nextval, '의사5-1', '산부인과', '2년', '월-금 09:00-15:00','hospital5');
commit;




-- == HOURS 테이블 ==
-- 영업 시간 테이블 삭제
drop table hours;
-- 영업 시간 테이블 생성
create table hours (
    hours_idx number primary key,
    week varchar2(15) not null,
    starttime varchar2(15) not null,
    endtime varchar2(15) not null,
    startbreak varchar2(15),
    endbreak varchar2(15),
    deadline varchar2(15) not null,
    hosp_ref varchar2(15) not null
);
-- 영업 시간 테이블 외래키 삭제
alter table hours drop constraint const_hours_member;
-- 영업 시간 테이블 외래키 생성
alter table hours
    add constraint const_hours_member foreign key(hosp_ref)
    references member(id) on delete cascade;
-- 영업 시간 테이블 시퀀스 삭제
drop sequence seq_hours_idx;
-- 영업 시간 테이블 시퀀스 생성
create sequence seq_hours_idx
    increment by 1
    start with 1
    minvalue 1
    nomaxvalue
    nocycle
    nocache;
-- 더미데이터 생성
insert into hours values (seq_hours_idx.nextval, '월요일', '09:00', '17:00', '12:00', '13:00', '16:00', 'hospital1');
insert into hours values (seq_hours_idx.nextval, '화요일', '09:00', '17:00', '12:00', '13:00', '16:00', 'hospital1');
insert into hours values (seq_hours_idx.nextval, '수요일', '09:00', '12:00', '11:00', 'hospital1');
insert into hours values (seq_hours_idx.nextval, '목요일', '09:00', '17:00', '12:00', '13:00', '13:00', 'hospital1');
insert into hours values (seq_hours_idx.nextval, '금요일', '09:00', '17:00', '12:00', '13:00', '16:00', 'hospital1');
insert into hours values (seq_hours_idx.nextval, '토요일', '09:00', '17:00', '12:00', '13:00', '16:00', 'hospital1');
insert into hours values (seq_hours_idx.nextval, '월요일', '08:00', '20:00', '13:00', '14:00', '19:00', 'hospital2');
insert into hours values (seq_hours_idx.nextval, '화요일', '08:00', '20:00', '13:00', '14:00', '19:00', 'hospital2');
insert into hours values (seq_hours_idx.nextval, '수요일', '08:00', '20:00', '13:00', '14:00', '19:00', 'hospital2');
insert into hours values (seq_hours_idx.nextval, '목요일', '08:00', '20:00', '13:00', '14:00', '19:00', 'hospital2');
insert into hours values (seq_hours_idx.nextval, '금요일', '08:00', '20:00', '13:00', '14:00', '19:00', 'hospital2');
insert into hours values (seq_hours_idx.nextval, '월요일', '09:00', '18:00', '13:00', '14:00', '17:30', 'hospital3');
insert into hours values (seq_hours_idx.nextval, '화요일', '09:00', '18:00', '13:00', '14:00', '17:30', 'hospital3');
insert into hours values (seq_hours_idx.nextval, '수요일', '09:00', '18:00', '13:00', '14:00', '17:30', 'hospital3');
insert into hours values (seq_hours_idx.nextval, '금요일', '09:00', '18:00', '13:00', '14:00', '17:30', 'hospital3');
insert into hours values (seq_hours_idx.nextval, '토요일', '09:00', '18:00', '13:00', '14:00', '17:30', 'hospital3');
insert into hours values (seq_hours_idx.nextval, '일요일', '09:00', '18:00', '13:00', '14:00', '17:30', 'hospital3');
insert into hours values (seq_hours_idx.nextval, '월요일', '09:00', '17:00', '12:00', '13:00', '16:00', 'hospital4');
insert into hours values (seq_hours_idx.nextval, '화요일', '09:00', '17:00', '12:00', '13:00', '16:00', 'hospital4');
insert into hours values (seq_hours_idx.nextval, '수요일', '09:00', '12:00', '11:00', 'hospital4');
insert into hours values (seq_hours_idx.nextval, '목요일', '09:00', '17:00', '12:00', '13:00', '13:00', 'hospital4');
insert into hours values (seq_hours_idx.nextval, '금요일', '09:00', '17:00', '12:00', '13:00', '16:00', 'hospital4');
insert into hours values (seq_hours_idx.nextval, '토요일', '09:00', '17:00', '12:00', '13:00', '16:00', 'hospital4');
insert into hours values (seq_hours_idx.nextval, '월요일', '08:00', '20:00', '13:00', '14:00', '19:00', 'hospital5');
insert into hours values (seq_hours_idx.nextval, '화요일', '08:00', '20:00', '13:00', '14:00', '19:00', 'hospital5');
insert into hours values (seq_hours_idx.nextval, '수요일', '08:00', '20:00', '13:00', '14:00', '19:00', 'hospital5');
insert into hours values (seq_hours_idx.nextval, '목요일', '08:00', '20:00', '13:00', '14:00', '19:00', 'hospital5');
insert into hours values (seq_hours_idx.nextval, '금요일', '08:00', '20:00', '13:00', '14:00', '19:00', 'hospital5');
commit;




-- == HREVIEW 테이블 ==
-- 병원 리뷰 테이블 삭제
drop table hreview;
-- 병원 리뷰 테이블 생성
create table hreview (
    review_idx number primary key, -- 일련번호
    original_idx number not null, -- 리뷰의 일련번호
    postdate date default sysdate not null, -- 작성일
    score number, -- 별점
    content varchar2(1000) not null, -- 내용
    cost number, -- 비용
    treat varchar2(100), -- 치료 내용
    purpose varchar2(100), -- 방문 목적
    doctor varchar2(30), -- 담당의
    rewrite varchar2(1) default 'F' not null, -- 수정 여부
    writer_ref varchar2(15) not null, -- 작성자
    hosp_ref varchar2(15) not null -- 방문 병원
);
-- 병원 리뷰 테이블 외래키 삭제
alter table hreview drop constraint const_hreview_member1;
alter table hreview drop constraint const_hreview_member2;
-- 병원 리뷰 테이블 외래키 생성
alter table hreview
    add constraint const_hreview_member1 foreign key(writer_ref)
    references member(id) on delete set null;
alter table hreview
    add constraint const_hreview_member2 foreign key(hosp_ref)
    references member(id) on delete cascade;
-- 병원 리뷰 테이블 시퀀스 삭제
drop sequence seq_hreview_idx;
-- 병원 리뷰 테이블 시퀀스 생성
create sequence seq_hreview_idx
    increment by 1
    start with 1
    minvalue 1
    nomaxvalue
    nocycle
    nocache;
-- 더미데이터 생성
insert into hreview (review_idx, original_idx, score, content, writer_ref, hosp_ref)
    values (seq_hreview_idx.nextval, seq_hreview_idx.nextval, 4, '리뷰를 작성해보아욧', 'harim', 'hospital1');
insert into hreview (review_idx, original_idx, score, content, writer_ref, hosp_ref)
    values (seq_hreview_idx.nextval, seq_hreview_idx.nextval, 5, '리뷰를 작성해보아욧', 'leehr', 'hospital1');
insert into hreview (review_idx, original_idx, score, content, writer_ref, hosp_ref)
    values (seq_hreview_idx.nextval, seq_hreview_idx.nextval, 4, '리뷰를 작성해보아욧', 'dayeong', 'hospital1');
insert into hreview (review_idx, original_idx, content, writer_ref, hosp_ref)
    values (seq_hreview_idx.nextval, 1, '리뷰에 대한 답장을 해보아욧', 'hospital1', 'hospital1');
insert into hreview (review_idx, original_idx, content, writer_ref, hosp_ref)
    values (seq_hreview_idx.nextval, 2, '리뷰에 대한 답장을 해보아욧', 'hospital1', 'hospital1');
insert into hreview (review_idx, original_idx, content, writer_ref, hosp_ref)
    values (seq_hreview_idx.nextval, 3, '리뷰에 대한 답장을 해보아욧', 'hospital1', 'hospital1');
insert into hreview (review_idx, original_idx, score, content, writer_ref, hosp_ref)
    values (seq_hreview_idx.nextval, seq_hreview_idx.nextval, 4, '리뷰를 작성해보아욧', 'harim', 'hospital2');
insert into hreview (review_idx, original_idx, score, content, writer_ref, hosp_ref)
    values (seq_hreview_idx.nextval, seq_hreview_idx.nextval, 1, '리뷰를 작성해보아욧', 'leehr', 'hospital2');
insert into hreview (review_idx, original_idx, score, content, writer_ref, hosp_ref)
    values (seq_hreview_idx.nextval, seq_hreview_idx.nextval, 3, '리뷰를 작성해보아욧', 'dayeong', 'hospital2');
insert into hreview (review_idx, original_idx, content, writer_ref, hosp_ref)
    values (seq_hreview_idx.nextval, 7, '리뷰에 대한 답장을 해보아욧', 'hospital2', 'hospital2');
insert into hreview (review_idx, original_idx, content, writer_ref, hosp_ref)
    values (seq_hreview_idx.nextval, 8, '리뷰에 대한 답장을 해보아욧', 'hospital2', 'hospital2');
insert into hreview (review_idx, original_idx, content, writer_ref, hosp_ref)
    values (seq_hreview_idx.nextval, 9, '리뷰에 대한 답장을 해보아욧', 'hospital2', 'hospital2');
insert into hreview (review_idx, original_idx, score, content, writer_ref, hosp_ref)
    values (seq_hreview_idx.nextval, seq_hreview_idx.nextval, 1, '리뷰를 작성해보아욧', 'harim', 'hospital3');
insert into hreview (review_idx, original_idx, score, content, writer_ref, hosp_ref)
    values (seq_hreview_idx.nextval, seq_hreview_idx.nextval, 1, '리뷰를 작성해보아욧', 'leehr', 'hospital3');
insert into hreview (review_idx, original_idx, score, content, writer_ref, hosp_ref)
    values (seq_hreview_idx.nextval, seq_hreview_idx.nextval, 3, '리뷰를 작성해보아욧', 'dayeong', 'hospital3');
insert into hreview (review_idx, original_idx, content, writer_ref, hosp_ref)
    values (seq_hreview_idx.nextval, 13, '리뷰에 대한 답장을 해보아욧', 'hospital3', 'hospital3');
insert into hreview (review_idx, original_idx, content, writer_ref, hosp_ref)
    values (seq_hreview_idx.nextval, 14, '리뷰에 대한 답장을 해보아욧', 'hospital3', 'hospital3');
insert into hreview (review_idx, original_idx, content, writer_ref, hosp_ref)
    values (seq_hreview_idx.nextval, 15, '리뷰에 대한 답장을 해보아욧', 'hospital3', 'hospital3');
insert into hreview (review_idx, original_idx, score, content, writer_ref, hosp_ref)
    values (seq_hreview_idx.nextval, seq_hreview_idx.nextval, 5, '리뷰를 작성해보아욧', 'harim', 'hospital4');
insert into hreview (review_idx, original_idx, score, content, writer_ref, hosp_ref)
    values (seq_hreview_idx.nextval, seq_hreview_idx.nextval, 5, '리뷰를 작성해보아욧', 'leehr', 'hospital4');
insert into hreview (review_idx, original_idx, score, content, writer_ref, hosp_ref)
    values (seq_hreview_idx.nextval, seq_hreview_idx.nextval, 5, '리뷰를 작성해보아욧', 'dayeong', 'hospital4');
insert into hreview (review_idx, original_idx, content, writer_ref, hosp_ref)
    values (seq_hreview_idx.nextval, 19, '리뷰에 대한 답장을 해보아욧', 'hospital4', 'hospital4');
insert into hreview (review_idx, original_idx, content, writer_ref, hosp_ref)
    values (seq_hreview_idx.nextval, 20, '리뷰에 대한 답장을 해보아욧', 'hospital4', 'hospital4');
insert into hreview (review_idx, original_idx, content, writer_ref, hosp_ref)
    values (seq_hreview_idx.nextval, 21, '리뷰에 대한 답장을 해보아욧', 'hospital4', 'hospital4');
insert into hreview (review_idx, original_idx, score, content, writer_ref, hosp_ref)
    values (seq_hreview_idx.nextval, seq_hreview_idx.nextval, 1, '리뷰를 작성해보아욧', 'harim', 'hospital5');
insert into hreview (review_idx, original_idx, score, content, writer_ref, hosp_ref)
    values (seq_hreview_idx.nextval, seq_hreview_idx.nextval, 1, '리뷰를 작성해보아욧', 'leehr', 'hospital5');
insert into hreview (review_idx, original_idx, score, content, writer_ref, hosp_ref)
    values (seq_hreview_idx.nextval, seq_hreview_idx.nextval, 1, '리뷰를 작성해보아욧', 'dayeong', 'hospital5');
insert into hreview (review_idx, original_idx, content, writer_ref, hosp_ref)
    values (seq_hreview_idx.nextval, 25, '리뷰에 대한 답장을 해보아욧', 'hospital5', 'hospital5');
insert into hreview (review_idx, original_idx, content, writer_ref, hosp_ref)
    values (seq_hreview_idx.nextval, 26, '리뷰에 대한 답장을 해보아욧', 'hospital5', 'hospital5');
insert into hreview (review_idx, original_idx, content, writer_ref, hosp_ref)
    values (seq_hreview_idx.nextval, 27, '리뷰에 대한 답장을 해보아욧', 'hospital5', 'hospital5');
commit;




-- == DREVIEW 테이블 생성 ==
-- 의사 리뷰 테이블 삭제
drop table dreview;
-- 의사 리뷰 테이블 생성
create table dreview (
    review_idx number primary key,
    original_idx number not null,
    postdate date default sysdate not null,
    score number,
    content varchar2(1000) not null,
    rewrite varchar2(1) default 'F' not null,
    writer_ref varchar2(15) not null,
    doc_ref number not null
);
-- 의사 리뷰 테이블 외래키 삭제
alter table dreview drop constraint const_dreview_member;
alter table dreivew drop constraint const_dreview_doctor;
-- 의사 리뷰 테이블 외래키 설정
alter table dreview
    add constraint const_dreview_member foreign key(writer_ref)
    references member(id) on delete set null;
alter table dreview
    add constraint const_dreview_doctor foreign key(doc_ref)
    references doctor(doc_idx) on delete cascade;
-- 의사 리뷰 테이블 시퀀스 삭제
drop sequence seq_dreview_idx;
-- 의사 리뷰 테이블 시퀀스 생성
create sequence seq_dreview_idx
    increment by 1
    start with 1
    minvalue 1
    nomaxvalue
    nocycle
    nocache;
-- 더미데이터 생성
insert into dreview (review_idx, original_idx, score, content, writer_ref, doc_ref)
    values (seq_dreview_idx.nextval, seq_dreview_idx.nextval, 3, '의사에게 리뷰를 작성해보아욧', 'harim', 1);
insert into dreview (review_idx, original_idx, score, content, writer_ref, doc_ref)
    values (seq_dreview_idx.nextval, seq_dreview_idx.nextval, 4, '의사에게 리뷰를 작성해보아욧', 'dayeong', 1);
insert into dreview (review_idx, original_idx, score, content, writer_ref, doc_ref)
    values (seq_dreview_idx.nextval, seq_dreview_idx.nextval, 5, '의사에게 리뷰를 작성해보아욧', 'leehr', 1);
insert into dreview (review_idx, original_idx, content, writer_ref, doc_ref)
    values (seq_dreview_idx.nextval, 1, '리뷰에 대한 답변을 해보아욧', 'hospital1', 1);
insert into dreview (review_idx, original_idx, content, writer_ref, doc_ref)
    values (seq_dreview_idx.nextval, 2, '리뷰에 대한 답변을 해보아욧', 'hospital1', 1);
insert into dreview (review_idx, original_idx, content, writer_ref, doc_ref)
    values (seq_dreview_idx.nextval, 3, '리뷰에 대한 답변을 해보아욧', 'hospital1', 1);
commit;




-- == BOARD 테이블 ==
-- 게시판 테이블 삭제
drop table board;
-- 게시판 테이블 생성
create table board (
    board_idx number primary key, -- 일련번호
    boardname varchar2(15) not null, -- 게시판 이름
    postdate date default sysdate not null, -- 작성일
    title varchar2(200) not null, -- 제목
    content varchar2(2000) not null, -- 내용
    visitcount number default 0 not null, -- 조회수
    reportcount number default 0 not null, -- 신고수
    writer_ref varchar2(15) -- 작성자
);
-- 게시판 외래키 삭제
alter table board drop constraint const_board_member;
-- 게시판 외래키 설정
alter table board
    add constraint const_board_member foreign key(writer_ref)
    references member(id) on delete set null;
-- 게시판 시퀀스 삭제
drop sequence seq_board_idx;
-- 게시판 시퀀스 생성
create sequence seq_board_idx
    increment by 1
    start with 1
    minvalue 1
    nomaxvalue
    nocycle
    nocache;
-- 더미데이터 생성
insert into board (board_idx, boardname, title, content, writer_ref)
    values (seq_board_idx.nextval, 'freeboard', '제목1', '내용1입니다', 'harim');
insert into board (board_idx, boardname, title, content, writer_ref)
    values (seq_board_idx.nextval, 'freeboard', '제목2', '내용2입니다', 'dayeong');
insert into board (board_idx, boardname, title, content, writer_ref)
    values (seq_board_idx.nextval, 'freeboard', '제목3', '내용3입니다', 'leehr');
insert into board (board_idx, boardname, title, content, writer_ref)
    values (seq_board_idx.nextval, 'freeboard', '제목4', '내용1입니다', 'harim');
insert into board (board_idx, boardname, title, content, writer_ref)
    values (seq_board_idx.nextval, 'freeboard', '제목5', '내용2입니다', 'dayeong');
insert into board (board_idx, boardname, title, content, writer_ref)
    values (seq_board_idx.nextval, 'freeboard', '제목6', '내용3입니다', 'leehr');
insert into board (board_idx, boardname, title, content, writer_ref)
    values (seq_board_idx.nextval, 'qnaboard', '제목1', '내용1입니다', 'harim');
insert into board (board_idx, boardname, title, content, writer_ref)
    values (seq_board_idx.nextval, 'qnaboard', '제목2', '내용2입니다', 'dayeong');
insert into board (board_idx, boardname, title, content, writer_ref)
    values (seq_board_idx.nextval, 'qnaboard', '제목3', '내용3입니다', 'leehr');
insert into board (board_idx, boardname, title, content, writer_ref)
    values (seq_board_idx.nextval, 'qnaboard', '제목4', '내용1입니다', 'harim');
insert into board (board_idx, boardname, title, content, writer_ref)
    values (seq_board_idx.nextval, 'qnaboard', '제목5', '내용2입니다', 'dayeong');
insert into board (board_idx, boardname, title, content, writer_ref)
    values (seq_board_idx.nextval, 'qnaboard', '제목6', '내용3입니다', 'leehr');
commit;
-- 트리거 생성
-- create or replace trigger trig_delete_when_reportcount_three
--     after update
--     of reportcount on board
--     for each row
-- begin
    -- reportcount가 3이 되었을 때만 삭제 수행
--     if :old.reportcount = 3 then
--         delete from board
--         where board_idx = :old.board_idx;
--     end if;
-- end;
-- /






-- == COMMENT 테이블 ==
-- 게시판 댓글 테이블 삭제
drop table comments;
-- 게시판 댓글 테이블 생성
create table comments (
    comm_idx number primary key, -- 일련번호
    postdate date default sysdate not null, -- 작성일
    content varchar2(2000) not null, -- 내용
    board_ref number not null, -- 게시물 일련번호
    writer_ref varchar2(15) -- 작성자
);
-- 게시판 댓글 외래키 삭제
alter table comments drop constraint const_comments_board;
alter table comments drop constraint const_comments_member;
-- 게시판 댓글 외래키 설정
alter table comments
    add constraint const_comments_board foreign key(board_ref)
    references board(board_idx) on delete cascade;
alter table comments
    add constraint const_comments_member foreign key(writer_ref)
    references member(id) on delete set null;
-- 게시판 댓글 시퀀스 삭제
drop sequence seq_comments_idx;
-- 게시판 댓글 시퀀스 생성
create sequence seq_comments_idx
    increment by 1
    start with 1
    minvalue 1
    nomaxvalue
    nocycle
    nocache;
-- 더미데이터 생성
insert into comments (comm_idx, content, board_ref, writer_ref)
    values (seq_comments_idx.nextval, '댓글1입니닷', 1, 'harim');
insert into comments (comm_idx, content, board_ref, writer_ref)
    values (seq_comments_idx.nextval, '댓글2입니닷', 1, 'dayeong');
insert into comments (comm_idx, content, board_ref, writer_ref)
    values (seq_comments_idx.nextval, '댓글3입니닷', 1, 'leehr');
insert into comments (comm_idx, content, board_ref, writer_ref)
    values (seq_comments_idx.nextval, '댓글1입니닷', 2, 'harim');
insert into comments (comm_idx, content, board_ref, writer_ref)
    values (seq_comments_idx.nextval, '댓글2입니닷', 2, 'dayeong');
insert into comments (comm_idx, content, board_ref, writer_ref)
    values (seq_comments_idx.nextval, '댓글3입니닷', 2, 'leehr');
insert into comments (comm_idx, content, board_ref, writer_ref)
    values (seq_comments_idx.nextval, '댓글1입니닷', 3, 'harim');
insert into comments (comm_idx, content, board_ref, writer_ref)
    values (seq_comments_idx.nextval, '댓글2입니닷', 3, 'dayeong');
insert into comments (comm_idx, content, board_ref, writer_ref)
    values (seq_comments_idx.nextval, '댓글3입니닷', 3, 'leehr');
insert into comments (comm_idx, content, board_ref, writer_ref)
    values (seq_comments_idx.nextval, '댓글1입니닷', 4, 'harim');
insert into comments (comm_idx, content, board_ref, writer_ref)
    values (seq_comments_idx.nextval, '댓글2입니닷', 4, 'dayeong');
insert into comments (comm_idx, content, board_ref, writer_ref)
    values (seq_comments_idx.nextval, '댓글3입니닷', 4, 'leehr');
insert into comments (comm_idx, content, board_ref, writer_ref)
    values (seq_comments_idx.nextval, '댓글1입니닷', 5, 'harim');
insert into comments (comm_idx, content, board_ref, writer_ref)
    values (seq_comments_idx.nextval, '댓글2입니닷', 5, 'dayeong');
insert into comments (comm_idx, content, board_ref, writer_ref)
    values (seq_comments_idx.nextval, '댓글3입니닷', 5, 'leehr');
insert into comments (comm_idx, content, board_ref, writer_ref)
    values (seq_comments_idx.nextval, '댓글1입니닷', 6, 'harim');
insert into comments (comm_idx, content, board_ref, writer_ref)
    values (seq_comments_idx.nextval, '댓글2입니닷', 6, 'dayeong');
insert into comments (comm_idx, content, board_ref, writer_ref)
    values (seq_comments_idx.nextval, '댓글3입니닷', 6, 'leehr');
insert into comments (comm_idx, content, board_ref, writer_ref)
    values (seq_comments_idx.nextval, '댓글1입니닷', 7, 'harim');
insert into comments (comm_idx, content, board_ref, writer_ref)
    values (seq_comments_idx.nextval, '댓글2입니닷', 7, 'dayeong');
insert into comments (comm_idx, content, board_ref, writer_ref)
    values (seq_comments_idx.nextval, '댓글3입니닷', 7, 'leehr');
insert into comments (comm_idx, content, board_ref, writer_ref)
    values (seq_comments_idx.nextval, '댓글1입니닷', 8, 'harim');
insert into comments (comm_idx, content, board_ref, writer_ref)
    values (seq_comments_idx.nextval, '댓글2입니닷', 8, 'dayeong');
insert into comments (comm_idx, content, board_ref, writer_ref)
    values (seq_comments_idx.nextval, '댓글3입니닷', 8, 'leehr');
insert into comments (comm_idx, content, board_ref, writer_ref)
    values (seq_comments_idx.nextval, '댓글1입니닷', 9, 'harim');
insert into comments (comm_idx, content, board_ref, writer_ref)
    values (seq_comments_idx.nextval, '댓글2입니닷', 9, 'dayeong');
insert into comments (comm_idx, content, board_ref, writer_ref)
    values (seq_comments_idx.nextval, '댓글3입니닷', 9, 'leehr');
insert into comments (comm_idx, content, board_ref, writer_ref)
    values (seq_comments_idx.nextval, '댓글1입니닷', 10, 'harim');
insert into comments (comm_idx, content, board_ref, writer_ref)
    values (seq_comments_idx.nextval, '댓글2입니닷', 10, 'dayeong');
insert into comments (comm_idx, content, board_ref, writer_ref)
    values (seq_comments_idx.nextval, '댓글3입니닷', 10, 'leehr');
insert into comments (comm_idx, content, board_ref, writer_ref)
    values (seq_comments_idx.nextval, '댓글1입니닷', 11, 'harim');
insert into comments (comm_idx, content, board_ref, writer_ref)
    values (seq_comments_idx.nextval, '댓글2입니닷', 11, 'dayeong');
insert into comments (comm_idx, content, board_ref, writer_ref)
    values (seq_comments_idx.nextval, '댓글3입니닷', 11, 'leehr');
insert into comments (comm_idx, content, board_ref, writer_ref)
    values (seq_comments_idx.nextval, '댓글1입니닷', 12, 'harim');
insert into comments (comm_idx, content, board_ref, writer_ref)
    values (seq_comments_idx.nextval, '댓글2입니닷', 12, 'dayeong');
insert into comments (comm_idx, content, board_ref, writer_ref)
    values (seq_comments_idx.nextval, '댓글3입니닷', 12, 'leehr');
commit;




-- == HASHTAG 테이블 ==
-- 해시태그 기능 테이블 삭제
drop table hashtag;
-- 해시태그 기능 테이블 생성
create table hashtag (
    tag_idx number primary key,
    hosp_ref varchar2(15),
    review_ref number,
    tag varchar2(100) not null
);
-- 해시태그 기능 외래키 삭제
alter table hashtag drop constraint const_hashtag_member;
alter table hashtag drop constraint const_hashtag_hreview;
-- 해시태그 기능 외래키 설정
alter table hashtag
    add constraint const_hashtag_member foreign key(hosp_ref)
    references member(id) on delete cascade;
alter table hashtag
    add constraint const_hashtag_hreview foreign key(review_ref)
    references hreview(review_idx) on delete cascade;
-- 해시태그 기능 시퀀스 삭제
drop sequence seq_hashtag_idx;
-- 해시태그 기능 시퀀스 생성
create sequence seq_hashtag_idx
    increment by 1
    start with 1
    minvalue 1
    nomaxvalue
    nocycle
    nocache;
-- 더미데이터 생성
-- 병원
insert into hashtag (tag_idx, hosp_ref, tag)
    values (seq_hashtag_idx.nextval, 'hospital1', '태그1');
insert into hashtag (tag_idx, hosp_ref, tag)
    values (seq_hashtag_idx.nextval, 'hospital1', '태그2');
insert into hashtag (tag_idx, hosp_ref, tag)
    values (seq_hashtag_idx.nextval, 'hospital1', '태그3');
insert into hashtag (tag_idx, hosp_ref, tag)
    values (seq_hashtag_idx.nextval, 'hospital2', '태그1');
insert into hashtag (tag_idx, hosp_ref, tag)
    values (seq_hashtag_idx.nextval, 'hospital3', '태그2');
insert into hashtag (tag_idx, hosp_ref, tag)
    values (seq_hashtag_idx.nextval, 'hospital3', '태그3');
insert into hashtag (tag_idx, hosp_ref, tag)
    values (seq_hashtag_idx.nextval, 'hospital3', '태그4');
-- 리뷰
insert into hashtag (tag_idx, review_ref, tag)
    values (seq_hashtag_idx.nextval, 1, '태그1');
insert into hashtag (tag_idx, review_ref, tag)
    values (seq_hashtag_idx.nextval, 1, '태그2');
insert into hashtag (tag_idx, review_ref, tag)
    values (seq_hashtag_idx.nextval, 1, '태그3');
commit;




-- == LIKES 테이블 ==
-- 좋아요 기능 테이블 삭제
drop table likes;
-- 좋아요 기능 테이블 생성
create table likes (
    like_idx number primary key,
    member_ref varchar2(15),
    tablename varchar2(15) not null,
    recodenum varchar2(15) not null
);
-- 좋아요 기능 외래키 삭제
alter table likes drop constraint const_likes_member;
-- 좋아요 기능 외래키 설정
alter table likes
    add constraint const_likes_member foreign key(member_ref)
    references member(id) on delete set null;
-- 좋아요 기능 시퀀스 삭제
drop sequence seq_likes_idx;
-- 좋아요 기능 시퀀스 생성
create sequence seq_likes_idx
    increment by 1
    start with 1
    minvalue 1
    nomaxvalue
    nocycle
    nocache;
-- 더미데이터 생성
-- 게시판
insert into likes values (seq_likes_idx.nextval, 'harim', 'board', '1');
insert into likes values (seq_likes_idx.nextval, 'dayeong', 'board', '1');
insert into likes values (seq_likes_idx.nextval, 'leehr', 'board', '1');
insert into likes values (seq_likes_idx.nextval, 'harim', 'board', '2');
insert into likes values (seq_likes_idx.nextval, 'dayeong', 'board', '2');
insert into likes values (seq_likes_idx.nextval, 'dayeong', 'board', '3');
insert into likes values (seq_likes_idx.nextval, 'harim', 'board', '5');
insert into likes values (seq_likes_idx.nextval, 'dayeong', 'board', '6');
insert into likes values (seq_likes_idx.nextval, 'leehr', 'board', '6');
insert into likes values (seq_likes_idx.nextval, 'harim', 'board', '7');
insert into likes values (seq_likes_idx.nextval, 'dayeong', 'board', '7');
insert into likes values (seq_likes_idx.nextval, 'dayeong', 'board', '8');
insert into likes values (seq_likes_idx.nextval, 'harim', 'board', '10');
insert into likes values (seq_likes_idx.nextval, 'dayeong', 'board', '10');
insert into likes values (seq_likes_idx.nextval, 'leehr', 'board', '10');
insert into likes values (seq_likes_idx.nextval, 'harim', 'board', '11');
insert into likes values (seq_likes_idx.nextval, 'dayeong', 'board', '11');
insert into likes values (seq_likes_idx.nextval, 'dayeong', 'board', '12');
-- 병원
insert into likes values (seq_likes_idx.nextval, 'harim', 'member', 'hospital1');
insert into likes values (seq_likes_idx.nextval, 'dayeong', 'member', 'hospital1');
insert into likes values (seq_likes_idx.nextval, 'leehr', 'member', 'hospital1');
insert into likes values (seq_likes_idx.nextval, 'harim', 'member', 'hospital2');
insert into likes values (seq_likes_idx.nextval, 'dayeong', 'member', 'hospital2');
insert into likes values (seq_likes_idx.nextval, 'dayeong', 'member', 'hospital3');
insert into likes values (seq_likes_idx.nextval, 'harim', 'member', 'hospital4');
insert into likes values (seq_likes_idx.nextval, 'dayeong', 'member', 'hospital5');
insert into likes values (seq_likes_idx.nextval, 'leehr', 'member', 'hospital5');
-- 의사
insert into likes values (seq_likes_idx.nextval, 'harim', 'doctor', '1');
insert into likes values (seq_likes_idx.nextval, 'dayeong', 'doctor', '1');
insert into likes values (seq_likes_idx.nextval, 'leehr', 'doctor', '1');
insert into likes values (seq_likes_idx.nextval, 'harim', 'doctor', '2');
insert into likes values (seq_likes_idx.nextval, 'dayeong', 'doctor', '2');
insert into likes values (seq_likes_idx.nextval, 'dayeong', 'doctor', '3');
insert into likes values (seq_likes_idx.nextval, 'harim', 'doctor', '4');
insert into likes values (seq_likes_idx.nextval, 'dayeong', 'doctor', '5');
insert into likes values (seq_likes_idx.nextval, 'leehr', 'doctor', '5');
commit;




-- == REPORT 테이블 ==
-- 신고 기능 테이블 삭제
drop table report;
-- 신고 기능 테이블 생성
create table report (
    report_idx number primary key,
    member_ref varchar2(15),
    board_ref number not null
);
-- 신고 기능 외래키 삭제
alter table report drop constraint const_report_member;
alter table report drop constraint const_report_board;
-- 신고 기능 외래키 설정
alter table report
    add constraint const_report_member foreign key(member_ref)
    references member(id) on delete set null;
alter table report
    add constraint const_report_board foreign key(board_ref)
    references board(board_idx) on delete cascade;
-- 신고 기능 시퀀스 삭제
drop sequence seq_report_idx;
-- 좋아요 기능 시퀀스 생성
create sequence seq_report_idx
    increment by 1
    start with 1
    minvalue 1
    nomaxvalue
    nocycle
    nocache;
-- 더미데이터 생성
insert into report values (seq_report_idx.nextval, 'harim', 1);
insert into report values (seq_report_idx.nextval, 'dayeong', 1);
insert into report values (seq_report_idx.nextval, 'leehr', 1);
commit;





-- == APPOINTMENT 테이블 ==
-- 예약 테이블 삭제
drop table appointment;
-- 예약 테이블 생성
create table appointment (
    app_id number primary key, -- 일련번호
    hospname varchar2(30) not null, -- 병원 이름
    doctorname varchar2(30), -- 의사 이름
    username varchar2(30) not null, -- 예약자 이름
    tel varchar2(30) not null, -- 예약자 연락처
    rrn varchar2(30) not null, -- 예약자 주민등록번호
    address varchar2(100) not null, -- 예약자 주소
    postdate date not null, -- 예약일
    posttime varchar2(30) not null, -- 예약 시간
    alarm varchar2(1) default 'T' not null, -- 알림 여부
    review varchar2(1) default 'F' not null, -- 리뷰 등록 여부
    hide varchar2(1) default 'F' not null, -- 숨기기 여부
    user_ref varchar2(15), -- 사용자
    hosp_ref varchar2(15) -- 병원
);
-- 예약 테이블 외래키 삭제
alter table appointment drop constraint const_appointment_member1;
alter table appointment drop constraint const_appointment_member2;
-- 예약 테이블 외래키 설정
alter table appointment
    add constraint const_appointment_member1 foreign key(user_ref)
    references member(id) on delete set null;
alter table appointment
    add constraint const_appointment_member2 foreign key(hosp_ref)
    references member(id) on delete set null;
-- 예약 테이블 시퀀스 삭제
drop sequence seq_appointment_idx;
-- 예약 테이블 시퀀스 생성
create sequence seq_appointment_idx
    increment by 1
    start with 1
    minvalue 1
    nomaxvalue
    nocycle
    nocache;
-- 더미데이터 생성
commit;




-- == CHAT 테이블 ==
-- 채팅 테이블 삭제
drop table chat;
-- 채팅 테이블 생성
create table chat (
    chat_idx number primary key,
    member_ref varchar2(15) not null,
    roomid number not null,
    message varchar2(1000) not null,
    postdate date default sysdate not null
);
-- 채팅 테이블 외래키 삭제
alter table chat drop constraint const_chat_member;
-- 채팅 테이블 외래키 설정
alter table chat
    add constraint const_chat_member foreign key(member_ref)
    references member(id) on delete cascade;
-- 채팅 테이블 시퀀스 삭제
drop sequence seq_chat_idx;
-- 채팅 테이블 시컨스 생성
create sequence seq_chat_idx
    increment by 1
    start with 1
    minvalue 1
    nomaxvalue
    nocycle
    nocache;
-- 더미데이터 생성
commit;




-- == STORE 테이블 ==
-- 상점 테이블 삭제
drop table store;
-- 상점 테이블 생성
create table store (
    store_idx number primary key,
    price number not null,
    emoji varchar2(10) not null,
    title varchar2(100) not null
);
-- 상점 시퀀스 삭제
drop sequence seq_store_idx;
-- 상점 시퀀스 생성
create sequence seq_store_idx
    increment by 1
    start with 1
    minvalue 1
    nomaxvalue
    nocycle
    nocache;
-- 더미데이터 생성
insert into store values (seq_store_idx.nextval, 100, '(*_*)', '눈이 별이예욧');
insert into store values (seq_store_idx.nextval, 90, '(@_@)', '어지러워욧');
insert into store values (seq_store_idx.nextval, 110, '(^_^)', '행복해욧');
insert into store values (seq_store_idx.nextval, 120, '(>_<)', '깜찍해욧');
insert into store values (seq_store_idx.nextval, 130, '(+_+)', '기절했어욧');
insert into store values (seq_store_idx.nextval, 130, '(-.-)', '졸려욧');
commit;




-- == EMOJI 테이블 ==
-- 이모지 테이블 삭제
drop table emoji;
-- 이모지 테이블 생성
create table emoji (
    emoji_idx number primary key,
    user_ref varchar2(15) not null,
    emoji varchar2(10) not null
);
-- 이모지 외래키 삭제
alter table emoji drop constraint const_emoji_member;
-- 이모지 외래키 설정
alter table emoji
    add constraint const_emoji_member foreign key(user_ref)
    references member(id) on delete cascade;
-- 이모지 시퀀스 삭제
drop sequence seq_emoji_idx;
-- 이모지 시퀀스 생성
create sequence seq_emoji_idx
    increment by 1
    start with 1
    minvalue 1
    nomaxvalue
    nocycle
    nocache;
-- 더미데이터 생성
insert into emoji values (seq_emoji_idx.nextval, 'harim', '(-.-)');
insert into emoji values (seq_emoji_idx.nextval, 'harim', '(@_@)');
insert into emoji values (seq_emoji_idx.nextval, 'harim', '(>_<)');
insert into emoji values (seq_emoji_idx.nextval, 'dayeong', '(>_<)');
insert into emoji values (seq_emoji_idx.nextval, 'dayeong', '(+_+)');
insert into emoji values (seq_emoji_idx.nextval, 'leehr', '(*_*)');
insert into emoji values (seq_emoji_idx.nextval, 'leehr', '(^_^)');
insert into emoji values (seq_emoji_idx.nextval, 'leehr', '(@_@)');
commit;