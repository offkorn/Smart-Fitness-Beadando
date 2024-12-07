CREATE OR REPLACE VIEW user_workout_summary AS
SELECT 
    u.USERNAME,
    wp.PLAN_NAME,
    wd.DAY_NUMBER,
    ws.STATUS
FROM 
    USERS u
JOIN 
    WORKOUT_PLANS wp ON u.USER_ID = wp.USER_ID
JOIN 
    WORKOUT_DAYS wd ON wp.PLAN_ID = wd.PLAN_ID
JOIN 
    WORKOUT_STATUS ws ON wd.DAY_ID = ws.DAY_ID;



SELECT * FROM user_workout_summary;
