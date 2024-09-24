<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<main id="container">
  <div class="content">
    <div class="content_inner">
      <div class="login_wrap">
        <h2>병원 회원가입</h2>
        <form name="joinFrm" method="post" action="../../member/join/hosp.do" onsubmit="return validateForm(this);">
          <div class="agree_wrap">
            <div class="agree">
              <p class="agree_title">개인정보 수집 및 이용 동의</p>     
              <div class="agree_box">
                <p>'닥터뷰'(이하 "회사")는 회원가입 절차에서 필요한 최소한의 개인정보를 수집하고 있습니다. 회사는 수집한 개인정보를 다음의 목적을 위해 사용하며, 사용 목적 외 다른 용도로는 절대 사용하지 않습니다.<br>
                <br>
                1. 수집하는 개인정보 항목<br>
                • 필수 항목: 이름, 이메일 주소, 비밀번호, 연락처(휴대전화번호)<br>
                • 선택 항목: 프로필 사진, 성별, 생년월일<br>
                <br>
                2. 개인정보의 수집 및 이용 목적<br>
                • 회원 가입 의사 확인, 이용자 식별 및 본인 인증<br>
                • 고객 관리 및 서비스 이용에 관한 문의 처리<br>
                • 맞춤형 콘텐츠 제공 및 서비스 개선<br>
                • 법적 의무 준수 및 분쟁 해결<br>
                <br>
                3. 개인정보의 보유 및 이용 기간<br>
                • 회원 탈퇴 시 즉시 파기 (단, 관련 법령에 따라 보존이 필요한 경우에는 해당 기간 동안 보관)<br>
                <br>
                4. 동의 거부 시 불이익 안내<br>
                회원가입 시 필수 항목에 대한 동의를 거부하실 수 있으나, 이 경우 서비스 이용이 제한될 수 있습니다.<br>
                <br>
                5. 개인정보 제공 동의<br>
                회사는 수집된 개인정보를 상기 목적 범위 내에서만 사용하며, 회원님의 동의 없이 제3자에게 제공하지 않습니다.<br>
                <br>
                본인은 위 내용을 충분히 이해하였으며, 이에 동의합니다.</p>
              </div>
              <label class="checkbox_wrap">
              	<!-- checkAgree <-> terms1 -->
                <input id="terms1" name="terms1" type="checkbox" value="yes">
                <label for="terms1">개인정보 수집 및 이용에 동의합니다. <span class="must">(필수)</span></label>
              </label>
            </div>
            <div class="agree">
              <p class="agree_title">개인정보 처리 위탁에 대한 동의</p>     
              <div class="agree_box">
                <p>'닥터뷰'(이하 "회사")는 서비스 향상을 위해 개인정보 처리 업무를 외부 전문업체에 위탁할 수 있습니다. 회사는 위탁 계약 시 개인정보 보호법 등 관련 법령에 따라 개인정보가 안전하게 관리될 수 있도록 필요한 사항을 규정하고 있습니다.<br>
                <br>
                1. 개인정보 처리 위탁 사항<br>
                회사는 다음과 같은 업무를 위탁하며, 위탁 받은 업체는 해당 업무를 수행하기 위해 필요한 범위 내에서만 개인정보를 처리합니다.<br>
                <br>
                • 위탁 업무 내용: 데이터 보관 및 관리, 결제 처리, 고객 문의 대응<br>
                • 위탁 업체: (해당 시 위탁업체의 이름을 명시)<br>
                <br>
                2. 개인정보의 위탁 목적<br>
                • 회원의 원활한 서비스 제공을 위한 데이터 보관 및 유지<br>
                • 결제 서비스 및 고객 지원 서비스 제공<br>
                • 시스템 운영 및 유지보수<br>
                <br>
                3. 위탁업체의 개인정보 처리 보유 및 이용 기간<br>
                • 회원 탈퇴 시 또는 위탁 계약 종료 시 즉시 파기<br>
                • 법령에 의해 보존이 필요한 경우 해당 법령에 따른 보존 기간 동안 보관<br>
                <br>
                4. 동의 거부 시 불이익 안내<br>
                회원님께서는 개인정보 위탁에 대한 동의를 거부할 수 있으나, 이 경우 일부 서비스 이용에 제한이 있을 수 있습니다.<br>
                <br>
                본인은 위 내용을 충분히 이해하였으며, 이에 동의합니다.</p>
              </div>
              <label class="checkbox_wrap">
                <input id="checkAgree" name="checkAgree" type="checkbox">
                <label for="checkAgree">개인정보 위탁에 동의합니다. <span class="must">(필수)</span></label>
              </label>
            </div>
          </div>


          <form>
            <p>*필수 입력사항</p>
            <table class="regist">
              <tr>
                <td class="left">아이디</td>
                <td colspan="6">
                  <input type="text" name="hospId" placeholder="아이디* (영문+숫자, 6~15자)" />
                  <!-- 실시간 중복 확인 가능하게 되면 삭제할 것 -->
                  <!-- <button class="id_check" type="button"><span class="blind">중복 확인</span></button> -->
                  <br>
                  <span class="notice_no">아이디를 입력해주세요.</span>
                  <!-- <span class="notice_no">영어로만 또는 숫자로만 이루어진 아이디는 사용할 수 없습니다.</span> -->
                  <!-- <span class="notice_ok">사용 가능한 아이디 입니다.</span> -->
                </td>
              </tr>
              <!-- 비밀번호 폼 시작 -->
              <tr class="pass">
                <td rowspan="2" class="left">비밀번호</td>
                <td colspan="6"><input type="password" name="hospPass" placeholder="비밀번호* (영문+숫자, 특수문자(선택), 8~20자)" /></td>
              </tr>
              <tr>
                <td colspan="6">
                  <input type="password" name="hospPass" placeholder="비밀번호 확인*">
                  <!-- <button class="pass_check" type="button"><span class="blind">비밀번호 확인</span></button> -->
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
              <button type="button">취소</button>
              <button type="submit">완료</button>
            </div>
          </form>
      </div>
    </div>
  </div>
</main>