<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<main id="container">
  <div class="content">
    <div class="content_inner">

      <div class="list_title">
        <h2>병원 찾기</h2>
        <p>병원명, 지역명, 해시태그 등으로 검색해보세요.</p>
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
        <div class="other_search">
          <form class="searchForm" name="searchForm">
            <select class="searchField" name="searchDepart">
              <option value="department">-- 진료과목 선택 --</option>
              <option value="in">내과</option>
              <option value="out">외과</option>
              <option value="bone">정형외과</option>
              <option value="skin">피부과</option>
              <option value="ear">이비인후과</option>
              <option value="face">성형외과</option>
              <option value="teeth">치과</option>
            </select>
            <select name="searchTag" class="searchField">
              <option value="tag">-- 해시태그 선택 --</option>
              <option value="cold">감기</option>
              <option value="head">두통</option>
              <option value="tooth">치통</option>
              <option value="stomach">복통</option>
            </select>
            <select name="searchPark" class="searchField">
              <option value="park">-- 주차 선택 --</option>
              <option value="yesPark">주차 가능</option>
              <option value="noPark">주차 불가능</option>
            </select>
            <select name="searchPcr" class="searchField">
              <option value="pcr">-- PCR 검사 선택 --</option>
              <option value="yesPcr">PCR 검사 가능</option>
              <option value="noPcr">PCR 검사 불가능</option>
            </select>
            <select name="searchBed" class="searchField">
              <option value="bed">-- 입원 선택 --</option>
              <option value="yesBed">입원 가능</option>
              <option value="noBed">입원 불가능</option>
            </select>
            <select name="searchReserv" class="searchField">
              <option value="reserv">-- 예약 선택 --</option>
              <option value="yesReserv">예약 가능</option>
              <option value="noReserv">예약 불가능</option>
            </select>

            <!-- 검색 + 페이징 처리를 위한 hidden 박스인듯 -->
            <!-- <input type="hidden" name="page" value="1"> -->
            <input type="submit" class="search_btn" value="적용">
          </form>
        </div>

        <!-- 검색하기 전, 혹은 결과가 없을 때 -->
        <!-- <h1>검색 결과가 없습니다.</h1> -->

        <ul class="hospital">
          <li>
            <span class="img"></span>
            <div class="info">
              
              <div class="info_top">
                <h3>동안의원</h3>
                <div class="detail">
                  <p class="depart">피부과</p>
                  <p class="address">서울특별시 종로구 어쩌고 저쩌고 샬라샬라</p>
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

              <div class="info_bottom">
                <div class="hash">
                  <p>#해시태그</p>
                  <p>#해시태그</p>
                  <p>#해시태그</p>
                  <p>#해시태그</p>
                  <p>#해시태그</p>
                </div>
              </div>
            </div>

            <a href="#"><span class="blind">병원 바로가기</span></a>
          </li>

          <li>
            <span class="img"></span>
            <div class="info">
              
              <div class="info_top">
                <h3>동안의원</h3>
                <div class="detail">
                  <p class="depart">피부과</p>
                  <p class="address">서울특별시 종로구 어쩌고 저쩌고 샬라샬라</p>
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

              <div class="info_bottom">
                <div class="hash">
                  <p>#해시태그</p>
                  <p>#해시태그</p>
                  <p>#해시태그</p>
                  <p>#해시태그</p>
                  <p>#해시태그</p>
                </div>
              </div>
            </div>

            <a href="#"><span class="blind">병원 바로가기</span></a>
          </li>
          <li>
            <span class="img"></span>
            <div class="info">
              
              <div class="info_top">
                <h3>동안의원</h3>
                <div class="detail">
                  <p class="depart">피부과</p>
                  <p class="address">서울특별시 종로구 어쩌고 저쩌고 샬라샬라</p>
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

              <div class="info_bottom">
                <div class="hash">
                  <p>#해시태그</p>
                  <p>#해시태그</p>
                  <p>#해시태그</p>
                  <p>#해시태그</p>
                  <p>#해시태그</p>
                </div>
              </div>
            </div>

            <a href="#"><span class="blind">병원 바로가기</span></a>
          </li>
        </ul>


      </div>
      <div class="pagination">
        1 2 3 4 5
      </div>
      
      
      
    </div>
  </div>
</main>