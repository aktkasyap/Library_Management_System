<%
String emailx=(String)session.getAttribute("email");
if(emailx==null){
	response.sendRedirect("forgetpass.jsp");
}
%>
<%@page import="com.library.student.StudentDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link type="text/css" rel="stylesheet" href="css/style.css">
</head>
<body>
	<jsp:include page="header.html"></jsp:include>
	<jsp:include page="main_menu.html"></jsp:include>
	<%
		if(request.getMethod().equalsIgnoreCase("post")){

			String pass=request.getParameter("password");
			String email=(String)session.getAttribute("email");
			if(new StudentDao().changePassword(email, pass)){
				session.removeAttribute("email");
				response.sendRedirect("signin.jsp");
			}
		}
	%>
	<div class="container">
		<div style="text-align: center; font-weight: bold; font-size: 20px;">Forgot
			Password</div>
		<form action="resetPassword.jsp" method="post">

			<label for="fname">New Password</label> <input type="text" id="pass"
				name="password" placeholder="Your new password.." autofocus
				required="required">

			<center>
				<input type="submit" value="Submit">
			</center>
			<br />

		</form>
	</div>
</body>
</html>