--DAY8
 
-- 다중행 서브쿼리에 사용할 수 있는 연산자
-- IN/NOT IN, ANY, ALL

-- 컬럼명 > ANY (다중행 서브쿼리) : 서브쿼리 값들 중에 최소값보다 크냐?
-- 컬러명 < ANY (다중행 서브쿼리) : 서브쿼리 값들 중에 최대값보다 작으냐?

-- 대리 직급의 직원 중에서 과장 직급 급여의 최소값보다 많이 받는 직원 조회
SELECT EMP_ID, EMP_NAME, JOB_TITLE, SALARY
FROM EMPLOYEE
JOIN JOB USING (JOB_ID)
WHERE JOB_TITLE = '대리'
AND SALARY > ANY (SELECT SALARY
                            FROM EMPLOYEE
                            JOIN JOB USING(JOB_ID)
                            WHERE JOB_TITLE = '과장');
                            
-- 컬럼명 > ALL (다중행 서브쿼리) : 컬럼값이 서브쿼리 결과값들과 비교해서 가장 큰 값보다 크냐?
-- 컬럼명 < ALL (다중행 서브쿼리) : 컬럼값이 서브쿼리 결과값들과 비교해서 가장 작은 값보다 작으냐?


-- 과장 직급의 급여 중 가장 큰 값보다 급여를 많이 받는 대리 직원 조회
SELECT EMP_NAME, JOB_TITLE, SALARY
FROM EMPLOYEE
JOIN JOB USING (JOB_ID)
WHERE JOB_TITLE = '대리'
AND SALARY > ALL (SELECT SALARY
                            FROM EMPLOYEE
                            JOIN JOB USING(JOB_ID)
                            WHERE JOB_TITLE = '과장');
                            
-- 서브쿼리의 사용 위치
-- SELECT 절, FROM 절, WHERE 절, GROUP BY 절, HAVING 절,
-- ORDER BY 절, INSERT 문, UPDATE 문, CREAT TABLE 문
-- CREAT VIEW 문

-- 자기 직급의 평균 급여를 받는 직원 조회
-- 1. WHERE 절에서 사용한 경우
SELECT JOB_ID, TRUNC(AVG(SALARY), -5)
FROM EMPLOYEE
GROUP BY  JOB_ID;

SELECT EMP_NAME, JOB_TITLE, SALARY, E.JOB_ID
FROM EMPLOYEE E
LEFT JOIN JOB J ON (E.JOB_ID = J.JOB_ID)
WHERE SALARY IN (SELECT TRUNC(AVG(SALARY), -5)
                          FROM EMPLOYEE
                          WHERE NVL(JOB_ID,' ') = NVL(J.JOB_ID,' ')
                          GROUP BY JOB_ID
                          );
                          
SELECT EMP_NAME, JOB_TITLE, SALARY, JOB_ID
FROM EMPLOYEE 
LEFT JOIN JOB USING (JOB_ID)
WHERE SALARY IN (SELECT TRUNC(AVG(SALARY), -5)
                          FROM EMPLOYEE
                          GROUP BY JOB_ID
                          );                          
                          
-- 2. FROM 절에서 사용한 서브쿼리
-- FROM 테이블명 >>>>> FROM (서브쿼리)
-- 테이블을 대신함
-- 인라인 뷰(INLINE VIEW) : FROM 절에 사용된 서브쿼리의 결과집합
-- 조인 처리시 오라클 전용구문과 ANSI 표준구문의 ON 사용시에 테이블 별칭 사용가능

SELECT EMP_NAME, JOB_TITLE, SALARY
FROM (SELECT JOB_ID, TRUNC(AVG(SALARY),-5) JOBAVG
         FROM EMPLOYEE
         GROUP BY JOB_ID) V  -- 인라인 뷰
LEFT JOIN EMPLOYEE E ON (V.JOBAVG = E.SALARY 
                                    AND NVL(V.JOB_ID,' ') = NVL(E.JOB_ID,' '))
LEFT JOIN JOB J ON (E.JOB_ID = J.JOB_ID)
ORDER BY 3, 2;

/*
서브쿼리의 종류
단일행 서브쿼리 : 결과값이 1개에 값 1개
다중행 서브쿼리 : 결과값이 항목 1개에 값 여러 개
다중열 단일행 서브쿼리 : 결과값이 항목이 여러 개 값은 1행
다중열 다중행 서브쿼리 : 결과값이 항목 여러개, 값도 여러행
=> 대부분의 서브쿼리는 서브쿼리가 만든 값을 메인 쿼리가 사용하는 구조임

상[호연]관 서브쿼리 : 서브쿼리가 메인쿼리의 값을 가져다가 결과를 만듦
                           메인쿼리의 값에 따라 서브쿼리의 결과도 달라짐
스칼라 서브쿼리 : 상관쿼리 + 단일행 서브쿼리
*/

-- 3. 상[호연]관 서브쿼리 
SELECT EMP_NAME, JOB_TITLE, SALARY, E.JOB_ID
FROM EMPLOYEE E
LEFT JOIN JOB J ON (E.JOB_ID = J.JOB_ID)
WHERE SALARY = (SELECT TRUNC(AVG(SALARY),-5)
                        FROM EMPLOYEE
                        WHERE NVL(JOB_ID, ' ') = NVL(E.JOB_ID,' '))
ORDER BY 2;

-- 4. 다중열 다중행 서브쿼리
SELECT EMP_NAME, JOB_TITLE, SALARY
FROM EMPLOYEE
LEFT JOIN JOB USING (JOB_ID)
WHERE (NVL(JOB_ID,' '), SALARY) IN (SELECT NVL(JOB_ID,' '), TRUNC(AVG(SALARY), -5)
                  FROM EMPLOYEE
                  GROUP BY NVL(JOB_ID,' ')
                  )
ORDER BY 2;

-- EXISTS / NOT EXISTS 연산자
-- 상관쿼리에만 사용하는 연산자임
-- 서브쿼리의 결과가 존재하는지 / 존재하지 않는지 물어보는 연산자임.

-- 관리자인 직원 정보 조회
SELECT EMP_ID, EMP_NAME, '관리자' 구분
FROM EMPLOYEE E
WHERE EXISTS (SELECT NULL
                     FROM EMPLOYEE 
                     WHERE E.EMP_ID = MGR_ID);
-- 서브쿼리의 조건을 만족하는 행들만 골라냄                     
                     
-- 관리자가 아닌 직원 정보 조회
SELECT EMP_ID, EMP_NAME, '직원' 구분
FROM EMPLOYEE E
WHERE NOT EXISTS (SELECT NULL
                            FROM EMPLOYEE
                            WHERE E.EMP_ID = MGR_ID);
-- 서브쿼리 조건절과 일치하지 않는 행들만 골라냄

-- 스칼라 서브쿼리
-- 한 컬럼의 한개의 행만 결과로 반환하는 상관쿼리
-- 상관쿼리 + 단일행 서브쿼리

-- 사원명, 부서코드, 급여, 해당 직원이 소속된 부서의 급여평균 조회
-- SELECT 절에서 사용한 경우
SELECT EMP_NAME, DEPT_ID, SALARY, 
          (SELECT TRUNC(AVG(SALARY),-5) --항목 1개 평균값 1개
          FROM EMPLOYEE
          WHERE DEPT_ID = E.DEPT_ID) AS AVGSAL
FROM EMPLOYEE E;

-- CASE 표현식에 서브쿼리 사용
-- 부서의 근무지역이 'OT'이면 '본사팀', 아니면 '지역팀' 으로 
-- 직원의 근무지역에 대한 소속을 조회
SELECT EMP_ID, EMP_NAME, 
         CASE 
         WHEN DEPT_ID = (SELECT DEPT_ID
                                FROM DEPARTMENT
                                WHERE LOC_ID = 'OT') THEN '본사팀'
         ELSE '지역팀'
         END AS 소속
FROM EMPLOYEE 
ORDER BY 소속 DESC;

-- ORDER BY 절에 스칼라 서브쿼리 사용 가능

-- 직원이 소속된 부서의 부서명이 큰 값부터 정렬되게 직원 정보 조회
SELECT EMP_ID, EMP_NAME, DEPT_ID, HIRE_DATE
FROM EMPLOYEE E
ORDER BY (SELECT DEPT_NAME
               FROM DEPARTMENT
               WHERE DEPT_ID = E.DEPT_ID) DESC NULLS LAST;

-- TOP-N 분석 ******************************
-- 상위 몇 개, 하위 몇 개를 조회할 때

-- 인라인 뷰와 RANK() 함수를 이용한 TOP-N 분석의 예
-- 예 : 직원 정보에서 급여를 가장 많이 받는 직원 5명 조회
SELECT *
FROM (SELECT EMP_NAME, SALARY,
                    RANK() OVER(ORDER BY SALARY DESC) 순위
         FROM EMPLOYEE) --인라인 뷰
WHERE 순위 <= 5;

-- ROWNUM 을 이용한 TOP-N 분석
SELECT ROWNUM, EMP_ID, EMP_NAME
FROM EMPLOYEE
WHERE SALARY > 3500000
ORDER BY EMP_NAME DESC;

-- ROWNUM(행번호) 이 부여되는 시점은 FROM 할때임.
-- ORDER BY 하면 행번호는 변경 안되고 섞임.
-- 해결 : ORDER BY 한 다음에 ROWNUM 이 부여되게 하려면
--          FROM 절에 서브쿼리를 사용(인라인 뷰)

-- 예 : 급여를 많이 받는 직원 3명 조회 : 그냥 조회
SELECT ROWNUM, EMP_NAME, SALARY
FROM EMPLOYEE
WHERE ROWNUM < 4
ORDER BY SALARY DESC;
-- 급여 내림차순 정렬 전에 ROWNUM이 설정됨
-- 실제 결과는 틀림

-- 해결 : 정렬되고 나서 ROWNUM 이 부여되게끔 하면 가능함
-- 인라인뷰를 이용함
SELECT ROWNUM, EMP_NAME, SALARY
FROM (SELECT *
          FROM EMPLOYEE
          ORDER BY SALARY DESC) --정렬 후에 ROWNUM 이 부여됨
WHERE ROWNUM < 4;





