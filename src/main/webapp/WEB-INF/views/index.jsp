<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page session="false" %>
<c:set var="loginId"
       value="${pageContext.request.getSession(false)==null ? '' : pageContext.request.session.getAttribute('id')}"/>
<c:set var="loginOutLink" value="${loginId=='' ? '/login/login' : '/login/logout'}"/>
<c:set var="loginOut" value="${loginId=='' ? 'Login' : 'ID='+=loginId}"/>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha2/dist/css/bootstrap.min.css"
      rel="stylesheet"
      integrity="sha384-aFq/bzH65dt+w6FI2ooMVUpc+21e0SRygnTpmBvdBgSdnuTN7QbdgL+OapgHtvPp"
      crossorigin="anonymous">
<link href="https://hangeul.pstatic.net/hangeul_static/css/nanum-square-round.css" rel="stylesheet">
<script src="https://code.jquery.com/jquery-1.11.3.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha2/dist/js/bootstrap.bundle.min.js"></script>
<!DOCTYPE html>
<html>
<style>
    * {
        box-sizing: border-box;
        margin: 0;
        padding: 0;
        font-family: 'NanumSquareRound';
    }

    a {
        text-decoration: none;
        color: black;
    }

    button,
    input {
        border: none;
        outline: none;
    }

    .board-container {
        width: 60%;
        height: 1200px;
        margin: 0 auto;
        /* border: 1px solid black; */
    }

    .search-container {
        background-color: rgb(253, 253, 250);
        width: 100%;
        height: 110px;
        border: 1px solid #ddd;
        margin-top: 50px;
        margin-bottom: 30px;
        display: flex;
        justify-content: center;
        align-items: center;
    }

    .search-form {
        height: 37px;
        display: flex;
    }

    .search-option {
        width: 100px;
        height: 100%;
        outline: none;
        margin-right: 5px;
        border: 1px solid #ccc;
        color: gray;
    }

    .search-option > option {
        text-align: center;
    }

    .search-input {
        color: gray;
        background-color: white;
        border: 1px solid #ccc;
        height: 100%;
        width: 300px;
        font-size: 15px;
        padding: 5px 7px;
    }

    .search-input::placeholder {
        color: gray;
    }

    .search-button {
        /* 메뉴바의 검색 버튼 아이콘  */
        width: 20%;
        height: 100%;
        background-color: rgb(22, 22, 22);
        color: rgb(209, 209, 209);
        display: flex;
        align-items: center;
        justify-content: center;
        font-size: 15px;
    }

    .search-button:hover {
        color: rgb(165, 165, 165);
    }

    table {
        border-collapse: collapse;
        width: 100%;
        border-top: 2px solid rgb(39, 39, 39);
    }

    tr:nth-child(even) {
        background-color: #f0f0f070;
    }

    th,
    td {
        width: 300px;
        text-align: center;
        padding: 10px 12px;
        border-bottom: 1px solid #ddd;
    }

    td {
        color: rgb(53, 53, 53);
        text-align: center;
    }

    .no {
        width: 150px;
    }

    .title {
        width: 50%;
    }

    /*td.title   { text-align: left;  }*/
    /*td.writer  { text-align: left;  }*/
    /*td.viewcnt { text-align: right; }*/
    td.title:hover {
        text-decoration: underline;
    }

    .paging {
        color: black;
        width: 100%;
        align-items: center;
    }

    .page {
        color: black;
        padding: 6px;
        margin-right: 10px;
    }

    .paging-active {
        background-color: rgb(216, 216, 216);
        border-radius: 5px;
        color: rgb(24, 24, 24);
    }

    .paging-container {
        width: 100%;
        height: 70px;
        display: flex;
        margin-top: 50px;
        margin: auto;
    }

    .btn-write {
        background-color: rgb(236, 236, 236); /* Blue background */
        border: none; /* Remove borders */
        color: black; /* White text */
        padding: 6px 12px; /* Some padding */
        font-size: 16px; /* Set a font size */
        cursor: pointer; /* Mouse pointer on hover */
        border-radius: 5px;
        margin-left: 30px;
    }

    .btn-write:hover {
        text-decoration: underline;
    }

    .newsapi {
        font-size: medium;
        display: flex;
        align-items: center;
        background-color: #f8f8f8;
        width: inherit;
        border-radius: 10px;

    }

    img {
        display: block;

        float: left;
        border-radius: 10px;
    }

    article {
        text-align: center;
        line-height: 150px;
        width: 480px;
        height: 500px;
        border-radius: 10px;
        background-color: white;
        margin: 0 auto;
        margin-bottom: 25px;
    }

    .newsapi a:hover {
        background-color: white;
        color: white;
    }

    strong {
        color: black;
    }

    /*dropdown메뉴*/
    .submenu {
        display: none;
    }

    .menubar li:hover .submenu {
        display: block;
    }

    .question {
        width: 40%;
        float: right;
    }

    .information {
        width: 40%;
    }
    .culture {
        font-size: medium;

        align-items: center;
        background-color: #f8f8f8;
        width: inherit;
        border-radius: 10px;

    }
    .culture a:hover {
        background-color: white;
        color: white;
    }

</style>
<head>
    <meta charset="UTF-8">
    <title>FOCO</title>
    <%--    <link rel="stylesheet" href="<c:url value='/css/menu.css'/>">--%>
    <link rel="stylesheet" href="<c:url value='/css/stylepractice.css'/>">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css"/>
</head>
<body>
<div class="menu clearfix">
    <ul class="menubar clearfix">
        <li id="logo">FOCO</li>
        <li><a href="<c:url value='/'/>">Home</a></li>
        <li><a href="<c:url value='/board/list'/>" class="drop clearfix">Board</a>
            <ul class="submenu">
                <li><a href="<c:url value='/board/list'/>">koboard</a></li>
                <li><a href="#">enboard</a></li>
                <li><a href="#">jpboard</a></li>
                <li><a href="#">chboard</a></li>
                <li><a href="#">twboard</a></li>
            </ul>
        </li>
        <li><a href="<c:url value='${loginOutLink}'/>">${loginOut}</a></li>
        <li><a href="<c:url value='/registerAdd'/>">Sign in</a></li>
        <li><a href=""><i class="fa fa-search"></i></a></li>
    </ul>
</div>
<div class="wrap">
    <div class="box1 clearfix">
        <div class="search-container">
            <form action="<c:url value="/board/list"/>" class="search-form" method="get">
                <select class="search-option" name="option">
                    <option value="A" ${option=='A' ? "selected" : ""}>title+content</option>
                    <option value="T" ${option=='T' ? "selected" : ""}>title</option>
                    <option value="W" ${option=='W' ? "selected" : ""}>Writer</option>
                </select>

                <input type="text" name="keyword" class="search-input" type="text" value="${param.keyword}"
                       placeholder="Please enter a search term">
                <input type="submit" class="search-button" value="Search">
            </form>
            <button id="writeBtn" class="btn-write" onclick="location.href='<c:url value="/board/write"/>'"><i
                    class="fa fa-pencil"></i> write
            </button>
        </div>
        <h3>Free</h3>
        <table>
            <tr>
                <th class="no">no</th>
                <th class="title">Title</th>
                <th class="writer">Name</th>
                <th class="Country">Country</th>
                <th class="regdate">Register Date</th>
                <th class="viewcnt">Count View</th>
            </tr>
            <c:forEach var="boardDto" items="${list}">
                <tr>
                    <td class="no">${boardDto.bno}</td>
                    <td class="title"><a
                            href="<c:url value="/board/read?bno=${boardDto.bno}&page=${ph.page}&pageSize=${ph.pageSize}"/>">${boardDto.title}</a>
                    </td>
                    <td class="writer">${boardDto.writer}</td>
<%--                    <td class="writer">${boardDto.Country}</td>--%>
                    <td> </td>
                    <c:choose>
                        <c:when test="${boardDto.reg_date.time >= startOfToday}">
                            <td class="regdate"><fmt:formatDate value="${boardDto.reg_date}" pattern="HH:mm"
                                                                type="time"/></td>
                        </c:when>
                        <c:otherwise>
                            <td class="regdate"><fmt:formatDate value="${boardDto.reg_date}" pattern="yyyy-MM-dd"
                                                                type="date"/></td>
                        </c:otherwise>
                    </c:choose>
                    <td class="viewcnt">${boardDto.view_cnt}</td>
                </tr>
            </c:forEach>
        </table>
        <br>
        <div class="paging-container">
            <div class="paging">
                <c:if test="${totalCnt==null || totalCnt==0}">
                    <%--                    <div> 게시물이 없습니다. </div>--%>
                </c:if>
                <c:if test="${totalCnt!=null && totalCnt!=0}">
                    <c:if test="${ph.showPrev}">
                        <a class="page" href="<c:url value="/board/list?page=${ph.beginPage-1}"/>">&lt;</a>
                    </c:if>
                    <c:forEach var="i" begin="${ph.beginPage}" end="${ph.endPage}">
                        <a class="page ${i==ph.page? "paging-active" : ""}"
                           href="<c:url value="/board/list?page=${i}"/>">${i}</a>
                    </c:forEach>
                    <c:if test="${ph.showNext}">
                        <a class="page" href="<c:url value="/board/list?page=${ph.endPage+1}"/>">&gt;</a>
                    </c:if>
                </c:if>
            </div>
        </div>

        <div class="question">
            <h3>Question</h3>
            <table class="question1">
                <tr>
                    <th class="no">No</th>
                    <th class="title">Title</th>
                    <th class="writer">Name</th>

                </tr>
                <c:forEach var="boardDto" items="${list}" varStatus="status">
                    <c:if test="${status.index >= 7}">
                        <tr>
                            <td class="no">${boardDto.bno}</td>
                            <td class="title"><a
                                    href="<c:url value="/board/read?bno=${boardDto.bno}&page=${ph.page}&pageSize=${ph.pageSize}"/>">${boardDto.title}</a>
                            </td>
                            <td class="writer">${boardDto.writer}</td>


                        </tr>
                    </c:if>
                </c:forEach>
            </table>
        </div>
        <div class="information">
            <h3>Infomation</h3>
            <table class="infomation1">
                <tr>
                    <th class="no">No</th>
                    <th class="title">Title</th>
                    <th class="writer">Name</th>

                </tr>
                <c:forEach var="boardDto" items="${list}" varStatus="status">
                    <c:if test="${status.index >= 4}">
                        <tr>
                            <td class="no">${boardDto.bno}</td>
                            <td class="title"><a
                                    href="<c:url value="/board/read?bno=${boardDto.bno}&page=${ph.page}&pageSize=${ph.pageSize}"/>">${boardDto.title}</a>
                            </td>
                            <td class="writer">${boardDto.writer}</td>


                        </tr>
                    </c:if>
                </c:forEach>
            </table>

        </div>
    </div>
</div>
<div class="box2 clearfix">
    <!-- 환율 -->
    <ul class="money">
        <li><img src="<c:url value='/img/us.png' />" alt="america"></li>
        <li><a class="USD">&#8361;</a></li>
        <li><img src="<c:url value='/img/jp.png' />" alt="jpan"></li>
        <li><a class="JPY">&#8361;</a></li>
        <li><img src="<c:url value='/img/ch.png' />" alt="china"></li>
        <li><a class="CNH">&#8361;</a></li>
        <li><img src="<c:url value='/img/eu.png' />" alt="eu"></li>
        <li><a class="EUR">&#8361;</a></li>
    </ul>


    <!-- 아티클 -->
    <article>
        <!-- 뉴스 -->
        <h3>Head Lines</h3>
        <h3 id="newsapi0" class="newsapi"></h3>
        <h3 id="newsapi1" class="newsapi"></h3>
        <h3 id="newsapi2" class="newsapi"></h3>


    </article>
    <!--  어사이드 -->
    <aside>
        <%--        취업정보--%>
        <h3>Culture</h3>
        <h3 id="culture0" class="culture"></h3>
        <h3 id="culture1" class="culture"></h3>
        <h3 id="culture2" class="culture"></h3>
        <h3 id="culture3" class="culture"></h3>
        <h3 id="culture4" class="culture"></h3>
    </aside>
</div>
</div>
<script src="https://code.jquery.com/jquery-3.5.1.js"
        integrity="sha256-QWo7LDvxbWT2tbbQ97B53yJnYU3WhH/C8ycbRAkjPDc=" crossorigin="anonymous"></script>
<script>
    $.ajax({
        method: "GET",
        url: "https://www.koreaexim.go.kr/site/program/financial/exchangeJSON?authkey=WewAmYPBjl4ndM1RltNdsGO0Mk0cyBTV&searchdate=20230328&data=AP01",
        dataType: "json"


    })
        .done(function (msg) {

            console.log(msg);
            console.log(msg[22].bkpr);
            console.log(msg[12].bkpr);
            console.log(msg[6].bkpr);
            console.log(msg[21].bkpr);
            $('.USD').append("<strong>" + msg[22].bkpr + "</strong>");
            $('.JPY').append("<strong>" + msg[12].bkpr + "</strong>");
            $('.CNH').append("<strong>" + msg[6].bkpr + "</strong>");
            $('.EUR').append("<strong>" + msg[8].bkpr + "</strong>");
        });
</script>
<script>
    $.ajax({
        type: "GET",
        url: `https://newsapi.org/v2/everything?q=mongol&apiKey=1a2e4a006c4642098b1fe591f2e54d3e`,
        data: {},

        success: function (response) {
            console.log(response);

            for (var i = 0; i < 3; i++) {
                $("#newsapi" + i).append(
                    "<img src='" + response.articles[i].urlToImage
                    + "'  height='140' width='140'/>" +
                    "<a href='" +
                    response.articles[i].url +
                    "'/>" +
                    "<strong>" +
                    response.articles[i].title +
                    "</strong> </a>" + "<br>"
                );

            }

        },
    });
</script>
<script>
    $.ajax({
        type: "GET",
        url: `http://api.kcisa.kr/openapi/service/rest/convergence/conver8?serviceKey=ea59e6c2-0eb4-4283-a86b-cee8992fc0c0&numOfRows=10&pageNo=1`,
        data: {},
        dataType: "json",
        success: function (test) {
            console.log(test);

            for (var i = 0; i < 5; i++) {
                $("#culture" + i).append(
                    "Title: " + test.response.body.items.item[i].title + "<br>Category:" + test.response.body.items.item[i].subjectCategory + "<br>지역: " + test.response.body.items.item[i].creator

                );

            }


        },
    });
</script>
<%--<script>--%>

<%--    $(document).ready(function(){--%>

<%--        $('#drop .submenu').hide();--%>

<%--        $('#drop').mouseover(function(){--%>
<%--            $('.submenu').slideDown();--%>

<%--        });--%>
<%--        $('.submenu').mouseleave(function(){--%>
<%--            $('.submenu').hide();--%>
<%--        });--%>
<%--    });--%>

<%--</script>--%>


</body>
</htm