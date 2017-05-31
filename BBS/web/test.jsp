<%-- 
    Document   : test
    Created on : 2017-5-26, 12:02:06
    Author     : zjlov
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.bbs.beanTest,com.bbs.DataBase,java.sql.*" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <% 
            beanTest bean = new beanTest();
            bean.setA(3);
            DataBase db = new DataBase();
            db.ConnectDB();
            ResultSet rs = db.getUser("Zj");
            System.out.println("fuck");
            try{
                if(rs.next()){
                    out.write("find");
                }
                else{
                    out.write("no");
                }
            }
            catch(Exception e){
                
            }
            %>
        <h1>Hello World!</h1>
        <%=bean.getA()%>
    </body>
</html>
