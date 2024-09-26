<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<main id="container">
  <div class="content">
    <div class="content_inner">
      <div class="login_wrap">
      	
      	${ foundId }
		${ notfountId }
      	
        <h2>아이디 찾기</h2>
        <form name="findIdFrm" method="post" action="../member/findId.do" onsubmit="return validateForm(this);">
          <div class="login">
            <p>이메일</p>
            <input type="text" name="email" value="" placeholder="이메일 입력">
            <span></span>
            <p>비밀번호</p>
            <input type="password" name="password" value="" placeholder="이메일 입력">
          </div>
        </form>
        <div class="login_btn">
          <input type="submit" value="회원인증"/>
        </div>
      </div>
    </div>
  </div>
</main>