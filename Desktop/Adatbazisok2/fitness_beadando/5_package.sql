CREATE OR REPLACE TYPE workout_info AS OBJECT 
(
    username VARCHAR2(50),
    fitness_level VARCHAR2(20),
    goal VARCHAR2(50),
    weekly_workouts NUMBER
);

CREATE OR REPLACE TYPE workout_list IS TABLE OF workout_info;

-- package head
CREATE OR REPLACE PACKAGE workout_package AS
    PROCEDURE generate_personal_plan(p_user_id NUMBER);
    FUNCTION calculate_weekly_workouts(p_user_id NUMBER) RETURN NUMBER;
    PROCEDURE display_weekly_workouts(p_weekly_workouts OUT workout_list);
END workout_package;
/

-- body
CREATE OR REPLACE PACKAGE BODY workout_package AS

--generate_personal_plan
    PROCEDURE generate_personal_plan(p_user_id NUMBER) AS
        v_age NUMBER;
        v_fitness_level VARCHAR2(20);
        v_goal VARCHAR2(50);
        v_workout_type VARCHAR2(50);
        v_duration_weeks NUMBER;
        v_plan_id NUMBER;
        v_user_name VARCHAR2(100);
        v_day_id NUMBER;
    BEGIN
        BEGIN
            SELECT AGE, FITNESS_LEVEL, GOAL, USERNAME
            INTO v_age, v_fitness_level, v_goal, v_user_name
            FROM USERS
            WHERE USER_ID = p_user_id;
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                DBMS_OUTPUT.PUT_LINE('hiba: nem letezo felhasznalo ID');
                RETURN;
        END;

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

        BEGIN
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
        EXCEPTION
            WHEN OTHERS THEN
                DBMS_OUTPUT.PUT_LINE('hiba a WORKOUT_PLANS beszurasakor: ' || SQLERRM);
                RETURN;
        END;

        FOR i IN 1..v_duration_weeks 
        LOOP
            BEGIN
                INSERT INTO WORKOUT_DAYS (DAY_ID, PLAN_ID, DAY_NUMBER)
                VALUES (WORKOUT_DAYS_SEQ.NEXTVAL, v_plan_id, i)
                RETURNING DAY_ID INTO v_day_id;

                INSERT INTO WORKOUT_STATUS (STATUS_ID, DAY_ID, STATUS, USER_ID)
                SELECT WORKOUT_STATUS_SEQ.NEXTVAL, v_day_id, STATUS, p_user_id
                FROM WORKOUT_STATUS
                WHERE USER_ID = p_user_id AND ROWNUM = 1;
            EXCEPTION
                WHEN OTHERS THEN
                    DBMS_OUTPUT.PUT_LINE('hiba a WORKOUT_DAYS vagy WORKOUT_STATUS beszurasakor: ' || SQLERRM);
                    RETURN;
            END;
        END LOOP;

        DBMS_OUTPUT.PUT_LINE('edzesterv neve: Custom plan for ' || v_user_name);
        DBMS_OUTPUT.PUT_LINE('leiras: Generated based on user data: ' || v_goal);
        DBMS_OUTPUT.PUT_LINE('idotartam: ' || v_duration_weeks || ' het');
        DBMS_OUTPUT.PUT_LINE('edzes tipus: ' || v_workout_type);
        DBMS_OUTPUT.PUT_LINE('-------------------');

        COMMIT;
    END generate_personal_plan;

-- calculate_weekly_workouts
    FUNCTION calculate_weekly_workouts(p_user_id NUMBER) RETURN NUMBER AS
        v_weekly_workouts NUMBER;
        v_fitness_level VARCHAR2(20);
    BEGIN
        SELECT FITNESS_LEVEL INTO v_fitness_level
        FROM USERS
        WHERE USER_ID = p_user_id;

        SELECT WEEKLY_WORKOUTS INTO v_weekly_workouts
        FROM USERS_LEVEL_GOAL
        WHERE FITNESS_LEVEL = v_fitness_level;

        RETURN v_weekly_workouts;
    END calculate_weekly_workouts;

-- display_weekly_workouts
    PROCEDURE display_weekly_workouts(p_weekly_workouts OUT workout_list) AS
    BEGIN
        p_weekly_workouts := workout_list();

        FOR user_rec IN (SELECT USER_ID, USERNAME, FITNESS_LEVEL, GOAL FROM USERS) 
        LOOP
            p_weekly_workouts.EXTEND;
            p_weekly_workouts(p_weekly_workouts.COUNT) := workout_info
            (
                user_rec.USERNAME,
                user_rec.FITNESS_LEVEL,
                user_rec.GOAL,
                calculate_weekly_workouts(user_rec.USER_ID) 
            );
        END LOOP;
    END display_weekly_workouts;
END workout_package;
/



-- check --
-- uj edzes terv
BEGIN
    workout_package.generate_personal_plan(2);
END;
/

-- display_weekly_workouts
DECLARE
    workout_results workout_list;
BEGIN
    workout_package.display_weekly_workouts(p_weekly_workouts => workout_results);

    FOR i IN 1 .. workout_results.COUNT 
    LOOP
        DBMS_OUTPUT.PUT_LINE('Username: ' || workout_results(i).username);
        DBMS_OUTPUT.PUT_LINE('Fitness Level: ' || workout_results(i).fitness_level);
        DBMS_OUTPUT.PUT_LINE('Goal: ' || workout_results(i).goal);
        DBMS_OUTPUT.PUT_LINE('Weekly Workouts: ' || workout_results(i).weekly_workouts);
        DBMS_OUTPUT.PUT_LINE('-----------------------------------------');
    END LOOP;
END;
/





--------
SELECT object_name, status
FROM all_objects
WHERE object_type IN ('PACKAGE', 'PACKAGE BODY')
AND owner = 'FITNESS';

SELECT name, line, text
FROM user_errors
WHERE name LIKE 'WORKOUT_PACKAGE%';


--------
BEGIN
    EXECUTE IMMEDIATE 'DROP PACKAGE FITNESS.WORKOUT_PACKAGE';
END;


