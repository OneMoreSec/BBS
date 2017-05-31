/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 *
 * @author zjlov
 */
package com.bbs;
import java.sql.*;
import java.text.*;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.io.UnsupportedEncodingException;

public class DataBase {
    private String driverName = "com.mysql.jdbc.Driver";
    private String userName = "root";
    private String userPswd = "RAYALLEN27zj";
    private String url = "jdbc:mysql://localhost:3306/forum";
    private Connection conn = null;
    public Statement stmt = null;
   PreparedStatement pStmt = null;
    public void ConnectDB(){
        try{
            Class.forName(driverName);
            conn = DriverManager.getConnection(url,userName,userPswd);
        }
        catch(Exception e){
            e.printStackTrace();
        }
    }
    
    public ResultSet getUser(String user){
        ResultSet rs = null;
        try{
            stmt = conn.createStatement();
            String sql = String.format("select * from user where binary user_name = '%s'", user);
            System.out.println(sql);
            rs = stmt.executeQuery(sql);
        }
        catch(Exception e){
            e.printStackTrace();
        }
        return rs;
    }
    
    public void addUser(String userName,String password,String email){
        try{
            stmt = conn.createStatement();
            String sql = String.format("insert into forum.user(user_name,password,e_mail) values('%s','%s','%s')",userName,password,email);
            stmt.executeUpdate(sql);
            
        }
        catch(Exception e){
            e.printStackTrace();
            
        }
    }
    
    public void addTopic(String title,int authorID,int sectionID,String content){
        pStmt = null;
        try{
            pStmt = conn.prepareStatement("INSERT INTO forum.topic"+
                    "(topic_id,topic_title,user_id,topic_section,topic_time)"+
                    "values(?,?,?,?,?)");
            conn.setAutoCommit(false);
            java.util.Date date = new java.util.Date();
            Timestamp tt = new Timestamp(date.getTime());
            String tid = this.EncoderByMd5(title+authorID);
            pStmt.setString(1, tid);
            pStmt.setString(2, title);
            pStmt.setInt(3, authorID);
            pStmt.setInt(4, sectionID);
            pStmt.setTimestamp(5, tt);
            pStmt.executeUpdate();
            conn.commit();
            this.addComment(authorID, content, tid, null,true);
        }
        catch(Exception e){
            e.printStackTrace();
        }
    }
    
    public void addComment(int authorID,String content,String topicID,String referID,boolean isMainContent){
        pStmt = null;
        try{
            pStmt = conn.prepareStatement("INSERT INTO forum.comment"+
                    "(comment_id,user_id,content,comment_time,topic_id,is_maincontent,refer_comment)"+
                    "values(?,?,?,?,?,?,?)");
            pStmt.setString(7, referID);
            conn.setAutoCommit(false);          
            java.util.Date date = new java.util.Date();
            Timestamp tt = new Timestamp(date.getTime());
            String cid = this.EncoderByMd5(topicID+authorID+content);
            pStmt.setString(1, cid);
            pStmt.setInt(2, authorID);
            pStmt.setString(3, content);
            pStmt.setTimestamp(4, tt);
            pStmt.setString(5, topicID);
            pStmt.setBoolean(6, isMainContent);
            if(referID==null){
                pStmt.setString(7, cid);
            }
            else{
                pStmt.setString(7, referID);
            }
            pStmt.executeUpdate();
            conn.commit();
        }
        catch(Exception e){
            e.printStackTrace();
        }
    }
    
    public String getSectionNameByID(int sid){
        pStmt = null;
        ResultSet rs = null;
        String sectionName = "";
        try{
            pStmt = conn.prepareStatement("SELECT section_name FROM section where section_id=?");
            conn.setAutoCommit(false);
            pStmt.setInt(1, sid);
            rs = pStmt.executeQuery();
            if(rs.next()){
                sectionName = rs.getString("section_name");
            }
        }
        catch(Exception e){
            e.printStackTrace();
        }
        return sectionName;
    }
    
    public ResultSet getTopicFromASection(int sid){
        pStmt = null;
        ResultSet rs = null;
        try{
            pStmt = conn.prepareStatement("SELECT * FROM topic NATURAL JOIN user WHERE topic_section = ?");
            pStmt.setInt(1, sid);
            rs = pStmt.executeQuery();
        }
        catch(Exception e){
            e.printStackTrace();
        }
        return rs;
    }
    
    public ResultSet getCommentById(String cid){
        pStmt = null;
        ResultSet rs = null;
        try{
            pStmt = conn.prepareStatement("SELECT * FROM comment NATURAL JOIN user WHERE comment_id = ?");
            pStmt.setString(1, cid);
            rs = pStmt.executeQuery();
            
        }
        catch(Exception e){
            e.printStackTrace();
        }
        return rs;
    }
    
    public ResultSet getCommentFromATopic(String tid,boolean isMainContent){
        pStmt = null;
        ResultSet rs = null;
        try{
            pStmt = conn.prepareStatement("SELECT * FROM comment NATURAL JOIN user WHERE topic_id = ? and is_maincontent = ? ORDER BY comment_time");

            pStmt.setString(1, tid);
            pStmt.setBoolean(2, isMainContent);
            rs = pStmt.executeQuery();
        }
        catch(Exception e){
            e.printStackTrace();
        }
        return rs;
    }
    
    public ResultSet getTopic(String tid){
        pStmt = null;
        ResultSet rs = null;
        try{
            pStmt = conn.prepareStatement("SELECT * FROM topic NATURAL JOIN user WHERE topic_id = ?");
            pStmt.setString(1, tid);
            rs = pStmt.executeQuery();
        }
        catch(Exception e){
            e.printStackTrace();
        }
        return rs;
    }
    
    public void CloseDB(){
        try{
            if(stmt!=null){
                stmt.close();
            }
            conn.close();
        }
        catch(SQLException SqlE){
            SqlE.printStackTrace();
        }
    }
    public String EncoderByMd5(String str) throws NoSuchAlgorithmException, UnsupportedEncodingException{
             //确定计算方法
              MessageDigest md5=MessageDigest.getInstance("MD5");
             sun.misc.BASE64Encoder base64en = new sun.misc.BASE64Encoder();
              //加密后的字符串
             String newstr=base64en.encode(md5.digest(str.getBytes("utf-8")));
              return newstr;
             }
}
