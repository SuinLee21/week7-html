<%@ page language="java" contentType="text/html" pageEncoding="utf-8" %>

<% 
    request.setCharacterEncoding("utf-8");

    String id = "";
    String pw = "";
    String name = "";
    String birth = "";
    String phoneNum = "";

    boolean isLogginIn = false;

    if(session.getAttribute("idx") != null){
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
    <title>ModifyMyInfo</title>
    <link rel="stylesheet" type="text/css" href="../../css/7weeks/modifyMyInfo.css">
</head>

<body>
    <form action="../../jspAction/7weeks/modifyMyInfoAction.jsp" class="modifyMyInfoForm"
        onsubmit="return checkValidityEvent({id:true, pw:true, name:true, birth:true, phoneNum:true})">
        <input type="text" class="modifyMyInfoFormChild" name="userId" id="userId">
        <input type="text" class="modifyMyInfoFormChild" name="userPw" id="userPw">
        <input type="text" class="modifyMyInfoFormChild" name="userName" id="userName">
        <input type="text" class="modifyMyInfoFormChild" name="userBirth" id="userBirth">
        <input type="text" class="modifyMyInfoFormChild" name="userPhoneNum" id="userPhoneNum">
        <input type="submit" class="modifyMyInfoFormChild" value="수정하기">
    </form>

    <script src="../../js/7weeks/checkValidity.js"></script>
    <script>
        var isLogginIn = <%=isLogginIn%>;

        if (isLogginIn) {
            var id = "<%=id%>";
            var pw = "<%=pw%>";
            var name = "<%=name%>";
            var birth = "<%=birth%>";
            var phoneNum = "<%=phoneNum%>";

            document.getElementById('userId').value = id;
            document.getElementById('userPw').value = pw;
            document.getElementById('userName').value = name;
            document.getElementById('userBirth').value = birth;
            document.getElementById('userPhoneNum').value = phoneNum;
        } else {
            alert('접근 권한이 없습니다.');
            location.href = "blog.jsp";
        }

    </script>
</body>