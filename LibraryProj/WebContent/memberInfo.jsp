<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Member Info</title>
	</head>
	<body>
		<%!
		String name; 
		String id;
		String number;
		String status;
		%>
		<%
		session = request.getSession();
		name = (String)session.getAttribute("memberName");
		id = (String)session.getAttribute("memberID");
		number = (String)session.getAttribute("memberPhone");
		status = (String)session.getAttribute("memberStatus");
		%>
		
		<%
		if(status.equals("Y")){
			status = "정상 (대출 가능)";
		} else {
			status = "대출 정지 (연체)";
		}
		%>
		
		<h3><%= name %> 님의 회원정보 입니다.</h3>
		<p>
		회원 번호: <%= id %><br>
		연락처: <%= number %><br>
		현재 상태: <%= status %><br>
		</p>
		
		<form action="mainPage.jsp" method="post">
			<input type="submit" value="메인으로">
		</form>
		
	</body>
</html>