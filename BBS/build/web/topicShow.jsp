<%-- 
    Document   : topicShow
    Created on : 2017-5-30, 19:36:50
    Author     : zjlov
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.bbs.DataBase,java.sql.*,java.text.*" %>
<!DOCTYPE html>
<html>
    <head>
        <link rel="stylesheet" href="header.css" />
        <link rel="stylesheet" href="topic.css" />
        <script type="text/javascript">
            function addRefer(refer_id){
                var refer = document.getElementById('referedComment');
                var referID = document.getElementById('referID');
                //var referDiv = document.getElementById(refer_id);
                referID.setAttribute("value",refer_id);
                //var referContent="@";
                refer.innerHTML = "fuck";
            }
        </script>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <%
            DataBase db = new DataBase();
            db.ConnectDB();
            String tid = request.getParameter("tid");
            ResultSet topic = db.getTopic(tid);
            String title = "";
            String content = "";
            String author = "";
            String time = "";
            //tcid主贴内容的commentID
            String tcid = "";
            SimpleDateFormat formatter = null;
            if(topic.next()){
                title = topic.getString("topic_title");
                author = topic.getString("user_name");
                ResultSet topicContent = db.getCommentFromATopic(tid, true);
                if(topicContent.next()){
                    content = topicContent.getString("content");
                    tcid = topicContent.getString("comment_id");
                }
                formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
                time = formatter.format(topic.getTimestamp("topic_time"));
            }
        %>
        <title><%=title%></title>
    </head>
    <body>        

        <%@include file="header.jsp" %>
        <%
            String isDisabled = "";
            if(isOnline==null){
                isDisabled = "disabled = \"disabled\"";
            }
        %>
        <main>
            <h2><%=title%></h2>
            <div class = "floor">
                <div class="floorHead"><%=author%>
                    <span class="floorTime"><%=time%></span>
                </div>
                <%=content%>
            </div><br><br>
            <%
                ResultSet rs = db.getCommentFromATopic(tid,false);
                while(rs.next()){
            %>
                    <div class ="floor" id=<%=rs.getString("comment_id")%>>
                        <div class="floorHead"><%=rs.getString("user_name")%>
                        <span class="floorTime"><%=formatter.format(rs.getTimestamp("comment_time"))%></span>
                            <% if(isOnline!=null){%>
                            <a class="refer" href="#" onclick="addRefer('<%=rs.getString("comment_id")%>')" >引用</a><%}%>
                        </div>
                        <%  String rcid = rs.getString("refer_comment");
                            if(rcid!=null&&!rcid.equals(tcid)){
                            ResultSet referComment = db.getCommentById(rcid);
                            if(referComment.next()){
                        %>
                            <blockquote>
                                <b>引用@<%=referComment.getString("user_name")%>发表的</b><br>
                                <%=referComment.getString("content")%>
                            </blockquote>
                        <%}}%>
                        <div class="floorContent"><%=rs.getString("content")%></div>
                    </div><br><br>
            <%
                }
            %>
            <div class ="commentPublishArea">
                <form action="post.jsp?tid=<%=tid%>" method="post">
                    <div id="referedComment" class="referedComment" name="refered"></div>
                    <input type="text" name="referID" id="referID" style="display: none" value="<%=tcid%>"/>
                    <textarea <%=isDisabled%> name="content" cols="80" rows="5">

                    </textarea><br>
                    <input type="submit" value="发表" <%=isDisabled%> />
                </form>
            </div>
        </main>
    </body>
</html>
