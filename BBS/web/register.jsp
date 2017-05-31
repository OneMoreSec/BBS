<%-- 
    Document   : userRegister
    Created on : 2017-5-26, 21:59:42
    Author     : zjlov
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.bbs.DataBase,java.sql.*" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>用户注册</title>
    </head>
    <body>
        <%
            String message = "";
            if(request.getMethod().equalsIgnoreCase("post")){
                DataBase db = new DataBase();
                db.ConnectDB();
                String userName = request.getParameter("userName");
                String password = request.getParameter("password");
                String email = request.getParameter("email");
                ResultSet rs = db.getUser(userName);
                if(!rs.next()){
                    db.addUser(userName, password, email);
                    message = "注册成功！";
                }
                else{
                    message = "该用户名已经被注册！";
                }
                db.CloseDB();
            }
        %>
        <div><%=message%></div>
        <a href="index.html">返回</a>
    </body>
</html>
