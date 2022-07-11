# 개발웍스_Project
KH정보교육원 4조 파이널 프로젝트 그룹웨어 사이트입니다.
팀장 [김희헌](https://github.com/DevelopHeon), 최경민, 양수연 총 3명이 구현하였습니다.

## 1. 프로젝트 기간
- 프로젝트 기간 : 2022년 05월 20일 ~ 2022년 7월 11일
![image](https://user-images.githubusercontent.com/87063007/178243425-dc0e5c59-51f3-4ee2-b6e9-ff6d8de98c6a.png)

## 2. 기획의도
- 구성원 간의 원활한 업무 공유를 위한 그룹웨어입니다.
- 조직구성원 간의 의사소통 및 결재업무, 사내게시판 등의 기능을 지원합니다.
- 직관적인 UI와 기능별 조작이 간편하도록 구현하였습니다.

## 3. 주요 기능
- 전자결재 (결재 승인, 반려, 파일 첨부, 결재자 선택, 의견 등)
- 사내 게시판 (공지사항 게시판, 익명 게시판, 댓글 등)
- 인사/근태관리 (개인정보 수정, 출/퇴근 기능, 연차 등)
- 메일 (메일 기능, 중요도, 비밀 참조 등)
- 관리자 기능 (직위/부서 관리, 사원들 인사 관리 등)
- 예약 기능 (회의실 및 비품 예약 관리)

## 4. 개발 환경
|제목|내용|
|---|---|
|**프로그래밍 언어**|	Java Open JDK 11, JavaScript|
|**마크업 언어**|	HTML5, CSS3|
|**개발 툴**|	이클립스 STS, Oracle SQL Developer|
|**서버 구축**|	Apache Tomcat 9.0.60|
|**DBMS**|	Oracle Database 11g Express Edition|
|**협업 툴**|	Notion|
|**프레임 워크**|	Mybatis, Spring Framework(5.2.9.RELEASE), BootStrap|
|**형상관리**|	GitHub|
|**라이브러리**|	jquery-3.6.0, slf4j-api-1.7.30,|
||aspectjrt-1.9.6, jstl-1.2, jsp-api-2.1, |
||servlet-api-2.5, ojdbc6-11.2.0.4,|
||spring-jdbc, mybatis-3.5.6, |
||commons-dbcp-1.4,lombok-1.18.12, spring-security-core-5.2.9, |
||aspectjweaver-1.9.6, log4jdbc-remix-0.2.7,|
||logback-classic-1.2.9, gson-2.8.6,|
||commons-fileupload-1.3.3,|
||commons-io-2.6, validation-api-1.1.0.Final,|
||hibernate-validator-6.2.0.Final, standard1.1.2, json-simple-1.1.1, poi-4.1.2|

## 5. ERD 다이어그램
![image](https://user-images.githubusercontent.com/87063007/178254079-1f601b02-c618-4576-ac52-4a945e268ced.png)

## 6. 프로그램 실제 화면
### 로그인 페이지
![image](https://user-images.githubusercontent.com/87063007/178254599-aa6e29d3-3440-43df-9295-def85fd0793e.png)

### 회원가입
![image](https://user-images.githubusercontent.com/87063007/178254783-abc8c2e5-a4c0-421c-bea3-f6f1af887b15.png)
- 아이디 중복확인 이후 회원가입 가능
- 입력 값들의 유효성 검사
- 관리자가 승인 해주어야 로그인 가능
- 비밀번호 Spring security로 암호화 처리  

### 개발웍스 홈
![localhost_8084_spring_login do (1)](https://user-images.githubusercontent.com/87063007/178255563-d153729c-a610-4209-82f3-2896ecdd5203.png)
### 사원 마이페이지
![image](https://user-images.githubusercontent.com/87063007/178255793-9f7cf349-d4df-4226-9748-eca3f2aaccd2.png)
- 프로필 사진 변경
- 인사정보는 관리자가 입력 가능  
### 비밀번호 변경
![image](https://user-images.githubusercontent.com/87063007/178256025-99138dab-48b9-4a06-94b0-8e86ad45c209.png)
- 비밀번호는 Spring security로 암호화 되어있으므로 matches로 비교 후 변경 가능
- 입력한 값들 유효성 검사 (현재 비밀번호란 암호화 와 같은지, 새 비밀번호와 비밀번호 확인이 같은 값인지)  
### 내 근태 현황
![image](https://user-images.githubusercontent.com/87063007/178257296-a19b0d92-ffcb-49ad-b891-09b28bcecccc.png)
- 주차별 근태 현황 조회
- 월간 근무 상태 조회
### 내 연차 내역
![image](https://user-images.githubusercontent.com/87063007/178258388-78e5ad3e-0694-4abe-9cd2-34e674f90ea3.png)
- 전자결재 승인 상태 완료일 경우 연차 내역에 추가

### 주소록
![image](https://user-images.githubusercontent.com/87063007/178259621-abd057e6-77c1-4fb9-94f0-bf8594b9396c.png)
- 검색을 통한 사원 조회
- 사원 클릭시 메일 쓰기

### 전자결재 - 휴가 신청서
![localhost_8084_spring_approvalEnrollForm do_ano=1 (1)](https://user-images.githubusercontent.com/87063007/178260235-8b49d9c5-41d6-42a5-98ea-14c1f43c894d.png)
- 남은 연차 Ajax로 비교 후 사용 가능 일차일 경우에만 결재 요청 가능
- 입력 값들 유효성 검사

### 전자결재 - 지출결의서
![localhost_8084_spring_approvalEnrollForm do_ano=2 (1)](https://user-images.githubusercontent.com/87063007/178260945-122ebfc9-dedc-4242-8382-32a6c339386b.png)
- 지출 증빙 최대 5개까지 추가 가능
- 입력 값들 유효성 검사

### 전자결재 - 결재자 추가
![image](https://user-images.githubusercontent.com/87063007/178260456-87c4b761-058a-4195-8333-60834b4175bd.png)
- 같은 결재자 추가 안되도록 유효성 검사
- 부서 클릭시 같은 부서인 사원들 목록 출력
- 이름을 통한 검색 조회

### 전자결재 - 상신함, 수신함
<p align="center">
<img src="https://user-images.githubusercontent.com/87063007/178261297-9c833764-5fb6-4905-b764-7438d4657874.png" width="45%" />
<img src="https://user-images.githubusercontent.com/87063007/178261386-dac10e15-9d6e-414c-97f2-f79e9a9ab633.png" width="45%" />
</p>
- 수신함, 상신함 결재 상태별 문서 조회
