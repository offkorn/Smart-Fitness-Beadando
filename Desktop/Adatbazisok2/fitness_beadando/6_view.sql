﻿CREATE OR REPLACE VIEW user_workout_summary as
SELECT 
    u.USERNAME as felhasznalo_nev,
    wp.PLAN_NAME as edzesterv_nev,
    ws.STATUS as statusz,
    COUNT(we.EXERCISE_ID) as gyakorlatok_szama, 
    SUM(we.REPS) as ossz_ismetles              
FROM USERS u
JOIN WORKOUT_PLANS wp ON u.USER_ID = wp.USER_ID
JOIN WORKOUT_DAYS wd ON wp.PLAN_ID = wd.PLAN_ID
JOIN WORKOUT_STATUS ws ON wd.DAY_ID = ws.DAY_ID
LEFT JOIN WORKOUT_EXERCISES we ON wd.DAY_ID = we.DAY_ID 
GROUP BY 
    u.USERNAME,
    wp.PLAN_NAME,
    ws.STATUS;




-- check
SELECT * FROM user_workout_summary;
