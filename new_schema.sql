DROP TABLE IF EXISTS "users"
DROP TABLE IF EXISTS "topics"
DROP TABLE IF EXISTS "posts"
DROP TABLE IF EXISTS "comments"
DROP TABLE IF EXISTS "votes"


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




-- c.Allow registered users to create new posts on existing topics:
    -- i.	Posts have a required title of at most 100 characters
    -- ii.	The title of a post can’t be empty.
    -- iii.	Posts should contain either a URL or a text content, but not both.
    -- iv.	If a topic gets deleted, all the posts associated with it should be automatically deleted too.
    -- v.	If the user who created the post gets deleted, then the post will remain, but it will become dissociated from that user.
    CREATE TABLE "posts"(
        "id" SERIAL PRIMARY KEY,
        "title" VARCHAR(100) NOT NULL,
        "URL" VARCHAR(5000) DEFAULT NULL,
        "text_content" TEXT DEFAULT NULL,
        "topic_id" INTEGER REFERENCES "topics" ON DELETE CASCADE,
        "user_id" INTEGER REFERENCES "users" ON DELETE SET NULL,
        CONSTRAINT "non_empty_title" CHECK(LENGTH(TRIM("title"))>0),
        CONSTRAINT "url_or_text"(CHECK(LENGTH(TRIM("URL"))>0 AND LENGTH(TRIM("text_content"))=0) OR   
                                    (LENGTH(TRIM("URL"))=0 AND LENGTH(TRIM("text_content"))>0))

    );



--d.Allow registered users to comment on existing posts:
    -- i.	A comment’s text content can’t be empty.
    -- ii.	Contrary to the current linear comments, the new structure should allow comment threads at arbitrary levels.
    -- iii.	If a post gets deleted, all comments associated with it should be automatically deleted too.
    -- iv.	If the user who created the comment gets deleted, then the comment will remain, but it will become dissociated from that user.
    -- v.	If a comment gets deleted, then all its descendants in the thread structure should be automatically deleted too.
    CREATE TABLE "comments"(
        "id" SERIAL,
        "text_content" TEXT DEFAULT NULL,
        "post_id" INTEGER REFERENCES "posts" ON DELETE CASCADE,
        "user_id" INTEGER REFERENCES "users" ON DELETE SET NULL,
        "comment_id" INTEGER REFERENCES "comments" ON DELETE CASCADE,
        CONSTRAINT "non_empty_text_content" CHECK(LENGTH(TRIM("text_content"))>0),
        PRIMARY KEY("user_id", "post_id")
    );



-- e.Make sure that a given user can only vote once on a given post:
    -- i.	Hint: you can store the (up/down) value of the vote as the values 1 and -1 respectively.
    -- ii.	If the user who cast a vote gets deleted, then all their votes will remain, but will become dissociated from the user.
    CREATE 
