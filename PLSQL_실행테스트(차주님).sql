-- PL/SQL
-- ����Ŭ������ ������
-- SQL ���� ���࿡ ���α׷��� ����� �߰���

-- ��� ��� �۵� Ȯ��
SHOW SERVEROUTPUT;
-- ��µǰ� �� ����
SET SERVEROUTPUT ON;

-- �Ѽ��� ������ ����� �̸� ��� :  PLSQL BLOCK ���
SET SERVEROUTPUT ON;
DECLARE  -- ����� : ���� ����
    -- ������ �ڷ���;
    VEMPNO  CHAR(3);
    VENAME  VARCHAR2(20);
BEGIN
    -- ������ �� ����, ���, ��¹� ó��
    SELECT EMP_ID, EMP_NAME
    INTO VEMPNO, VENAME
    FROM EMPLOYEE
    WHERE EMP_NAME = '�Ѽ���';
    
    SYS.DBMS_OUTPUT.PUT_LINE('���    �̸�');
    SYS.DBMS_OUTPUT.PUT_LINE('------------------------------');
    SYS.DBMS_OUTPUT.PUT_LINE(VEMPNO || '    ' || VENAME);
END;
/

-- ����� �Է¹޾� ���� ���� ��ȸ ��� ó��
SET SERVEROUTPUT ON;
DECLARE
    VEMPNO  EMPLOYEE.EMP_ID%TYPE;
    VENAME  EMPLOYEE.EMP_NAME%TYPE;
    VSAL    EMPLOYEE.SALARY%TYPE;
    VHIREDATE  EMPLOYEE.HIRE_DATE%TYPE;
BEGIN
    SELECT EMP_ID, EMP_NAME, SALARY, HIRE_DATE
    INTO VEMPNO, VENAME, VSAL, VHIREDATE
    FROM EMPLOYEE
    WHERE EMP_ID = '&���';
    
    DBMS_OUTPUT.PUT_LINE(VEMPNO || '  ' || VENAME || '  ' || VSAL || '  ' || VHIREDATE);
END;
/













