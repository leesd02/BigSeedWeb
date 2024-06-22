<%@ page import="java.sql.*"%>
<% Connection conn = null;
String url = "jdbc:mysql://localhost:3306/big_seed";
String user = "root";
String password = "971106";
Class.forName("com.mysql.jdbc.Driver");
conn = DriverManager.getConnection(url, user, password);
%>