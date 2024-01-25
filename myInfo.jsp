<%@ page language="java" contentType="text/html" pageEncoding="utf-8" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
    
<%
    String id = "";
    String pw = "";
    String name = "";
    String birth = "";
    String phoneNum = "";
    
    boolean isLogginIn = false;

    if(session.getAttribute("id") != null){
        isLogginIn = true;

        id = String.valueOf(session.getAttribute("id"));
        pw = String.valueOf(session.getAttribute("pw"));
        name = String.valueOf(session.getAttribute("name"));
        birth = String.valueOf(session.getAttribute("birth"));
        phoneNum = String.valueOf(session.getAttribute("phoneNum"));
    }
%>

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>MyInfo</title>
    <link rel="stylesheet" type="text/css" href="../../css/7weeks/nav.css">
</head>

<body>
    <jsp:include page="nav.jsp"></jsp:include>

    <h1 id="printId"></h1>
    <h1 id="printPw"></h1>
    <h1 id="printName"></h1>
    <h1 id="printBirth"></h1>
    <h1 id="printPhoneNum"></h1>

    <script>
        var isLogginIn = <%=isLogginIn%>;
        var loginState = "";

        if (isLogginIn) {
            var id = "<%=id%>";
            var pw = "<%=pw%>";
            var name = "<%=name%>";
            var birth = "<%=birth%>";
            var phoneNum = "<%=phoneNum%>";
            loginState = "logged";

            document.getElementById('printId').innerText = "아이디 : " + id;
            document.getElementById('printPw').innerText = "비밀번호 : " + pw;
            document.getElementById('printName').innerText = "이름 : " + name;
            document.getElementById('printBirth').innerText = "생년월일 : " + birth;
            document.getElementById('printPhoneNum').innerText = "전화번호 : " + phoneNum;
        } else {
            loginState = "loggedOut";
            alert('접근 권한이 없습니다.');
            location.href = "blog.jsp";
        }
    </script>
    <script src="../../js/7weeks/openBox.js"></script>
</body>