<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<main id="container">
  <div class="content">
    <h2>글쓰기</h2>
    <div class="board_inner">
      <form name="writeFrm">
        <table class="board">
            <tr>
                <td class="left">제목</td>
                <td><input type="text" name="title" /></td>
            </tr>
            <tr>
                <td class="left">내용</td>
                <td class="area"><textarea name="content"></textarea></td>
            </tr>
          </table>    
          <div class="board_btn">
            <button type="button">취소</button>
            <button type="submit">완료</button>
          </div>
      </form>
    </div>
  </div>
</main>