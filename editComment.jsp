<%@ include file="dbconn.jsp" %>
<%@ page import="java.io.*, java.sql.*, javax.servlet.http.*, javax.servlet.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>BigSeed - 댓글 수정</title>
    <link rel="stylesheet" href="style.css">
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
        int commentId = Integer.parseInt(request.getParameter("id"));
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            pstmt = conn.prepareStatement("SELECT * FROM comments WHERE id = ?");
            pstmt.setInt(1, commentId);
            rs = pstmt.executeQuery();

            if (rs.next()) {
                String author = rs.getString("author");
                String content = rs.getString("content");
                int postId = rs.getInt("post_id");
    %>
    <div class="comment-edit-container">
        <h2>댓글 수정</h2>
        <form action="updateComment.jsp" method="post">
            <input type="hidden" name="id" value="<%= commentId %>">
            <input type="hidden" name="post_id" value="<%= postId %>">
            <label for="author">작성자:</label>
            <input type="text" id="author" name="author" value="<%= author %>" readonly>
            <label for="content">내용:</label>
            <textarea id="content" name="content"><%= content %></textarea>
            <button type="submit">수정 완료</button>
        </form>
    </div>
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
