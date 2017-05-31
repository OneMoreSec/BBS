<%-- 
    Document   : userLogoff
    Created on : 2017-5-30, 16:19:49
    Author     : zjlov
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>注销</title>
    </head>
    <body>
        <%
            session.removeAttribute("isOnline");
            session.removeAttribute("userID");
            session.removeAttribute("userName");
        %>
        <div>
            账户已经注销！
            <%String ref = request.getHeader("REFERER");%>
            <a href="#" onclick="javascript:window.location='<%=ref%>'">点击返回</a>
        </div>
    </body>
</html>
