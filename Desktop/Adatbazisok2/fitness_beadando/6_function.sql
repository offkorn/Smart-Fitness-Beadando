CREATE OR REPLACE FUNCTION calculate_weekly_workouts 
(
    p_fitness_level VARCHAR2,
    p_goal VARCHAR2
) RETURN NUMBER AS
    v_weekly_workouts NUMBER;
BEGIN
    IF p_fitness_level = 'Beginner' THEN
        v_weekly_workouts := 3;
    ELSIF p_fitness_level = 'Intermediate' THEN
        v_weekly_workouts := 5;
    ELSE
        v_weekly_workouts := 6;
    END IF;

    RETURN v_weekly_workouts;
END;


-- check
SELECT calculate_weekly_workouts('Beginner', 'Weight Loss') FROM DUAL;

