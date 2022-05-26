
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "user.UserDAO" %>
<%@ page import = "java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>
 
<jsp:useBean id="user" class="user.User" scope="page"></jsp:useBean>
<jsp:setProperty name="user" property="email"/>
<jsp:setProperty name="user" property="password"/>

 
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Login</title>
</head>
<body>
	<%
		// 현재 세션 상태를 체크한다
		String userid = null;
		if(session.getAttribute("userID") != null){
			userid = (String)session.getAttribute("userID");
		}
		// 이미 로그인했으면 다시 로그인을 할 수 없게 한다
		if(userid != null){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('Already Logged in)");
			script.println("location.href='main.jsp'");
			script.println("</script>");
		}
		UserDAO userDAO = new UserDAO();
		int result = userDAO.login(user.getEmail(), user.getPassword());
		if(result == 1){
			// 로그인에 성공하면 세션을 부여
			session.setAttribute("userID", user.getEmail());
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('Successfully logged in')");
			script.println("location.href='main.jsp'");
			script.println("</script>");
		}else if(result == 0){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('Wrong Password')");
			script.println("history.back()");
			script.println("</script>");
		}else if(result == -1){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('The id does not exist')");
			script.println("history.back()");
			script.println("</script>");
		}else if(result == -2){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('Database Error')");
			script.println("history.back()");
			script.println("</script>");
		}
	%>
</body>
</html>