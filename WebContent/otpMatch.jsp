<%
Integer otpx=(Integer)session.getAttribute("otp");
String email=(String)session.getAttribute("email");
if(otpx==null || email==null){
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
			int otp=Integer.parseInt(request.getParameter("otp"));
			int oldotp=(int) session.getAttribute("otp");
			if(otp == oldotp){
				session.removeAttribute("otp");
				response.sendRedirect("resetPassword.jsp");
			}
			else {
				%>
				<h1>Please enter valid OTP</h1>
				<%
			}
		}
	%>
	<div class="container">
		<div style="text-align: center; font-weight: bold; font-size: 20px;">Forgot
			Password</div>
		<form action="otpMatch.jsp" method="post">

			<label for="fname">OTP</label> <input type="text" id="otp"
				name="otp" placeholder="Your OTP.." autofocus
				required="required">

			<center>
				<input type="submit" value="Submit">
			</center>
			<br />

		</form>
	</div>
</body>
</html>