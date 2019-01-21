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

-- ������ �� �����ϰ� ��� Ȯ��
DECLARE
    EMPNO NUMBER(4);
    ENAME VARCHAR2(10);
BEGIN
    EMPNO := 1001;  -- ������ := ��;
    ENAME := '����';
    
    DBMS_OUTPUT.PUT_LINE(' ��� �̸�');
    DBMS_OUTPUT.PUT_LINE('---------------------------------');
    DBMS_OUTPUT.PUT_LINE('  ' || EMPNO || '  ' || ENAME);
END;
/

-- ����> �μ���ȣ�� �μ��� �˾Ƴ���
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
    
    DBMS_OUTPUT.PUT_LINE('��� �̸� �μ���');
    DBMS_OUTPUT.PUT_LINE('--------------------------------------');
    DBMS_OUTPUT.PUT_LINE(VEMPNO || ' ' || VENAME || ' ' || VDNAME);
END;
/




-- ����> �μ���ȣ�� �μ��� �˾Ƴ���
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
    
    DBMS_OUTPUT.PUT_LINE('��� �̸� �μ���');
    DBMS_OUTPUT.PUT_LINE('--------------------------------------');
    DBMS_OUTPUT.PUT_LINE(VEMP.EMPNO || ' ' || VEMP.ENAME || ' ' || VDNAME);
END;
/

-- ����> ������ ���ϴ� ����
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
    
    DBMS_OUTPUT.PUT_LINE('��� �̸� ����');
    DBMS_OUTPUT.PUT_LINE('--------------------------------------');
    DBMS_OUTPUT.PUT_LINE(VEMP.EMPNO || ' ' || VEMP.ENAME || ' ' || ANNSAL);
END;
/

-- �ǽ�> Ư�� ����� Ŀ�̼��� �޴��� �� �޴����� �����ؼ� ����Ͻÿ�.
-- ��� ��: ��� 7788 �� SCOTT ����̰� Ŀ�̼��� ���� �ʽ��ϴ�.
-- ��� ��: ��� 7654 �� MARTIN ����̰� Ŀ�̼��� 1400 �޽��ϴ�.
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
        DBMS_OUTPUT.PUT_LINE('���' || VEMPNO || '�� ' || VENAME || '����̰�
        Ŀ�̼��� ���� �ʽ��ϴ�.' );
    ELSE
        DBMS_OUTPUT.PUT_LINE('���' || VEMPNO || '�� ' || VENAME || '����̰�' ||
        VCOMM || '�� �޽��ϴ�.' );
    END IF;
END;
/




-- �ǽ�> score ������ 85 �� �����ϰ�, ������ ���� ������ ����Ͻÿ�.
-- ��� �� : ����� SCORE �� 85 ���̰�,Grade �� B �Դϴ�.
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
    DBMS_OUTPUT.PUT_LINE('����� SCOR �� ' || score || '���̰�,' || 'Grade �� ' || grade || '
�Դϴ�.');
END;
/



-- ����> �μ���ȣ�� �μ��� �˾Ƴ���
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


-- ����> BASIC LOOP ������ 1 ���� 5 ���� ����ϱ�
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


-- ����> FOR LOOP ������ 1 ���� 5 ���� ����ϱ�
DECLARE
BEGIN
    FOR N IN 1..5 LOOP
        DBMS_OUTPUT.PUT_LINE(N);
    END LOOP;
END;
/



-- �ǽ� 1> 1 ���� 10 ���� �ݺ��Ͽ� TEST1 ���̺� ����ǰ� �Ͻÿ�.
-- SCOTT �������� TEST1 ���̺� ����
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

-- ������ Ȯ��
select * from test1;

-- �ǽ� 2> �������� Ȧ���ܸ� ��µǰ� �Ͻÿ�. (for ���� if �� ȥ��)
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


-- ����> WHILE LOOP ������ 1 ���� 5 ���� ����ϱ�
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


-- �ǽ�> ������ 2 ~ 9 �ܿ��� ����� Ȧ���� �͸� ��µǰ� �Ͻÿ�.
-- (WHILE LOOP ���)
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

-- ����ó��
INSERT INTO EMP (EMPNO, ENAME)
VALUES (9999, 'ROSA-MADONA');
-- ORA-12899 ���� �߻� : �÷� ���� ����Ʈ ������ �ʰ���
-- value too large for column

-- PL/SQL �������� �����ڵ忡 �����̸� �����ְ� ����ϱ�
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
        DBMS_OUTPUT.PUT_LINE('��ϵ� ������� ���ڰ� 10����Ʈ�� �ʰ��Ͽ����ϴ�.');
END;
/

SELECT * FROM EMP;


CREATE SEQUENCE SEQ_ENO
START WITH 8200
INCREMENT BY 1
MAXVALUE 9999
NOCYCLE
NOCACHE;


-- �ǽ�> ���̵�� ��ȣ�� �Է¹޾�,
-- ���̵�� ��ȣ�� ���ڰ����� 10 �����̻� 15 ���� �̸��� ���� ���� ����ϰ�
-- ���� ������ 10 ���� �̸��̸�, TOOSHORT ���� �߻���Ű��
-- ���� ������ 15 ���� �̻��̸�, TOOLONG ���� �߻���Ű���� PL/SQL ������
--�ۼ��Ͻÿ�.
-- TOOLONG �� �����Ǵ� �����ڵ� -12899 �� ���� �����ϰ�,
-- TOOSHORT �� �����ڵ带 -20001 �� ���� ���ϰ�, �޼����� '���ڰ�������'���� ó����
-- ���̵�� ���� �� �ι� �Է¸��ϰ� �ߺ� ���� ������.
-- ���̵� �ߺ� ���� �׽�Ʈ�� �ʱⰪ ������ ���̵� ���� ���� �غ��� ����
-- �Էµ� ���̵�� �غ�� �������� ������ �ߺ� ���� �߻���Ŵ

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
        RAISE_APPLICATION_ERROR(-20001, '���� ���� ����');
     END IF;

     IF VID = V_ID THEN
        RAISE DUP_VAL_ON_INDEX;
     END IF;

EXCEPTION 
     WHEN DUP_VAL_ON_INDEX THEN
        DBMS_OUTPUT.PUT_LINE('���̵� �ߺ��Ǿ����ϴ�.');
     WHEN TOOLONG THEN
        DBMS_OUTPUT.PUT_LINE('���� ���� ���� �ʰ�');
     WHEN TOOSHORT THEN
        DBMS_OUTPUT.PUT_LINE('���� ���� ����.');
     WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('�˼� ���� ������ �߻��Ͽ����ϴ�.');
END;
/   





