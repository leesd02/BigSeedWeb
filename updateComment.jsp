<%@ include file="dbconn.jsp" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

<%
request.setCharacterEncoding("UTF-8");
int commentId = Integer.parseInt(request.getParameter("id"));
int postId = Integer.parseInt(request.getParameter("post_id"));
String newContent = request.getParameter("content");


try {
    PreparedStatement pstmt = conn.prepareStatement("UPDATE comments SET content = ? WHERE id = ?");
    pstmt.setString(1, newContent);
    pstmt.setInt(2, commentId);
    pstmt.executeUpdate();

    // viewPost.jsp로 리다이렉트
    response.sendRedirect("viewPost.jsp?id=" + postId);
} catch (SQLException e) {
    out.println("Error occurred while updating the comment.");
    e.printStackTrace();
} finally {
    try {
        if (pstmt != null) pstmt.close();
        if (conn != null) conn.close();
    } catch (SQLException e) {
        out.println("Error occurred while closing database resources.");
        e.printStackTrace();
    }
}
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Edit Comment</title>
</head>
<body>
    <h1>Edit Comment</h1>
    <form action="updateComment.jsp" method="post">
        <input type="hidden" name="id" value="<%= commentId %>">
        <input type="hidden" name="post_id" value="<%= postId %>">
        <!-- 코멘트 내용 입력 필드 등 추가 -->
        <button type="submit">Update</button>
    </form>
</body>
</html>
