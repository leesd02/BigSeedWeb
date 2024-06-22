<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.sql.*"%>

<!DOCTYPE html>
<html>
<head>
<title>회원가입</title>
<link rel="stylesheet" href="register_style.css">
</head>
<body>

<%@ include file="dbconn.jsp" %>

<%
request.setCharacterEncoding("utf-8");

String id = request.getParameter("id");
String passwd = request.getParameter("passwd");
String name = request.getParameter("name");

if (id != null && passwd != null && name != null) {
    try {
        String sql = "INSERT INTO member (id, passwd, name) VALUES (?, ?, ?)";
        PreparedStatement pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, id);
        pstmt.setString(2, passwd);
        pstmt.setString(3, name);
        
        int result = pstmt.executeUpdate();
        
        if (result > 0) {
%>
            <div class="register-container">
                <script>
                alert("회원가입이 완료되었습니다. 로그인창으로 이동합니다.");
                location.href = "login.jsp";
                </script>
            </div>
<%
        } else {
%>
            <div class="register-container">
                <script>
                alert("이미 사용중인 아이디입니다.");
                location.href = "register.jsp";
                </script>
            </div>
<%
        }
    } catch (SQLException ex) {
        if (ex.getErrorCode() == 1062) { // 중복된 키 에러 코드
%>
            <div class="register-container">
                <script>
                alert("이미 사용중인 아이디입니다.");
                location.href = "register.jsp";
                </script>
            </div>

<%
        } else {
%>
            <div class="register-container">
                <h1>데이터베이스 오류</h1>
                <p>데이터베이스 작업 중 오류가 발생했습니다.</p>
                <p>SQLException: <%= ex.getMessage() %></p>
            </div>
<%
        }
    } finally {
        if (conn != null)
            conn.close();
    }
}
%>

<div class="register-container">
    <h1>회원가입</h1>
    <form method="post" action="register.jsp">
        <label for="id">아이디:</label>
        <input type="text" id="id" name="id" required>
        <label for="passwd">비밀번호:</label>
        <input type="password" id="passwd" name="passwd" required>
        <label for="name">이름:</label>
        <input type="text" id="name" name="name" required>
        <button type="submit">회원가입</button>
         <button type="button" onclick="location.href='login.jsp'">로그인 페이지로 이동</button>
    </form>
</div>

</body>
</html>
