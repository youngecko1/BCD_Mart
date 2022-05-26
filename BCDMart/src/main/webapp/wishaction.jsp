<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "shoe.ShoeDAO" %>
    <%@ page import = "shoe.Shoe" %>
<%@ page import = "java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="shoe" class="shoe.Shoe" scope="page" />
<jsp:setProperty name="shoe" property="upload_id" />
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>BCD MART</title>
</head>
<body>
    <%
    String user_id = null;
    if(session.getAttribute("userID") != null) {
    	user_id = (String) session.getAttribute("userID");
    }
    if(user_id == null) {
    	 PrintWriter script = response.getWriter();
         script.println("<script>");
         script.println("alert('Need to login.')");
         script.println("location.href = 'login.jsp'");
         script.println("</script>");
    }
    
    String upload_id = null;
    if(session.getAttribute("upload_id") != null){
    	upload_id = (String)session.getAttribute("upload_id");
    }
    if(upload_id == null) {
   	 PrintWriter script = response.getWriter();
       script.println("<script>");
       script.println("alert('Not valid shoe.')");
       script.println("location.href = 'buy.jsp'");
       script.println("</script>");
   }
    
    ShoeDAO sdao = new ShoeDAO();
    Shoe sh = sdao.getShoeinfo(upload_id);
    int result = sdao.getUserWishes(upload_id, user_id);
   	if(result == -1){
   		PrintWriter script = response.getWriter();
   	    script.println("<script>");
   	    script.println("alert('Database error.')");
   	    script.println("history.back()");
   	    script.println("</script>");
   		
   	} 
   	else if(result == 0){
   		sdao.setWishes(user_id, upload_id);
   		PrintWriter script = response.getWriter();
   	    script.println("<script>");
   	    script.println("alert('Successfully wished.')");
   	    script.println("location.href = 'buy.jsp'");
   	    script.println("</script>");
   	}
   	else if(result == 1){
   		sdao.unsetWishes(user_id, upload_id);
   	    PrintWriter script = response.getWriter();
   	    script.println("<script>");
   	    script.println("alert('Successfully unwished.')");
   	    script.println("location.href = 'buy.jsp'");
   	    script.println("</script>");
   	}
    
    %>

</body>