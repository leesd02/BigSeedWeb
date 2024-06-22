<%@ include file="dbconn.jsp" %>
<%@ page import="java.io.*, java.sql.*, javax.servlet.http.*, javax.servlet.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    int postId = Integer.parseInt(request.getParameter("id"));
    PreparedStatement pstmt = null;

    try {
        // 댓글 삭제
        pstmt = conn.prepareStatement("DELETE FROM comments WHERE post_id = ?");
        pstmt.setInt(1, postId);
        pstmt.executeUpdate();

        // 게시물 삭제
        pstmt = conn.prepareStatement("DELETE FROM posts WHERE id = ?");
        pstmt.setInt(1, postId);
        pstmt.executeUpdate();

        response.sendRedirect("main.jsp");
    } catch (Exception e) {
        out.println("데이터베이스 연결 또는 쿼리 실행 중 오류가 발생했습니다.");
        e.printStackTrace();
    } finally {
        try {
            if (pstmt != null) pstmt.close();
            if (conn != null) conn.close();
        } catch (SQLException e) {
            out.println("데이터베이스 리소스 반환 중 오류가 발생했습니다.");
            e.printStackTrace();
        }
    }
%>
