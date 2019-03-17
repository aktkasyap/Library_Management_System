<%
Integer aid=(Integer)session.getAttribute("aid");
if(aid==null){
	response.sendRedirect("adminsignin.jsp");
}
%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Admin Home</title>
<link type="text/css" rel="stylesheet" href="css/style.css">
</head>
<body>
<jsp:include page="header.html"></jsp:include>
<jsp:include page="adminmenu.html"></jsp:include>
</body>
</html>