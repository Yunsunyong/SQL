--함수 연습문제

--1. 직원명과 주민번호를 조회함
--  단, 주민번호 9번째 자리부터 끝까지는 '*'문자로 채움
--  예 : 홍길동 771120-1******
SELECT EMP_NAME 직원명, 
           RPAD(SUBSTR(EMP_NO,1,8),14,'*') 주민번호
FROM EMPLOYEE;

--2. 직원명, 직급코드, 연봉(원) 조회
--  단, 연봉은 ￦57,000,000 으로 표시되게 함
--     연봉은 보너스포인트가 적용된 1년치 급여임
SELECT EMP_NAME 직원명, 
           DEPT_ID 직급코드, 
           TO_CHAR((SALARY + (SALARY * NVL(BONUS_PCT,0))) * 12, 'L999,999,999') "연봉(원)"
FROM EMPLOYEE;

--3. 부서코드가 50, 90인 직원들 중에서 2004년도에 입사한 직원의 
--   수 조회함.
--	사번 사원명 부서코드 입사일
SELECT EMP_NO 사번, 
           EMP_NAME 사원명, 
           DEPT_ID 부서코드, 
           HIRE_DATE 입사일
FROM EMPLOYEE
WHERE (DEPT_ID = '50' OR DEPT_ID = '90') AND TO_CHAR(HIRE_DATE, 'YY') = '04';

--4. 직원명, 입사일, 입사한 달의 근무일수 조회
--  단, 주말도 포함함
SELECT EMP_NAME 직원명, 
           HIRE_DATE 입사일, 
           LAST_DAY(HIRE_DATE) - HIRE_DATE "입사한 달의 근무일수"
FROM EMPLOYEE;

--5. 직원명, 부서코드, 생년월일, 나이(만) 조회
--  단, 생년월일은 주민번호에서 추출해서, 
--     ㅇㅇ년 ㅇㅇ월 ㅇㅇ일로 출력되게 함.
--  나이는 주민번호에서 추출해서 날짜데이터로 변환한 다음, 계산함
SELECT EMP_NAME 직원명, 
           DEPT_ID 부서코드,
           TO_CHAR(TO_DATE(SUBSTR(EMP_NO,1, 6), 'RRMMDD'),'RRRR"년" MM"월" DD"일"') 생년월일,
           FLOOR(MONTHS_BETWEEN(SYSDATE,TO_DATE(SUBSTR(EMP_NO,1, 6),'RRMMDD')) / 12) 나이
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO,5,2) <= 31;

--6. 직원들의 입사일로 부터 년도만 가지고, 각 년도별 입사인원수를 구하시오.
--  아래의 년도에 입사한 인원수를 조회하시오.
--  => to_char, decode, sum 사용

--	-------------------------------------------------------------
--	전체직원수   2001년   2002년   2003년   2004년
--	-------------------------------------------------------------
SELECT SUM(1) 전체직원수,
           SUM(DECODE(TO_CHAR(HIRE_DATE,'YY'),
                  '01', 1)) "2001년",
           SUM(DECODE(TO_CHAR(HIRE_DATE,'YY'),
                  '02', 1)) "2002년",
           SUM(DECODE(TO_CHAR(HIRE_DATE,'YY'),
                  '03', 1)) "2003년",
           SUM(DECODE(TO_CHAR(HIRE_DATE,'YY'),
                  '04', 1)) "2004년"
FROM EMPLOYEE;


--7.  부서코드가 50이면 총무부, 60이면 기획부, 90이면 영업부로 처리하시오.
--   단, 부서코드가 50, 60, 90 인 직원의 정보만 조회함
--  => case 사용
--	부서코드 기준 오름차순 정렬함.
SELECT EMP_NAME 이름, DEPT_ID 부서코드,
          CASE DEPT_ID 
          WHEN '50' THEN '기획부'
          WHEN '60' THEN '기획부'
          ELSE '영업부' END AS 부서
FROM EMPLOYEE
WHERE DEPT_ID IN('50','60','90')
ORDER BY DEPT_ID;














