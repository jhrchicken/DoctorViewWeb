# 지역 기반 의료 서비스 매칭 플랫폼 닥터뷰
<b>지역 기반 의료 서비스 매칭 플랫폼</b>
<br/>
<br/>

## 개발 기간
<ul>
  <li>2024.09.19 - 2024.10.23</li>
</ul>

## 팀원 소개
<ul>
  <li><b>정하림 (팀장)</b> : </li>
  <li><b>부다영</b> - 로그인, 회원가입, ID찾기, PW찾기, 예약, 이모지, </li>
  <li><b>이회리</b> : </li>
</ul>
<br />


## 기술 스택

### 언어
 <img src="https://img.shields.io/badge/java-007396?style=for-the-badge&logo=java&logoColor=white"> 





## 구현 목록
<details>
  <summary><b>메인</b></summary>
</details>
<br />
<details>
  <summary><b>로그인 & 회원가입</b></summary>
  <div markdown="1">
    <ul>
      <li>로그인</li>
      <li>아이디 찾기</li>
      <li>
        비밀번호 찾기
        <ul>
          <li>이메일로 임시 비밀번호 발급</li>
        </ul>
      </li>
      <li>
        회원가입
        <ul>
          <li>닉네임 랜덤 추천 (일반 회원용)</li>
          <li>영업 시간 및 의료진 등 추가 정보 등록 (병원 회원용)</li>
        </ul>
      </li>
    </ul>
  </div>
</details>
<br />
<details>
  <summary><b>병원/의사 찾기</b></summary>
  <div markdown="1">
    <ul>
      <li>
        공통 (병원/의사)
        <ul>
          <li>목록에서 찜 갯수, 리뷰 평점 및 갯수 확인 가능 </li>
          <li>병원/의사에 대한 찜, 신고 가능</li>
          <li>
            리뷰
            <ul>
              <li>해시태그, 별점 지정하여 리뷰 작성 가능</li>
              <li>리뷰에 대한 답글 작성 가능</li>
              <li>리뷰에 대한 좋아요 가능</li>
            </ul>
          </li>
        </ul>
      </li>
      <li>
        병원 찾기
        <ul>
          <li>지역, 병원명, 전공, 해시태그를 통해 검색 가능</li>
          <li>비동기식 추가 조건 검색</li>
          <li>해시태그 확인 가능</li>
        </ul>
      </li>
      <li>
        의사 찾기
        <ul>
          <li>의사명, 전공을 통해 검색 가능</li>
        </ul>
      </li>
      <li>
        지도로 찾기
        <ul>
          <li>병원명, 전공을 통해 검색 가능</li>
          <li>현재 나의 위치 마커로 표시</li>
          <li>병원들의 위치 마커로 표시</li>
          <li>마커를 통해 상세페이지 진입 가능</li>
          <li>조건에 맞는 병원 필터링 가능</li>
          <li>지도 확대, 축소</li>
          <li>교통정보 확인 가능</li>
        </ul>
      </li>
    </ul>
  </div>
</details>
<br />
<details>
  <summary><b>게시판</b></summary>
  <div markdown="1">
    <ul>
      <li>자유게시판</li>
      <li>상담게시판</li>
      <li>베스트게시판</li>
      <li>내가 쓴 글</li>
      <li>댓글 단 글</li>
      <li>댓글을 기다리는 글 (병원용)</li>
    </ul>
  </div>
</details>
<br />
<details>
  <summary><b>이모지</b></summary>
  <div markdown="1">
    <ul>
      <li>
        나의 이모지
        <ul>
          <li>이모지 변경</li>
          <li>보유 이모지 목록</li>
          <li>현재 적용된 이모지 및 보유 포인트 확인 가능</li>
          <li>이모지 상점 바로가기</li>
        </ul>
      </li>
      <li>
        이모지 상점
        <ul>
          <li>이모지 구매</li>
          <li>현재 적용된 이모지 및 보유 포인트 확인 가능</li>
          <li>나의 이모지 바로가기</li>
        </ul>
      </li>
    </ul>
  </div>
</details>
<br />
<details>
  <summary><b>마이페이지</b></summary>
  <div markdown="1">
    <ul>
      <li>
        공통
        <ul>
          <li>개인정보 수정</li>
          <li>회원 인증</li>
        </ul>
      </li>
      <li>
        회원용
        <ul>
          <li>찜한 병원</li>
          <li>찜한 의사</li>
          <li>작성한 리뷰</li>
          <li>출석체크</li>
        </ul>
      </li>
      <li>
        병원용
        <ul>
          <li>
            의사 관리
            <ul>
              <li>등록된 의사 목록</li>
              <li>등록된 의사 정보 수정</li>
              <li>등록된 의사 삭제</li>
              <li>의사 추가 등록</li>
            </ul>
          </li>
        </ul>
      </li>
    </ul>
  </div>
</details>
<br />
<details>
  <summary><b>예약</b></summary>
  <div markdown="1">
    <ul>
      <li>
        회원용
        <ul>
          <li>예약하기</li>
          <li>예약 내역</li>
          <li>
            예약 관리
            <ul>
              <li>예약 취소</li>
              <li>내역 숨김</li>
              <li>메모 추가 및 수정</li>
            </ul>
          </li>
        </ul>
      </li>
      <li>
        병원용
        <ul>
          <li>예약 목록</li>
          <li>
            예약 관리
            <ul>
              <li>예약 막을 시간 설정</li>
            </ul>
          </li>
        </ul>
      </li>
    </ul>
  </div>
</details>
<br />
<details>
  <summary><b>채팅</b></summary>
</details>
<br />

### 데이터베이스 (SQL)


<br />

### 개발 환경 및 사용 기술


<br />
