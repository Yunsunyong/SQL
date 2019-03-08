-- 동의어 (SYNONYM)
/*
데이터베이스에서 다른 사용자가 가진 객체에 대한 줄임말
여러 사용자가 테이블을 공유할 경우, 다른 사용자가 테이블에 접글할 때
사용자명.테이블명 으로 표현함.
이때 동의어를 사용하면 간단하게 기술할 수 있게 됨.

동의어 생성 방법
CREATE SYNONYM 줄임말 FOR 사용자이름.객체명;
*/

--예 : 테이블명 줄임말 만들기
CREATE SYNONYM EP FOR EMPLOYEE;

SELECT * FROM EMPLOYEE;
SELECT * FROM EP;

-- 예
SELECT * FROM SCOTT.EMP;

CREATE SYNONYM SE FOR SCOTT.EMP;
SELECT * FROM SE;

-- 예
SELECT * FROM SYS.DUAL;

CREATE SYNONYM D FOR SYS.DUAL;

SELECT 25+3
--FROM DUAL;
FROM D;

-- 동의어는 모든 사용자를 대상으로 하는 공개(PUBLIC) 동의어와
-- 개별 사용자를 대상으로 하는 비공개 동의어로 구분함
-- 공개 동의어는 반드시 SYSTEM (관리자) 계정에서 생성해야 함
/*
CREATE PUBLIC SYNONYM 줄임말(동의어이름) 
FOR 사용자이름.객체명;
*/

-- 동의어 삭제
-- DROP SYNONYM 동의어이름(줄임말);
DROP SYNONYM D;

-- 관리자계정에서 공개동의어 삭제
-- DROP PUBLIC SYNONYM 동의어이름;





