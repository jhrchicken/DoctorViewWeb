<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<main id="container">
  <div class="content">
    <div class="content_inner">
      <h2>병원 예약</h2>
      
      <!-- 병원 정보 -->
      <div class="list">
        <ul class="doctor">
          <li>
            <span class="img">
              <img src="/images/hospital.png" alt="" />
            </span>
            <div class="info">
              <div class="info_top">
                <h3>더조은병원</h3>
              </div>
              <div class="detail">
                <div class="details">
                  <p class="blue">전화</p>
                  <p>02-738-5001</p>
                </div>
                <div class="details">
                  <p class="blue">주소</p>
                  <p>서울특별시 종로구</p>
                </div>
                <div class="details">
                  <p class="blue">전화</p>
                  <p>02-738-5001</p>
                </div>
                <div class="details">
                  <p class="blue">주소</p>
                  <p>서울특별시 종로구</p>
                </div>
              </div>
            </div>
          </li>
        </ul>
      </div>

      <div class="list_search">
        <form class="searchForm" name="searchForm">
          <div class="search_depart">
            <select name="searchSelect" class="searchField">
              <option value="depart">-- 진료과목 선택 --</option>
              <option value="in">내과</option>
              <option value="out">외과</option>
              <option value="ear">이비인후과</option>
              <option value="plastic">성형외과</option>
            </select>
            <input type="submit" class="search_btn" value="">
          </div>
        </form>
      </div>
      <!-- 예약 폼 -->
      <div class="reservation">

        <div class="reserv_top">
          <div class="date_select">
            <div class="calendar_title">
              <button type="button" class="btn_prev disabled" disabled="">
                <span class="blind">이전달</span>
              </button>
              <p>2024.9</p>
              <button type="button" class="btn_next">
                <span class="blind">다음달</span>
              </button>
            </div>
            
            <table class="calendar_table">
              <caption>달력 테이블</caption>
              <thead class="calendar_header">
                <tr>
                  <th>일</th>
                  <th>월</th>
                  <th>화</th>
                  <th>수</th>
                  <th>목</th>
                  <th>금</th>
                  <th>토</th>
                </tr>
              </thead>
              <tbody class="calendar_body">
                <!-- 1~7일 -->
                <tr>
                  <td>
                    <button type="button" class="calendar_date unselectable dayoff" disabled="">
                      <span class="num">1</span>
                    </button>
                  </td>
                  <td>
                    <button type="button" class="calendar_date unselectable" disabled="">
                      <span class="num">2</span>
                    </button>
                  </td>
                  <td>
                    <button type="button" class="calendar_date unselectable" disabled="">
                      <span class="num">3</span>
                    </button>
                  </td>
                  <td>
                    <button type="button" class="calendar_date unselectable" disabled="">
                      <span class="num">4</span>
                    </button>
                  </td>
                  <td>
                    <button type="button" class="calendar_date unselectable" disabled="">
                      <span class="num">5</span>
                    </button>
                  </td>
                  <td>
                    <button type="button" class="calendar_date unselectable" disabled="">
                      <span class="num">6</span>
                    </button>
                  </td>
                  <td>
                    <button type="button" class="calendar_date unselectable" disabled="">
                      <span class="num">7</span>
                    </button>
                  </td>
                </tr>
                
                <!-- 8~14일 -->
                <tr>
                  <td><button type="button" class="calendar_date unselectable dayoff" disabled=""><span class="num">8</span></button></td><td><button type="button" class="calendar_date unselectable" disabled=""><span class="num">9</span></button></td><td><button type="button" class="calendar_date unselectable" disabled=""><span class="num">10</span></button></td><td><button type="button" class="calendar_date unselectable" disabled=""><span class="num">11</span></button></td><td><button type="button" class="calendar_date unselectable" disabled=""><span class="num">12</span></button></td><td><button type="button" class="calendar_date unselectable" disabled=""><span class="num">13</span></button></td><td><button type="button" class="calendar_date unselectable" disabled=""><span class="num">14</span></button></td>
                </tr>

                <!-- 15~28일 -->
                <tr>
                  <td><button type="button" class="calendar_date unselectable dayoff" disabled=""><span class="num">15</span></button></td><td><button type="button" class="calendar_date unselectable" disabled=""><span class="num">16</span></button></td><td><button type="button" class="calendar_date unselectable" disabled=""><span class="num">17</span></button></td><td><button type="button" class="calendar_date unselectable" disabled=""><span class="num">18</span></button></td><td><button type="button" class="calendar_date unselectable" disabled=""><span class="num">19</span></button></td><td><button type="button" class="calendar_date unselectable" disabled=""><span class="num">20</span></button></td><td><button type="button" class="calendar_date unselectable" disabled=""><span class="num">21</span></button></td>
                </tr>

                <!-- 22~28일 -->
                <tr>
                  <td><button type="button" class="calendar_date unselectable dayoff" disabled=""><span class="num">22</span></button></td><td><button type="button" class="calendar_date unselectable" disabled=""><span class="num">23</span></button></td><td><button type="button" class="calendar_date unselectable" disabled=""><span class="num">24</span></button></td><td><button type="button" class="calendar_date unselectable" disabled=""><span class="num">25</span></button></td><td><button type="button" class="calendar_date unselectable" disabled=""><span class="num">26</span></button></td><td><button type="button" class="calendar_date unselectable" disabled=""><span class="num">27</span></button></td><td><button type="button" class="calendar_date unselectable" disabled=""><span class="num">28</span></button></td>
                </tr>

                <!-- 29~5일 -->
                <tr>
                  <td>
                    <button type="button" class="calendar_date dayoff today selected">
                      <span class="num">29</span>
                      <span class="text">오늘</span>
                    </button>
                  </td>
                  <td>
                    <button type="button" class="calendar_date" disabled="">
                      <span class="num">30</span>
                    </button>
                  </td>
                  <td>
                    <button type="button" class="calendar_date dayoff">
                      <span class="num">1</span>
                      <span class="text">임시공휴일</span>
                    </button>
                  </td>
                  <td>
                    <button type="button" class="calendar_date">
                      <span class="num">2</span>
                    </button>
                  </td>
                  <td>
                    <button type="button" class="calendar_date dayoff">
                      <span class="num">3</span>
                      <span class="text">개천절</span>
                    </button>
                  </td>
                  <td>
                    <button type="button" class="calendar_date">
                      <span class="num">4</span>
                    </button>
                  </td>
                  <td>
                    <button type="button" class="calendar_date">
                      <span class="num">5</span>
                    </button>
                  </td>
                </tr>
              </tbody>
            </table>
          </div>

          <div class="time_select">
            <div class="am">
              <div class="time_title">오전</div>
              <ul class="time_list">
                <li class="time_item">
                  <button type="button" class="btn_time unselectable" disabled="">11:30</button>
                </li>
              </ul>
            </div>
            <div>
              <div class="time_title">오후</div>
              <ul class="time_list">
                <li class="time_item">
                  <button type="button" class="btn_time unselectable" disabled="">12:00</button>
                </li>
                <li class="time_item">
                  <button type="button" class="btn_time">12:30</button>
                </li>
                <li class="time_item">
                  <button type="button" class="btn_time">1:00</button>
                </li>
                <li class="time_item">
                  <button type="button" class="btn_time">1:30</button>
                </li>
                <li class="time_item">
                  <button type="button" class="btn_time">2:00</button>
                </li>
                <li class="time_item">
                  <button type="button" class="btn_time">2:30</button>
                </li>
                <li class="time_item">
                  <button type="button" class="btn_time">3:00</button>
                </li>
                <li class="time_item">
                  <button type="button" class="btn_time">3:30</button>
                </li>
                <li class="time_item">
                  <button type="button" class="btn_time">4:00</button>
                </li>
                <li class="time_item">
                  <button type="button" class="btn_time">4:30</button>
                </li>
                <li class="time_item">
                  <button type="button" class="btn_time">5:00</button>
                </li>
                <li class="time_item">
                  <button type="button" class="btn_time unselectable" disabled="">5:30</button>
                </li>
                <li class="time_item">
                  <button type="button" class="btn_time">6:00</button>
                </li>
                <li class="time_item">
                  <button type="button" class="btn_time">6:30</button>
                </li>
                <li class="time_item">
                  <button type="button" class="btn_time">7:00</button>
                </li>
                <li class="time_item">
                  <button type="button" class="btn_time">7:30</button>
                </li>
              </ul>
            </div>
          </div>
        </div>

        <div class="reserv_bottom">
          <h3>예약자 정보</h3>
          <p>실제 방문하시는 분의 정보를 입력해주세요.</p>
          <div class="reserv_form">
            <div class="reserv_wrap">
              <table>
                <tr class="first_tr">
                  <td class="left">이름</td>
                  <td><input type="text" placeholder="방문자의 이름을 입력해주세요."></td>
                </tr>
                <tr>
                  <td class="left">전화번호</td>
                  <td><input type="text" placeholder="방문자의 전화번호를 입력해주세요."></td>
                </tr>
                <tr></tr>
              </table>
            </div>
            <button type="button">다음</button>
          </div>
        </div>

      </div>
    </div>
  </div>
</main>