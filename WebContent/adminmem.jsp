<%
Integer aid=(Integer)session.getAttribute("aid");
if(aid==null){
	response.sendRedirect("adminsignin.jsp");
}
%>
<%@page import="com.library.student.StudentDto"%>
<%@page import="com.library.book.BookDto"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Members</title>
<link type="text/css" rel="stylesheet" href="css/style.css">

</head>
<body>
	<jsp:include page="header.html"></jsp:include>
	<jsp:include page="adminmenu.html"></jsp:include>
	<jsp:useBean id="dao" class="com.library.student.StudentDao"></jsp:useBean>
	<h1>
		<center>Members</center>
	</h1>
	<%
		String sid = request.getParameter("sid");
		if (sid != null) {
			int studentid = Integer.parseInt(sid);
			dao.removeStudent(studentid);
		}
		ArrayList<StudentDto> al = dao.getAllStudent();
		int x = 0;
		if (al == null) {
	%>
	No Data in Database
	<%
		} else {
	%>
	<table id="book">
		<tr>
			<th>S.No</th>
			<th>Men Id</th>
			<th>Name</th>
			<th>Email</th>
			<th>Mobile</th>
			<th>Date</th>
			<th>Dob</th>
		</tr>
		<%
			for (StudentDto dto : al) {
		%>
		<tr>
			<td><%=++x%></td>
			<td><%=dto.getSid()%></td>
			<td><%=dto.getName()%></td>
			<td><%=dto.getEmail()%></td>
			<td><%=dto.getMobile()%></td>
			<td><%=dto.getDate()%></td>
			<td><%=dto.getDob()%></td>
			<td><a href="adminmem.jsp?sid=<%=dto.getSid()%>">Delete</a></td>
		</tr>

		<%
			}
		%>
	</table>
	<%
		}
	%>
</body>
</html>