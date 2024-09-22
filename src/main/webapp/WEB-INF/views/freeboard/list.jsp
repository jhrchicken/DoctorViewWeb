<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판</title>
</head>
<body>
	<h2>게시판 목록</h2>
	<!-- 검색 폼 -->
    <form method="get">  
    <table border="1" width="90%">
    <tr>
        <td align="center">
            <select name="searchField">
                <option value="title">제목</option>
                <option value="content">내용</option>
            </select>
            <input type="text" name="searchWord" />
            <input type="submit" value="검색하기" />
        </td>
    </tr>
    </table>
    </form>

    <!-- 목록 테이블 -->
    <table border="1" width="90%">
        <tr>
            <th width="10%">번호</th>
            <th width="*">제목</th>
            <th width="15%">작성자 아이디</th>
            <th width="10%">조회수</th>
            <th width="15%">작성일</th>
        </tr>
<c:choose>
    <c:when test="${ empty postsList }"> 
        <tr>
            <td colspan="5" align="center">
                등록된 게시물이 없습니다^^*
            </td>
        </tr>
    </c:when> 
    <c:otherwise> 
        <c:forEach items="${ postsList }" var="row" varStatus="loop">    
        <tr align="center">
            <td> 
            <!-- 게시물의갯수, 페이지번호, 페이지사이즈를 통해 가상번호를 계산해서
            출력한다. -->
            ${ maps.total - 
                (((maps.pageNum-1) * maps.postsPerPage)	+ loop.index)}
            </td>
            <td align="left"> 
                <a href="./freeboard/viewPost.do?board_idx=${ row.board_idx }">${ row.title }</a> 
            </td> 
            <td>${ row.writer_ref }</td>
            <td>${ row.visitcount }</td> 
            <td>${ row.postdate }</td> 
        </tr>
        </c:forEach>        
    </c:otherwise>    
</c:choose>
    </table>
    
    <!-- 하단 메뉴(바로가기, 글쓰기) -->
    <table border="1" width="90%">
        <tr align="center">
            <td>
                ${ pagingImg }
            </td>
            <td width="100"><button type="button"
                onclick="location.href='./freeboard/writePost.do';">글쓰기</button></td>
        </tr>
    </table>
</body>
</html>
