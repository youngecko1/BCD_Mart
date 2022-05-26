<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>    
    <%@ page import = "java.io.PrintWriter"%>
        <%@ page import = "user.UserDAO" %>
       <%@ page import = "user.User" %>
               <%@ page import = "shoe.ShoeDAO" %>
       <%@ page import = "shoe.Shoe" %>
       <%@ page import = "java.util.ArrayList"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<meta name="viewport" content="width=device-width, initial-scale=1" >        
<link rel="stylesheet" href = "resources/css/bootstrap.css">
<link rel="stylesheet" href = "resources/css/NewFile.css">
<script src = "https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script src = "resources/js/bootstrap.js"></script>
<title>BCD MART</title>
</head>
<body>
<% 
String userid = null;
String nickname = null;
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
%>
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
                    aria-expanded="false">Welcome <%= nickname %><span class="caret"></span></a>
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
                    aria-expanded="false">Welcome, <%= nickname %><span class="caret"></span></a>
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
                <form method = "post" action="sellAction.jsp">
                    <h3 style="text-align:center;">Sell</h3>
                    <%
                    ShoeDAO d = ShoeDAO.getInstance();
                    ArrayList<String> brand = d.findbrand();
                    	%>
                    	<div class ="form-group">
                        Shoe Brand 
                        <select name = "brand" onchange="SetTypeTail(brand.options[this.selectedIndex].value)">
                        <option value="notSelected" >::Choose the brand::</option>
   <%  for(int i = 0; i < brand.size(); i++) {
           String option = (String)brand.get(i);
   %>
   <option value="<%= option %>"><%= option %></option>
   <% } %>
</select>
</div>
                     <%
                    ArrayList<String> name = d.findname();
                    	%>
                    	<div class ="form-group">
                        Shoe Name 
                        <select name = "shoe_name" onchange="SetTypeTail(shoe_name.options[this.selectedIndex].value)">
                        <option value="notSelected" >::Choose the name::</option>
   <%  for(int i = 0; i < name.size(); i++) {
           String option = (String)name.get(i);
   %>
   <option value="<%= option %>"><%= option %></option>
   <% } %>
</select>
</div>

 <%
                    ArrayList<String> Type = d.findtype();
                    	%>
                    	<div class ="form-group">
                        Type
                        <select name = "type" onchange="SetTypeTail(type.options[this.selectedIndex].value)">
                        <option value="notSelected" >::Choose the Type::</option>
   <%  for(int i = 0; i < Type.size(); i++) {
           String option = (String)Type.get(i);
   %>
   <option value="<%= option %>"><%= option %></option>
   <% } %>
</select>
</div>

 <%
                    ArrayList<String> Sizes = d.findSize();
                    	%>
                    	<div class ="form-group">
                        Sizes
                        <select name = "sizes" onchange="SetTypeTail(sizes.options[this.selectedIndex].value)">
                        <option value="notSelected" >::Choose the Size::</option>
   <%  for(int i = 0; i < Sizes.size(); i++) {
           String option = (String)Sizes.get(i);
   %>
   <option value="<%= option %>"><%= option %></option>
   <% } %>
</select>
</div>

                    <div class ="form-group">
                        Color<input type ="text" class="form-control" value ="" name ="color" maxlength='20'>
                    </div>
					<div class ="form-group">
                        Price<input type ="text" class="form-control" value ="" name ="price" maxlength='20'>
                    </div>
                   

                        <div class ="form-group">
                        Quantity<input type ="text" class="form-control" value ="" name ="quantity" maxlength='20'>
                    </div>  
                    
                                        
<div class ="form-group">
                        Image<input type ="file" class="form-control" value ="" name ="pimg" maxlength='20'>
                    </div> 
					
                    <input type="submit" class="btn btn=primary form-control" value="Sell this Shoe">
                </form>
            </div> 
        </div> 
</div>
</body>
</html>