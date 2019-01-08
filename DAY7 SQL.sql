--DAY7

-- SET OPERATOR (집합 연산자)
-- UNION, UNION ALL, INTERSECT, MINUS
-- UNION, UNION ALL (합집합) : 여러 개의 SELECT 문의 결과를 하나로 합침
-- INTERSECT (교집합) : 여러 개의 SELECT 결과에서 골통된 행만 골라냄
-- MINUS (차집합) : 첫번째 SELECT 결과에서 두번째 SELECT 결과와 겹치는
--          일치하는 부분을 뺀 결과만 선택함

SELECT EMP_ID, ROLE_NAME
FROM EMPLOYEE_ROLE
UNION ALL
SELECT EMP_ID, ROLE_NAME
FROM ROLE_HISTORY;

SELECT EMP_ID, ROLE_NAME
FROM EMPLOYEE_ROLE
INTERSECT
SELECT EMP_ID, ROLE_NAME
FROM ROLE_HISTORY;

SELECT EMP_ID, ROLE_NAME
FROM EMPLOYEE_ROLE
MINUS
SELECT EMP_ID, ROLE_NAME
FROM ROLE_HISTORY;

-- SET 연산자 사용시 주의사항
-- SELECT 절에 컬럼의 갯수가 같아야 함 : 더미(DUMMY) 컬럼을 이용함
-- SELECT 절의 각 항목별로 자료형이 같아야 함
SELECT EMP_NAME, JOB_ID, HIRE_DATE
FROM EMPLOYEE
WHERE DEPT_ID = '20'
UNION
SELECT DEPT_NAME, DEPT_ID, NULL
FROM DEPARTMENT
WHERE DEPT_ID = '20';

-- 50번 부서에 소속된 직원 중 관리자와 일반 직원을 따로 조회해서 하나로 합쳐라
SELECT *
FROM EMPLOYEE
WHERE DEPT_ID = '50';

SELECT EMP_ID, EMP_NAME, '관리자' 구분
FROM EMPLOYEE
WHERE DEPT_ID = '50' AND EMP_ID = '141'
UNION
SELECT EMP_ID, EMP_NAME, '직원' 구분
FROM EMPLOYEE
WHERE DEPT_ID = '50' AND EMP_ID <> '141'
ORDER BY 3, 1;

SELECT 'SQL을 공부하고 있습니다' 문장, 3 순서 FROM DUAL
UNION
SELECT '우리는 지금', 1 FROM DUAL
UNION
SELECT '아주 재미있게', 2 FROM DUAL
ORDER BY 순서;

-- 집합 연산자와 JOIN의 관계
SELECT EMP_ID, ROLE_NAME
FROM EMPLOYEE_ROLE
INTERSECT
SELECT EMP_ID, ROLE_NAME
FROM ROLE_HISTORY;

-- 조인구문에서 USING (EMP_ID, ROLE_NAME) 의 의미
-- 두 컬럼의 값을 하나의 값으로 생각하고 일치하는 항목을 찾음.
-- (104 SE) = (104 SE) : 같은 값
-- (104 SE-ANLY) != (104 SE) : 다른 값

-- 위의 쿼리문을 조인구문으로 바꾸면
SELECT EMP_ID, ROLE_NAME
FROM EMPLOYEE_ROLE
JOIN ROLE_HISTORY USING(EMP_ID, ROLE_NAME);

-- 집합 연산자와 IN 연산자의 관계
-- UNION 과 IN 이 서로 동일한 결과를 만들 수 있음
-- 직급이 대리 또는 사원인 직원의 이름과 직급명 조회
-- 직급순 오름차순정렬하고, 직급이 같으면 이름순 오름차순정렬 처리
SELECT EMP_NAME, JOB_TITLE
FROM EMPLOYEE
JOIN JOB USING (JOB_ID)
WHERE JOB_TITLE IN ('대리','사원')
ORDER BY 2, 1;

--UNION으로 바꾸면
SELECT EMP_NAME, JOB_TITLE
FROM EMPLOYEE
JOIN JOB USING (JOB_ID)
WHERE JOB_TITLE = '대리'
UNION
SELECT EMP_NAME, JOB_TITLE
FROM EMPLOYEE
JOIN JOB USING (JOB_ID)
WHERE JOB_TITLE = '사원'
ORDER BY 2, 1;

-- *********************************************************************************
/*
메소드(리턴값이 있는 메소드())
컬럼명 비교연산자 비교할값 <--- 비교할 값을 알아내기위한 SELECT 문을
                                         값 사용 위치에 바로 쓸 수 있음
컬럼명 비교연산자 (SELECT ... )                                    
*/

-- 서브쿼리 (SUB QUERY)
-- 쿼리문 안에 사용된 쿼리문

-- 예 : 나승원 이라는 직원과 같은 부서에 소속된 직원들의 명단 조회
-- 1. 나승원이 소속된 부서 조회
SELECT DEPT_ID
FROM EMPLOYEE
WHERE EMP_NAME = '나승원'; --50번 부서

-- 2. 조회된 결과값을 사용해서 부서원들 조회
SELECT EMP_NAME
FROM EMPLOYEE
WHERE DEPT_ID = '50';

-- 서브쿼리를 이용하면
SELECT EMP_NAME
FROM EMPLOYEE
WHERE DEPT_ID = (SELECT DEPT_ID
                        FROM EMPLOYEE
                        WHERE EMP_NAME = '나승원'); --한개의 결과를 만들어내는 서브쿼리는 단일행서브쿼리

-- 서브쿼리의 유형은
-- 단일행 서브쿼리, 다중행 서브쿼리, 다중열 서브쿼리, 다중열 다중행 서브쿼리
-- 상호연관 서브쿼리, 스칼라 서브쿼리
-- 서브쿼리 앞에 붙는 연산자가 달라짐.

-- 단일행 서브쿼리 (SINGLE ROW SUBQUERY)
-- 서브쿼리의 결과값이 한 개인 경우
-- 단일행 서브쿼리 앞에는 일반 비교연산자 모두 사용 가능함
-- <, >, <=, >=, =, !=|<>|^=

-- 예 : 나승원과 직급이 같으면서, 나승원보다 급여를 많이 받는 직원 조회
-- 이름, 직급, 급여

--1. 나승원의 직급 조회
SELECT JOB_ID
FROM EMPLOYEE
WHERE EMP_NAME = '나승원';  --J5
          
--2. 나승원의 급여 조회
SELECT SALARY
FROM EMPLOYEE
WHERE EMP_NAME = '나승원';  --2300000

-- 3. 결과 조회
SELECT EMP_NAME 이름,
          JOB_ID 직급,
          SALARY 급여
FROM EMPLOYEE
WHERE JOB_ID = 'J5' AND
          SALARY > 2300000;
          
-- 서브쿼리로 바꾼다면
SELECT EMP_NAME 이름,
          JOB_ID 직급,
          SALARY 급여
FROM EMPLOYEE
WHERE JOB_ID = (SELECT JOB_ID
                        FROM EMPLOYEE
                        WHERE EMP_NAME = '나승원')
                        AND
            SALARY > (SELECT SALARY
                          FROM EMPLOYEE
                          WHERE EMP_NAME = '나승원');
                          
SELECT EMP_NAME,
          JOB_ID,
          SALARY
FROM EMPLOYEE
WHERE SALARY = (SELECT MIN(SALARY)
                        FROM EMPLOYEE);    

-- 부서별 급여합계 중 가장 큰 값 조회
-- 가장 많은 급여를 받아가는 부서 조회
SELECT DEPT_NAME, SUM(SALARY)
FROM EMPLOYEE
LEFT JOIN DEPARTMENT USING (DEPT_ID)
GROUP BY DEPT_NAME
HAVING SUM(SALARY) = (SELECT MAX(SUM(SALARY))
                                  FROM EMPLOYEE
                                  GROUP BY DEPT_ID);   --당일행 서브쿼리
                                  
-- 서브쿼리는 SELECT절, FROM절, WHERE절, GROUP BY절, HAVING 절
-- ORDER BY절에서 모두 사용 가능함

-- 다중행(MULTIPLE ROW)서브쿼리 *****************************************
-- 서브쿼리 결과값의 갯수가 여러 개인 경우
SELECT MIN(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_ID;
                         
-- 부서별로 그 부서의 최저급여를 받고 있는 직원 조회
SELECT EMP_ID, SALARY
FROM EMPLOYEE
WHERE SALARY = (SELECT MIN(SALARY)
                        FROM EMPLOYEE 
                        GROUP BY DEPT_ID); --다중행 서브쿼리 ERR
                         
/*
다중행 서브쿼리 앞에는 일반 비교연산자 사용 못 함
일반 비교연산자는 한 개의 값을 가지고 비교 판단함.

다중행 서브쿼리 앞에 사용할 수 있는 연산자는
컬럼명 IN (다중행 서브쿼리) : 여러 개의 값중에서 한 개라도 일치하는 값이 있다면...
컬럼명 NOT IN (다중행 서브쿼리) : 여러 개의 값중 한개라도 일치하지 않는다면....

컬럼명 > ANY (다중행 서브쿼리) : 여러 값중 하나라도 크냐?
                                    가장 작은 값보다 크냐?
컬럼명 < ANY (다중행 서브쿼리) : 여러 값중 하나라도 작으냐?
                                    가장 큰 값보다 작으냐?

컬럼명 > ALL (다중행 서브쿼리) : 모든 값보다 크냐? (가장 큰 값보다 크냐?)
컬럼명 < ALL (다중행 서브쿼리) : 모든 값보다 작으냐? (가장 작은 값보다 작으냐?)
*/                         
SELECT EMP_ID, SALARY
FROM EMPLOYEE
WHERE SALARY IN (SELECT MIN(SALARY)
                        FROM EMPLOYEE 
                        GROUP BY DEPT_ID);   
                          
-- IN / NOT IN
-- 여러 개의 값과 비교해서 같은 값이 있는지/ 같은 값이 없느지 비교
SELECT DISTINCT MGR_ID
FROM EMPLOYEE
WHERE MGR_ID IS NOT NULL;

-- 직원 정보에서 관리자만 추출 조회
SELECT EMP_ID, EMP_NAME, '관리자' 구분
FROM EMPLOYEE
WHERE EMP_ID IN (SELECT MGR_ID FROM EMPLOYEE)
UNION
SELECT EMP_ID, EMP_NAME, '직원' 구분
FROM EMPLOYEE
WHERE EMP_ID NOT IN (SELECT MGR_ID FROM EMPLOYEE
                                WHERE MGR_ID IS NOT NULL)
ORDER BY 3, 1;       

SELECT EMP_ID, EMP_NAME,
        CASE
        WHEN EMP_ID IN (SELECT MGR_ID FROM EMPLOYEE) THEN '관리자'
        ELSE '직원' 
        END 구분
FROM EMPLOYEE
ORDER BY 3, 1;
                          
                          
                          
                          
                          
                          