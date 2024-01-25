<%@ page language="java" contentType="text/html" pageEncoding="utf-8" %>

<%
    boolean isLogginIn = false;

    if(session.getAttribute("idx") != null){
        isLogginIn = true;
    }else{
        isLogginIn = false;
    }
%>

<nav>
    <a href="blog.jsp">
        <img src="../../img/7weeks/home.jpg" class="homeImg">
    </a>
    <img src="../../img/7weeks/info.jpg" class="navInfoImg" id="navInfoImg" onclick="openNavInfoBoxEvent()">
    <img src="../../img/7weeks/my.jpg" class="navMyImg" id="navMyImg" onclick="openNavMyBoxEvent()">
</nav>

<div class="loggedOutNavMyBox" id="loggedOutNavMyBox">
    로그인 후 이용가능합니다.
</div>
<div class="loggedNavMyBox" id="loggedNavMyBox">
    <a href="myInfo.jsp">
        <div class="myBoxDiv">내정보 보기</div>
    </a>
    <a href="modifyMyInfo.jsp">
        <div class="myBoxDiv">내정보 수정</div>
    </a>
</div>

<div class="navInfoBox" id="loggedOutNavInfoBox">
    <a href="login.html" class="infoBoxButton">로그인</a>
    <a href="signUp.html" class="infoBoxButton">회원가입</a>
</div>
<div class="navInfoBox" id="loggedNavInfoBox">
    <a href="../../jspAction/7weeks/logoutAction.jsp" class="infoBoxButton">로그아웃</a>
    <a href="../../jspAction/7weeks/withdrawalAction.jsp" class="infoBoxButton">회원탈퇴</a>
</div>

<%-- <script>
    var isLogginIn = <%=isLogginIn%>;
    var loginState = "";

    if(isLogginIn){
        loginState = "logged";
    }else{
        loginState = "loggedOut";
    }
</script> --%>