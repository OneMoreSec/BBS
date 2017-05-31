<%-- 
    Document   : section
    Created on : 2017-5-30, 17:12:22
    Author     : zjlov
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.bbs.DataBase,java.sql.*,java.text.*" %>
<!DOCTYPE html>
<html>
    <head>        
        <link rel="stylesheet" href="header.css" />
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <%
            DataBase db = new DataBase();
            db.ConnectDB();
            int sid = Integer.valueOf(request.getParameter("sid")).intValue();
            ResultSet sectionTopic = db.getTopicFromASection(sid);           
            SimpleDateFormat formatter = null;
        %>
        <title><%=db.getSectionNameByID(sid)%></title>
    </head>
    <body>
        <%@include file="header.jsp" %>
        <main>
            <div class = "newTopic">
                <a href="newTopic.jsp?sid=<%=sid%>">发新贴</a>
            </div>
            <div class="topic_show">
                <table border="1px black solid">
                    <tr>
                        <th>标题</th>
                        <th>作者</th>
                        <th>时间</th>
                        <th>楼层</th>
                    </tr>
                    <%
                        while(sectionTopic.next()){
                             String title = sectionTopic.getString("topic_title");
                             String author = sectionTopic.getString("user_name");
                             formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
                             String time = formatter.format(sectionTopic.getTimestamp("topic_time"));
                             int replyCount = sectionTopic.getInt("topic_reply");
                             String tid = sectionTopic.getString("topic_id");
                             out.write("<tr><td><a href=\"topicShow.jsp?tid="+tid+"\">"+title+"</a></td>");
                             out.write("<td>"+author+"</td>");
                             out.write("<td>"+time+"</td>");
                             out.write("<td>"+replyCount+"</td></tr>");
                        }
                    %>
                    
                </table>

            </div>
        </main>
    </body>
</html>
