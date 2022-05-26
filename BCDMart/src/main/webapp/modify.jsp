
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>  
    <%@ page import = "user.UserDAO" %>
       <%@ page import = "user.User" %>
    <%@ page import = "java.io.PrintWriter" %>
               <%@ page import = "java.util.ArrayList"%>
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
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href = "resources/css/bootstrap.css">
<link rel="stylesheet" href = "resources/css/NewFile.css">
<script src = "https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script src = "resources/js/bootstrap.js"></script>
<title>BCD MART</title>
<%
String userid = null;
String nickname= null;
if(session.getAttribute("userID") != null) {
	userid = (String) session.getAttribute("userID");
	UserDAO dao = UserDAO.getInstance();
	nickname = dao.getUserinfo(userid).getNickname();
}

if(userid== null) {
	 PrintWriter script = response.getWriter();
    script.println("<script>");
    script.println("alert('You need to log in.')");
    script.println("location.href = 'login.jsp'");
    script.println("</script>");
}
UserDAO dao = UserDAO.getInstance();
User info = dao.getUserinfo(userid);
if(!userid.equals(info.getEmail())) {
  	 PrintWriter script = response.getWriter();
  	    script.println("<script>");
  	    script.println("alert('You need to be the owner of the account.')");
  	    script.println("location.href = 'main.jsp'");
  	    script.println("</script>");
   }
%>

</head>
<body>

    <nav class ="navbar navbar-default">
        <div class="navbar-header">
            <button type="button" class="navbar-toggle collapsed"
                data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"
                aria-expand="false">
                <span class ="icon-bar"></span>
                <span class ="icon-bar"></span>
                <span class ="icon-bar"></span>
            </button>
            <a class ="navbar-brand" href="main.jsp">BCD MART</a>
        </div>
        <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
            <ul class="nav navbar-nav">
              <li><a href="buy.jsp">BUY</a></li>
                    <li><a href="sell.jsp">SELL</a></li>
                 
                 <li><a href="community.jsp">COMMUNITY</a></li>
                   <li><a href="coupon.jsp">COUPON</a></li>
            
            </ul>
         <%
            if(userid == null) {
            	 %>
            	<ul class="nav navbar-nav navbar-right">
                <li class="dropdown">
                <a href="#" class = "dropdown-toggle"
                    data-toggle="dropdown" role ="button" 
                    aria-haspopup="true"
                    aria-expanded="false">User<span class="caret"></span></a>
                    <ul class="dropdown-menu">
                        <li><a href="login.jsp">Login</a></li>
                        <li><a href="join.jsp">Register</a></li>                    
                    </ul>
                </li>
            </ul>
            <%
            } else {
            	 %>
            	 <ul class="nav navbar-nav navbar-right">
                <li class="dropdown">
                <a href="#" class = "dropdown-toggle"
                    data-toggle="dropdown" role ="button" 
                    aria-haspopup="true"
                    aria-expanded="false">Welcome <%= nickname %><span class="caret"></span></a>
                    <ul class="dropdown-menu">
                    <li><a href="userpage.jsp">Mypage</a></li>      
                        <li><a href="modify.jsp">Modify</a></li>          
                        <li><a href="logoutAction.jsp">Logout</a></li>                  
                    </ul>
                </li>
            </ul>
            	 <%
            }
            %>
            
        </div>
    </nav>
    
    <div class="container">
        <div class="col-lg-4"></div>
        <div class="col-lg-4">
            <div class ="jumbotron" style="padding-top:20px;">
                <form method = "post" action="modifyAction.jsp">
                    <h3 style="text-align:center;">Modify</h3>
                    <div class ="form-group">
                    	Email
                        <input type ="text" class="form-control" value =  "<%=info.getEmail().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>")%>" name ="email" maxlength='50' readonly>
                    </div>
                    <div class ="form-group">
                    	Nickname
                        <input type ="text" class="form-control" value ="<%=info.getNickname().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>")%>" name ="nickname" maxlength='20'>
                    </div>
                       <div class ="form-group">
                       FirstName
                        <input type ="text" class="form-control" value ="<%=info.getFirst_name().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>")%>" name ="first_name" maxlength='20'>
                    </div>
                    <div class ="form-group">
                    	LastName
                        <input type ="text" class="form-control" value ="<%=info.getLast_name().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>")%>" name ="last_name" maxlength='20'>
                    </div>
                    	District
                    <div class="form-group">
					<%
                    UserDAO d = UserDAO.getInstance();
                    ArrayList<String> dlist = d.findcity();
                    	%>
					 <select name = "district" onchange="SetTypeTail(district.options[this.selectedIndex].value)">
                        <option value="notSelected" >::Choose the city::</option>
   <%  for(int i = 0; i < dlist.size(); i++) {
           String option = (String)dlist.get(i);
   %>
   <option value="<%= option %>"><%= option %></option>
   <% } %>
</select>
</div>
                    	Cell Number
                    <div class ="form-group">
                        <input type ="text" class="form-control" value = "<%=info.getCell_num()%>" name ="cell_num" maxlength='45'>
                    </div>
                    	Balance
                    <div class ="form-group">
                        <input type="number" name="balance"value = "<%=info.getBalance()%>" />
                    </div>
                    	  <div class ="form-group" style="text-align:center;">
                          <div class="btn-group" data-toggle="buttons">
                          <label class="btn btn-primary active">
                          <input type = "radio" name = "gender" autocomplete="off" value = "Male" checked>Male
                          </label>
                            <label class="btn btn-primary active">
                          <input type = "radio" name = "gender" autocomplete="off" value = "Female" checked>Female
                          </label>
                          </div>
                          </div>
                    <input type="submit" class="btn btn=primary form-control" value="Modify">
                </form>
            </div> 
        </div> 
         </div>
    
    
    
    <script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
    <script src="/js/bootstrap.js"></script>
    
</body>
</html>
