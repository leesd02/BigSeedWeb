<%@ include file="dbconn.jsp" %>
<%@ page import="java.io.*, java.sql.*, javax.servlet.http.*, javax.servlet.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>BigSeed</title>
    <link rel="stylesheet" href="main_style.css">
</head>
<body>
    <div class="header">
        <h1>BigSeed</h1>
        <nav class="nav">
            <a href="#">Home</a>
            <a href="#">Followers</a>
            <a href="writePost.jsp">Post</a>
        </nav>
    </div>
    <%
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        try {
            pstmt = conn.prepareStatement("SELECT * FROM posts");
            rs = pstmt.executeQuery();
    %>

    <h2>게시물 목록</h2>
    <table>
        <tr>
            <th>제목</th>
            <th>내용</th>
            <th>첨부 파일</th>
            <th>수정</th>
            <th>삭제</th>
        </tr>
        <% while(rs.next()) { %>
        <tr>
            <td><a href="viewPost.jsp?id=<%= rs.getInt("id") %>"><%= rs.getString("title") %></a></td>
            <td><%= rs.getString("content") %></td>
            <td><a href="downloadFile.jsp?id=<%= rs.getInt("id") %>"><%= rs.getString("file_name") %></a></td>
            <td><a href="editPost.jsp?id=<%= rs.getInt("id") %>">수정</a></td>
            <td><a href="deletePost.jsp?id=<%= rs.getInt("id") %>">삭제</a></td>
        </tr>
        <% } %>
    </table>

    <%
        } catch (Exception e) {
            out.println("데이터베이스 연결 또는 쿼리 실행 중 오류가 발생했습니다.");
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) rs.close();
                if (pstmt != null) pstmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                out.println("데이터베이스 리소스 반환 중 오류가 발생했습니다.");
                e.printStackTrace();
            }
        }
    %>
</body>
</html>
