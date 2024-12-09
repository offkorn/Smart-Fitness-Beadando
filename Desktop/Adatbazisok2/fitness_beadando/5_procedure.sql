CREATE OR REPLACE PROCEDURE generate_personal_plan 
(
    p_user_id NUMBER  
) AS
    v_age NUMBER;                    
    v_fitness_level VARCHAR2(20);    
    v_goal VARCHAR2(50);            
    v_workout_type VARCHAR2(50);     
    v_duration_weeks NUMBER;         
    v_plan_id NUMBER;                
    v_user_name VARCHAR2(100);       
    v_day_id NUMBER;
BEGIN
   
    SELECT AGE, FITNESS_LEVEL, GOAL, USERNAME
    INTO v_age, v_fitness_level, v_goal, v_user_name
    FROM USERS
    WHERE USER_ID = p_user_id;

    
    IF v_fitness_level = 'Beginner' AND v_age > 50 THEN
        v_workout_type := 'Bodyweight';
        v_duration_weeks := 6;
    ELSIF v_fitness_level = 'Beginner' AND v_age <= 50 THEN
        v_workout_type := 'Gym';
        v_duration_weeks := 8;
    ELSIF v_fitness_level = 'Intermediate' THEN
        v_workout_type := 'Gym';
        v_duration_weeks := 10;
    ELSIF v_fitness_level = 'Advanced' THEN
        v_workout_type := 'Gym';
        v_duration_weeks := 12;
    ELSE
        v_workout_type := 'Bodyweight';
        v_duration_weeks := 4;
    END IF;

   
    INSERT INTO WORKOUT_PLANS (PLAN_ID, USER_ID, PLAN_NAME, PLAN_DESCRIPTION, DURATION_WEEKS, PREFERRED_WORKOUT_TYPE)
    VALUES 
    (
        WORKOUT_PLANS_SEQ.NEXTVAL,
        p_user_id,
        'Custom plan for ' || v_user_name,
        'Generated based on user data: ' || v_goal,
        v_duration_weeks,
        v_workout_type
    )
    RETURNING PLAN_ID INTO v_plan_id;

    
    FOR i IN 1..v_duration_weeks LOOP
       
        INSERT INTO WORKOUT_DAYS (DAY_ID, PLAN_ID, DAY_NUMBER)
        VALUES (WORKOUT_DAYS_SEQ.NEXTVAL, v_plan_id, i)
        RETURNING DAY_ID INTO v_day_id;

        
        INSERT INTO WORKOUT_STATUS (STATUS_ID, DAY_ID, STATUS, USER_ID)
        SELECT WORKOUT_STATUS_SEQ.NEXTVAL, v_day_id, STATUS, p_user_id
        FROM WORKOUT_STATUS
        WHERE USER_ID = p_user_id AND ROWNUM = 1;
    END LOOP;

    
    DBMS_OUTPUT.PUT_LINE('edzesterv neve: Custom plan for ' || v_user_name);
    DBMS_OUTPUT.PUT_LINE('leiras: Generated based on user data: ' || v_goal);
    DBMS_OUTPUT.PUT_LINE('idotartam: ' || v_duration_weeks || ' het');
    DBMS_OUTPUT.PUT_LINE('edzestipus: ' || v_workout_type);
    DBMS_OUTPUT.PUT_LINE('-------------------');

    
    COMMIT;
END;




-- check -- 
SELECT U.USER_ID, U.USERNAME FROM USERS U;
BEGIN
    generate_personal_plan(2);
END;




--
SELECT * FROM WORKOUT_PLANS;
SELECT * FROM user_workout_summary;


----------------------
SELECT OBJECT_NAME, STATUS 
FROM USER_OBJECTS 
WHERE OBJECT_TYPE = 'PROCEDURE';

SELECT *
FROM USER_ERRORS
WHERE NAME = 'GENERATE_PERSONAL_PLAN';



