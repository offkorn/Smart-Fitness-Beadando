﻿-- USERS tábla
INSERT INTO USERS (USERNAME, EMAIL, AGE, WEIGHT, HEIGHT, FITNESS_LEVEL, GOAL)
VALUES
('John Doe', 'johndoe@example.com', 28, 75, 180, 'Intermediate', 'Gain Muscle');

INSERT INTO USERS (USERNAME, EMAIL, AGE, WEIGHT, HEIGHT, FITNESS_LEVEL, GOAL)
VALUES
('Jane Smith', 'janesmith@example.com', 25, 60, 165, 'Beginner', 'Lose Fat');

INSERT INTO USERS (USERNAME, EMAIL, AGE, WEIGHT, HEIGHT, FITNESS_LEVEL, GOAL)
VALUES
('Alice Brown', 'aliceb@example.com', 35, 68, 170, 'Advanced', 'Maintain Fitness');

-- WORKOUT_PLANS tábla
INSERT INTO WORKOUT_PLANS (USER_ID, PLAN_NAME, PLAN_DESCRIPTION, DURATION_WEEKS, PREFERRED_WORKOUT_TYPE)
VALUES
(
    (SELECT USER_ID FROM USERS WHERE USERNAME = 'John Doe'),
    'Muscle Building Plan', 
    'A 4-week plan focusing on weight training.', 
    4, 
    'Gym'
);

INSERT INTO WORKOUT_PLANS (USER_ID, PLAN_NAME, PLAN_DESCRIPTION, DURATION_WEEKS, PREFERRED_WORKOUT_TYPE)
VALUES
(
    (SELECT USER_ID FROM USERS WHERE USERNAME = 'Jane Smith'),
    'Fat Loss Plan', 
    'A 6-week plan with cardio and bodyweight exercises.', 
    6, 
    'Bodyweight'
);

INSERT INTO WORKOUT_PLANS (USER_ID, PLAN_NAME, PLAN_DESCRIPTION, DURATION_WEEKS, PREFERRED_WORKOUT_TYPE)
VALUES
(
    (SELECT USER_ID FROM USERS WHERE USERNAME = 'Alice Brown'),
    'Fitness Maintenance', 
    'A balanced 8-week plan for overall fitness.', 
    8, 
    'Gym'
);

-- WORKOUT_DAYS tábla
INSERT INTO WORKOUT_DAYS (PLAN_ID, DAY_NUMBER, STATUS)
VALUES
(
    (SELECT PLAN_ID FROM WORKOUT_PLANS WHERE PLAN_NAME = 'Muscle Building Plan'),
    1, 
    'Not Started'
);

INSERT INTO WORKOUT_DAYS (PLAN_ID, DAY_NUMBER, STATUS)
VALUES
(
    (SELECT PLAN_ID FROM WORKOUT_PLANS WHERE PLAN_NAME = 'Muscle Building Plan'),
    2, 
    'Not Started'
);

INSERT INTO WORKOUT_DAYS (PLAN_ID, DAY_NUMBER, STATUS)
VALUES
(
    (SELECT PLAN_ID FROM WORKOUT_PLANS WHERE PLAN_NAME = 'Fat Loss Plan'),
    1, 
    'Not Started'
);

INSERT INTO WORKOUT_DAYS (PLAN_ID, DAY_NUMBER, STATUS)
VALUES
(
    (SELECT PLAN_ID FROM WORKOUT_PLANS WHERE PLAN_NAME = 'Fat Loss Plan'),
    2, 
    'Not Started'
);

INSERT INTO WORKOUT_DAYS (PLAN_ID, DAY_NUMBER, STATUS)
VALUES
(
    (SELECT PLAN_ID FROM WORKOUT_PLANS WHERE PLAN_NAME = 'Fitness Maintenance'),
    1, 
    'Not Started'
);

-- WORKOUT_EXERCISES tábla
INSERT INTO WORKOUT_EXERCISES (DAY_ID, EXERCISE_NAME, REPS, SETS)
VALUES
(
    (SELECT DAY_ID FROM WORKOUT_DAYS WHERE PLAN_ID = (SELECT PLAN_ID FROM WORKOUT_PLANS WHERE PLAN_NAME = 'Muscle Building Plan') AND DAY_NUMBER = 1),
    'Bench Press', 
    12, 
    4
);

INSERT INTO WORKOUT_EXERCISES (DAY_ID, EXERCISE_NAME, REPS, SETS)
VALUES
(
    (SELECT DAY_ID FROM WORKOUT_DAYS WHERE PLAN_ID = (SELECT PLAN_ID FROM WORKOUT_PLANS WHERE PLAN_NAME = 'Muscle Building Plan') AND DAY_NUMBER = 1),
    'Squats', 
    10, 
    3
);

INSERT INTO WORKOUT_EXERCISES (DAY_ID, EXERCISE_NAME, REPS, SETS)
VALUES
(
    (SELECT DAY_ID FROM WORKOUT_DAYS WHERE PLAN_ID = (SELECT PLAN_ID FROM WORKOUT_PLANS WHERE PLAN_NAME = 'Fat Loss Plan') AND DAY_NUMBER = 1),
    'Push-ups', 
    15, 
    3
);

INSERT INTO WORKOUT_EXERCISES (DAY_ID, EXERCISE_NAME, REPS, SETS)
VALUES
(
    (SELECT DAY_ID FROM WORKOUT_DAYS WHERE PLAN_ID = (SELECT PLAN_ID FROM WORKOUT_PLANS WHERE PLAN_NAME = 'Fitness Maintenance') AND DAY_NUMBER = 1),
    'Running', 
    30, 
    1
);

INSERT INTO WORKOUT_EXERCISES (DAY_ID, EXERCISE_NAME, REPS, SETS)
VALUES
(
    (SELECT DAY_ID FROM WORKOUT_DAYS WHERE PLAN_ID = (SELECT PLAN_ID FROM WORKOUT_PLANS WHERE PLAN_NAME = 'Fitness Maintenance') AND DAY_NUMBER = 1),
    'Plank', 
    2, 
    1
);

-- WORKOUT_STATUS tábla
INSERT INTO WORKOUT_STATUS (USER_ID, DAY_ID, STATUS)
VALUES
(
    (SELECT USER_ID FROM USERS WHERE USERNAME = 'John Doe'),
    (SELECT DAY_ID FROM WORKOUT_DAYS WHERE PLAN_ID = (SELECT PLAN_ID FROM WORKOUT_PLANS WHERE PLAN_NAME = 'Muscle Building Plan') AND DAY_NUMBER = 1),
    'Not Completed'
);

INSERT INTO WORKOUT_STATUS (USER_ID, DAY_ID, STATUS)
VALUES
(
    (SELECT USER_ID FROM USERS WHERE USERNAME = 'John Doe'),
    (SELECT DAY_ID FROM WORKOUT_DAYS WHERE PLAN_ID = (SELECT PLAN_ID FROM WORKOUT_PLANS WHERE PLAN_NAME = 'Muscle Building Plan') AND DAY_NUMBER = 2),
    'Not Completed'
);

INSERT INTO WORKOUT_STATUS (USER_ID, DAY_ID, STATUS)
VALUES
(
    (SELECT USER_ID FROM USERS WHERE USERNAME = 'Jane Smith'),
    (SELECT DAY_ID FROM WORKOUT_DAYS WHERE PLAN_ID = (SELECT PLAN_ID FROM WORKOUT_PLANS WHERE PLAN_NAME = 'Fat Loss Plan') AND DAY_NUMBER = 1),
    'Completed'
);

INSERT INTO WORKOUT_STATUS (USER_ID, DAY_ID, STATUS)
VALUES
(
    (SELECT USER_ID FROM USERS WHERE USERNAME = 'Alice Brown'),
    (SELECT DAY_ID FROM WORKOUT_DAYS WHERE PLAN_ID = (SELECT PLAN_ID FROM WORKOUT_PLANS WHERE PLAN_NAME = 'Fitness Maintenance') AND DAY_NUMBER = 1),
    'Not Completed'
);



COMMIT;

-- check
SELECT * FROM USERS;
SELECT * FROM WORKOUT_PLANS;
SELECT * FROM WORKOUT_DAYS;
SELECT * FROM WORKOUT_EXERCISES;
SELECT * FROM WORKOUT_STATUS;


-- Adatok törlése
DELETE FROM WORKOUT_STATUS;
DELETE FROM WORKOUT_EXERCISES;
DELETE FROM WORKOUT_DAYS;
DELETE FROM WORKOUT_PLANS;
DELETE FROM USERS;


