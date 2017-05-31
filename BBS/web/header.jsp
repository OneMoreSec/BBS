<%-- 
    Document   : header
    Created on : 2017-5-30, 23:46:32
    Author     : zjlov
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
        <header>   
            <div id="log">     
            <%
                Boolean isOnline = (Boolean)session.getAttribute("isOnline");
                if(isOnline==null){
            %>
            
                <a class = "buttonAnchor" href="userRegister.html" >注册</a>
                <a class="buttonAnchor" href="userLogin.jsp">登陆</a>
            
            <%
                }
                else{
                    String user = (String)session.getAttribute("userName");
            %>
                    <%=user%>您好！
                    <a class = "buttonAnchor" href="userLogoff.jsp">注销</a>
            <%
                }
            %>
            </div>                
            <nav>
                <a href="index.jsp">HomePage</a>
                <a href="section.jsp?sid=1">OverWatch</a>
                <a href="section.jsp?sid=2">CS:GO</a>
            </nav>
        </header>