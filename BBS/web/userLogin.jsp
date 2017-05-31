<%-- 
    Document   : userLogin
    Created on : 2017-5-26, 14:45:32
    Author     : zjlov
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.bbs.DataBase,java.sql.*" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Login</title>
    </head>
    <body>
        <%
            String message = "";
            if(request.getMethod().equalsIgnoreCase("post")){
                String userName = request.getParameter("userName");
                String password = request.getParameter("password");
                DataBase db = new DataBase();
                db.ConnectDB();
                ResultSet rs = db.getUser(userName);
                if(rs.next()){
                    if(password.equals(rs.getString("password"))){
                        message = "登陆成功！";
                        session.setAttribute("userID", rs.getString("user_id"));
                        session.setAttribute("userName", rs.getString("user_name"));
                        session.setAttribute("isOnline", true);
                        %>        
                        <%=message%><br>
                        <%String ref = (String)session.getAttribute("referer");
                        session.removeAttribute("referer");%>
                        <a href="#" onclick="javascript:window.location='<%=ref%>'">点击返回</a>
                        <%
                    }
                    else{
                        message = "密码错误！";
                    }
                }
                else{
                    message = "用户不存在！";
                }
            }
                else{
                    String ref = request.getHeader("REFERER");
                    session.setAttribute("referer", ref);
        %>
                    <form action="userLogin.jsp" method="post">
                        用户名:<input type="text" name="userName" /><br><br>
                        密码：<input type="password" name="password" /><br><br>
                        <input type="submit" value="登陆" />
                    </form>
                <%
                    }
                %>
    </body>
</html>
