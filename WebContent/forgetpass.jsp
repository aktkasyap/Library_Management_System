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
		if (request.getMethod().equalsIgnoreCase("post")) {
			String email = request.getParameter("email");
			String mno = request.getParameter("mobile");
			StudentDao dao = new StudentDao();
			int otp = dao.sendOtp(email, mno);
			if (otp != 0) {
				session.setAttribute("otp", otp);
				session.setAttribute("email", email);
				System.out.println(otp);
				response.sendRedirect("otpMatch.jsp");
			}
		}
	%>

	<div class="container">
		<div style="text-align: center; font-weight: bold; font-size: 20px;">Forgot
			Password</div>
		<form action="forgetpass.jsp" method="post">

			<label for="fname">Email</label>
			<input type="text" name="email" placeholder="Your emailid.." autofocus required="required">
			<label for="mobile">Enter your Mobile</label>
			<input type="text" name="mobile" placeholder="Your mobile..." required="required">

			<center>
				<input type="submit" value="Submit">
			</center>
			<br />

		</form>
	</div>
</body>
</html>