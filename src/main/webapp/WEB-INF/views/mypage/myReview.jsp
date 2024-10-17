<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page session="true" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>닥터뷰 | 작성한 리뷰</title>
<%@include file="../common/head.jsp" %>
<link rel="stylesheet" href="/css/my-review.css" />
</head>
<body>
<%@include file="../common/main_header.jsp" %>
<main id="container">
  <div class="content">
    <div class="content_inner">
      <h2>작성한 리뷰</h2>

      <ul class="my">
        <li>
          <div class="info">
            <img src="/images/hospital.png" alt="병원 사진">
            <div class="info_right">
                <div class="info_top">
                  <h4>병원명</h4>
                  <p>전공</p>
                </div>
                <div class="info_bottom">
                  <div class="detail">
                    <p class="blue">주소</p>
                    <p>서울특별시 서초구 남부순환로 2151, (방배동)</p>
                  </div>
                  <div class="detail">
                    <p class="blue">번호</p>
                    <p>02-738-5001</p>
                  </div>
                </div>
            </div>
          </div>
          <div class="review">
            <div class="review_score">
              <div class="star">
                <img src="/images/star.svg" alt="Star">
                <img src="/images/star.svg" alt="Star">
                <img src="/images/star.svg" alt="Star">
                <img src="/images/star.svg" alt="Star">
                <img src="/images/star.svg" alt="Star">
              </div>
              <p>5</p>
            </div>
            <div class="taginfo">
              <ul class="review_hash">
                <li class="hash">
                  <p>신속해요</p>
                </li>
              </ul>
              <div class="review_title">
                <p>2024-10-13</p>
                <p class="edit">(수정됨)</p>
              </div>
            </div>
            <div class="review_content">
              <p>너무 비싸요 그래도 빨라요</p>					
            </div>
            <div class="btn_wrap">
              <button type="button">수정<br />하기</button>
              <button type="button">삭제<br />하기</button>
            </div> 
          </div>
          <a href="">
            <span class="blind">리뷰 바로가기</span>
          </a>
        </li>
      </ul>
    </div>
  </div>
</main>
<%@include file="../common/main_footer.jsp" %>
</body>
</html>