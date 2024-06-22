<%@ include file="dbconn.jsp" %>
<%@ page import="java.io.*, java.sql.*, javax.servlet.http.*, javax.servlet.*, org.apache.commons.io.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    try {
        int id = Integer.parseInt(request.getParameter("id"));
        pstmt = conn.prepareStatement("SELECT * FROM posts WHERE id = ?");
        pstmt.setInt(1, id);
        rs = pstmt.executeQuery();

        if (rs.next()) {
%>
<!DOCTYPE html>
<html>
<head>
    <title>게시물 수정</title>
    <link rel="stylesheet" href="edit_style.css"> <!-- 외부 스타일시트 적용 -->
</head>
<body>
    <div class="header">
        <h2>게시물 수정</h2>
        <nav class="nav">
            <a href="board.jsp">목록으로</a>
        </nav>
    </div>
    <div class="container">
        <form action="updatePost.jsp" method="post" enctype="multipart/form-data">
            <input type="hidden" name="id" value="<%= rs.getInt("id") %>">
            <div class="form-group">
                <label for="title">제목:</label>
                <input type="text" id="title" name="title" value="<%= rs.getString("title") %>">
            </div>
            <div class="form-group">
                <label for="content">내용:</label>
                <textarea id="content" name="content"><%= rs.getString("content") %></textarea>
            </div>
            <div class="form-group">
                <p>첨부 파일: <a href="downloadFile.jsp?id=<%= rs.getInt("id") %>"><%= rs.getString("file_name") %></a></p>
                <label for="newFile">새로운 파일 선택:</label>
                <input type="file" id="newFile" name="newFile">
            </div>
            <button type="submit" class="btn">수정</button>
        </form>
    </div>
</body>
</html>
<%
        } else {
            out.println("해당 게시물을 찾을 수 없습니다.");
        }
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        try {
            if (rs != null) rs.close();
            if (pstmt != null) pstmt.close();
            if (conn != null) conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
%>
