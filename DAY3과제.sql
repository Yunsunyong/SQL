﻿--1번문제
SELECT STUDENT_NO 학번, STUDENT_NAME 이름, ENTRANCE_DATE 입학년도
FROM TB_STUDENT
WHERE DEPARTMENT_NO = '002'
ORDER BY ENTRANCE_DATE ASC;

--2번문제
SELECT PROFESSOR_NAME, PROFESSOR_SSN
FROM TB_PROFESSOR
WHERE LENGTH(PROFESSOR_NAME) <= '2' OR LENGTH(PROFESSOR_NAME) > 3;

--3번문제
SELECT PROFESSOR_NAME 교수이름
FROM TB_PROFESSOR
WHERE PROFESSOR_SSN LIKE '_______1%'
ORDER BY SUBSTR(PROFESSOR_SSN,1,2) DESC, PROFESSOR_NAME ASC; 

--4번문제
SELECT SUBSTR(PROFESSOR_NAME, 2, 4) 이름
FROM TB_PROFESSOR;

--5번문제
SELECT STUDENT_NO, STUDENT_NAME
FROM TB_STUDENT
WHERE MONTHS_BETWEEN(ENTRANCE_DATE,SUBSTR(STUDENT_SSN,1,6)) > 230
ORDER BY STUDENT_NO ASC;

--6번문제
SELECT TO_CHAR(TO_DATE('20/12/25'), 'DAY') "2020년 크리스마스 요일"
FROM DUAL;

--7번문제
SELECT TO_CHAR(TO_DATE('99/10/11','YY/MM/DD'),'YYYY"년" MM"월" DD"일"') "YY/MM/DD", 
           TO_CHAR(TO_DATE('49/10/11','YY/MM/DD'),'YYYY"년" MM"월" DD"일"') "YY/MM/DD",
           TO_CHAR(TO_DATE('99/10/11','RR/MM/DD'),'RRRR"년" MM"월" DD"일"') "RR/MM/DD",
           TO_CHAR(TO_DATE('49/10/11','RR/MM/DD'),'RRRR"년" MM"월" DD"일"') "RR/MM/DD"
FROM DUAL;

--8번문제
SELECT STUDENT_NO, STUDENT_NAME
FROM TB_STUDENT
WHERE STUDENT_NO NOT LIKE 'A%'
ORDER BY STUDENT_NO ASC;

--9번문제
SELECT ROUND(AVG(POINT),1) 평점
FROM TB_GRADE
WHERE STUDENT_NO = 'A517178';

--10번문제
SELECT DISTINCT(DEPARTMENT_NO) 학과번호, COUNT(DEPARTMENT_NO)
FROM TB_STUDENT 
GROUP BY (DEPARTMENT_NO)
ORDER BY DEPARTMENT_NO ASC;

--11번문제
SELECT COUNT(*) - COUNT(COACH_PROFESSOR_NO)
FROM TB_STUDENT;

--12번문제
SELECT DISTINCT SUBSTR(TERM_NO,1,4) 년도, ROUND(AVG(POINT),1) "년도 별 평점"
FROM TB_GRADE
WHERE STUDENT_NO = 'A112113'
GROUP BY SUBSTR(TERM_NO,1,4)
ORDER BY 년도;

--13번문제
SELECT DISTINCT DEPARTMENT_NO, SUM(DECODE(ABSENCE_YN, 'Y', 1 , 'N' , 0))
FROM TB_STUDENT
GROUP BY DEPARTMENT_NO
ORDER BY DEPARTMENT_NO ASC;

--14번문제
SELECT STUDENT_NAME 동일인물, SUM(1) "동명인 수"
FROM TB_STUDENT
GROUP BY STUDENT_NAME
HAVING COUNT(*) > 1
ORDER BY 동일인물;

--15번문제



