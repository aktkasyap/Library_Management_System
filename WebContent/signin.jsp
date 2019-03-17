<%@page import="com.library.student.StudentDao"%>
<%@page import="com.library.student.StudentDto"%>
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
		
<div class="container">
<div style="text-align: center; font-weight: bold; font-size: 20px;">Sign In</div>
<%
if(request.getMethod().equalsIgnoreCase("post")){
	String email=request.getParameter("email");
	String pwd=request.getParameter("password");
	StudentDto dto=new StudentDao().studentLogin(email, pwd);
	if(dto != null){
		session.setAttribute("sid", dto.getSid());
		response.sendRedirect("studentHome.jsp");
	}else{
		%>
		<h4><center>Enter valid login details...</center></h4>
		<%
	}
}
%>
<form action="signin.jsp" method="post">

    <label for="fname">Student Id</label>
    <input type="text" id="sid" name="email" placeholder="Your emailid.." autofocus required="required">

    <label for="password">Password</label>
    <input type="password" id="pass" name="password" placeholder="Your password..." required="required">

    <center><input type="submit" value="Submit"></center>
    <br/>
    <center><a href="signup.jsp" class="a" >Sign Up</a>
    <a href="forgetpass.jsp" class="a">Forget Password?</a></center>
  </form>
</div>
</body>
</html>