<%-- 
    Document   : newTopic
    Created on : 2017-5-30, 13:47:22
    Author     : zjlov
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.bbs.DataBase,java.sql.*" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="header.css" />
        <title>newTopic</title>
    </head>
    <body>
        <%@include file="header.jsp" %>
        <%
        request.setCharacterEncoding("utf-8");
        int sid = Integer.valueOf(request.getParameter("sid")).intValue();
        if(request.getMethod().equalsIgnoreCase("post")){
            DataBase db = new DataBase();
            db.ConnectDB();
            String title = request.getParameter("title");
            String content = request.getParameter("content");
            out.println(title);
            String userID = (String)session.getAttribute("userID");
            int uid = Integer.valueOf(userID).intValue();
            //System.out.println(request.getParameter("sid"));
            db.addTopic(title, uid, sid, content);
            db.CloseDB();
       
        %>
        <div>发表成功</div><br>
        <a href="section.jsp?sid=<%=sid%>">点击返回</a>
        <%}
        else if(session.getAttribute("isOnline")!=null) {
        %>
        <form action="newTopic.jsp?sid=<%=sid%>" method="post">
            标题<input type="text" name="title"><br>
            内容<textarea rows="5" cols="50" name="content"></textarea><br>
            <input type="submit" name="submit" value="提交">
        </form>
        <%
            }
        else{    
        %>
        <div>请先<a href="userLogin.jsp">登陆</a>或<a href="userRegister.html">注册</a>！</div>
        <a href="#" onclick="javascript:window.location='<%=(String)request.getHeader("REFERER")%>'">点击返回</a>
        <%}
        %>
    </body>

</html>
