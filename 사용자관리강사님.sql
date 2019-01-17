< ����� ���� >
 : ����� ������ ��ȣ ����, ���� �ο�

 - ����Ŭ �����ͺ��̽��� ��ġ�ϸ�, �⺻������ �����Ǵ� ������
	SYS
	SYSTEM
	SCOTT (������ ���� ������ : ������ ���� ��� ���� �� ����)
	HR (���� ������ : ó������ ��� ����, 11g�� ����)

 - ������ ���� �����ͺ��̽� ������
	: ����ڰ� �����ͺ��̽��� ��ü(���̺�, �� ��)�� ���� Ư�� ������
	���� �� �ְ� ��.
	�ټ��� ����ڰ� �����ϴ� �����ͺ��̽� ������ ���� ���� ������.
	�����ͺ��̽��� �����ϴ� ����ڸ��� ���� �ٸ� ���Ѱ� ���� �ο���.

 - ���� : ����ڰ� Ư�� ���̺� ������ �� �ֵ��� �ϰų�, 
	�ش� ���̺� SQL(SELECT/INSERT/UPDATE/DELETE)����
	����� �� �ֵ��� ������ �δ� ��

	* �ý��� ���� : �����ͺ��̽� �����ڰ� ������ �ִ� ����
		CREATE USER (����� ���� �����)
		DROP USER (����� ���� ����)
		DROP ANY TABLE (������ ���̺� ����)
		QUERY REWRITE (�Լ� ��� �ε��� ����)
		BACKUP ANY TABLE (���̺� ���)

	* �ý��� �����ڰ� ����ڿ��� �ο��ϴ� ����
		CREATE SESSION (�����ͺ��̽��� ����)
		CREATE TABLE (���̺� ����)
		CREATE VIEW (�� ����)
		CREATE SEQUENCE (������ ����)
		CREATE PROCEDURE (�Լ� ����)

	* ��ü ���� : ��ü�� ������ �� �ִ� ����

 - ����� ���� ����
	: �����ͺ��̽��� ������ �� �ִ� ���̵�(�̸�)�� ��ȣ ����
	[����]
	CREATE USER ������̸�
	IDENTIFIED BY ��ȣ;
	
	[�ǽ�] --------------------------------------------------------------
	1. system �������� �α���
	SQL> CONN system/��ȣ

	2. �α��ε� ���� Ȯ��
	SQL> SHOW USER

	3. ���ο� ����� ������ ��ȣ ����
	SQL> CREATE USER USER01 IDENTIFIED BY PASS01;

	4. ����� �������� �α����� ��
	SQL> CONN USER01/PASS01
	-- ���� �߻��� : ����ڿ��� ������ �ο����� �ʾұ� ������.

 - ���� �ο��ϱ� : GRANT ��ɾ� �����
	[����]
	GRANT �������� 
	TO ������̸� 
	[WITH ADMIN OPTION];

	* ������̸� ��� PUBLIC�� ����ϸ� 
	��� ����ڿ��� �ش� �ý��۱����� �ο���

	[�ǽ�] �α��� ���� �ο��ϱ� -----------------------------------------
	1. system ��������
	SQL> GRANT CREATE SESSION TO USER01;

	2. USER01 �α�����
	SQL> CONN USER01/PASS01
	SQL> SHOW USER

	[�ǽ�] ���̺� ���� ���� �ο��ϱ� ----------------------------------
	1. USER01 ��������
	SQL> CREATE TABLE EMP01(
		ENO 	NUMBER(4),
		ENAME 	VARCHAR2(20),
		JOB 	VARCHAR2(10),
		DPTNO 	NUMBER(2));
	-- ���� ����� ���� �߻�

	2. system �������� �α�����
	SQL> CONN system/��ȣ
	SQL> SHOW USER

	3. CREATE TABLE ���� �ο���
	SQL> GRANT CREATE TABLE TO USER01;

	4. USER01�� �α��� ��, ���̺� �ٽ� ������
	SQL> CONN USER01/PASS01;
	SQL> SHOW USER

	SQL> CREATE TABLE EMP01(
		ENO 	NUMBER(4),
		ENAME 	VARCHAR2(20),
		JOB 	VARCHAR2(10),
		DPTNO 	NUMBER(2));

	5. CREATE TABLE ������ �־��µ��� ���̺��� �������� ����
	=> ����Ʈ ���̺����̽��� USERS �� ����(QUOTA)�� ��������
	   �ʾұ� ������.

 - ���̺����̽�(Tablespace)
	: ���̺�, ��, �� ���� �����ͺ��̽� ��ü���� ����Ǵ� ��ũ����
	���
	����Ŭ ��ġ�� scott ������ �����͸� �����ϱ� ���� USERS ���
	���̺����̽��� ����.

	[�ǽ�] ���� ������ USER01 ������� ���̺����̽��� Ȯ���Ϸ���
	1. system �������� ����� ���¿���
	SQL> CONN system/��ȣ
	SQL> SHOW USER

	SQL> SELECT USERNAME, DEFAULT_TABLESPACE
		FROM DBA_USERS
		WHERE USERNAME = 'USER01';
	-- ���̺����̽��� USERS �� �� Ȯ��.

	2. ���̺����̽� ���� �Ҵ�
	: USER01 ����ڰ� ����� ���̺����̽� ������ �Ҵ���
	=> QUOTA �� �����. ( 10M, 5M, UNLIMITED ��)
	SQL> ALTER USER USER01
		QUOTA 2M ON SYSTEM;

	3. USER01 �� �ٽ� ������
	SQL> CONN USER01/PASS01
	SQL> SHOW USER

	4. ���̺� ������
	SQL> CREATE TABLE EMP01(
		ENO 	NUMBER(4),
		ENAME 	VARCHAR2(20),
		JOB 	VARCHAR2(10),
		DPTNO 	NUMBER(2));

	5. ���̺� ���� Ȯ����
	SQL> DESC EMP01;

	[����] ----------------------------------------------------------------
	����ڸ� : USER007
	�� ȣ : PASS007
	���̺����̽� : 3M
	�� �� : DB ����, ���̺� ���� �����
	=> ���� Ȯ���� ��
	------------------------------------------------------------------------

 - WITH ADMIN OPTION
	: ����ڿ��� �ý��� ������ �ο��� �� �����
	������ �ο����� ����ڴ� �ٸ� ����ڿ��� ������ ������ �� ����
	[����]
	GRANT CREATE SESSION TO ����ڸ�
	WITH ADMIN OPTION;

 - ��ü ���� : ���̺��̳� ��, ������, �Լ� �� �� ��ü���� DML���� �����
	�� �ִ� ������ �����ϴ� ��
	[����]
	GRANT �������� [(�÷���)] | ALL
	ON ��ü�� | ROLE �̸� | PUBLIC
	TO ������̸�;

	* ���� ����	���� ��ü
	ALTER	:	TABLE, SEQUENCE
	DELETE	:	TABLE, VIEW
	EXECUTE	:	PROCEDURE
	INDEX	:	TABLE
	INSERT	:	TABLE, VIEW
	REFERENCES : 	TABLE
	SELECT	:	TABLE, VIEW, SEQUENCE
	UPDATE	:	TABLE, VIEW


	[�ǽ�] -----------------------------------------------------
	: �ٸ� ����ڰ� ���� ���̺��� ��ȸ�ϰ��� �Ѵٸ�
	1. USER01 �� ����
	SQL> CONN USER01/PASS01
	SQL> SHOW USER

	2. USER007 ����ڰ� USER01�� ���� EMP01 ���̺��� 
	SELECT �Ϸ���
	SQL> GRANT SELECT 
		ON EMP01
		TO USER007;

	3. USER007 �α���
	SQL> CONN USER007/PASS007
	SQL> SHOW USER

	4. ���̺� ���� Ȯ��
	SQL> SELECT * FROM USER01.EMP01;


 - ����ڿ��� �ο��� ���� ��ȸ�ϱ�
	: ����� ���Ѱ� ���õ� ������ ��ųʸ�

	- �ڽſ��� �ο��� ����� ������ �˰��� �� ��
		* USER_TAB_PRIVS_RECD
	=> SELECT * FROM USER_TAB_PRIVS_RECD;

	- ���� ����ڰ� �ٸ� ����ڿ��� �ο��� ���� ���� ����
		* USER_TAB_PRIVS_MADE
	=> SELECT * FROM USER_TAB_PRIVS_MADE;

 - ���� öȸ
	: REVOKE ��ɾ� ���
	[����]
	REVOKE �������� | ALL
	ON ��ü��
	FROM [������̸� | ROLE �̸� | PUBLIC];

	[�ǽ�] ------------------------------------------------------------
	1. USER01 �α���

	2. �ش� ����ڰ� ������ ���� Ȯ��
	SQL> SELECT * FROM USER_TAB_PRIVS_MADE;

	3. SELECT ���� ������
	SQL> REVOKE SELECT ON EMP01 FROM USER007;

	4. ������ ��ųʸ����� ���� Ȯ����
	SQL> SELECT * FROM USER_TAB_PRIVS_MADE;

 - WITH GRANT OPTION 
	: ����ڰ� �ش� ��ü�� ������ �� �ִ� ������ �ο� �����鼭
	�� ������ �ٸ� ����ڿ��� �ٽ� �ο��� �� ����

	[�ǽ�] -----------------------------------------------------------------
	1. USER01 ��������
	SQL> GRANT SELECT ON USER01.EMP01 TO USER007
		WITH GRANT OPTION;

	2. USER007 �� �α���
	SQL> GRANT SELECT ON USER01.EMP01 TO STUDENT;
	-- �ٸ� ����ڿ��� �ο����� ������ �ٽ� �ο� Ȯ��.	