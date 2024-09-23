<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<main id="container">
  <div class="content">
    <h2>게시글 상세보기</h2>	
    <div class="board_inner">
      <!-- <form name="writeFrm">
        <input type="hidden" name="board_idx" value="1" />
      </form> -->
      <table class="board">
          <tr>
              <td class="left">제목</td>
              <td colspan="3">제목입니다.</td>
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
              <td class="board_content" colspan="3">내용입니다.</td>
          </tr>
          <tr>
            <td class="left">좋아요</td> <td>492</td>
            <td class="left">댓글</td> <td>198</td>
          </tr>
          <!-- 하단 메뉴(버튼) -->
        </table>
        <div class="board_btn">
          <button type="button">뒤로가기</button>
          <button type="button">수정하기</button>
          <button type="button">삭제하기</button>
        </div>
    </div>
  </div>
</main>