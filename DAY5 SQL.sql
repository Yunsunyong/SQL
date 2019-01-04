--DAY5

-- 정렬시 NULL은 맨위로 오게 되있음
-- 단, 조정 가능함 ORDER BY 컬럼명 [ASC] | DESC NULLS LAST(맨밑에) | FIRST(맨위에)

-- ORDER BY 절 ************************************************************************
-- SELECT 한 컬럼을 기준으로 행들을 제배치 정렬시킬 때 사용함
-- ORDER BY 컬럼명 [ASC] | DESC (기본이 오름차순임)
-- ORDER BY 컬럼명 정렬방식, 컬럼명 정렬방식, 컬럼명 정렬방식, ......
-- 첫번째 컬럼에 대해 정렬하고, 첫번째 컬럼에서 같은 값에 대해서
-- 두번째 컬럼에 대해 정렬하고, ................
-- SELECT 문 맨 마지막에 사용함.
-- 실행순서도 가장 마지막에 실행됨.
/*
5 : SELECT 컬렴명 별칭, 계산식, 함수식
1 : FROM 테이블명
2 : WHERE 컬럼명 | 단일행함수식 연산자 비교값 | 단일행함수식
3 : GROUP BY 컬럼명 | 함수식
4 : HAVING 그룹함수 비교연산자 비교값
6 : ORDER BY 컬럼명 | 별칭 | 컬럼순번 정렬방식 [NULLS LAST] | [NULLS FIRST]
*/

SELECT EMP_NAME, SALARY, DEPT_ID
FROM EMPLOYEE
WHERE DEPT_ID = '50' OR DEPT_ID IS NULL
ORDER BY SALARY DESC, 1 DESC;

-- 2003년 1월 1일 이후에 입사한 직원정보 조회
-- 이름, 입사일, 부서코드, 급여 조회, 별칭 처리
-- 부서코드를 기준 내림차순 정렬하고, 같은 부서코드일 때 입사일 기준 오름차순 정렬
-- 입사일도 같으면 이름 기준 오름차순정렬 처리함
SELECT EMP_NAME 이름, HIRE_DATE 입사일, DEPT_ID 부서코드, SALARY 급여
FROM EMPLOYEE
WHERE HIRE_DATE > TO_DATE('20030101', 'RRRRMMDD')
--ORDER BY DETP_ID DESC NULLS LAST, HIRE_DATE, EMP_NAME;
--ORDER BY 3 DESC NULLS LAST, 2, 1;
ORDER BY 부서코드 DESC NULLS LAST, 입사일, 이름 ;

-- GROUP BY 절 **********************************************************
-- 같은 값들이 여러 개 기록된 컬럼을 기준으로 같은 값들을 그룹 묶을 때 사용함
-- GPOUP BY 컬럼명 | 계산식
-- 같은 항목끼리 묶어서 계산할 때 사용함
-- 그룹 묶은 항목에 대한 계산은 SELECT 절에 그룹함수로 명시됨

SELECT EMP_NAME, SALARY, DEPT_ID
FROM EMPLOYEE;

-- 부서별 급여의 합계를 구함
SELECT DEPT_ID, SUM(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_ID  --부서별로 그룹 묶음
ORDER BY DEPT_ID ASC NULLS LAST;

-- 직급별 급여의 합계, 급여의 평균(정수로 처리), 직원수 조회
SELECT JOB_ID 직급코드, SUM(SALARY) "급여의 합계", FLOOR(AVG(SALARY)) "급여의 평균"
FROM EMPLOYEE
GROUP BY JOB_ID
ORDER BY JOB_ID NULLS LAST;

-- GROUP BY 절에 명시하지 않은 컬럼은 SELECT 절에 사용 못 함
-- SELECT 절에 그룹함수와 같이 사용할 컬럼은 반드시 GROUP BY 절에 사용되어야 함
-- 부서별, 직급별 급여합계, 평균, 직원수 조회
SELECT DEPT_ID, JOB_ID, SUM(SALARY), FLOOR(AVG(SALARY)), COUNT(*)
FROM EMPLOYEE
GROUP BY DEPT_ID; --ERROR

--해결
SELECT DEPT_ID, JOB_ID, SUM(SALARY), FLOOR(AVG(SALARY)), COUNT(*)
FROM EMPLOYEE
GROUP BY DEPT_ID, JOB_ID
ORDER BY DEPT_ID NULLS LAST, JOB_ID NULLS LAST;

-- 계산식 사용
-- 성별별 급여합계, 급여평균(천단위에서 반올림함), 직원수 조회
SELECT DECODE(SUBSTR(EMP_NO,8,1), '1', '남', '3', '남', '여') 성별,
          SUM(SALARY), ROUND(AVG(SALARY), -4), COUNT(*)
FROM EMPLOYEE
GROUP BY DECODE(SUBSTR(EMP_NO,8,1), '1', '남', '3', '남', '여')
ORDER BY 성별;

-- 에러 : 출력행의 갯수가 달라서 에러남
SELECT DEPT_ID, COUNT(*)
FROM EMPLOYEE;

-- 해결
SELECT DEPT_ID, COUNT(*)
FROM EMPLOYEE
GROUP BY DEPT_ID;

-- 부서별 급여합계중 가장 큰 값 조회
SELECT MAX(SUM(SALARY)) -- 18100000
FROM EMPLOYEE
GROUP BY DEPT_ID;

-- ERROR : ROW 갯수가 다름
SELECT DEPT_ID, MAX(SUM(SALARY))
FROM EMPLOYEE
GROUP BY DEPT_ID;

-- HAVING 절 *******************************************************************
-- GROUP BY 절 아래에 사용함
-- 반드시 GROUP BY 절과 함게 사용해야 함
-- 그룹 묶어서 계산한 그룹함수 결과값들에 대한 조건처리가 목적임

-- HAVING 그룹함수(컬럼명) 비교연산자 비교값
-- SELECT 절은 HAVING 처리로 골라낸 결과만 출력 처리함

-- 부서별 급여합계 중 9백만을 초과하는 부서와 급여합계 조회
SELECT DEPT_ID, SUM(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_ID 
HAVING SUM(SALARY) > 9000000;

-- 분석함수 *************************************************************************
-- RANK() 함수 : 순위(등수) 조회시 사용

-- 해당 값에 대한 전체 값에서의 순위를 알고자 할 때
-- RANK(순위를 알고자 하는 값) WITHIN GROUP (ORDER BY 컬럼명 정렬방식)
SELECT RANK(2300000) WITHIN GROUP (ORDER BY SALARY DESC) 순위
FROM EMPLOYEE;

-- 전체 값에 순위를 매기고자 할 경우
SELECT EMP_NAME, SALARY, 
          RANK() OVER (ORDER BY SALARY DESC) 순위
FROM EMPLOYEE
ORDER BY 순위;

-- ROLLUP 함수
-- GROUP BY 절에서만 사용함
-- 그룹별로 묶어서 계산한 결과에 대해서 총집계를 구할 때 사용함
SELECT DEPT_ID, SUM(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_ID;

SELECT DEPT_ID, SUM(SALARY)
FROM EMPLOYEE
GROUP BY ROLLUP(DEPT_ID);

SELECT DEPT_ID, SUM(SALARY), AVG(SALARY), MIN(SALARY), MAX(SALARY)
FROM EMPLOYEE
WHERE DEPT_ID IS NOT NULL
GROUP BY ROLLUP(DEPT_ID);
-- 그룹함수로 계산된 결과값들에 대한 총집계가 자동으로 아랫쪽에 행으로 추가됨.

-- 실습 : 부서코드와 직급코드를 함께 그룹으로 묶고
-- 급여의 합계를 구함
-- ROLLUP 사용함
SELECT DEPT_ID, JOB_ID, SUM(SALARY)
FROM EMPLOYEE
WHERE DEPT_ID IS NOT NULL AND JOB_ID IS NOT NULL
GROUP BY ROLLUP(DEPT_ID,JOB_ID);

SELECT DEPT_ID, JOB_ID, SUM(SALARY)
FROM EMPLOYEE
WHERE DEPT_ID IS NOT NULL AND JOB_ID IS NOT NULL
GROUP BY CUBE(DEPT_ID,JOB_ID);   --위쪽에 집계가 표시됨

SELECT DEPT_ID, JOB_ID, SUM(SALARY)
FROM EMPLOYEE
WHERE DEPT_ID IS NOT NULL AND JOB_ID IS NOT NULL
GROUP BY ROLLUP(DEPT_ID),ROLLUP(JOB_ID);

-- GROUPING **********************************************************
-- SELECT 절과 GROUP BY 절에서만 사용함
-- 컬럼 그룹 묶을 때 사용함.
-- 그룹 묶은 값(0)인지, 집계값(1)인지 구분하기 위한 용도로 사용함.
-- ROLLUP, CUBE 함수 사용시 이용하는 함수임.
SELECT DEPT_ID, JOB_ID, SUM(SALARY),
          GROUPING(DEPT_ID) "부서별 그룹 묶인 상태",
          GROUPING(JOB_ID) "직급별 그룹 묶인 상태"
FROM EMPLOYEE
WHERE DEPT_ID IS NOT NULL AND JOB_ID IS NOT NULL
GROUP BY ROLLUP(DEPT_ID, JOB_ID);

SELECT DEPT_ID, JOB_ID, SUM(SALARY),
          GROUPING(DEPT_ID) "부서별 그룹 묶인 상태",
          GROUPING(JOB_ID) "직급별 그룹 묶인 상태"
FROM EMPLOYEE
WHERE DEPT_ID IS NOT NULL AND JOB_ID IS NOT NULL
GROUP BY CUBE(DEPT_ID, JOB_ID);

-- GROUPING SETS ******************************************************
-- 그룹별로 묶어서 처리한 여러 개의 SELECT 문을 하나로 합친 결과를 원할 때 사용

-- 집합연산자(SET OPERATOR) 사용한 경우
-- NULL < DUMMY컬럼 칸수 맞추기 위한
SELECT DEPT_ID, JOB_ID, MGR_ID, AVG(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_ID, JOB_ID, MGR_ID
UNION ALL
SELECT DEPT_ID, NULL, MGR_ID, AVG(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_ID, MGR_ID
UNION ALL
SELECT NULL, JOB_ID, MGR_ID, AVG(SALARY)
FROM EMPLOYEE
GROUP BY JOB_ID, MGR_ID;

-- 위의 처리과정을 GROUPING SETS 로 바꾸면
SELECT DEPT_ID, JOB_ID, MGR_ID, AVG(SALARY)
FROM EMPLOYEE
GROUP BY GROUPING SETS((DEPT_ID, JOB_ID,MGR_ID),
                                    (DEPT_ID, MGR_ID),
                                    (JOB_ID,MGR_ID));
                                
SELECT DEPT_ID, JOB_ID, MGR_ID, SUM(SALARY)
FROM EMPLOYEE
GROUP BY ROLLUP(DEPT_ID, (JOB_ID,MGR_ID));

-- ROWID : 한 행을 구분하는 행에 대한 아이디값
-- 데이터베이스가 자동으로 붙임. 수정못함, 조회만 할 수 있음
SELECT EMP_ID, ROWID
FROM EMPLOYEE;




















