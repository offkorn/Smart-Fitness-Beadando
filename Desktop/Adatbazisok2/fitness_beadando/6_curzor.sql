CREATE OR REPLACE PROCEDURE display_weekly_workouts as
    CURSOR user_cursor IS
        SELECT USERNAME, FITNESS_LEVEL, GOAL FROM USERS;

    v_username USERS.USERNAME%TYPE;
    v_fitness_level USERS.FITNESS_LEVEL%TYPE;
    v_goal USERS.GOAL%TYPE;
    v_weekly_workouts NUMBER;
BEGIN
    OPEN user_cursor;
    LOOP
        FETCH user_cursor INTO v_username, v_fitness_level, v_goal;
        EXIT WHEN user_cursor%NOTFOUND;

        v_weekly_workouts := calculate_weekly_workouts(v_fitness_level, v_goal);
      
        DBMS_OUTPUT.PUT_LINE('felhasznalo: ' || v_username);
        DBMS_OUTPUT.PUT_LINE('edzettsegi szint: ' || v_fitness_level);
        DBMS_OUTPUT.PUT_LINE('cel: ' || v_goal);
        DBMS_OUTPUT.PUT_LINE('javasolt heti edzesmennyiseg: ' || v_weekly_workouts || ' alkalom');
        DBMS_OUTPUT.PUT_LINE('-----------------------------------');
    END LOOP;
    CLOSE user_cursor;
END;


-- check
BEGIN
    display_weekly_workouts;
END;
