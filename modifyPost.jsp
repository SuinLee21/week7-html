<%@ page language="java" contentType="text/html" pageEncoding="utf-8" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>

<% 
    request.setCharacterEncoding("utf-8");

    String userIdxValue = request.getParameter("user_idx");
    String postIdxValue = request.getParameter("postIdx");
    String title = "";
    String contents = "";
    
    boolean isUserEqual = false;

    if(userIdxValue.equals(String.valueOf(session.getAttribute("idx")))){
        isUserEqual = true;

        Class.forName("com.mysql.jdbc.Driver"); 
        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/web", "suin", "suin"); 

        String sql = "SELECT * FROM post WHERE idx=?";
        PreparedStatement query = conn.prepareStatement(sql); 

        query.setInt(1, Integer.parseInt(postIdxValue));
        ResultSet result = query.executeQuery();

        while(result.next()){
            title = result.getString("title");
            contents = result.getString("contents");
        }
    }
%>

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>modifyPost</title>
    <link rel="stylesheet" type="text/css" href="../../css/7weeks/modifyPost.css">
</head>

<body>
    <form action="../../jspAction/7weeks/modifyPostAction.jsp" class="modifyPostForm"
        onsubmit="return contentsCheckEvent()">
        <input type="hidden" name="user_idx" id="hiddenUserIdxInput">
        <input type="hidden" name="postIdx" id="hiddenPostIdxInput">
        <textarea class="modifyPostFormChild" id="title" name="title"></textarea>
        <textarea class="modifyPostFormChild modifyTextareaContent" id="contents" name="contents"></textarea>
        <input type="submit" value="수정">
    </form>

    <script>
        var isUserEqual = <%=isUserEqual%>;

        if (isUserEqual) {
            var title = "<%=title%>";
            var contents = "<%=contents%>";
            var userIdxValue = "<%=userIdxValue%>";
            var postIdxValue = "<%=postIdxValue%>";

            document.getElementById('title').value = title;
            document.getElementById('contents').value = contents;
            document.getElementById('hiddenUserIdxInput').value = userIdxValue;
            document.getElementById('hiddenPostIdxInput').value = postIdxValue;
        } else {
            alert('접근 권한이 없습니다.');
            location.href = "blog.jsp";
        }
    </script>

    <script src="../../js/7weeks/checkValidity.js"></script>
</body>