<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<!-- 병원 회원가입 폼 확인하며 수정해야 함!!!!!!!!!!!!!!!!!!!!! -->



<main id="container">
  <div class="content">
    <div class="content_inner">
      <div class="login_wrap">
        <h2>회원정보 변경</h2>
        <form>
          <p>*필수 입력사항</p>
          <table class="regist">
            <tr>
              <td class="left">아이디</td>
              <td colspan="6">test1235</td>
            </tr>
            <!-- 비밀번호 폼 시작 -->
            <tr class="pass">
              <td rowspan="2" class="left">비밀번호</td>
              <td colspan="6"><input type="password" name="hospPass" placeholder="비밀번호* (영문+숫자, 특수문자(선택), 8~20자)" /></td>
            </tr>
            <tr>
              <td colspan="6">
                <input type="password" name="hospPass" placeholder="비밀번호 확인*">
                <br>
                <span class="notice_no">비밀번호를 입력해주세요.</span>
                <!-- <span class="notice_no">비밀번호가 일치하지 않습니다.</span> -->
                <!-- <span class="notice_ok">사용 가능한 비밀번호 입니다.</span> -->
              </td>
            </tr>
            <!-- 비밀번호 폼 끝 -->
            <tr>
              <td class="left">이름</td>
              <td colspan="6"><input type="text" name="hospName" placeholder="병원명*" /></td>
            </tr>
            <tr>
              <td class="left">전화번호</td>
              <td colspan="6" class="mobile">
                <select name="hospRegiber">
                  <option value="015">015</option>
                  <option value="070">070</option>
                  <option value="080">080</option>
                  <option value="02">02</option>
                  <option value="031">031</option>
                </select>
                <span>-</span>
                <input type="text" name="hospRegiber" placeholder="전화번호*">
                <span>-</span>
                <input type="text" name="hospRegiber">
              </td>
            </tr>
            <tr>
              <td class="left">주소</td>
              <td colspan="6"><input type="text" name="hospAdd" placeholder="주소*"></td>
            </tr>
            <tr>
              <td class="left">진료과목</td>
              <td colspan="6">
                <input type="text" name="hospSub" placeholder="진료과목*">
            </tr>
            <tr>
              <td class="left">사업자 번호</td>
              <td colspan="6" class="regi">
                <input type="text" name="hospRegi" placeholder="사업자번호*" maxlength="3">
              <span>-</span>
              <input type="text" name="hospRegi" maxlength="2">
              <span>-</span>
              <input type="text" name="hospRegi" maxlength="5">
            </tr>
            <!-- 영업시간 폼 시작 -->
            <tr class="time">
              <td rowspan="4" class="left">영업시간</td>
              <td colspan="6">
                <div class="week_wrap">
                  요일:  
                  <label class="week_check">
                      <input type="checkbox" value="monday">
                      <span>월</span>
                  </label>
                  <label class="week_check">
                      <input type="checkbox" value="tuesday">
                      <span>화</span>
                  </label>
                  <label class="week_check">
                      <input type="checkbox" value="wednesday">
                      <span>수</span>
                  </label>
                  <label class="week_check">
                      <input type="checkbox" value="thursday">
                      <span>목</span>
                  </label>
                  <label class="week_check">
                      <input type="checkbox" value="friday">
                      <span>금</span>
                  </label>
                  <label class="week_check">
                      <input type="checkbox" value="saturday">
                      <span>토</span>
                  </label>
                  <label class="week_check">
                      <input type="checkbox" value="sunday">
                      <span>일</span>
                  </label>
                </div>
              </td>
            </tr>
            <tr class="time">
              <td colspan="6">
                진료 시간: <input type="time"> ~ <input type="time">
              </td>
            </tr>
            <tr class="time">
              <td colspan="6">
                휴게 시간: <input type="time"> ~ <input type="time">
              </td>
            </tr>
            <tr class="time">
              <td colspan="6">
                접수 마감: <input type="time">
              </td>
            </tr>
            <!-- 영업시간 폼 끝 -->
            <!-- 의료진 폼 시작 -->
            <tr class="doc">
              <td rowspan="4" class="left">의료진 1</td>
              <td colspan="5">이름: <input type="text" placeholder="이름*"></td>
              <td class="plus" rowspan="4"><button type="button"><span class="blind">의료진 추가</span></button></td>
            </tr>
            <tr class="doc">
              <td colspan="5">전공: <input type="text" placeholder="전공*"></td>
            </tr>
            <tr class="doc">
              <td colspan="5">경력: <input type="text" placeholder="경력*"></td>
            </tr>
            <tr class="doc">
              <td colspan="5">진료 시간: <br>
                <textarea name="doc_time" class="doc_time" placeholder=
                "아래의 형식대로 작성해주세요.
                
월 - 00:00~00:00
화 - 00:00~00:00
수 - 00:00~00:00
목 - 00:00~00:00
금 - 00:00~00:00
토 - 00:00~00:00
일 - 휴무"></textarea>
              </td>
            </tr>
            <!-- 의료진 폼 끝 -->
          </table>    

          
          <div class="btn_wrap">
            <button type="button">회원탈퇴</button>
            <button type="submit">회원정보 변경</button>
          </div>
        </form>
      </div>
    </div>
  </div>
</main>