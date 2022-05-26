<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import = "shoe.ShoeDAO" %>
<%@ page import = "shoe.Shoe" %>
<%@ page import = "user.UserDAO" %>
<%@ page import = "java.util.ArrayList"%>
<%@ page import = "user.User" %>
                   <%@ page import = "java.net.URLEncoder"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<meta name="viewport" content="width=device-width, initial-scale=1" >        
<link rel="stylesheet" href = "resources/css/bootstrap.css">
<link rel="stylesheet" href = "resources/css/NewFile.css">
<script src = "https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script src = "resources/js/bootstrap.js"></script>
<jsp:useBean id="sh" class="shoe.Shoe" scope="page" />
<jsp:setProperty name="sh" property="upload_id" />
<meta charset="EUC-KR">
<title>BCD MART</title>
</head>
<body>
<% 
String userid = null;
String nickname= null;
if(session.getAttribute("userID") != null) {
	userid = (String) session.getAttribute("userID");
	UserDAO dao = UserDAO.getInstance();
	nickname = dao.getUserinfo(userid).getNickname();
}
String upload_id = null;
if(request.getParameter("upload_id") != null) {
	upload_id = request.getParameter("upload_id");
}
System.out.println(upload_id);
int pageNum = 1;
if(request.getParameter("pageNum") != null){
	pageNum = Integer.parseInt(request.getParameter("pageNum"));
}
%>
<style>

  @import url(//fonts.googleapis.com/earlyaccess/notosanskr.css);

html {
    font-family: "Noto Sans KR", sans-serif;
}


/*노말라이즈*/
body,
ul,
li {
    list-style: none;
    padding: 0;
    margin: 0;
}
a {
    text-decoration: none;
    color: inherit;
}

/*라이브러리*/

.con {
    margin-left: auto;
    margin-right: auto;
}

.cell {
    float: left;
    box-sizing: border-box;
    margin-bottom: 20px;
}
.row::after {
    content: "";
    display: block;
    clear: both;
}
.img-box > img {
    display: block;
    width: 100%;
}
/*커스텀*/
html,
body {
    overflow-x: hidden;
}
.con {
    max-width: 1000px;
}
.logo-bar {
    text-align: center;
    margin-bottom: 20px;
    margin-top: 20px;
}

.bn-box {
    margin-bottom: 20px;
    margin-top: 20px;
}
@media ( max-width:700px ) {
    .top-bn-box-1 {
        overflow-x:hidden;
    }

    .top-bn-box-1 > .img-box {
        margin-left:-50%;
    }
}

.menu-box {
    margin-bottom: 20px;
    margin-top: 20px;
}
.menu-box > ul > li {
    width: calc(100% / 7);
}
@media (max-width: 800px) {
    .menu-box {
        display: none;
    }
}

.menu-box > ul > li > a {
    display: block;
    text-align: center;
    font-weight: bold;
    position: relative;
}
.menu-box > ul > li:hover > a {
    color: red;
    text-decoration: underline;
}
.menu-box > ul > li > a::before,
.menu-box > ul > li > a::after {
    content: "";
    width: 1px;
    height: 13px;
    background-color: black;
    position: absolute;
    top: 50%;
    transform: translatey(-50%);
    left: 0;
}
.menu-box > ul > li > a::after {
    left: auto;
    right: 0;
}
.menu-box > ul > li:first-child > a::before,
.menu-box > ul > li:last-child > a::after {
    width: 2px;
}
.list > ul > li {
    width: calc(100% / 6);
}

.list > ul > li {
    padding: 0 10px;
}
.list > ul {
    margin: 0 -10px;
}

.list > ul > li > .product-name {
    text-align: Center;
    font-weight: bold;
}
.list > ul > li:hover > .product-name {
    text-decoration: underline;
}
.list > ul > li > .product-price {
    text-align: center;
    font-weight: bold;
    font-size: 1.5rem;
}
.list > ul > li > .product-price::after {
    content: "원";
    font-size: 1rem;
    font-weight:normal;
}


@media (max-width: 800px) {
    .list > ul > li {
        width: calc(100% / 5);
    }
}

@media (max-width: 650px) {
    .list > ul > li {
        width: calc(100% / 4);
    }
}

@media (max-width: 500px) {
    .list > ul > li {
        width: calc(100% / 3);
    }
}

@media (max-width: 400px) {
    .list > ul > li {
        width: calc(100% / 2);
    }
}

@media (max-width: 300px) {
    .list > ul > li {
        width: calc(100% / 1);
    }
}
.middle {
  display: table-cell;
  vertical-align: middle;
}
</style>

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
    
</div>

<div style="text-align:center">
<Strong>All the Shoes in the order of uploads</Strong>
</div>
<div class="container">
		<div class="row">
			<table class="table table-striped" style="text-align: center; border: 1px solid #dddddd">
				<thead>
					<tr>
						<th style="background-color: #eeeeee; text-align: center;">Name</th>
						<th style="background-color: #eeeeee; text-align: center;">Brand</th>
						<th style="background-color: #eeeeee; text-align: center;">Color</th>
						<th style="background-color: #eeeeee; text-align: center;">Size</th>
						<th style="background-color: #eeeeee; text-align: center;">Quantity</th>
						<th style="background-color: #eeeeee; text-align: center;">Seller</th>
						<th style="background-color: #eeeeee; text-align: center;">Pics</th>
					</tr>
				</thead>
				<tbody>
					<%
						ShoeDAO com = new ShoeDAO(); // 인스턴스 생성
						ArrayList<Shoe> list = com.getList();
						for(int i = 0; i < list.size(); i++){
							String address = com.getPic(list.get(i).getBrand(), list.get(i).getShoe_name());
							address = "resources/" + address;
					%>
					<tr>
						<!-- 게시글 제목을 누르면 해당 글을 볼 수 있도록 링크를 걸어둔다 -->
						<td><a href="viewshoe.jsp?upload_id=<%= list.get(i).getUpload_id() %>">
							<%= list.get(i).getShoe_name() %></a></td>
						<td><%= list.get(i).getBrand() %></td>
						<td><%= list.get(i).getColor() %></td>
						<td><%= list.get(i).getSizes() %></td>
						<td><%= list.get(i).getQuantity() %></td>
						<td><%= com.getUploader(list.get(i).getUpload_id()) %></td>
						<td><img src="<%=address %>" width=200, height=200></td>
					</tr>
					<%
						}
					%>
				</tbody>
				
			</table>

			</div>
			</div>

</body>
</html>