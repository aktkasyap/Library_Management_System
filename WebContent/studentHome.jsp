<%
Integer sid=(Integer)session.getAttribute("sid");
if(sid==null){
	response.sendRedirect("signin.jsp");
}
%><%@ page language="java" contentType="text/html; charset=UTF-8"
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
<jsp:include page="studentMenu.jsp"></jsp:include>
Student Home
</body>
</html>