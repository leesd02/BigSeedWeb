<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.sql.*"%>

<!DOCTYPE html>
<html>
<head>
<title>로그인</title>
<link rel="stylesheet" href="login_style.css">
</head>
<body>

<%@ include file="dbconn.jsp" %>

<%
request.setCharacterEncoding("utf-8");

String id = request.getParameter("id");
String passwd = request.getParameter("passwd");

if (request.getMethod().equals("POST")) {
    try {
        String sql = "SELECT * FROM member WHERE id = ? AND passwd = ?";
        PreparedStatement pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, id);
        pstmt.setString(2, passwd);
        
        ResultSet rs = pstmt.executeQuery();
        
        if (rs.next()) {
            // 로그인 성공 시 메인 페이지로 리다이렉트
            response.sendRedirect("main.jsp");
            return;
        } else {
%>
            <script>
                alert("아이디 및 비밀번호를 다시 확인해주세요.");
            </script>
<%
        }
    } catch (SQLException ex) {
%>
        <h2>데이터베이스 작업 중 오류가 발생했습니다.</h2>
        <p>SQLException: <%= ex.getMessage() %></p>
<%
    } finally {
        if (conn != null)
            conn.close();
    }
}
%>

<div class="login-container">
    <h1>BigSeed</h1>
    <form method="post" action="login.jsp">
        <label for="id">아이디:</label>
        <input type="text" id="id" name="id" required>
        <label for="passwd">비밀번호:</label>
        <input type="password" id="passwd" name="passwd" required>
        <button type="submit">로그인</button>
        <button type="button" onclick="location.href='register.jsp'">회원가입</button>
    </form>
</div>


</body>
</html>
