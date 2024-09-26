<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<main id="container">
  <div class="content">
    <div class="content_inner">

      <div class="list_title">
        <h2>의사 찾기</h2>
        <p>의사 이름, 지역명, 병원명 등으로 검색해보세요.</p>
      </div>

      <div class="list_search">
        <form class="searchForm" name="searchForm">
          <div class="search_city">
            <!-- 광역시도 선택 (필수) -->
            <select name="searchSido" class="searchField">
              <option value="sido">-- 광역시도 선택 --</option>
              <option value="seoul">서울특별시</option>
              <option value="busan">부산광역시</option>
              <option value="incheon">인천광역시</option>
              <option value="gyeonggi">경기도</option>
              <option value="gangwon">강원도</option>
              <option value="jeju">제주도</option>
            </select>
            <!-- 시군구 선택 (필수) -->
            <select name="searchSigungu" class="searchField">
              <option value="sigungu">-- 시/군/구 선택 --</option>
              <option value="seoul">서울특별시</option>
              <option value="busan">부산광역시</option>
              <option value="incheon">인천광역시</option>
              <option value="gyeonggi">경기도</option>
              <option value="gangwon">강원도</option>
              <option value="jeju">제주도</option>
            </select>
            <!-- 동 선택 (선택) -->
            <select name="searchDong" class="searchField">
              <option value="dong">-- 읍/면/동 선택 --</option>
              <option value="seoul">서울특별시</option>
              <option value="busan">부산광역시</option>
              <option value="incheon">인천광역시</option>
              <option value="gyeonggi">경기도</option>
              <option value="gangwon">강원도</option>
              <option value="jeju">제주도</option>
            </select>

            <!-- 검색 + 페이징 처리를 위한 hidden 박스인듯 -->
            <!-- <input type="hidden" name="page" value="1"> -->
            <input name="searchName" class="searchKeyword" type="text" placeholder="병원 이름을 입력하세요">
            <input type="submit" class="search_btn" value="">
          </div>
        </form>
      </div>

      <div class="list">
        <!-- 조건 검색 넣을거면 여기에 추가 (병원 폼 복사해온 후 내용만 수정하기!!!!) -->


        <!-- 검색하기 전, 혹은 결과가 없을 때 -->
        <!-- <h1>검색 결과가 없습니다.</h1> -->

        <ul class="hospital">
          <li>
            <span class="img"></span>
            <div class="info">
              
              <div class="info_top">
                <h3>김의사</h3>
                <div class="detail">
                  <p>서울대학교병원 내과</p>
                  <p>월, 수, 목 10:00 ~ 16:00</p>
                  <p>서울대학교 의과대학 의학과 졸업</p>
                </div>
              </div>
              
              <div class="info_right">
                <div class="star">
                  ⭐⭐⭐⭐⭐
                  <p>5.0</p>
                </div>
                <div class="right_down">
                  <p class="like">13</p>
                  <p class="comm">28</p>
                </div>
              </div>

            <a href="#"><span class="blind">의사 바로가기</span></a>
          </li>
          
          <li>
            <span class="img"></span>
            <div class="info">
              
              <div class="info_top">
                <h3>김의사</h3>
                <div class="detail">
                  <p>서울대학교병원 내과</p>
                  <p>월, 수, 목 10:00 ~ 16:00</p>
                  <p>서울대학교 의과대학 의학과 졸업</p>
                </div>
              </div>
              
              <div class="info_right">
                <div class="star">
                  ⭐⭐⭐⭐⭐
                  <p>5.0</p>
                </div>
                <div class="right_down">
                  <p class="like">13</p>
                  <p class="comm">28</p>
                </div>
              </div>

            <a href="#"><span class="blind">의사 바로가기</span></a>
          </li>
          <li>
            <span class="img"></span>
            <div class="info">
              
              <div class="info_top">
                <h3>김의사</h3>
                <div class="detail">
                  <p>서울대학교병원 내과</p>
                  <p>월, 수, 목 10:00 ~ 16:00</p>
                  <p>서울대학교 의과대학 의학과 졸업</p>
                </div>
              </div>
              
              <div class="info_right">
                <div class="star">
                  ⭐⭐⭐⭐⭐
                  <p>5.0</p>
                </div>
                <div class="right_down">
                  <p class="like">13</p>
                  <p class="comm">28</p>
                </div>
              </div>

            <a href="#"><span class="blind">의사 바로가기</span></a>
          </li>

          
          
        </ul>

      <!-- </div>
      <div class="pagination">
        1 2 3 4 5
      </div> -->
      
      
      
    </div>
  </div>
</main>