<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!doctype html>
<html lang="en">

<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>닥터뷰 관리자모드</title>
  <link rel="shortcut icon" type="image/png" href="../assets/images/logos/favicon.png" />
  <link rel="stylesheet" href="../assets/css/styles.min.css" />
  <style>
  #boardTr{ background-color:silver;}
  
/*** 게시판 - 페이지네이션 ***/
body .pagination {
  margin-top: 30px;  
  width: 100%;
  display: flex;
  justify-content: center;
}
body .pagination_inner {
  display: flex;
  justify-content: center;
  vertical-align: center;
  text-align: center;
  gap: 0 20px;
}
body .pagination a {
  font-weight: 700;
  font-size: 18px;
  color: #bbb;
  display: block;
  width: 24px;
  height: 24px;
}
body .pagination a:hover {
  color: var(--point-color2);
}
body .pagination p {
  font-weight: 700;
  font-size: 18px;
  color: var(--point-color2);
  display: block;
  width: 24px;
  height: 24px;
}
  </style>  
</head>