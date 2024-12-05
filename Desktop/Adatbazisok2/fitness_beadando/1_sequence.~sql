-- USERS tábla szekvencia
CREATE SEQUENCE user_seq START WITH 1 INCREMENT BY 1;

-- WORKOUT_PLANS tábla szekvencia
CREATE SEQUENCE workout_plans_seq START WITH 1 INCREMENT BY 1;

-- WORKOUT_DAYS tábla szekvencia
CREATE SEQUENCE workout_days_seq START WITH 1 INCREMENT BY 1;

-- WORKOUT_EXERCISES tábla szekvencia
CREATE SEQUENCE workout_exercises_seq START WITH 1 INCREMENT BY 1;

-- WORKOUT_STATUS tábla szekvencia
CREATE SEQUENCE workout_status_seq START WITH 1 INCREMENT BY 1;


-- check
SELECT user_seq.NEXTVAL FROM DUAL;
SELECT workout_plans_seq.NEXTVAL FROM DUAL;
SELECT workout_days_seq.NEXTVAL FROM DUAL;
SELECT workout_exercises_seq.NEXTVAL FROM DUAL;
SELECT workout_status_seq.NEXTVAL FROM DUAL;
---------
SELECT user_seq.CURRVAL FROM DUAL;
SELECT workout_plans_seq.CURRVAL FROM DUAL;
SELECT workout_days_seq.CURRVAL FROM DUAL;
SELECT workout_exercises_seq.CURRVAL FROM DUAL;
SELECT workout_status_seq.CURRVAL FROM DUAL;

------
DROP SEQUENCE user_seq;
DROP SEQUENCE workout_plans_seq;
DROP SEQUENCE workout_days_seq;
DROP SEQUENCE workout_exercises_seq;
DROP SEQUENCE workout_status_seq;


SELECT SEQUENCE_NAME
FROM USER_SEQUENCES;
