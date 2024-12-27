<a id="readme-top"></a>


<!-- 프로젝트 로고 -->
<br />
<div align="center">
  <a href="https://github.com/othneildrew/Best-README-Template">
    <img src="src/main/resources/static/images/cover_img.png" alt="Logo" width="200" height="100">
  </a>

  <h3 align="center">지역 기반 의료 서비스 매칭 플랫폼 닥터뷰</h3>

  <p align="center">
    지금 바로 닥터뷰를 시작해보세요!
    <br />
    <a href=""><strong>Explore Our Website »</strong></a>
    <br />
    <br />
    <a href="https://github.com/jhrchicken/DoctorViewWeb">View Demo</a>
    ·
    <a href="https://github.com/jhrchicken/DoctorViewWeb/issues/new?labels=bug&template=bug-report---.md">Report Bug</a>
    ·
    <a href="https://github.com/jhrchicken/DoctorViewWeb/issues/new?labels=enhancement&template=feature-request---.md">Request Feature</a>
  </p>
</div>

<!-- 목차 -->
<details>
  <summary>목차</summary>
  <ol>
    <li>
      <a href="#1">프로젝트 정보</a>
      <ul>
        <li><a href="#1-1">프로젝트 개요</a></li>
        <li><a href="#1-2">소속 단체 및 개발 기간</a></li>
        <li><a href="#1-3">팀원 소개</a></li>
      </ul>
    </li>
    <li><a href="#2">설치 가이드</a></li>
    <li><a href="#3">기술 스택</a></li>
    <li><a href="#4">주요 기능</a></li>
    <li>
      <a href="#5">아키텍처</a>
      <ul>
        <li><a href="#5-1">아키텍처</a></li>
        <li><a href="#5-2">프로젝트 구조</a></li>
      </ul>
    </li>
        <li>
      <a href="#6">기타</a>
      <ul>
        <li><a href="#6-1">개발문서</a></li>
        <li><a href="#6-2">문제 해결 과정</a></li>
        <li><a href="#6-2">프로젝트를 통해 배운 점</a></li>
        <li><a href="#6-2">결과 및 확장성</a></li>
        <li><a href="#6-2">개선점 및 향후 계획</a></li>
      </ul>
    </li>
  </ol>
</details>

<br/>

# <span id="1">01. 프로젝트 정보</span>

## <span id="1-1">프로젝트 개요</span>

<b>닥터뷰는 지역 기반 의료 서비스 매칭 플랫폼입니다.</b>

닥터뷰는 병원 정보의 부족, 만족스러운 의료진 선택의 어려움, 긴급 상황에서 병원 찾기의 불편함, 번거로운 예약 과정 등 환자들이 겪는 문제를 해결하고자 하는 의도에서부터 출발하였습니다. 닥터뷰는 다양한 검색 방식과 조건을 통해 개인에게 적합한 병원을 찾고 예약할 수 있는 서비스를 제공합니다. 병원 방문 전후에는 채팅 기능을 통해 병원과 소통할 수 있으며, 게시판을 통해 건강 정보를 공유하는 커뮤니티를 형성하여 기존의 의료 시스템에 새로운 알고리즘을 도입합니다.

<b>닥터뷰는 웹과 모바일 앱을 모두 지원합니다.</b> <a href="https://github.com/jhrchicken/DoctorViewApp">닥터뷰 앱에 대한 내용은 여기에서 확인하세요.</a>

이 웹사이트는 다음과 같은 기능들을 제공합니다.

🔻 변경 사항 1

1. 다양한 검색 방식으로 검색 조건에 일치하는 병원과 의료진의 정보을 찾아 예약하고 리뷰를 남길 수 있습니다.
2. 환자들이 병원 방문 전후에 의료진과 간편하게 소통할 수 있도록 채팅 기능을 제공합니다.
3. 게시판을 통해 건강 정보를 공유하고 커뮤니티 내에서 자유롭게 상호작용할 수 있습니다.

🔺 변경 사항 1

<b>이제 </b><a href="">여기를 클릭하여</a><b> 지역 기반 의료 시스템 매칭 플랫폼 닥터뷰를 시작해보세요!</b>

<br/>

<div align="right">
  
[(back to top)](#readme-top)

</div>

## <span id="1-2">소속 단체 및 개발 기간</span>

<ul>
  <li>더조은아카데미 클라우드(AWS) 환경에서 개발하는 풀스택(프론트엔드&백엔드) 자바(JAVA)웹&앱 4기</li>
  <li>프로젝트 개발 기간: 2024.09.19 - 2024.10.23</li>
  <li>프로젝트 보완 기간: 2025.01.01 - 진행 중</li>
</ul>

<br/>

<div align="right">
  
[(back to top)](#readme-top)

</div>

## <span id="1-3">팀원 소개</span>

닥터뷰 프로젝트는 백엔드 2명과 프론트엔드 1명이 참여하여 개발하였습니다.

🔻 변경 사항 2

#### 정하림 ([@jhrchicken](https://github.com/jhrchicken)) - 백엔드 및 팀장
<ul>
  <li>데이터베이스 설계, 요구사항 정의서 작성, 웹 기능 정의서 작성</li>
  <li><b>화면 설계 및 구현</b> : 홈, 게시판 목록, 게시판 작성, 게시판 수정, 게시판 상세, 나의 이모지, 이모지 상점, 예약 내역</li>
  <li><b>기능 개발</b> : 
    병원 지도로 찾기, 리뷰 CRUD, 게시판 CRUD 댓글 CRUD, 좋아요 신고 표시 기능, 병원 검색, 병원 조건 검색, 병원 조회, 의사, 의사 찜, 게시판 내가 좋아요 한 게시판 등등, 리뷰 찜 내역 등</li>
</ul>

#### 부다영 ([@Budayeong](https://github.com/Budayeong)) - 백엔드
#### 이회리 ([@leeeeeeeeeeeehr](https://github.com/leeeeeeeeeeeehr)) - 프론트엔드

🔺 변경 사항 2

<div align="right">
  
[(back to top)](#readme-top)

</div>

<br/><br/>

# <span id="2">02. 설치 가이드</span>

### 배포 URL

- 배포 URL:
- 관리자 URL: /admin.do

### Test ID/PW

🔻 변경 사항 3

- 일반 사용자 Test ID/PW : harim1104 / 12341234
- 일반 사용자 Test ID/PW : dayeong1209 / 12341234

🔺 변경 사항 3

- 병원 Test ID/PW : hospital1 / 12341234
- 관리자 Test ID/PW : admin / 12341234

<br/><br/>

<div align="right">
  
[(back to top)](#readme-top)

</div>

# <span id="3">03. 기술 스택</span>

### 프론트엔드

<div>
  <img src="https://img.shields.io/badge/HTML5-%23E34F26?style=for-the-badge">
  <img src="https://img.shields.io/badge/CSS3-%231572B6?style=for-the-badge&logo=css3">
  <img src="https://img.shields.io/badge/JavaScript%20ES6-%23F7DF1E?style=for-the-badge&logo=javascript&logoColor=%23000">
  <img src="https://img.shields.io/badge/React%2018.3.1-%2361DAFB?style=for-the-badge&logo=react&logoColor=%23000">
</div>

### 백엔드

<div>
  <img src="https://img.shields.io/badge/Java%2021-%23000000?style=for-the-badge&logo=openjdk">
  <img src="https://img.shields.io/badge/Spring%20Boot%203.0.3-%236DB33F?style=for-the-badge&logo=spring%20boot&logoColor=%23fff"> 
  <img src="https://img.shields.io/badge/MyBatis%203.0.3-%234479A1?style=for-the-badge">
</div>

### 데이터베이스

<div>
  <img src="https://img.shields.io/badge/Oracle%2021c-%23F80000?style=for-the-badge&logo=oracle">
  <img src="https://img.shields.io/badge/Firebase%20realtime%2010.13.2-%23EB844E?style=for-the-badge&logo=firebase">
</div>

### 서버

<div>
  <img src="https://img.shields.io/badge/Linux-%23FCC624?style=for-the-badge&logo=linux&logoColor=%23000000">
  <img src="https://img.shields.io/badge/Apache%20Tomcat%2010.1.26-%23F8DC75?style=for-the-badge&logo=apachetomcat&logoColor=%23000">
  <img src="https://img.shields.io/badge/AWS%20ec2-%23232F3E?style=for-the-badge&logo=amazonwebservices">
</div>

### 개발 환경 및 도구

<div>
  <img src="https://img.shields.io/badge/visual%20studio%20code-%230082FC?style=for-the-badge">
  <img src="https://img.shields.io/badge/sts%204-%236DB33F?style=for-the-badge&logo=spring&logoColor=%23fff">
  <img src="https://img.shields.io/badge/sqldeveloper-%23575757?style=for-the-badge">
  <img src="https://img.shields.io/badge/termius-%23000000?style=for-the-badge&logo=termius">
</div>

### 라이브러리 및 API

<div>
  <img src="https://img.shields.io/badge/KakaoMap-%23FFCD00?style=for-the-badge&logo=kakao&logoColor=%23000">
  <img src="https://img.shields.io/badge/Bootstrap%205.3.3-%237952B3?style=for-the-badge&logo=bootstrap&logoColor=%23fff">
  <img src="https://img.shields.io/badge/jQuery%20%26%20Ajax-%230769AD?style=for-the-badge&logo=jquery">
</div>

### 협업

<div>
  <img src="https://img.shields.io/badge/github-%23181717?style=for-the-badge&logo=github">
  <img src="https://img.shields.io/badge/figma-%23F24E1E?style=for-the-badge&logo=figma&logoColor=%23fff">
  <img src="https://img.shields.io/badge/staruml-%23FFE200?style=for-the-badge">
  <img src="https://img.shields.io/badge/notion-%23000000?style=for-the-badge&logo=notion">
  <img src="https://img.shields.io/badge/google%20drive-%234285F4?style=for-the-badge&logo=googledrive&logoColor=%23fff">
</div>

<div align="right">
  
[(back to top)](#readme-top)

</div>

<br/><br/>

# <span id="4">04. 주요 기능</span>

### 로그인 및 회원가입

<ul>
  <li>STMP로 이메일 전송을 통한 비밀번호 찾기 기능</li>
  <li>AJAX 비동기 방식으로 회원가입 화면 변경 없이 사용자 닉네임 랜덤 추천</li>
  ++ 폼값 검증 ++++++ alert XX ajax 00
</ul>

<br/>

### 병원 검색 및 상세정보 확인

#### 병원 찾기
<ul>
  <li>키워드로 직접 검색 (지역, 병원명, 전공, 해시태그)</li>
  <li>AJAX로 비동기식 조건 필터링 검색</li>
</ul>

#### 지도로 찾기
<ul>
  <li>KakaoMap을 이용해 병원 위치를 지도에 표시</li>
  <li>야간진료, 주말진료, 진료중 병원 필터링 후 지도에 표시</li>
  <li>지도 확대/축소 및 교통정보 확인</li>
</ul>

#### 병원 상세정보 확인

<ul>
  <li>진료 과목, 주소, 소속 의료진 등 병원 기본 정보 제공</li>
  <li>해시태그 같은 추가 정보 제공</li>
  <li>병원 찜 기능 제공<li>
  <li>별점과 해시태그를 추가하여 리뷰 작성 가능</li>
  <li>리뷰는 수정 및 삭제가 가능하며 수정된 리뷰에는 수정 여부 표시</li>
  <li>병원 사용자는 리뷰에 대한 답변 작성과 수정과 삭제 가능</li>
</ul>

<br/>

### 의사 검색 및 상세정보 확인

<ul>
  <li>진료 과목, 소속 병원 등 병원 기본 정보 제공</li>
  <li>의사 찜 기능 제공<li>
</ul>

<br/>

### 예약

<ul>
  <li>일반 사용자가 날짜와 시간을 선택하여 병원 진료 예약</li>
  <li>병원 진료시간 데이터를 JSON으로 변환해 예약 가능 시간을 JS 이용하여 동적으로 표시</li>
</ul>

<br/>

### 채팅

<ul>
  <li>React와 Firebase를 이용한 일반 사용자와 병원 사용자 간의 실시간 채팅 기능</li>
  <li>대화 내용을 Firebase Realtime Database에 저장하여 채팅 이력과 이전 대화 조회</li>
  <li>다중 채팅방을 지원하여 여러 대화방에서 동시에 채팅 가능</li>
  <li>날짜와 시간을 적절히 표시하여 사용자 편의 제공</li>
</ul>

### 게시판

<ul>
  <li>게시글 작성과 수정과 삭제</li>
  <li>게시글 작성과 수정과 삭제</li>
  <li>AJAX로 비동기 방식으로 게시글 좋아요 및 신고</li>
  <li>내가 단 글, 좋아요 한 글 등 게시판 활동 로그 확인</li>
</ul>

<br/>

### 이모지

<ul>
  <li>출석체크를 통해 얻은 포인트를 시용해 이모지 구매</li>
  <li>보유 이모지 목록 확인 후 이모지 변경 및 해제 가능</li>
</ul>

<div align="right">
  
[(back to top)](#readme-top)

</div>

<br/><br/>

# <span id="5">05. 아키텍처</span>

## <span id="5-1">아키텍쳐</span>

<div align="right">
  
[(back to top)](#readme-top)

</div>

## <span id="5-2">프로젝트 구조</span>

<div align="right">
  
[(back to top)](#readme-top)

</div>




<br/><br/>

# <span id="6">06. 기타</span>

## <span id="6-1">개발 문서</span>

기능정의서
ERD
class diagram

<div align="right">
  
[(back to top)](#readme-top)

</div>

<br/>

## <span id="6-2">문제 해결 과정</span>

#### 1. 병원 목록에서 페이징과 필터링 방식의 충돌 문제 해결을 위한 AJAX 방식 적용 및 성능 개선 - [디버깅 중]

병원 목록에서 기존의 요청 기반 페이징 방식과 AJAX 기반 필터링 방식 간의 충돌로 인해, 필터링된 목록에서 페이지 이동 시 전체 병원을 기준으로 페이징이 적용되는 문제가 발생했습니다. 페이징 기능을 제거하는 경우 필터링 조건을 해제할 때 약 25,000건의 데이터를 한 번에 조회해야 하여 성능이 크게 저하되었습니다. 이를 해결하기 위해 필터링 기능은 AJAX 방식으로 유지하고, 기존 페이징 방식을 요청 기반에서 AJAX 기반으로 변경하였습니다. 초기에는 10개의 항목만 표시하고 '더보기' 버튼을 통해 추가 데이터를 불러오는 방식으로 개선하여 데이터 로드량을 줄이고, 사용자 경험을 향상시켰습니다.

#### 2. 예약 기능을 위한 사용자 선택에 따른 백엔드 데이터 출력

예약 기능 구현 과정에서, JS로 제작한 달력에서 진료가 불가능한 시간은 선택할 수 없도록 표시해야 했습니다.
이를 위해 DB에서 가져온 병원의 예약 불가 날짜와 시간 데이터를 사용자가 선택한 값과 비교해, 동일한 경우 선택을 제한하는 기능이 필요했습니다.
초기에는 AJAX를 사용해 사용자가 선택한 날짜 데이터를 비동기로 백엔드에 전송하고, 선택 가능한 시간 데이터를 반환받는 방식이었습니다.
그러나 이 방식은 데이터 전송을 위한 별도의 이벤트를 필요로 하였고, 사용자가 예약 시간을 선택할 때마다 버튼을 눌러야 하는 불필요한 행동을 유발하는 문제가 있었습니다.

<div align="right">
  
[(back to top)](#readme-top)

</div>

<br/>

## <span id="6-3">프로젝트를 통해 배운 점</span>

#### 1. 팀 프로젝트에서 의사소통의 중요성과 문서화의 역할

팀 프로젝트를 진행하며 팀원 간의 의사소통이 개발 결과에 큰 영향을 미친다는 점을 깨달았습니다. 프로젝트에 대해 같이 논의하더라도, 각 팀원이 상상하는 이미지와 방향이 다른 경우가 있었습니다.
이렇게 각자의 이해가 다른 채 개발이 진행되어 수정과정을 거치는 경험을 하게 되었습니다.
이러한 경험을 통해 팀원 모두가 동일한 이해를 바탕으로 각자의 역할을 수행할 수 있도록 개선한 요소가 문서화였습니다.
문서화를 통해 기능을 명확히 정의하고 프로토타입을 제작해 시각적인 내용 역시 확정하여 개발 방향을 확실히 하였습니다.
의견이 정리된 이후에는 개발에 집중할 수 있었고, 그 결과 시간 내에 개발을 마칠 수 있었습니다.
이 경험을 통해 효율적이고 정확한 개발을 위해 문서화를 통한 명확한 의사소통의 중요성을 깊이 느낄 수 있었습니다.

#### 2. 효율적인 협업의 중요성과 향후 개선 방안

원활한 협업을 위해서는 팀 내의 명확한 규칙과 협업 방식이 필요합니다. 이 점을 인식하고 프로젝트 시작 당시 정의서를 작성하고 커밋 메시지 컨벤션을 정하는 등 협업을 위한 기초를 다졌습니다. 그럼에도 불구하고 프로젝트를 진행하면서 협업에서 불편함과 아쉬움이 남았습니다. 깃허브의 이슈 트래커와 릴리즈를 통한 버전 관리 그리고 다른 협업 도구들을 활용해 보다 체계적으로 프로젝트를 관리하고 싶다는 욕심이 생겼습니다. 이후 프로젝트에서는 사용법을 배우고 반영하여 효울적으로 협업을 진행할 예정입니다.

<div align="right">
  
[(back to top)](#readme-top)

</div>

<br/>

## <span id="6-4">결과 및 확장성</span>

#### 1. 의료 사각지대 지역의 서비스 접근성 향상

병원을 찾기 어려운 지역에 초점을 맞춰 해당 지역의 의료 서비스의 접근성을 높일 수 있습니다. 부족한 의료 시설과 특수한 서비스에 대한 데이터를 지속적으로 분석하여 의료 서비스의 격차를 줄이고 어디서나 질 높은 서비스를 제공받을 수 있습니다.


🔻 수정/추가 환영
#### 2. 커뮤니티 활성화로 의료정보 허브 구성

자유게시판을 발달시켜 의료서비스 매칭 플랫폼 뿐만 아니라 의료정보를 탐색하고 지역 별 사용자 간 소모임 등 커뮤니티를 형성해 의료 정보 허브로 확장 가능합니다.

<div align="right">
  
[(back to top)](#readme-top)

</div>

<br/>

## <span id="6-5">개선점 및 향후 계획</span>


<div align="right">
  
[(back to top)](#readme-top)

</div>

