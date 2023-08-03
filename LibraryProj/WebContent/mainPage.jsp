<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Main Page</title>
	</head>
	<body>
		<%!String name; %>
		<%
		session = request.getSession();
		name = (String)session.getAttribute("memberName");
		// name = "윤서정";
		%>
		
		<h3><%= name %> 님 환영합니다.</h3>
		<form action="bookPage" method="post">
			<input type="submit" value="도서 검색">
		</form>
		<form action="memberPage" method="post">
			<input type="submit" value="회원 정보 열람">
		</form><br>
			
		<form action="logoutCon" method="post">
			<input type="submit" value="로그아웃">
		</form>

	</body>
</html>