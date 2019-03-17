<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link type="text/css" rel="stylesheet" href="css/style.css">
<link rel="stylesheet" type="text/css" media="all"
	href="calander/jsDatePick_ltr.min.css" />
<script type="text/javascript" src="calander/jsDatePick.min.1.3.js"></script>
<script type="text/javascript">
	window.onload = function() {
		new JsDatePick({
			useMode : 2,
			target : "dob",
			dateFormat : "%Y-%M-%d"
		});

	};
</script>

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
	<jsp:include page="main_menu.html"></jsp:include>

	<div class="container">
		<div style="text-align: center; font-weight: bold; font-size: 20px;">Sign
			Up</div>

		<%
			if (request.getMethod().equalsIgnoreCase("post")) {
		%>
		<jsp:useBean id="dto" class="com.library.student.StudentDto"></jsp:useBean>
		<jsp:setProperty property="*" name="dto" />
		<jsp:useBean id="dao" class="com.library.student.StudentDao"></jsp:useBean>

		<%
			if (dao.addStudent(dto)) {
		%>
		<jsp:forward page="signin.jsp"></jsp:forward>
		<%
			} else {
		%>
		<br />
		<center style="color: red;">Registration Failed</center>
		<%
			}
			}
		%>
		<form action="signup.jsp" method="post">

			<label>Name</label> <input type="text" id="name" name="name"
				placeholder="Your name.." autofocus required="required"
				pattern="[A-Za-z|\s]*"
				onchange="this.setCustomValidity(validity.patternMismatch ? 'Insert only alphabets' : '');">

			<label>Password</label> <input type="password" id="pass"
				name="password" placeholder="Your password..." required="required">

			<label>Email</label> <input type="email" id="email" name="email"
				placeholder="Your email.." required="required"
				pattern="^([a-zA-Z0-9_\-\.]+)@([a-zA-Z0-9_\-\.]+)\.([a-zA-Z]{2,5})$"
				onchange="this.setCustomValidity(validity.patternMismatch ? 'Insert valid email address' : '');">


			<label>Mobile Number</label> <input type="text" id="mobile"
				name="mobile" placeholder="Your mobile number.." required="required"
				pattern="[0-9]{10}"
				onclick="this.setCustomValidity(validity.patternMismatch ? 'Enter valid mobile number ' : '');"
				onchange="check()">
			<span id="mob"></span>
			<br/>
			
			<label>Date of Birth</label> <input type="text" name="dob" id="dob"
				placeholder="Enter date of birth" required="required">

			<center>
				<input type="submit" value="Submit">
			</center>
	</div>
</body>
</html>