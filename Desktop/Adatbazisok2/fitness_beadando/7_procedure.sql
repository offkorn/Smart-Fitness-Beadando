CREATE OR REPLACE PROCEDURE register_user 
(
    p_username VARCHAR2,
    p_age NUMBER,
    p_fitness_level VARCHAR2,
    p_goal VARCHAR2,
    p_email VARCHAR2 DEFAULT '',  
    p_weight NUMBER,               
    p_height NUMBER                
) AS
BEGIN
    DECLARE
        v_count NUMBER;
    BEGIN
        SELECT COUNT(*)
        INTO v_count
        FROM USERS
        WHERE USERNAME = p_username OR EMAIL = p_email;

        IF v_count > 0 THEN
            RAISE_APPLICATION_ERROR(-20001, 'felhasznalo nev vagy email mar letezik.');
        END IF;

        INSERT INTO USERS (USER_ID, USERNAME, AGE, FITNESS_LEVEL, GOAL, EMAIL, WEIGHT, HEIGHT)
        VALUES 
        (
            USER_SEQ.NEXTVAL,
            p_username,
            p_age,
            p_fitness_level,
            p_goal,
            p_email,  
            p_weight,  
            p_height   
        );

        COMMIT;
        DBMS_OUTPUT.PUT_LINE(' uj felhasznalo rogzitve: ' || p_username);
    END;
END;





-- check
BEGIN
    register_user('johny_doey', 52, 'Intermediate', 'weight loss', 'ex@example.com', 70, 175);
END;







