<%-- 
    Document   : publishComment
    Created on : 2017-5-30, 21:15:23
    Author     : zjlov
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.bbs.DataBase,java.sql.*" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>发表评论</title>
    </head>
    <body>
        <%
            request.setCharacterEncoding("utf-8");
            String tid = request.getParameter("tid");    
            String rid = request.getParameter("referID");
            int uid = Integer.valueOf((String)session.getAttribute("userID")).intValue();
            String content = request.getParameter("content");
            DataBase db = new DataBase();
            db.ConnectDB();
            db.addComment(uid, content, tid, rid, false);
            String ref = request.getHeader("REFERER");
        %>
        评论成功！<br>
        <a href="#" onclick="javascript:window.location='<%=ref%>'">点击返回</a>
    </body>
</html>
