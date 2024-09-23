<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<main id="container">
  <div class="content">
    <h2>자유게시판</h2>
    <div class="board_inner">
      <div class="board_top">
        <p class="board_total">
          총 <strong>30</strong>건의 게시글이 있습니다.
        </p>
        <div class="board_search">
          <form class="searchForm" name="searchForm">
            <select name="searchField" class="searchField">
              <option value="title">제목</option>
              <option value="content">내용</option>
              <option value="name">작성자</option>
            </select>
            <!-- 검색 + 페이징 처리를 위한 hidden 박스인듯 -->
            <!-- <input type="hidden" name="page" value="1"> -->
            <input name="searchKeyword" class="searchKeyword" type="text" placeholder="검색어를 입력하세요">
            <input type="submit" class="search_btn" value="">
          </form>
        </div>
      </div>
      <table class="board">
        <thead>
          <tr>
            <th width="100px">NO</th>
            <th width="150px">작성자</th>
            <th>제목</th>
            <th width="120px">작성일</th>
            <th width="100px">좋아요</th>
            <th width="100px">댓글</th>
          </tr>
        </thead>
        <tbody>
          <tr>
            <td class="num">1</td>
            <td class="name">익명</td>
            <td class="title">
              <a href="#">
                <p>제목입니다.</p>
                <p class="intro">미리보기입니다.</p>
              </a>
            </td>
            <td class="date">24.09.23</td>
            <td class="like">❤ 201</td>
            <td class="comment">💬 138</td>
          </tr>
        </tbody>
      </table>
      <!-- 로그인한 상태에서만 나타나도록 -->
      <!-- <div class="write_btn">
        <button type="button">글쓰기</button>
      </div> -->
      <div class="pagination">
        <a class="prev" href="#"> < </a>
        <a class="active" href="#">1</a>
        <a href="#">2</a>
        <a href="#">3</a>
        <a href="#">4</a>
        <a href="#">5</a>
        <a class="next" href="#"> > </a>
      </div>
    </div>
  </div>
</main>