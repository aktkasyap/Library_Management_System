<%@page import="com.library.admin.AdminDao"%>
<%@page import="com.library.admin.AdminDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Admin Sign In</title>
<link type="text/css" rel="stylesheet" href="css/style.css">
</head>
<body>
<jsp:include page="header.html"></jsp:include>
<jsp:include page="main_menu.html"></jsp:include>

<%
if(request.getMethod().equalsIgnoreCase("post")){
	String email=request.getParameter("email");
	String pwd=request.getParameter("password");
	AdminDto dto=new AdminDao().Authentication(email, pwd);
	if(dto != null){
		session.setAttribute("aid", dto.getAid());
		response.sendRedirect("adminhome.jsp");
	}else{
		%>
		<h4><center>Enter valid login details...</center></h4>
		<%
	}
}
%>

<div class="container">
<div style="text-align: center; font-weight: bold; font-size: 20px;">Sign In</div>
<form action="adminsignin.jsp" method="post">

    <label for="fname">Email Id</label>
    <input type="text" id="email" name="email" placeholder="Your email id.." autofocus required="required">

    <label for="password">Password</label>
    <input type="password" id="pass" name="password" placeholder="Your password..." required="required">

    <center><input type="submit" value="Submit"></center>
    <br/>
    <center><a href="adminsignup.jsp" class="a" >Sign Up</a>
    <a href="forgetpass.jsp" class="a">Forget Password?</a></center>
  </form>
</div>
</body>
</html>