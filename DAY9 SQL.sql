WITH TOTAL_SAL AS (SELECT DEPT_NAME, SUM(SALARY) SSAL
                            FROM EMPLOYEE
                            NATURAL JOIN DEPARTMENT
                            GROUP BY DEPT_NAME)
SELECT DEPT_NAME, SSAL
FROM TOTAL_SAL  --인라인 뷰
WHERE SSAL > (SELECT SUM(SALARY)*0.2
                     FROM EMPLOYEE);


-- *****************************************************************************
-- 분석함수 (윈도우함수)
/*
오라클 분석함수는 데이터를 분석하는 함수이다.
분석함수를 사용하면, 쿼리 실행의 결과인 RESULT SET(결과집합)을 대상으로
전체 데이터가 아닌 소그룹별로 각 행에 대한 분석 결과를 표현하는 함수이다

일반 그룹함수들과 다른 점은 분석함수는 분석함수용 그룹을 별도로 정의해서
각 그룹을 대상으로 분석을 위한 계산을 수행한다
일반 그룹함수는 그룹별로 계산을 수행한다.

사용형식(주로 SELECT절에서 씀)

SELECT 분석함수명 ([전달인자1], [전달인자2], [전달인자3]) 
          OVER ([쿼리 PARTITION 절]
                  [ORDER BY 절]
                  [WINDOW 절]) 
FROM 테이블명

* 분석함수명 : AVG, SUM, RANK, MAX, MIN, COUNT 등
* 전달인자 : 분석함수에 따라서 0~3개까지 사용할 수 있음
* 쿼리 PARTITION 절 : PARTITION BY 표현식
                PARTITION BY 로 시작하며, 표현식에 따라서 그룹별로 분리하는
                역활을 함 RESULT SET(결과집합)을 분리함
* ORDER BY 절 : ORDER BY 컬럼명 정렬방식
                ASC는 생략 가능함
                PARTITION BY 절 뒤에 위치하며,계산 대상 그룹에 대해서 정렬작업을 수행함
                분리된 소그룹 안에서 정렬 처리
* WINDOW 절 : 분석함수의 대상이 되는 데이터를 행 기준으로 범위의 더 세부적으로 정의함
                PARTITION BY 에 의해 나누어진 그룹에 대해 별도로 분석을 위한 소그룹을 만듦
                PARTITION 안에서 어디부터 어디까지의 데이터를 분석 처리해라 는 내용을 실행함
*/

-- 등수 매기는 함수 : RANK
-- 같은 등수가 있을 때는 다음 등수값이 건너뜀
-- 예 : 1, 2, 2, 4

-- 급여에 순위를 매긴다면
SELECT EMP_ID, EMP_NAME, SALARY,
          RANK() OVER (ORDER BY SALARY DESC) 순위  
FROM EMPLOYEE;

-- 어떤 값의 순위를 조회하고자 할 때는
-- RANK (순위를 알고자 하는 값)

-- 급여 2300000 이 급여 큰값에서 작은값순으로 정렬되었을 때
-- 순위를 조회하려면
SELECT RANK(2300000) WITHIN GROUP (ORDER BY SALARY DESC) 순위
FROM EMPLOYEE;

-- DENSE_RANK()
-- 같은 순위가 여러 개 있을 때, 다음 순위를 건너뛰지 않음
-- 예 : 1, 2, 2, 3
SELECT EMP_ID, EMP_NAME, SALARY, 
          RANK() OVER (ORDER BY SALARY DESC) "순위1",
          DENSE_RANK() OVER (ORDER BY SALARY DESC) "순위2",
          DENSE_RANK() OVER (PARTITION BY DEPT_ID
                                       ORDER BY SALARY DESC) "순위3"
                                       -- 그룹 안에서의 정렬임.  그룹안에서의 순위임
FROM EMPLOYEE
ORDER BY DEPT_ID DESC;

-- CUME_DIST()
-- CUMulative DISTribution
-- PARTITION BY 에 의해 나누어진 그룹별로 각 행을 ORDER BY 절에 명시된
-- 순서로 정렬한 다음에, 그룹별로 누적된 분산정도(상대적인 위치)를 구하는 함수임.
-- 분산정도(상대적인 위치)는 구하고자 하는 값보다 작거나 같은 값을 가진 행 수를
-- 그룹 내의 행수로 나눈 것을 의미함
-- 0 < 결과값 <= 1 범위의 값이 됨

-- 부서코드가 '50'인 직원의 이름, 급여, 누적분산을 조회
SELECT EMP_NAME, SALARY,
          ROUND(CUME_DIST() OVER (ORDER BY SALARY), 1) 누적분산
FROM EMPLOYEE
WHERE DEPT_ID = '50';

-- NTILE(전달인자) **********************
/*
PARTITION 을 버킷(BUCKET)이라 불리는 그룹별로 나누고,
PARTITION 내의 각 행을 BUCKET 에 배치하는 함수임
예를 들어 PARTITION 안에 100 개의 행이 있다면, 
BUCKET 을 4개로 정하면, 1개의 BUCKET 당 25개의 행이 배분됨
정확하게 분배되지 않을 때는 근사치로 배분한 후 남는 행은 최초 버킷에
할당됨
*/

-- 급여를 4등급으로 분류
SELECT EMP_NAME, SALARY,
          NTILE(4) OVER (ORDER BY SALARY) 등급
FROM EMPLOYEE;

-- ROW_NUMBER() ********************************
-- ROWNUM 과는 관계가 없음
-- 각 PARTITION 내의 값들을 ORDER BY 에 의해 정렬한 후에
-- 그 순서대로 순번을 부여함

-- 사번, 이름, 급여, 입사일, 순번
-- 단, 순번은 급여가 많은 순으로, 같은 급여는 입사일이 빠른 사람부터
SELECT EMP_ID, EMP_NAME, SALARY, HIRE_DATE,
          ROW_NUMBER() OVER (ORDER BY SALARY DESC, HIRE_DATE ASC) 순번
FROM EMPLOYEE;          
          
-- 집계함수 ********************************* 자주 나오는 개념
-- EMPLOYEE 테이블로 부터 부서코드가 '60'인 직원들의 
-- 사번, 급여, 해당 부서그룹(윈도우라고 함)의 사번을 오름차순 정렬하고
SELECT EMP_ID, SALARY, 
          SUM(SALARY) OVER (PARTITION BY DEPT_ID
                                      ORDER BY EMP_ID
                                      ROWS BETWEEN UNBOUNDED PRECEDING AND
                                      UNBOUNDED FOLLOWING) "WIN1",

-- 급여의 합계를 첫행부터 마지막행까지 구해서 "WIN1" 에,
-- 윈도우의 첫행 : UNBOUNDED PRECEDING
-- 윈도우의 마지막행 : UNBOUNDED FOLLOWING
        SUM(SALARY) OVER (PARTITION BY DEPT_ID
                                    ORDER BY EMP_ID
                                    ROWS BETWEEN UNBOUNDED PRECEDING AND
                                    CURRENT ROW) "WIN2",
-- 윈도우의 시작행에서 현재 위치(CURRENT ROW) 까지의 합계를 구해서 "WIN2" 에,
        SUM(SALARY) OVER (PARTITION BY DEPT_ID
                                    ORDER BY EMP_ID
                                    ROWS BETWEEN CURRENT ROW AND
                                    UNBOUNDED FOLLOWING) "WIN3"
-- 현재 위치에서 윈도우의 마지막행까지의 합계 구해서 "WIN3" 에 조회
FROM EMPLOYEE
WHERE DEPT_ID = '60';

SELECT EMP_ID, SALARY, 
          SUM(SALARY) OVER (PARTITION BY DEPT_ID
                                      ORDER BY EMP_ID
                                      ROWS BETWEEN 1 PRECEDING AND
                                      1 FOLLOWING) "WIN1",

-- 급여의 합계를 현재 행을 중심으로 이전행과 다음행까지 구해서 "WIN1" 에,
-- 1 PRECENDING AND 1 FOLLOWING 
        SUM(SALARY) OVER (PARTITION BY DEPT_ID
                                    ORDER BY EMP_ID
                                    ROWS BETWEEN 1 PRECEDING AND
                                    CURRENT ROW) "WIN2",
-- 윈도우의 이전행과 현재 위치(CURRENT ROW) 까지의 합계를 구해서 "WIN2" 에,
-- 1 PRECENDING AND CURRENT ROW        
        SUM(SALARY) OVER (PARTITION BY DEPT_ID
                                    ORDER BY EMP_ID
                                    ROWS BETWEEN CURRENT ROW AND
                                    1 FOLLOWING) "WIN3"
-- 현재 위치에서 윈도우의 다음행까지의 합계 구해서 "WIN3" 에 조회
-- CURRENT ROW AND 1 FOLLOWING
FROM EMPLOYEE
WHERE DEPT_ID = '60';

-- RATIO_TO_REPORT() **************************
-- 해당 구간에서 차지하는 비율을 리턴하는 함수

-- 직원들의 총급여를 2천만원 증가 시킬 때,
-- 기존 급여 비율을 적용해서 각 직원의 급여 인상분 조회
SELECT EMP_NAME, SALARY, 
          LPAD(TRUNC(RATIO_TO_REPORT(SALARY) OVER () * 100, 0), 5) || '%' 급여비율,
          TO_CHAR(TRUNC(RATIO_TO_REPORT(SALARY) OVER () * 20000000, 0) , 'L00,999,999') 급여인상분
FROM EMPLOYEE;

-- LAG(조회할 범위, 이전위치, 기준현재위치)
-- 지정하는 컬럼의 현재 행을 기준으로 이전 행(위쪽 행)의 값을 조회함
SELECT EMP_NAME, DEPT_ID, SALARY,
          LAG(SALARY, 1, 0) OVER (ORDER BY SALARY) "조회1",
          -- 1 : 현재 위치 기준으로 바로 위의 행의 값, 0 : 이전행이 없으면 0 처리함
          LAG(SALARY, 1, SALARY) OVER (ORDER BY SALARY) "조회2",
          -- 이전행이 없으면, 현재 행의 값을 출력
          LAG(SALARY, 1, SALARY) OVER (PARTITION BY DEPT_ID
                                                   ORDER BY SALARY) "조회3"
         -- 부서 그룹 안에서의 이전행값 출력                                                   
FROM EMPLOYEE;

-- LEAD(조회할 범위, 다음행수, 0 또는 컬럼명)
-- 다음 행의 값 조회
SELECT EMP_NAME, DEPT_ID, SALARY,
          LEAD(SALARY, 1, 0) OVER (ORDER BY SALARY) "조회1",
          -- 1 : 현재 위치 기준으로 바로 위의 행의 값, 0 : 다음행이 없으면 0 처리함
          LEAD(SALARY, 1, SALARY) OVER (ORDER BY SALARY) "조회2",
          -- 다음행이 없으면, 현재 행의 값을 출력
          LEAD(SALARY, 1, SALARY) OVER (PARTITION BY DEPT_ID
                                                   ORDER BY SALARY) "조회3"
         -- 부서 그룹 안에서의 다음행값 출력                                                   
FROM EMPLOYEE
ORDER BY DEPT_ID;