<%@ page language="java" contentType="text/html" pageEncoding="utf-8" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.util.ArrayList" %>

<% 
    request.setCharacterEncoding("utf-8");

    int postIdxValue = Integer.parseInt(request.getParameter("postIdx")); 
    String sessionUserIdx = "";
    String title = "";
    String contents = "";

    boolean isLogginIn = false;

    if(session.getAttribute("idx") != null){
        sessionUserIdx = String.valueOf(session.getAttribute("idx"));
        isLogginIn = true;
    }else{
        sessionUserIdx = null;
    }

    Class.forName("com.mysql.jdbc.Driver");
    Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/web", "suin", "suin");

    String sql = "SELECT * FROM post WHERE idx=?";
    PreparedStatement query = conn.prepareStatement(sql); 

    query.setInt(1, postIdxValue);

    ResultSet result = query.executeQuery();

    while(result.next()){
        title = result.getString("title"); 
        contents = result.getString("contents");
    }

    // sql = "SELECT * FROM comment WHERE post_idx=?";
    sql = "SELECT c.idx, c.user_idx, c.contents, c.created_at, c.updated_at, u.id, u.name FROM comment c INNER JOIN user u ON c.user_idx = u.idx WHERE c.post_idx=?";
    query = conn.prepareStatement(sql);

    query.setInt(1, postIdxValue);

    result = query.executeQuery();
    
    ArrayList<ArrayList<String>> commentDataList = new ArrayList<ArrayList<String>>();
    while(result.next()){
        String commentIdx = String.valueOf(result.getInt("idx"));
        String user_idx = String.valueOf(result.getInt("user_idx"));
        String commentContents = result.getString("contents");
        String createdAt = result.getString("created_at");
        String updatedAt = result.getString("updated_at");
        String id = result.getString("id");
        String name = result.getString("name");

        ArrayList<String> temp = new ArrayList<String>();

        temp.add("\"" + commentIdx + "\"");
        temp.add("\"" + user_idx + "\"");
        temp.add("\"" + commentContents + "\"");
        temp.add("\"" + createdAt + "\"");
        temp.add("\"" + updatedAt + "\"");
        temp.add("\"" + id + "\"");
        temp.add("\"" + name + "\"");

        commentDataList.add(temp);
    }
%>

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Page</title>
    <link rel="stylesheet" type="text/css" href="../../css/7weeks/nav.css">
    <link rel="stylesheet" type="text/css" href="../../css/7weeks/post.css">
</head>

<body>
    <jsp:include page="nav.jsp"></jsp:include>
    <main>
        <article class="textBox">
            <h1 class="title" id="postTitle"></h1>
            <h2 id="postContent"></h2>
        </article>

        <div class="commentOpen" onclick="commentOpenEvent()">
            <img src="../../img/7weeks/comment.jpg" class="commentImg">
            댓글보기
        </div>

        <div class="commentBoxParent" id="commentBoxParent">
            <div class="commentBoxChild">
                <div class="comment" style="margin-right: 70px">
                    정적데이터입니다.
                    <h3 class="commentSideInfo">작성자 : 이수인</h3>
                    <h3 class="commentSideInfo">작성날짜 : 2024-01-12</h3>
                </div>

            </div>

            <form action="../../jspAction/7weeks/createCommentAction.jsp" class="commentBoxChild"
                id="inputCommentParent" onsubmit="return commentCheckEvent({newComment:true})">
                <input type="hidden" name="postIdx" id="hiddenPostIdxInput">
                <input type="text" placeholder="댓글작성" name="comment" class="comment" id="newCommentInput">
                <input type="submit" class="submitButton" value="작성">
            </form>

            <input type="text" placeholder="수정할 내용" class="comment modifyCommentInput" id="modifyCommentInput">
        </div>
    </main>

    <script src="../../js/7weeks/createCommentElement.js"></script>
    <script src="../../js/7weeks/openBox.js"></script>
    <script src="../../js/7weeks/checkValidity.js"></script>
    <script>
        var sessionUserIdx = "<%=sessionUserIdx%>";
        var postIdxValue = "<%=postIdxValue%>"
        var title = "<%=title%>";
        var contents = "<%=contents%>";
        var commentDataList = <%=commentDataList%>;
        var isLogginIn = <%=isLogginIn%>;
        var loginState = "";

        console.log(commentDataList)
        if (isLogginIn) {
            loginState = "logged";
            document.getElementById('hiddenPostIdxInput').value = postIdxValue;
        } else {
            inputCommentParent.style.display = "none";
            modifyCommentInput.style.display = "none";
            loginState = "loggedOut";
        }

        document.getElementById('postTitle').innerText = title;
        document.getElementById('postContent').innerText = contents;

        for (var i = 0; i < commentDataList.length; i++) {
            createCommentElement(i, postIdxValue, sessionUserIdx, commentDataList);
        }
    </script>
</body>