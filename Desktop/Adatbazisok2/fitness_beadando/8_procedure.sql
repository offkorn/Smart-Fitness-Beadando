CREATE OR REPLACE PROCEDURE delete_workout_plan 
(
    p_plan_id NUMBER 
) AS
    v_plan_count NUMBER; 
BEGIN
    SELECT COUNT(*)
    INTO v_plan_count
    FROM WORKOUT_PLANS
    WHERE PLAN_ID = p_plan_id;

    IF v_plan_count = 0 THEN
        RAISE_APPLICATION_ERROR(-20002, 'hibas vagy nem letezo edzesterv ID: ' || p_plan_id);
    END IF;

    DELETE FROM WORKOUT_DAYS
    WHERE PLAN_ID = p_plan_id;

    DELETE FROM WORKOUT_PLANS
    WHERE PLAN_ID = p_plan_id;

    COMMIT;

    DBMS_OUTPUT.PUT_LINE('edzesterv torolve: ' || p_plan_id);
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('hiba tortent az edzesterv torlese kozben: ' || SQLERRM);
END;
/







-- check
SELECT plan_id, plan_name FROM WORKOUT_PLANS;

BEGIN
    delete_workout_plan(4);
END;





----
SELECT *
FROM USER_ERRORS
WHERE NAME = 'DELETE_WORKOUT_PLAN';
