SET SERVEROUTPUT ON;
DECLARE
    box NUMBER;
BEGIN
    SELECT empno
    INTO box
    FROM emp
    WHERE ename='WARD';
    
    DBMS_OUTPUT.PUT_LINE(box);
EXCEPTION
    WHEN NO_DATA_FOUND THEN DBMS_OUTPUT.PUT_LINE('No Data!!!');
END;
/

-- 변수에 값 대입하고 출력 확인
DECLARE
    EMPNO NUMBER(4);
    ENAME VARCHAR2(10);
BEGIN
    EMPNO := 1001;  -- 변수명 := 값;
    ENAME := '김사랑';
    
    DBMS_OUTPUT.PUT_LINE(' 사번 이름');
    DBMS_OUTPUT.PUT_LINE('---------------------------------');
    DBMS_OUTPUT.PUT_LINE('  ' || EMPNO || '  ' || ENAME);
END;
/

-- 예제> 부서번호로 부서명 알아내기
DECLARE
    VEMPNO EMP.EMPNO%TYPE;
    VENAME EMP.ENAME%TYPE;
    VDEPTNO EMP.DEPTNO%TYPE;
    VDNAME VARCHAR2(20) := NULL;
BEGIN
    SELECT EMPNO, ENAME, DEPTNO
    INTO VEMPNO, VENAME, VDEPTNO
    FROM EMP
    WHERE EMPNO = &EMPNO;
    
    IF (VDEPTNO = 10) THEN
        VDNAME := 'ACCOUNTING';
    END IF;
    IF (VDEPTNO = 20) THEN
        VDNAME := 'RESEARCH';
    END IF;
    IF (VDEPTNO = 30) THEN
        VDNAME := 'SALES';
    END IF;
    IF (VDEPTNO = 40) THEN
        VDNAME := 'OPERATIONS';
    END IF;
    
    DBMS_OUTPUT.PUT_LINE('사번 이름 부서명');
    DBMS_OUTPUT.PUT_LINE('--------------------------------------');
    DBMS_OUTPUT.PUT_LINE(VEMPNO || ' ' || VENAME || ' ' || VDNAME);
END;
/




-- 예제> 부서번호로 부서명 알아내기
DECLARE
    VEMP EMP%ROWTYPE;
    VDNAME VARCHAR2(14);
BEGIN
    SELECT * INTO VEMP
    FROM EMP
    WHERE ENAME = '&ENAME';
    
    IF (VEMP.DEPTNO = 10) THEN
        VDNAME := 'ACCOUNTING';
    ELSIF (VEMP.DEPTNO = 20) THEN
        VDNAME := 'RESEARCH';
    ELSIF (VEMP.DEPTNO = 30) THEN
        VDNAME := 'SALES';
    ELSIF (VEMP.DEPTNO = 40) THEN
        VDNAME := 'OPERATIONS';
    END IF;
    
    DBMS_OUTPUT.PUT_LINE('사번 이름 부서명');
    DBMS_OUTPUT.PUT_LINE('--------------------------------------');
    DBMS_OUTPUT.PUT_LINE(VEMP.EMPNO || ' ' || VEMP.ENAME || ' ' || VDNAME);
END;
/

-- 예제> 연봉을 구하는 예제
DECLARE
    VEMP EMP%ROWTYPE;
    ANNSAL NUMBER(7, 2);
BEGIN
    SELECT * INTO VEMP
    FROM EMP
    WHERE ENAME = '&ENAME';
    
    IF (VEMP.COMM IS NULL) THEN
        ANNSAL := VEMP.SAL * 12;
    ELSE
        ANNSAL := VEMP.SAL * 12 + VEMP.COMM;
    END IF;
    
    DBMS_OUTPUT.PUT_LINE('사번 이름 연봉');
    DBMS_OUTPUT.PUT_LINE('--------------------------------------');
    DBMS_OUTPUT.PUT_LINE(VEMP.EMPNO || ' ' || VEMP.ENAME || ' ' || ANNSAL);
END;
/

-- 실습> 특정 사원이 커미션을 받는지 안 받는지를 구분해서 출력하시오.
-- 출력 예: 사번 7788 은 SCOTT 사원이고 커미션을 받지 않습니다.
-- 출력 예: 사번 7654 은 MARTIN 사원이고 커미션을 1400 받습니다.
DECLARE
    VEMPNO EMP.EMPNO%TYPE;
    VCOMM EMP.COMM%TYPE;
    VENAME EMP.ENAME%TYPE;
BEGIN
    SELECT EMPNO, ENAME, COMM
    INTO VEMPNO, VENAME, VCOMM
    FROM EMP
    WHERE EMPNO =&EMPNO;
    
    IF (VCOMM IS NULL OR VCOMM = 0) THEN
        DBMS_OUTPUT.PUT_LINE('사번' || VEMPNO || '은 ' || VENAME || '사원이고
        커미션을 받지 않습니다.' );
    ELSE
        DBMS_OUTPUT.PUT_LINE('사번' || VEMPNO || '은 ' || VENAME || '사원이고' ||
        VCOMM || '을 받습니다.' );
    END IF;
END;
/




-- 실습> score 변수에 85 를 대입하고, 점수에 대한 학점을 출력하시오.
-- 출력 예 : 당신의 SCORE 는 85 점이고,Grade 는 B 입니다.
DECLARE
    score int;
    grade varchar2(2);
BEGIN
    score := &score;
    
    IF score>=90 THEN
        Grade :='A';
    ELSIF score>=80 THEN
        Grade :='B';
    ELSIF score >=70 THEN
        grade :='C';
    ELSIF score >=60 THEN
        grade :='D';
    ELSE grade :='F';
    END IF;
    DBMS_OUTPUT.PUT_LINE('당신의 SCOR 는 ' || score || '점이고,' || 'Grade 는 ' || grade || '
입니다.');
END;
/



-- 예제> 부서번호로 부서명 알아내기
DECLARE
    vempno EMP.EMPNO%TYPE;
    vename EMP.ENAME%TYPE;
    vdeptno EMP.DEPTNO%TYPE;
    vdname VARCHAR(20) := null;
BEGIN
    SELECT EMPNO, ENAME, DEPTNO
    INTO vempno, vename, vdeptno
    FROM EMP
    WHERE EMPNO = &EMPNO;
    
    vdname := CASE vdeptno
        WHEN 10 THEN 'ACCOUNT'
        WHEN 20 THEN 'RESEARCH'
        WHEN 30 THEN 'SALES'
        WHEN 40 THEN 'OPERATIONS'
    END;
    DBMS_OUTPUT.PUT_LINE (VEMPNO || ' ' || VENAME || ' ' ||VDEPTNO || ' ' || VDNAME);
END;
/


-- 예제> BASIC LOOP 문으로 1 부터 5 까지 출력하기
DECLARE
    N NUMBER := 1;
BEGIN
    LOOP
        DBMS_OUTPUT.PUT_LINE(N);
        N := N + 1;
        IF N > 5 THEN
            EXIT;
        END IF;
    END LOOP;
END;
/


-- 예제> FOR LOOP 문으로 1 부터 5 까지 출력하기
DECLARE
BEGIN
    FOR N IN 1..5 LOOP
        DBMS_OUTPUT.PUT_LINE(N);
    END LOOP;
END;
/



-- 실습 1> 1 에서 10 까지 반복하여 TEST1 테이블에 저장되게 하시오.
-- SCOTT 계정에서 TEST1 테이블 생성
create table test1(
    bunho number(3), 
    irum varchar2(10)
);

BEGIN
    FOR i IN 1..10 LOOP
        insert into test1 values(i, SYSDATE);
    END LOOP;
END;
/

-- 실행결과 확인
select * from test1;

-- 실습 2> 구구단의 홀수단만 출력되게 하시오. (for 문과 if 문 혼합)
SET SERVEROUTPUT ON;
DECLARE
    RESULT NUMBER;
BEGIN
     FOR DAN IN 2..9 LOOP
         IF MOD(DAN, 2) = 1 THEN
             FOR N IN 1..9 LOOP
                RESULT := DAN * N;
                DBMS_OUTPUT.PUT_LINE(DAN || ' * ' || N || ' = ' || RESULT);
             END LOOP;
         DBMS_OUTPUT.PUT_LINE(' ');
         END IF;
     END LOOP;
END;
/


-- 예제> WHILE LOOP 문으로 1 부터 5 까지 출력하기
SET SERVEROUTPUT ON;
DECLARE
    N NUMBER := 1;
BEGIN
    WHILE N <= 5 LOOP
        DBMS_OUTPUT.PUT_LINE(N);
        N := N + 1;
    END LOOP;
END;
/


-- 실습> 구구단 2 ~ 9 단에서 결과가 홀수인 것만 출력되게 하시오.
-- (WHILE LOOP 사용)
SET SERVEROUTPUT ON;
DECLARE
     RESULT NUMBER;
     DAN NUMBER := 2;
     SU NUMBER;
BEGIN
     WHILE DAN <= 9 LOOP
         SU := 1;
         
         WHILE SU <= 9 LOOP
             RESULT := DAN * SU;
             IF MOD(RESULT, 2) = 1 THEN
                DBMS_OUTPUT.PUT_LINE(DAN || ' * ' || SU || ' = ' || RESULT);
             END IF;
             SU := SU + 1;
         END LOOP;
         
         DBMS_OUTPUT.PUT_LINE(' ');
         DAN := DAN + 1;
     END LOOP;
END;
/

-- 예외처리
INSERT INTO EMP (EMPNO, ENAME)
VALUES (9999, 'ROSA-MADONA');
-- ORA-12899 에러 발생 : 컬럼 지정 바이트 사이즈 초과됨
-- value too large for column

-- PL/SQL 구문에서 오류코드에 예외이름 지어주고 사용하기
SET SERVEROUTPUT ON;
DECLARE
    TOOLONG_NAME EXCEPTION;
    PRAGMA EXCEPTION_INIT(TOOLONG_NAME, -12899);
BEGIN
    INSERT INTO EMP (EMPNO, ENAME)
    VALUES (SEQ_ENO.NEXTVAL, '&ENAME');
    COMMIT;
EXCEPTION
    WHEN TOOLONG_NAME THEN
        DBMS_OUTPUT.PUT_LINE('기록될 사원명의 글자가 10바이트를 초과하였습니다.');
END;
/

SELECT * FROM EMP;


CREATE SEQUENCE SEQ_ENO
START WITH 8200
INCREMENT BY 1
MAXVALUE 9999
NOCYCLE
NOCACHE;


-- 실습> 아이디와 암호를 입력받아,
-- 아이디와 암호는 글자갯수가 10 글자이상 15 글자 미만일 때만 정상 출력하고
-- 글자 갯수가 10 글자 미만이면, TOOSHORT 에외 발생시키고
-- 글자 갯수가 15 글자 이상이면, TOOLONG 예외 발생시키도록 PL/SQL 구문을
--작성하시오.
-- TOOLONG 은 제공되는 오류코드 -12899 에 대해 매핑하고,
-- TOOSHORT 는 오류코드를 -20001 로 새로 정하고, 메세지는 '글자갯수부족'으로 처리함
-- 아이디는 같은 값 두번 입력못하게 중복 예외 적용함.
-- 아이디 중복 예외 테스트용 초기값 대입한 아이디 변수 따로 준비해 놓음
-- 입력된 아이디와 준비된 변수값이 같으면 중복 예외 발생시킴

DECLARE
     VID VARCHAR2(14) := 'STUDENT0123';
     V_ID VARCHAR2(14);
     V_PWD VARCHAR2(14); 
     
     TOOLONG EXCEPTION;
     TOOSHORT EXCEPTION;
     
     PRAGMA EXCEPTION_INIT(TOOLONG, -12899);
     PRAGMA EXCEPTION_INIT(TOOSHORT, -20001);
BEGIN
     V_ID := '&ID';
     V_PWD := '&PWD';
    
     IF (LENGTH(V_ID) < 10 OR LENGTH(V_PWD) < 10) THEN
        RAISE_APPLICATION_ERROR(-20001, '글자 갯수 부족');
     END IF;

     IF VID = V_ID THEN
        RAISE DUP_VAL_ON_INDEX;
     END IF;

EXCEPTION 
     WHEN DUP_VAL_ON_INDEX THEN
        DBMS_OUTPUT.PUT_LINE('아이디가 중복되었습니다.');
     WHEN TOOLONG THEN
        DBMS_OUTPUT.PUT_LINE('글자 갯수 범위 초과');
     WHEN TOOSHORT THEN
        DBMS_OUTPUT.PUT_LINE('글자 갯수 부족.');
     WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('알수 없는 오류가 발생하였습니다.');
END;
/   





