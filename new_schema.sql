DROP TABLE IF EXISTS "users"
DROP TABLE IF EXISTS "topics"







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



 -- b.Allow registered users to create new topics:
    -- i.	Topic names have to be unique.
    -- ii.	The topic’s name is at most 30 characters
    -- iii.	The topic’s name can’t be empty
    -- iv.	Topics can have an optional description of at most 500 characters.
    CREATE TABLE "topics" (
        "id" SERIAL PRIMARY KEY,
        "name" VARCHAR(30) NOT NULL,
        "description" VARCHAR(500),
        CONSTRAINT "unique_topic_name" UNIQUE "name",
        CONSTRAINT "non_empty_topicname" CHECK(LENGTH(TRIM("name"))>0)
    );