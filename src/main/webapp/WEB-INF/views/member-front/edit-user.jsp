<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

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
              <td>test1234</td>
            </tr>
            <tr class="pass">
              <td rowspan="2" class="left">비밀번호</td>
              <td><input type="password" name="userPass" placeholder="비밀번호* (영문+숫자, 특수문자(선택), 8~20자)" /></td>
            </tr>
            <tr>
              <td>
                <input type="password" name="userPass" placeholder="비밀번호 확인*">
                  <br>
                  <span class="notice_no">비밀번호를 입력해주세요.</span>
                  <!-- <span class="notice_no">비밀번호가 일치하지 않습니다.</span> -->
                  <!-- <span class="notice_ok">사용 가능한 비밀번호 입니다.</span> -->
              </td>
            </tr>
            <tr>
              <td class="left">닉네임</td>
              <td>
                <input type="text" name="userName" placeholder="닉네임*" />
                <button class="random" type="button"><span class="blind">랜덤 추천</span></button>
              </td>
            </tr>
            <tr>
              <td class="left">이름</td>
              <td><input type="text" name="userName" placeholder="이름*" /></td>
            </tr>
            <tr>
              <td class="left">전화번호</td>
              <td class="mobile">
                <select name="userNumber">
                  <option value="010">010</option>
                  <option value="011">011</option>
                  <option value="016">016</option>
                  <option value="017">017</option>
                  <option value="018">018</option>
                  <option value="019">019</option>
                </select>
                <span>-</span>
                <input type="text" name="userNumber" placeholder="전화번호*">
                <span>-</span>
                <input type="text" name="userNumber">
              </td>
            </tr>
            <tr>
              <td class="left">이메일</td>
              <td><input type="text" name="userMail" placeholder="이메일*"></td>
            </tr>
            <tr>
              <td class="left">주소</td>
              <td><input type="text" name="userAdd" placeholder="주소*"></td>
            </tr>
            <tr>
              <td class="left">주민등록번호</td>
              <td class="resi">
                <!-- type="number"로 변경하면 javascript로 maxlength 처리하기 -->
                <input type="text" name="userResi" placeholder="주민등록번호*" maxlength="6">
                <span>-</span>
                <input type="text" name="userResi" maxlength="7">
              </td>
            </tr>
          </table>    
          <div class="btn_wrap">
            <button type="button">회원탈퇴</button>
            <button type="submit">회원정보 변경/button>
          </div>
        </form>
      </div>
    </div>
  </div>
</main>