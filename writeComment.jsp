<%@ include file="dbconn.jsp" %>
<%@ page import="java.io.*, java.sql.*, javax.servlet.http.*, javax.servlet.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>댓글 작성</title>
    <link rel="stylesheet" href="writeC_style.css">
</head>
<body>
    <h1>새 댓글 작성</h1>
    
    <%
    // 폼에서 입력받은 데이터 처리
    String content = request.getParameter("content");
    String author = request.getParameter("author");

    // 데이터베이스에 댓글 저장
    try {
        String sql = "INSERT INTO comments (content, author, post_id) VALUES (?, ?, ?)";
        PreparedStatement pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, content);
        pstmt.setString(2, author);
        pstmt.setInt(3, Integer.parseInt(request.getParameter("post_id")));
        pstmt.executeUpdate();

        // 댓글 작성 후 원래 페이지로 리다이렉트
        response.sendRedirect("viewPost.jsp?id=" + request.getParameter("post_id"));
    } catch (SQLException e) {
        out.println();
    }
%>

<form action="writeComment.jsp" method="post" class="container">
    <input type="hidden" name="post_id" value="<%=request.getParameter("post_id")%>">
    <label for="content">댓글 내용:</label>
    <textarea id="content" name="content" rows="5" required></textarea>

    <label for="author">작성자:</label>
    <input type="text" id="author" name="author" required>

    <button type="submit">작성</button>
</form>

<a href="viewPost.jsp?id=<%=request.getParameter("post_id")%>" class="cc">글로 돌아가기</a>

</body>
</html>
