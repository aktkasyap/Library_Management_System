<%
Integer aid=(Integer)session.getAttribute("aid");
if(aid==null){
	response.sendRedirect("adminsignin.jsp");
}
%>
<%@page import="com.library.book.BookDao"%>
<%@page import="com.library.book.BookDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link type="text/css" rel="stylesheet" href="css/style.css">

<script type="text/javascript">
	function check() {
		var mob = document.getElementById("mobile").value;
		obj = new XMLHttpRequest();
		obj.open("get", "checkMob.jsp?mobile=" + mob, true);
		obj.send(null);

		obj.onreadystatechange = function() {
			if (obj.readyState == 4 && obj.status == 200) {
				var msg = obj.responseText;
				document.getElementById("mob").innerHTML = msg;
			}
		}
	}
</script>

</head>
<body>
	<jsp:include page="header.html"></jsp:include>
	<jsp:include page="adminmenu.html"></jsp:include>

	<div class="container">
		<div style="text-align: center; font-weight: bold; font-size: 20px;">Update Book</div>

		<%
			if (request.getMethod().equalsIgnoreCase("post")) {
		%>
		<jsp:useBean id="dto" class="com.library.book.BookDto"></jsp:useBean>
		<jsp:setProperty property="*" name="dto" />
		<jsp:useBean id="dao" class="com.library.book.BookDao"></jsp:useBean>

		<%
			if (dao.updateBook(dto)) {
				response.sendRedirect("viewAllBooks.jsp");
			} else {
		%>
		<br />
		<center style="color: red;">Update Book Failed</center>
		<%
			}
			}
		BookDto d=new BookDao().viewBook(Integer.parseInt(request.getParameter("bid")));
		%>
		<form action="updateBook.jsp" method="post">

			<input type="hidden" name="bid" value="<%=d.getBid()%>">
			
			<label>BookName</label> <input type="text" id="bookname"
				name="bookname" placeholder="Book name.." autofocus
				required="required" pattern="[A-Za-z|\s]*"
				onchange="this.setCustomValidity(validity.patternMismatch ? 'Insert only alphabets' : '');"
				value="<%=d.getBookname()%>">

			<label>Author</label> <input type="text" id="author" name="author"
				placeholder="Author name.." required="required"
				pattern="[A-Za-z|\s]*"
				onchange="this.setCustomValidity(validity.patternMismatch ? 'Insert only alphabets' : '');"
				value="<%=d.getAuthor()%>">

			<label>Publication</label> <input type="text" id="publication"
				name="publication" placeholder="Publisher name.." required="required" 
				pattern="[A-Za-z|\s]*"
				onchange="this.setCustomValidity(validity.patternMismatch ? 'Insert only alphabets' : '');"
				value="<%=d.getPublication()%>">
			
			<label>Quantity</label> <input type="number" id="quantity"
				name="quantity" placeholder="Quantity.." required="required" 
				value="<%=d.getQuantity()%>">
				
			&nbsp&nbsp
			<label>Category</label>
			<select name="category" required="required">
			<option value="">Select Category</option>
			<option value="technical">Technical</option>
			<option value="non technical">Non Technical</option>
			</select>
			<br/>
			<br/>
			<center>
				<input type="submit" value="Update Book">
			</center>
			</form>
	</div>
</body>
</html>