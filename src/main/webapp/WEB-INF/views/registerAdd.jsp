<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<c:set var="loginId" value="${pageContext.request.getSession(false)==null ? '' : pageContext.request.session.getAttribute('id')}"/>
<c:set var="loginOutLink" value="${loginId=='' ? '/login/login' : '/login/logout'}"/>
<c:set var="loginOut" value="${loginId=='' ? 'Login' : 'ID='+=loginId}"/>
<script src="https://code.jquery.com/jquery-3.4.1.js"></script>
<style>
    * { box-sizing:border-box; }
    .form1 {
        width:133px;
        height:800px;
        display : flex;
        flex-direction: column;
        align-items:center;
        position : absolute;
        top:50%;
        left:50%;
        transform: translate(-50%, -50%) ;
        border: 1px solid rgb(89,117,196);
        border-radius: 10px;
    }
    .form2 {
        width:133px;
        height:800px;
        display : flex;
        flex-direction: column;
        align-items:center;
        position : absolute;
        top:50%;
        left:50%;
        transform: translate(-50%, -50%) ;
        border: 1px solid rgb(89,117,196);
        border-radius: 10px;
    }
    .form3 {
        width:133px;
        height:800px;
        display : flex;
        flex-direction: column;
        align-items:center;
        position : absolute;
        top:50%;
        left:50%;
        transform: translate(-50%, -50%) ;
        border: 1px solid rgb(89,117,196);
        border-radius: 10px;
    }
    .input-field {
        width: 300px;
        height: 40px;
        border : 1px solid rgb(89,117,196);
        border-radius:5px;
        padding: 0 10px;
        margin-bottom: 10px;
    }
    label {
        width:300px;
        height:30px;
        margin-top :4px;
    }
    button {
        background-color: rgb(89,117,196);
        color : white;
        width:300px;
        height:50px;
        font-size: 17px;
        border : none;
        border-radius: 5px;
        margin : 20px 0 30px 0;
    }
    .title {
        font-size : 50px;
        margin: 40px 0 30px 0;
    }
    .msg {
        height: 30px;
        text-align:center;
        font-size:16px;
        color:red;
        margin-bottom: 20px;
    }
    .sns-chk {
        margin-top : 5px;
    }
</style>
<html>
<head>
    <meta charset="UTF-8">
    <title>FOCO</title>
    <link rel="stylesheet" href="<c:url value='/css/menu.css'/>">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css"/>
</head>
<body>
<div id="menu">
    <ul>
        <li id="logo">FOCO</li>
        <li><a href="<c:url value='/'/>">Home</a></li>
        <li><a href="<c:url value='/board/list'/>">Board</a></li>
        <li><a href="<c:url value='${loginOutLink}'/>">${loginOut}</a></li>
        <li><a href="<c:url value='/registerAdd'/>">Sign in</a></li>
        <li><a href=""><i class="fa fa-search"></i></a></li>
    </ul>
</div>


<div class="title">Register</div>
<div id="msg1" class="msg">
</div>


<form action="<c:url value="/registerAdd/add"/>" method="post">
    <div class="title">Register</div>
    <div id="msg" class="msg">
    </div>

    <label for="">E-mail</label>
    <input class="input-field" id="userEmail1" type="text" name="email" placeholder="example@universe.ac.kr">
    <button id="com_Button">Send authentication number</button>


    <label for="">Authentication number</label>

    <input class="input-field" id="mail-check-input" type="text" name="id" placeholder="Authentication number">
    <button id="mail-Check-Btn">Verification of authentication number</button>
    <div>
        <span class="point successEmailChk">email check</span>
    </div>


    <label for="">Name</label>
    <input class="input-field" type="text" id="username" name="name" placeholder="name" required>
    <label for="">Password</label>
    <input class="input-field" type="password" id="password" name="pwd" placeholder="pasasword" required>
    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />

    <label for="">Language</label>
    <select name = "Country", id = "Country">
        <option value="Korea">한국어</option>
        <option value="America">English</option>
        <option value="China">中文</option>
        <option value="Japan">日語</option>
        <option value="Vietnam">Tiếng Việt</option>
        <option value="Mongol">Mongol</option>
    </select>

    <button type="submit" id="submitBtn" >Sign On</button>
</form>
<div>
    <span class="point successEmailChk">email check</span>
</div>




<script>
    function formCheck(frm) {
        let msg ='';
        if(frm.id.value.length<3) {
            setMessage('id의 길이는 3이상이어야 합니다.', frm.id);
            return false;
        }
        if(frm.pwd.value.length<3) {
            setMessage('pwd의 길이는 3이상이어야 합니다.', frm.pwd);
            return false;
        }

        return true;
    }
    function setMessage(msg, element){
        document.getElementById("msg").innerHTML = `<i class="fa fa-exclamation-circle"> '${msg}'</i>`;
        if(element) {
            element.select();
        }
    }

    $('#com_Button').click(function() {
        const eamil = $('#userEmail1').val(); // 이메일 주소값 얻어오기!
        console.log('완성된 이메일 : ' + eamil); // 이메일 오는지 확인

        const checkInput = $('.mail-check-input') // 인증번호 입력하는곳

        $.ajax({
            type : 'POST',
            url : '<c:url value ="/mailCheck?email="/>'+eamil, // GET방식이라 Url 뒤에 email을 뭍힐수있다.

            async: false,
            success : function (data) {
                console.log("data : " +  data);
                // checkInput.attr('disabled',false);
                code = data;
                alert("인증번호가 전송되었습니다.")

            },
            error: function (){
                console.log("error");
            },
            faii:function (){
                console.log("fail");
            }


        }); // end ajax
    }); // end send eamil

    // 인증번호 비교
    // blur -> focus가 벗어나는 경우 발생
    $('#mail-check-input').blur(function () {
        const inputCode = $(this).val();
        const $resultMsg = $("#mail-check-warn");

        if (inputCode === code) {
            console.log("인증번호 일치");
            $(".successEmailChk").text("인증번호가 일치합니다.");
            $(".successEmailChk").css("color", "green");

            $resultMsg.html("인증번호가 일치합니다.");
            $resultMsg.css('color', 'green');
            $('#mail-Check-Btn').attr('disabled', true);
            $('#userEamil1').attr('readonly', true);

            $("#submitBtn").click(function () {
            });
            $("#country").change(function() {
                checkForm();
            });

            $("#username, #password").on("input", checkForm);


            // function checkForm() {
            //     if($("#username").val() != "" && $("#password").val() != "" && $("#country").val() != "") {
            //         $("#submitBtn").prop("disabled", false);
            //         $("#submitBtn").css("background-color", "red");
            //         console.log("회원가입 완료");
            //         $('#submitBtn').click(function (){
            //             alert("버튼 눌림")
            //
            //         });
            //     } else {
            //         $("#submitBtn").prop("disabled", true);
            //         $("#submitBtn").css("background-color", "black");
            //     }
            // }


            // $('#userEamil2').attr('readonly',true);
            // $('#userEmail2').attr('onFocus', 'this.initialSelect = this.selectedIndex');
            // $('#userEmail2').attr('onChange', 'this.selectedIndex = this.initialSelect');
        }else{
            $(".successEmailChk").text("인증번호가 일치하지 않습니다. 확인해주시기 바랍니다.");
            $(".successEmailChk").css("color","red");
            $resultMsg.html("인증번호가 불일치 합니다. 다시 확인해주세요!.");
            $resultMsg.css('color','red');
            console.log("인증번호 불일치");
        }
    });
</script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
    //     $(document).ready(function() {
    //     // 이메일 검증 버튼 클릭 이벤트 처리
    //     $("#verifyEmailBtn").click(function() {
    //         // 이곳에서 이메일 검증 코드 작성
    //         // 이메일이 유효하다면 가입 버튼 활성화
    //         $("#submitBtn").prop("disabled", false);
    //     });
    //
    //     // 가입 버튼 클릭 이벤트 처리
    //     $("#submitBtn").click(function() {
    //     // 이곳에서 가입 양식 제출 코드 작성
    //     // 예를 들어, AJAX 요청을 서버에 전송하여 가입 데이터 저장
    // });

    // 사용자 이름과 비밀번호 입력란이 모두 채워졌는지 확인
</script>

</body>

</html>