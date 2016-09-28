drop table if exists entries;
create table entries (
  id integer primary key autoincrement,
  title text not null,
  'text' text not null
);

drop table if exists SCHOOL;
CREATE TABLE SCHOOL(
SCHL_ID VARCHAR( 8 ),
SCHL_NAME VARCHAR( 20 ) NOT NULL ,
SCHL_REQ INT( 4 ) NOT NULL ,
PRIMARY KEY ( SCHL_ID )
);

drop table if exists STUDENT;
CREATE TABLE STUDENT(
STU_ID VARCHAR(10) NOT NULL,
STU_NAME VARCHAR(20) NOT NULL,
STU_GRAD_YR INT(4) NOT NULL,
SCHL_ID VARCHAR(8) NOT NULL,
PRIMARY KEY(STU_ID),
FOREIGN KEY (SCHL_ID) REFERENCES SCHOOL (SCHL_ID)
);

drop table if exists UNIVERSITY;
CREATE TABLE UNIVERSITY(
UNI_ID VARCHAR(4) NOT NULL,
UNI_NAME VARCHAR(20) NOT NULL,
UNI_LOCATION VARCHAR(30) NOT NULL,
PRIMARY KEY (UNI_ID)
);

drop table if exists TERM;
CREATE TABLE TERM(
TRM_ID VARCHAR( 10 ) NOT NULL ,
TRM_YR INT( 4 ) NOT NULL ,
TRM_SEASON VARCHAR( 8 ) NOT NULL ,
UNI_ID VARCHAR( 4 ) NOT NULL ,
PRIMARY KEY ( TRM_ID ) ,
FOREIGN KEY ( UNI_ID ) REFERENCES UNIVERSITY( UNI_ID )
);

drop table if exists COURSE;
CREATE TABLE COURSE(
CRS_ID VARCHAR( 8 ) NOT NULL ,
CRS_NAME VARCHAR( 10 ) NOT NULL ,
CRS_CRED INT( 3 ) NOT NULL ,
PRIMARY KEY ( CRS_ID )
);

drop table if exists PERFORMANCE;
CREATE TABLE PERFORMANCE(
STU_ID VARCHAR(10) NOT NULL,
CRS_ID VARCHAR(8) NOT NULL,
TRM_ID VARCHAR(10) NOT NULL,
PFM_GRADE VARCHAR(3) NOT NULL,
PRIMARY KEY(STU_ID, CRS_ID, TRM_ID ),
FOREIGN KEY (STU_ID) REFERENCES STUDENT (STU_ID),
FOREIGN KEY (CRS_ID) REFERENCES COURSE (CRS_ID),
FOREIGN KEY (TRM_ID) REFERENCES TERM (TRM_ID)
);

