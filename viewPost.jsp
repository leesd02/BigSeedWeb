<%@ include file="dbconn.jsp" %>
<%@ page import="java.io.*, java.sql.*, javax.servlet.http.*, javax.servlet.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>BigSeed - 게시물 보기</title>
    <link rel="stylesheet" href="view_style.css">
</head>
<body>
    <div class="header">
        <h1>BigSeed</h1>
        <nav class="nav">
            <a href="main.jsp">Home</a>
            <a href="#">Followers</a>
            <a href="writePost.jsp">Post</a>
        </nav>
    </div>

    <%
        int postId = Integer.parseInt(request.getParameter("id"));
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            pstmt = conn.prepareStatement("SELECT * FROM posts WHERE id = ?");
            pstmt.setInt(1, postId);
            rs = pstmt.executeQuery();

            if (rs.next()) {
    %>
    <div class="post-container">
        <h2><%= rs.getString("title") %></h2>
        <p><%= rs.getString("content") %></p>
        <% if (rs.getString("file_name") != null && !rs.getString("file_name").isEmpty()) { %>
        <p>첨부 파일: <a href="downloadFile.jsp?id=<%= rs.getInt("id") %>"><%= rs.getString("file_name") %></a></p>
        <% } %>
        <% if (session.getAttribute("user_id") != null && session.getAttribute("user_id").equals(rs.getString("author"))) { %>
        <a href="deletePost.jsp?id=<%= rs.getInt("id") %>" onclick="return confirm('정말 삭제하시겠습니까?');">삭제</a>
        <% } %>
    </div>

    <div class="comment-container">
        <h3>댓글</h3>
        <%
            pstmt = conn.prepareStatement("SELECT * FROM comments WHERE post_id = ? ORDER BY created_at");
            pstmt.setInt(1, postId);
            rs = pstmt.executeQuery();

            while (rs.next()) {
        %>
        <div class="comment">
            <h4><%= rs.getString("author") %></h4>
            <p><%= rs.getString("content") %></p>
            <p>작성일: <%= rs.getTimestamp("created_at") %></p>
            <% if (session.getAttribute("user_id") != null && session.getAttribute("user_id").equals(rs.getString("author"))) { %>
            <a href="editComment.jsp?id=<%= rs.getInt("id") %>">수정</a>
            <a href="deleteComment.jsp?id=<%= rs.getInt("id") %>&post_id=<%= postId %>" onclick="return confirm('정말 삭제하시겠습니까?');">삭제</a>
            <% } else { %>
            <a href="editComment.jsp?id=<%= rs.getInt("id") %>">수정</a>
            <a href="deleteComment.jsp?id=<%= rs.getInt("id") %>&post_id=<%= postId %>" onclick="return confirm('정말 삭제하시겠습니까?');">삭제</a>
            <% } %>
        </div>
        <% } %>
    </div>

    <a href="writeComment.jsp?post_id=<%= postId %>" class="comment-link">댓글 작성하기</a>

    <%
            }
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

    <div class="footer">
        <p>&copy; 2023 BigSeed. All rights reserved.</p>
    </div>
</body>
</html>
