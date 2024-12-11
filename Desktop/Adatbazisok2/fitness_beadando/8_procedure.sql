CREATE OR REPLACE PROCEDURE delete_workout_plan 
(
    p_plan_id NUMBER
) AS
BEGIN
    DELETE FROM WORKOUT_DAYS
    WHERE PLAN_ID = p_plan_id;

    DELETE FROM WORKOUT_PLANS
    WHERE PLAN_ID = p_plan_id;

    COMMIT;

    DBMS_OUTPUT.PUT_LINE('edzesterv torolve: ' || p_plan_id);
END;





-- check
SELECT plan_id, plan_name FROM WORKOUT_PLANS;

BEGIN
    delete_workout_plan(5);
END;


----
SELECT *
FROM USER_ERRORS
WHERE NAME = 'DELETE_WORKOUT_PLAN';
