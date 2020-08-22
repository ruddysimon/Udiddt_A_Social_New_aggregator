DROP TABLE IF EXISTS "users"






-- a.Allow new users to register:
        -- i.	Each username has to be unique
        -- ii.	Usernames can be composed of at most 25 characters
        -- iii.	Usernames can’t be empty
        -- iv.	We won’t worry about user passwords for this project
    CREATE TABLE "users" (
        "id" SERIAL PRIMARY KEY,
        "username" VARCHAR(25) NOT NULL,
        "last_login" TIMESTAMP,
        CONSTRAINT "unique_username" UNIQUE "username",
        CONSTRAINT "non_empty_username" CHECK(LENGTH(TRIM("usernam"))>0)
    );