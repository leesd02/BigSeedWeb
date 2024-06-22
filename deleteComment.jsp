<%@ include file="dbconn.jsp" %>
<%@ page import="java.sql.*" %>

<%
    int commentId = Integer.parseInt(request.getParameter("id"));

    try {
        PreparedStatement pstmt = conn.prepareStatement("DELETE FROM comments WHERE id = ?");
        pstmt.setInt(1, commentId);
        pstmt.executeUpdate();

        response.sendRedirect("viewPost.jsp?id=" + request.getParameter("post_id"));
    } catch (SQLException e) {
        out.println("데이터베이스 삭제 중 오류가 발생했습니다.");
        e.printStackTrace();
    } finally {
        try {
            if (conn != null) conn.close();
        } catch (SQLException e) {
            out.println("데이터베이스 연결 해제 중 오류가 발생했습니다.");
            e.printStackTrace();
        }
    }
%>
