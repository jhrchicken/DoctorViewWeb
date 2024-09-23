<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<main id="container">
  <div class="content">
    <h2>수정하기</h2>
    <div class="board_inner">
      <form name="writeFrm">
        <table class="board">
          <tr>
              <td class="left">제목</td>
              <td colspan="3" style="padding: 0 5px"><input type="text" name="title" /></td>
          </tr>
          <tr>
              <td class="left">작성자</td>
              <td colspan="3">익명</td>
          </tr>
          <tr>
              <td class="left">작성일</td> <td>24.09.23</td>
              <td class="left">조회수</td> <td>5</td>
          </tr>
          <tr>
              <td class="left">내용</td>
              <td class="area board_content" colspan="3"><textarea name="content"></textarea></td>
          </tr>
          <tr>
            <td class="left">좋아요</td> <td>492</td>
            <td class="left">댓글</td> <td>198</td>
          </tr>
          <!-- 하단 메뉴(버튼) -->
        </table>
        <div class="board_btn">
          <button type="button">취소</button>
          <button type="submit">완료</button>
        </div>
      </form>
    </div>
  </div>
</main>