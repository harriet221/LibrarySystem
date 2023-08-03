<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>The First Page</title>
	</head>
	<body>
	
		<%
		if(session.getAttribute("memberID") != null) {
			response.sendRedirect("mainPage.jsp");
		}
		%>
		
		<form action="loginCon" method="post">
		  <h3>Login (회원 아이디 입력)</h3>
		  <input type="text" placeholder="회원 아이디 입력" name="mID">
		  <input type="submit" value="로그인">
		</form>
		
	</body>
</html>