
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>  
    <%@ page import = "user.UserDAO" %>
       <%@ page import = "user.User" %>
    <%@ page import = "java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>

<jsp:useBean id="user" class="user.User" scope="page"></jsp:useBean>
<jsp:setProperty name="user" property="email"/>
<jsp:setProperty name="user" property="nickname"/>
 <jsp:setProperty name="user" property="first_name"/>
<jsp:setProperty name="user" property="last_name"/>
<jsp:setProperty name="user" property="cell_num"/>  
<jsp:setProperty name="user" property="district"/>
<jsp:setProperty name="user" property="balance"/>
  <jsp:setProperty name="user" property="password"/>
  <jsp:setProperty name="user" property="gender"/>
<jsp:setProperty name="user" property="joindate"/>    
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>BCD MART</title>
</head>
<body>
    <% String userid = null;
    String nickname= null;
    if(session.getAttribute("userID") != null) {
    	userid = (String) session.getAttribute("userID");
    	UserDAO dao = UserDAO.getInstance();
    	nickname = dao.getUserinfo(userid).getNickname();
    }

    UserDAO dao = UserDAO.getInstance();
    if(!userid.equals(user.getEmail())) {
      	 PrintWriter script = response.getWriter();
      	    script.println("<script>");
      	    script.println("alert('You need to log in again.')");
      	    script.println("location.href = 'main.jsp'");
      	    script.println("</script>");
       }
    
    if(user.getGender() == null
    	    || user.getCell_num() == null ||
    	    		user.getFirst_name() == null ||  user.getLast_name() == null || user.getDistrict() == null || user.getNickname() == null
    	    		) {
    	    	 PrintWriter script = response.getWriter();
    	         script.println("<script>");
    	         script.println("alert('You missed Something.')");
    	         script.println("history.back()");    // 이전 페이지로 사용자를 보냄
    	         script.println("</script>");
    } else {
            dao.modify(user);
            User info = dao.getUserinfo(user.getEmail());
    	    PrintWriter script = response.getWriter();
    	    script.println("<script>");
    	    script.println("alert('Modified.')");
    	    script.println("location.href = 'main.jsp'");
    	    script.println("</script>");
    }
 

    %>
 
</body>
