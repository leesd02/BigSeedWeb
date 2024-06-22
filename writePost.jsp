<%@ include file="dbconn.jsp" %>
<%@ page import="java.io.*, java.sql.*, javax.servlet.http.*, javax.servlet.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html>
<head>
    <title>글 쓰기</title>
    <link rel="stylesheet" href="post_style.css"> <!-- 외부 CSS 파일 연결 -->
</head>
<body>
    <div class="header">
        <h2>글 쓰기</h2>
        <nav class="nav">
            <a href="main.jsp">목록으로</a>
        </nav>
    </div>

    <div class="content-wrapper">
        <form action="uploadFile.jsp" method="post" enctype="multipart/form-data" class="post-form">
            <div class="form-group">
                <label for="file">파일 선택:</label>
                <input type="file" name="file" id="file" class="form-control">
            </div>
            <div class="form-group">
                <label for="title">제목:</label>
                <input type="text" name="title" id="title" class="form-control">
            </div>
            <div class="form-group">
                <label for="content">내용:</label>
                <textarea name="content" id="content" class="form-control"></textarea>
            </div>
            <button type="submit" class="btn btn-primary">업로드</button>
        </form>
    </div>

    <%
        // 새로운 게시물 정보를 데이터베이스에 저장
        if (request.getMethod().equals("POST")) {
            String title = request.getParameter("title");
            String content = request.getParameter("content");
            String fileName = request.getParameter("file");

            PreparedStatement pstmt = null;
            try {
                pstmt = conn.prepareStatement("INSERT INTO posts (title, content, file_name) VALUES (?, ?, ?)");
                pstmt.setString(1, title);
                pstmt.setString(2, content);
                pstmt.setString(3, fileName);
                pstmt.executeUpdate();

                // 새로운 게시물이 main.jsp의 게시판 목록에 추가되도록 함
                response.sendRedirect("main.jsp");
            } catch (SQLException e) {
                out.println("데이터베이스 쿼리 실행 중 오류가 발생했습니다.");
                e.printStackTrace();
            } finally {
                if (pstmt != null) {
                    try {
                        pstmt.close();
                    } catch (SQLException e) {
                        out.println("데이터베이스 리소스 반환 중 오류가 발생했습니다.");
                        e.printStackTrace();
                    }
                }
            }
        }
    %>
</body>
</html>
