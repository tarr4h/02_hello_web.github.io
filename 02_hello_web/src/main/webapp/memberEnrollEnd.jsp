<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String userId = (String)request.getAttribute("userId");
	String userName = (String)request.getAttribute("userName");
	String ssn1 = (String)request.getAttribute("ssn1");
	String email = (String)request.getAttribute("email");
	String tel = (String)request.getAttribute("tel");
	String job = (String)request.getAttribute("job");
	String hobby = (String)request.getAttribute("hobby");
	
	String result = null;
	if((int)request.getAttribute("result") == 1) {
		result = "회원 가입이 정상적으로 이루어졌습니다.";
	} else {
		result = "회원가입이 정상적으로 이루어지지 않았습니다.";
	}
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>가입처리 결과</title>
</head>
<body>
<script>
	const enrollResult = `환영합니다.
	<%= result %>
	ID : <%= userId %>
	NAME : <%= userName %>
	SSN : <%= ssn1 %> - *******
	E-MAIL : <%= email %>
	TEL : <%= tel %>
	JOB : <%= job %>
	HOBBY : <%= hobby %>	
	`
	alert(enrollResult);
	location.href = "<%= request.getContextPath() %>";
</script>
</body>
</html>