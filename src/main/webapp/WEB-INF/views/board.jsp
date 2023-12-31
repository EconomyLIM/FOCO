<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jstl/core_rt" %>
<%@ page session="true"%>
<c:set var="loginId" value="${sessionScope.id}"/>
<c:set var="loginOutLink" value="${loginId=='' ? '/login/login' : '/login/logout'}"/>
<c:set var="loginOut" value="${loginId=='' ? 'Login' : 'ID='+=loginId}"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>FOCO</title>
    <link rel="stylesheet" href="<c:url value='/css/menu.css'/>">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <script src="https://code.jquery.com/jquery-1.11.3.js"></script>
    <style>
        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
            font-family: "Noto Sans KR", sans-serif;
        }
        .container {
            width : 50%;
            margin : auto;
        }
        .writing-header {
            position: relative;
            margin: 20px 0 0 0;
            padding-bottom: 10px;
            border-bottom: 1px solid #323232;
        }
        input {
            width: 100%;
            height: 35px;
            margin: 5px 0px 10px 0px;
            border: 1px solid #e9e8e8;
            padding: 8px;
            background: #f8f8f8;
            outline-color: #e6e6e6;
        }
        textarea {
            width: 100%;
            background: #f8f8f8;
            margin: 5px 0px 10px 0px;
            border: 1px solid #e9e8e8;
            resize: none;
            padding: 8px;
            outline-color: #e6e6e6;
        }
        .frm {
            width:100%;
        }
        .btn {
            background-color: rgb(236, 236, 236); /* Blue background */
            border: none; /* Remove borders */
            color: black; /* White text */
            padding: 6px 12px; /* Some padding */
            font-size: 16px; /* Set a font size */
            cursor: pointer; /* Mouse pointer on hover */
            border-radius: 5px;
        }
        .btn:hover {
            text-decoration: underline;
        }

        #commentList {
            width : 50%;
            margin : auto;
        }
        .menu2 {
            list-style-type: none;
            height: 48px;
            width: 100%;
            background-color: #30426E;
            display: flex;
        }

        ul {
            border:  1px solid rgb(235,236,239);
            border-bottom : 0;
        }

        .menu2 > .menu3 {
            color: lightgray;
            height : 100%;
            width:90px;
            display:flex;
            align-items: center;
        }

        li {
            background-color: #f9f9fa;
            list-style-type: none;
            border-bottom : 1px solid rgb(235,236,239);
            padding : 18px 18px 0 18px;
        }
    </style>
</head>
<body>
<div id="menu">
    <ul class="menu2">
        <li class = "menu3" id="logo">FOCO</li>
        <li class = "menu3" ><a href="<c:url value='/'/>">Home</a></li>
        <li class = "menu3" ><a href="<c:url value='/board/list'/>">Board</a></li>
        <li class = "menu3" ><a href="<c:url value='${loginOutLink}'/>">${loginOut}</a></li>
        <li class = "menu3" ><a href="<c:url value='/registerAdd'/>">Sign in</a></li>
        <li class = "menu3"><a href=""><i class="fa fa-search"></i></a></li>
    </ul>
</div>
<script>
    let msg = "${msg}";
    if(msg=="WRT_ERR") alert("게시물 등록에 실패하였습니다. 다시 시도해 주세요.");
    if(msg=="MOD_ERR") alert("게시물 수정에 실패하였습니다. 다시 시도해 주세요.");
</script>
<div class="container">
    <h2 class="writing-header">게시판 ${mode=="new" ? "글쓰기" : "읽기"}</h2>
    <form id="form" class="frm" action="<c:url value='/board/write'/>" method="get">
        <input type="hidden" name="bno" value="${boardDto.bno}">

        <input name="title" type="text" value="${boardDto.title}" placeholder="  제목을 입력해 주세요." ${mode=="new" ? "" : "readonly='readonly'"}><br>
        <textarea name="content" rows="20" placeholder=" 내용을 입력해 주세요." ${mode=="new" ? "" : "readonly='readonly'"}>${boardDto.content}</textarea><br>

        <c:if test="${mode eq 'new'}">
            <button type="button" id="writeBtn" class="btn btn-write"><i class="fa fa-pencil"></i> 등록</button>
        </c:if>
        <c:if test="${mode ne 'new'}">
            <button type="button" id="writeNewBtn" class="btn btn-write"><i class="fa fa-pencil"></i> 글쓰기</button>
        </c:if>
        <c:if test="${boardDto.writer eq loginId}">
            <button type="button" id="modifyBtn" class="btn btn-modify"><i class="fa fa-edit"></i> 수정</button>
            <button type="button" id="removeBtn" class="btn btn-remove"><i class="fa fa-trash"></i> 삭제</button>
        </c:if>
        <button type="button" id="listBtn" class="btn btn-list"><i class="fa fa-bars"></i> 목록</button>
    </form>
<script>
    $(document).ready(function(){
        let formCheck = function() {
            let form = document.getElementById("form");
            if(form.title.value=="") {
                alert("제목을 입력해 주세요.");
                form.title.focus();
                return false;
            }
            if(form.content.value=="") {
                alert("내용을 입력해 주세요.");
                form.content.focus();
                return false;
            }
            return true;
        }
        $("#writeNewBtn").on("click", function(){
            location.href="<c:url value='/board/write'/>";
        });
        $("#writeBtn").on("click", function(){
            let form = $("#form");
            form.attr("action", "<c:url value='/board/write'/>");
            form.attr("method", "post");
            if(formCheck())
                form.submit();
        });
        $("#modifyBtn").on("click", function(){
            let form = $("#form");
            let isReadonly = $("input[name=title]").attr('readonly');
            // 1. 읽기 상태이면, 수정 상태로 변경
            if(isReadonly=='readonly') {
                $(".writing-header").html("게시판 수정");
                $("input[name=title]").attr('readonly', false);
                $("textarea").attr('readonly', false);
                $("#modifyBtn").html("<i class='fa fa-pencil'></i> 등록");
                return;
            }
            // 2. 수정 상태이면, 수정된 내용을 서버로 전송
            form.attr("action", "<c:url value='/board/modify${searchCondition.queryString}'/>");
            form.attr("method", "post");
            if(formCheck())
                form.submit();
        });
        $("#removeBtn").on("click", function(){
            if(!confirm("정말로 삭제하시겠습니까?")) return;
            let form = $("#form");
            form.attr("action", "<c:url value='/board/remove${searchCondition.queryString}'/>");
            form.attr("method", "post");
            form.submit();
        });
        $("#listBtn").on("click", function(){
            location.href="<c:url value='/board/list${searchCondition.queryString}'/>";
        });
    });

    // //댓글 스크립트
    // let id = 'asdf';
    //
    // let addZero = function(value=1){
    //     return value > 9 ? value : "0"+value;
    // }
    //
    // let dateToString = function(ms=0) {
    //     let date = new Date(ms);
    //
    //     let yyyy = date.getFullYear();
    //     let mm = addZero(date.getMonth() + 1);
    //     let dd = addZero(date.getDate());
    //
    //     let HH = addZero(date.getHours());
    //     let MM = addZero(date.getMinutes());
    //     let ss = addZero(date.getSeconds());
    //
    //     return yyyy+"."+mm+"."+dd+ " " + HH + ":" + MM + ":" + ss;
    // }
    //
    // $(document).ready(function(){
    //     $("a.btn-write").click(function(e){
    //         let target = e.target;
    //         let cno = target.getAttribute("data-cno")
    //         let bno = target.getAttribute("data-bno")
    //
    //         let repForm = $("#reply-writebox");
    //         repForm.appendTo($("li[data-cno="+cno+"]"));
    //         repForm.css("display", "block");
    //         repForm.attr("data-pcno", pcno);
    //         repForm.attr("data-bno",  bno);
    //     });
    //
    //     $("#btn-cancel-reply").click(function(e){
    //         $("#reply-writebox").css("display", "none");
    //     });
    //
    //     $("a.btn-modify").click(function(e){
    //         let target = e.target;
    //         let cno = target.getAttribute("data-cno");
    //         let bno = target.getAttribute("data-bno");
    //         let pcno = target.getAttribute("data-pcno");
    //         let li = $("li[data-cno="+cno+"]");
    //         let commenter = $(".commenter", li).first().text();
    //         let comment = $(".comment-content", li).first().text();
    //
    //         $("#modalWin .commenter").text(commenter);
    //         $("#modalWin textarea").text(comment);
    //         $("#btn-write-modify").attr("data-cno", cno);
    //         $("#btn-write-modify").attr("data-pcno", pcno);
    //         $("#btn-write-modify").attr("data-bno", bno);
    //
    //         // 팝업창을 열고 내용을 보여준다.
    //         $("#modalWin").css("display","block");
    //     });
    //
    //     $("a.btn-delete").click(function(e){
    //         alert("delete");
    //     });
    //
    //     $("#btn-write-modify").click(function(){
    //         // 1. 변경된 내용을 서버로 전송
    //         // 2. 모달 창을 닫는다.
    //         $(".close").trigger("click");
    //     });
    //
    //     $(".close").click(function(){
    //         $("#modalWin").css("display","none");
    //     });
    // });
</script>
    comment: <input type="text" name="comment"><br>
    <button id="sendBtn" type="button">SEND</button>
    <button id="ModBtn" type="button">수정</button>

    <div id="commentList">
        <table>
            <tr>
                <th class="title">내용</th>
                <th class="writer">이름</th>
                <th class="regdate">등록일</th>
            </tr>

        </table>
    </div>


    <script>
        let bno = 133;

        let showlist = function (bno){
            $.ajax({
                type:'GET',       // 요청 메서드
                url: '/FOCO_war_exploded/comments?bno='+bno,  // 요청 URI
                success : function(result){
                    $("#commentList").html(toHtml(result));    // 서버로부터 응답이 도착하면 호출될 함수
                },
                error   : function(){ alert("error") } // 에러가 발생했을 때, 호출될 함수
            }); // $.ajax()

        }
        $(document).ready(function(){

            showlist(bno);

            // $("#ModBtn").click(function(){
            //   let cno = $(this).attr("data-cno");
            //   let comment = $("input[name=comment]").val();
            //
            //   if(comment.trim()==''){
            //     alert("댓글을 입력해주세요");
            //     $("input[name=comment]").focus()
            //     return;
            //   }
            //
            //   $.ajax({
            //     type:'PATCH',       // 요청 메서드
            //     url: '/FOCO_war_exploded/comments?cno='+cno,  // 요청 URI
            //     headers : { "content-type": "application/json"}, // 요청 헤더
            //     data : JSON.stringify({cno:cno, comment:comment}),  // 서버로 전송할 데이터. stringify()로 직렬화 필요.
            //     success : function(result){
            //       alert(result);
            //       showlist(bno);
            //     },
            //     error   : function(){ alert("error") } // 에러가 발생했을 때, 호출될 함수
            //   }); // $.ajax()


            $("#sendBtn").click(function(){

                let comment = $("input[name=comment]").val();

                if(comment.trim()==''){
                    alert("댓글을 입력해주세요");
                    $("input[name=comment]").focus()
                    return;
                }

                $.ajax({
                    type:'POST',       // 요청 메서드
                    url: '/FOCO_war_exploded/comments?bno='+bno,  // 요청 URI
                    headers : { "content-type": "application/json"}, // 요청 헤더
                    data : JSON.stringify({bno:bno, comment:comment}),  // 서버로 전송할 데이터. stringify()로 직렬화 필요.
                    success : function(result){
                        alert(result);
                        showlist(bno);
                    },
                    error   : function(){ alert("error") } // 에러가 발생했을 때, 호출될 함수
                }); // $.ajax()
            });

            $("#commentList").on("click", ".ModBtn", function(){

                let cno = $(this).parent().attr("data-cno");
                let comment = $("span.comment", $(this).parent()).text();

                //1.comment의 내용을 input에 뿌리기
                $("input[name=comment]").val(comment);
                //2. cno전달하기
                $("#ModBtn").attr("data-cno", cno);
            });
        });

        $("#commentList").on("click", ".delBtn", function(){

            let cno = $(this).parent().attr("data-cno");
            let bno = $(this).parent().attr("data-bno");

            $.ajax({
                type:'DELETE',       // 요청 메서드
                url: '/FOCO_war_exploded/comments?cno='+cno+'&bno='+bno,  // 요청 URI
                success : function(result){
                    alert(result)
                    showlist(bno);
                },
                error   : function(){ alert("error") } // 에러가 발생했을 때, 호출될 함수
            }); // $.ajax()
        });


        let toHtml = function (comments){
            let tmp = "<ul>";

            comments.forEach(function (comment){
                tmp += '<h3 data-cno='+comment.cno
                tmp += 'data-pcno='+comment.pcno
                tmp += 'data-bno='+comment.bno +'>'
                tmp += '<span class ="commenter">'+comment.commenter + '</span><br>'
                tmp += '<span class="commenter">' +comment.comment + '</span><br>'
                tmp +=  '<span style="font-size: small">' + comment.up_date +'</span>'
                tmp += '<button class="delBtn">삭제</button>'
                tmp += '<button class="modBtn">수정</button>'
                tmp += '</h3>'
            })

            return tmp+ "</ul>";
        }

    </script>
</body>
</html>