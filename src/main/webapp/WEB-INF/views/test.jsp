<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<html>
<head>
  <title>Title</title>
  <script src="https://code.jquery.com/jquery-1.11.3.js"></script>
</head>
<body>
<h2>commentTest</h2>

comment: <input type="text" name="comment"><br>
<button id="sendBtn" type="button">SEND</button>
<button id="ModBtn" type="button">수정</button>
<h2>Data From Server :</h2>
<div id="commentList"></div>
<script>
  // let bno = 133;

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
      tmp += '<li data-cno='+comment.cno
      tmp += 'data-pcno='+comment.pcno
      tmp += 'data-bno='+comment.bno +'>'
      tmp += 'commenter=<span class ="commenter">'+comment.commenter + '</span>'
      tmp += 'comment=<span class="commenter">' +comment.comment + '</span>'
      tmp += 'up_date=' +comment.up_date
      tmp += '<button class="delBtn">삭제</button>'
      tmp += '<button class="modBtn">수정</button>'
      tmp += '</li>'
    })

    return tmp+ "</ul>";
  }
</script>
</body>
</html>