<%@ page language="java" contentType="text/html" pageEncoding="utf-8" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.util.ArrayList" %>

<% 
    request.setCharacterEncoding("utf-8");

    String sessionUserIdx = "";
    boolean isLogginIn = false;

    if(session.getAttribute("idx") != null){
        sessionUserIdx = String.valueOf(session.getAttribute("idx"));
        isLogginIn = true;
    }else{
        sessionUserIdx = null;
    }

    Class.forName("com.mysql.jdbc.Driver");
    Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/web", "suin", "suin");

    String sql = "SELECT p.idx, p.user_idx, p.title, p.contents, p.created_at, p.updated_at, u.id, u.name FROM post p INNER JOIN user u ON p.user_idx = u.idx";
    PreparedStatement query = conn.prepareStatement(sql);

    ResultSet result = query.executeQuery();

    ArrayList<ArrayList<String>> postDataList = new ArrayList<ArrayList<String>>();
    while(result.next()){
        String postIdx = String.valueOf(result.getInt("idx")); 
        String user_idx = String.valueOf(result.getInt("user_idx")); 
        String title = result.getString("title"); 
        String contents = result.getString("contents");
        String createdAt = result.getString("created_at");
        String updatedAt = result.getString("updated_at");
        String id = result.getString("id");
        String name = result.getString("name");

        ArrayList<String> temp = new ArrayList<String>();
        temp.add("\"" + postIdx + "\"");
        temp.add("\"" + user_idx + "\"");
        temp.add("\"" + title + "\"");
        temp.add("\"" + contents + "\"");
        temp.add("\"" + createdAt + "\"");
        temp.add("\"" + updatedAt + "\"");
        temp.add("\"" + id + "\"");
        temp.add("\"" + name + "\"");

        postDataList.add(temp);
    }
%>

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Home</title>
    <link rel="stylesheet" type="text/css" href="../../css/7weeks/blog.css">
    <link rel="stylesheet" type="text/css" href="../../css/7weeks/nav.css">
</head>

<body>
    <jsp:include page="nav.jsp"></jsp:include>
    <main>
        <a href="createPost.html">
            <img src="../../img/7weeks/plus.jpg" class="plusImg" id="plusImg">
        </a>
        <section class="postBoxParent" id="postBoxParent">
            <article class="postBox" id="post0">
                <a class="postLink" href="post.jsp?postIdx=3">
                    <div>
                        <h1 class="postTitle">정적데이터입니다.</h1>
                        <h2 class="postContents">제곧내</h2>
                        <p class="postSideInfo">작성자 : 이수인</p>
                        <p class="postSideInfo">작성날짜 : 2024-01-12</p>
                        <p class="postSideInfo">수정날짜 : 2024-01-12</p>
                    </div>
                </a>
            </article>
        </section>
    </main>

    <script src="../../js/7weeks/createPostElement.js"></script>
    <script>
        var postDataList = <%=postDataList%>;
        var sessionUserIdx = "<%=sessionUserIdx%>";
        var isLogginIn = <%=isLogginIn%>;
        var loginState = "";
        var plusImgId = document.getElementById('plusImg');

        if (isLogginIn) {
            loginState = "logged";
        } else {
            loginState = "loggedOut";
            plusImgId.style.display = "none";
        }

        for (var i = 0; i < postDataList.length; i++) {
            createPostElement(i, sessionUserIdx, postDataList);
        }
    </script>
    <script src="../../js/7weeks/openBox.js"></script>
</body>