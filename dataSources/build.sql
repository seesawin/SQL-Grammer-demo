/*
-- 指定資料庫字元集與COLLECTION
CREATE DATABASE IF NOT EXISTS HELLODB CHARACTER SET UTF8 COLLATE UTF8_UNICODE_CI

-- 修改資料庫字元集與COLLECTION
ALTER DATABASE HELLODB CHARACTER SET BIG5 COLLATE UTF8_UNICODE_CI

-- 刪除資料庫
DROP DATABASE IF EXISTS HELLODB

-- 資料庫資訊
SHOW SCHEMAS
SHOW DATABASES
SHOW CREATE DATABASE TS

-- 查詢支援的儲存引擎
SHOW ENGINES

-- 資料庫相關的資訊
SELECT * FROM information_schema.SCHEMATA

-- LENGTH():非二進位制、non-binary的字串資料實際的儲存長度(byte)
-- CHAR_LENGTH():字串的字元數量
SELECT CATALOG_NAME CN, LENGTH(CATALOG_NAME), CHAR_LENGTH(CATALOG_NAME) FROM information_schema.SCHEMATA

-- 取得MySQL資料庫伺服器關於時區的設定
SELECT @@GLOBAL.TIME_ZONE, @@SESSION.TIME_ZONE

-- 設定系統時區
SET SESSION TIME_ZONE = 'SYSTEM'
SET CLOBAL TIME_ZONE = 'SYSTEM'
*/

-- 建立資料庫
DROP DATABASE IF EXISTS HELLODB;
CREATE DATABASE IF NOT EXISTS HELLODB;
USE HELLODB;

-- 建立表格
USE HELLODB;
 
DROP TABLE IF EXISTS MEMBER;

CREATE TABLE MEMBER (
  ID                                          INT           auto_increment,
  NAME                                        VARCHAR(30),
  SEX                                         VARCHAR(30),
  PHONE                                       VARCHAR(30),
  PROFESSION                                  VARCHAR(30),
  PRIMARY KEY(ID)
);

INSERT INTO MEMBER (NAME, SEX, PHONE, PROFESSION) VALUES ('Frank','boy','0911222333','Web Design');
INSERT INTO MEMBER (NAME, SEX, PHONE, PROFESSION) VALUES ('Alec','boy','0922333444','Sells');
INSERT INTO MEMBER (NAME, SEX, PHONE, PROFESSION) VALUES ('Benny','boy','0933444555','Teacher');
INSERT INTO MEMBER (NAME, SEX, PHONE, PROFESSION) VALUES ('Susan','girl','0944555666','Engineer');
INSERT INTO MEMBER (NAME, SEX, PHONE, PROFESSION) VALUES ('Dona','girl','0955666777','Boss');
INSERT INTO MEMBER (NAME, SEX, PHONE, PROFESSION) VALUES ('Ketty','girl','0966777888','Waiter');
commit;

SELECT * FROM MEMBER;

DROP TABLE IF EXISTS PROFESSION_DETAIL;

CREATE TABLE PROFESSION_DETAIL (
  ID                                          INT           auto_increment,
  M_ID                                        INT,
  DSCR                                        VARCHAR(30),
  REMARK                                      VARCHAR(30),
  PRIMARY KEY (ID)
  -- FOREIGN KEY (M_ID) REFERENCES MEMBER (ID)
);

INSERT INTO PROFESSION_DETAIL (M_ID, DSCR, REMARK) VALUES (1,'Java','HIGH');
INSERT INTO PROFESSION_DETAIL (M_ID, DSCR, REMARK) VALUES (1,'Nodejs','medium');
INSERT INTO PROFESSION_DETAIL (M_ID, DSCR, REMARK) VALUES (1,'go','low');
INSERT INTO PROFESSION_DETAIL (M_ID, DSCR, REMARK) VALUES (7,'English','HIGH');
INSERT INTO PROFESSION_DETAIL (M_ID, DSCR, REMARK) VALUES (7,'Chinese','medium');
INSERT INTO PROFESSION_DETAIL (M_ID, DSCR, REMARK) VALUES (7,'Japen','low');
commit;

select * from profession_detail;

-- join 語法
-- 1. cross join
select * from MEMBER a cross join PROFESSION_DETAIL;

-- 2、INNER Join code as the following:
-- OLD
Select * from MEMBER a, PROFESSION_DETAIL b where a.ID = b.M_ID;

-- NEW
Select * from MEMBER a inner join PROFESSION_DETAIL b on a.ID = b.M_ID;

/* 觀念
  outer join 對參與join的兩個表有主從之分，處理方式以主表的每條數據去match，
  從屬表的列，合乎條件的數據是我們所要的答案，不合乎條件的也是我們要的答案，只不過哪些從屬表選取的列將被添上null。
*/
-- 3. left (outer) join : 左邊的為主表，右邊為從屬表
Select * from member a left join profession_detail b on a.ID = b.M_ID;

-- 4. right join : 左邊的表為從屬表，右邊的表為主表
Select * from member a right join profession_detail b on b.M_ID = a.ID;

-- 5、FULL OUTER Join code as the following : 
-- (1)是 LEFT JOIN 與 RIGHT JOIN 的聯集，MySQL無支援
-- (2)不僅列出符合條件的數據，兩邊未符合join條件的數據也會一併列出。哪些未符合join條件的數據如果在select列中無法得到對應的值則填上null
-- 以union模擬full join
Select * from member a left join profession_detail b on a.ID = b.M_ID
union
Select * from member a right join profession_detail b on b.M_ID = a.ID;

-- OLD
/*Select * from MEMBER a, profession_detail b where a.ID *=  b.M_ID;
Select * from MEMBER a, profession_detail b where a.ID =*  b.M_ID;

-- NEW
select * from MEMBER a FULL outer join profession_detail b  on a.ID = b.M_ID;
*/

-- 6. self join : 常用在同一表內不同數據間對同一列的比較






