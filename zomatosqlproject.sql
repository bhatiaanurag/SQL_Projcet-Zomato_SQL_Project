# =========================
# CREATE DATABASE OF ZOMATO
# =========================
CREATE DATABASE ZOMATOSQLPROJECT;


# ======================
# USE OF ZOMATO DATABASE
# ======================
USE ZOMATOSQLPROJECT;


# ==========================
# CREATE TABLE OF GOLD USERS
# ==========================
CREATE TABLE GOLDUSERS_SIGNUP(
USERID INT,
GOLD_SIGNUP_DATE DATE);


# ===========================
# INSERT VALUES IN GOLD USERS
# ===========================
INSERT INTO GOLDUSERS_SIGNUP
VALUE
(1, '2017-09-22'),
(3, '2017-04-21');

SELECT * FROM GOLDUSERS_SIGNUP;


# =====================
# CREATE TABLE OF USERS
# =====================
CREATE TABLE USERS(
USERID INT,
SIGNUP_DATE DATE);


# ============================
# INSERT VALUES IN USERS TABLE
# ============================
INSERT INTO USERS
VALUE
(1, '2014-09-02'),
(2, '2015-01-15'),
(3, '2014-04-11');

SELECT * FROM USERS;


# =====================
# CREATE TABLE OF SALES
# =====================
CREATE TABLE SALES(
USERID INT,
CREATED_DATE DATE,
PRODUCT_ID INT);


# ============================
# INSERT VALUES IN SALES TABLE
# ============================
INSERT INTO SALES
VALUE
(1,'2017-04-19',2),
(3,'2019-12-18',1),
(2,'2020-07-20',3),
(1,'2019-10-23',2),
(1,'2018-03-19',3),
(3,'2016-12-20',2),
(1,'2016-11-09',1),
(1,'2016-05-20',3),
(2,'2017-09-24',1),
(1,'2017-03-11',2),
(1,'2016-03-11',1),
(3,'2016-11-10',1),
(3,'2017-12-07',2),
(3,'2016-12-15',2),
(2,'2017-11-08',2),
(2,'2018-09-10',3);


# ====================
# CREATE PRODUCT TABLE
# ====================
CREATE TABLE PRODUCT(
PRODUCT_ID INT,
PRODUCT_NAME TEXT,
PRICE INT); 


# ==============================
# INSERT VALUES IN PRODUCT TABLE
# ==============================
INSERT INTO PRODUCT
VALUES
(1,'p1',980),
(2,'p2',870),
(3,'p3',330);

SELECT * FROM SALES;
SELECT * FROM PRODUCT;
SELECT * FROM GOLDUSERS_SIGNUP;
SELECT * FROM USERS;


# ==========================================================
# 1. WHAT IS THE TOTAL AMOUNT EACH CUSTOMER SPENT ON ZOMATO?
# ==========================================================
SELECT
	SALES.USERID,
    SALES.PRODUCT_ID,
    PRODUCT.PRICE
FROM SALES
INNER JOIN PRODUCT
ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID;

# AS YOU CAN SEE THE TOTAL AMOUNT SPENT BY EACH CUSTOMER AS SHOWN BELOW

SELECT
	SALES.USERID,
    SUM(PRODUCT.PRICE) AS 'TOTAL AMOUNT SPENT'
FROM SALES
INNER JOIN PRODUCT
ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID
GROUP BY
	SALES.USERID;
    

# ==================================================
# 2. HOW MANY DAYS HAS EACH CUSTOMER VISITED ZOMATO?
# ==================================================
SELECT
	USERID,
    COUNT(DISTINCT CREATED_DATE) AS 'DISTINCT DAYS'
FROM SALES
GROUP BY
	USERID;
 
 
# ==================================================================================================
# 3. WHAT IS THE MOST PURCHASED ITEM ON THE MENU & HOW MANY TIMES IT WAS PURCHASED BY ALL CUSTOMERS?
# ==================================================================================================
SELECT
	PRODUCT_ID,
    COUNT(PRODUCT_ID) AS 'NO OF PRODUCT_ID'
FROM SALES
GROUP BY
	PRODUCT_ID
ORDER BY
	COUNT(PRODUCT_ID) DESC;
    
# AS WE CAN SEE THAT PRODUCT ID 2 IS THE MOST PURCHASED ITEM ON THE MENU

SELECT
	PRODUCT_ID,
    COUNT(PRODUCT_ID) CNT
FROM SALES
GROUP BY
	PRODUCT_ID
ORDER BY
	COUNT(PRODUCT_ID)
    DESC LIMIT 1;
    
SELECT
	USERID,
    COUNT(PRODUCT_ID) CNT
FROM SALES
WHERE
	PRODUCT_ID=(SELECT
					PRODUCT_ID
				FROM SALES
                GROUP BY
					PRODUCT_ID
				ORDER BY
					COUNT(PRODUCT_ID)
                    DESC LIMIT 1)
	GROUP BY
		USERID;
        
        
# =========================================================================
# 4. WHICH ITEM WAS FIRST PURCHASED BY CUSTOMER AFTER THEY BECOME A MEMBER?
# =========================================================================
SELECT
	SALES.USERID,
    SALES.CREATED_DATE,
    SALES.PRODUCT_ID,
    GOLDUSERS_SIGNUP.GOLD_SIGNUP_DATE
FROM SALES
INNER JOIN GOLDUSERS_SIGNUP
ON SALES.USERID = GOLDUSERS_SIGNUP.USERID;