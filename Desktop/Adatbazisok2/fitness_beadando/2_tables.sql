﻿-- USERS tábla
CREATE TABLE USERS 
(
    USER_ID NUMBER PRIMARY KEY,
    USERNAME VARCHAR2(50) NOT NULL,
    EMAIL VARCHAR2(100) NOT NULL UNIQUE,
    AGE NUMBER CHECK (AGE >= 0),
    WEIGHT NUMBER CHECK (WEIGHT > 0),
    HEIGHT NUMBER CHECK (HEIGHT > 0),
    FITNESS_LEVEL VARCHAR2(20) 
    CHECK (FITNESS_LEVEL IN ('Beginner', 'Intermediate', 'Advanced')), 
    GOAL VARCHAR2(50)
);

-- WORKOUT_PLANS tábla
CREATE TABLE WORKOUT_PLANS 
(
    PLAN_ID NUMBER PRIMARY KEY,
    USER_ID NUMBER,
    PLAN_NAME VARCHAR2(100) NOT NULL,
    PLAN_DESCRIPTION VARCHAR2(500),
    DURATION_WEEKS NUMBER CHECK (DURATION_WEEKS > 0),
    PREFERRED_WORKOUT_TYPE VARCHAR2(50) 
    CHECK (PREFERRED_WORKOUT_TYPE IN ('Gym', 'Bodyweight')),
    FOREIGN KEY (USER_ID) REFERENCES USERS(USER_ID)
);

-- WORKOUT_DAYS tábla
CREATE TABLE WORKOUT_DAYS 
(
    DAY_ID NUMBER PRIMARY KEY,
    PLAN_ID NUMBER,
    DAY_NUMBER NUMBER NOT NULL CHECK (DAY_NUMBER > 0),
    STATUS VARCHAR2(20) DEFAULT 'Not Started' 
    CHECK (STATUS IN ('Not Started', 'Completed')),
    FOREIGN KEY (PLAN_ID) REFERENCES WORKOUT_PLANS(PLAN_ID)
);

-- WORKOUT_EXERCISES tábla
CREATE TABLE WORKOUT_EXERCISES 
(
    EXERCISE_ID NUMBER PRIMARY KEY,
    DAY_ID NUMBER,
    EXERCISE_NAME VARCHAR2(100),
    REPS NUMBER CHECK (REPS > 0),
    SETS NUMBER CHECK (SETS > 0),
    FOREIGN KEY (DAY_ID) REFERENCES WORKOUT_DAYS(DAY_ID)
);

-- WORKOUT_STATUS tábla
CREATE TABLE WORKOUT_STATUS 
(
    STATUS_ID NUMBER PRIMARY KEY,
    USER_ID NUMBER,
    DAY_ID NUMBER,
    STATUS_DATE DATE DEFAULT SYSDATE,
    STATUS VARCHAR2(20) DEFAULT 'Not Completed' 
    CHECK (STATUS IN ('Completed', 'Not Completed')),
    FOREIGN KEY (USER_ID) REFERENCES USERS(USER_ID),
    FOREIGN KEY (DAY_ID) REFERENCES WORKOUT_DAYS(DAY_ID)
);

-- Indexek a gyorsabb lekérdezésekhez
CREATE INDEX IDX_USER_ID ON WORKOUT_PLANS(USER_ID);
CREATE INDEX IDX_PLAN_ID ON WORKOUT_DAYS(PLAN_ID);

--check
SELECT * FROM USERS;
SELECT * FROM WORKOUT_PLANS;
SELECT * FROM WORKOUT_DAYS;
SELECT * FROM WORKOUT_EXERCISES;
SELECT * FROM WORKOUT_STATUS;


