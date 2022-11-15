<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>팜스토리::메인</title>
    <link rel="stylesheet" href="/FarmStory3/css/style.css">
    <link rel="stylesheet" href="/FarmStory3/user/css/style.css">
    <link rel="stylesheet" href="/FarmStory3/board/css/style.css"/>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
    <!--
        날짜 : 2022/11/14
        이름 : 박종협
        내용 : 팜스토리 실습
    -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
    <script>
            $(function(){
            
            let slides = $('.slider > div > img');

            let i = 0;

            setInterval(()=>{

                slides.eq(i).animate({'left':'-100%'}, 1000);
                i++;

                if(i >= 3){
                    i=0;
                }
                slides.eq(i).css('left','100%').animate({'left':'0'}, 1000);
            }, 3000);
        });
    </script>
</head>
<body>
    <div id="wrapper">
        <header>
            <a href="/FarmStory3/index.jsp" class="logo"><img src="/FarmStory3/img/logo.png" alt="logo"></a>
            <img src="/FarmStory3/img/head_txt_img.png" alt="txt">
            <img src="/FarmStory3/img/head_menu_badge.png" alt="badge">
            <ul class="reg">
                <li><a href="/FarmStory3/">HOME |</a></li>
                <li><a href="/FarmStory3/user/login.jsp">로그인 |</a></li>
                <li><a href="/FarmStory3/user/terms.jsp">회원가입 |</a></li>
                <li><a href="#">고객센터</a></li>
            </ul>
            <ul class="gnb">
                <li><a href="/FarmStory3/introduction/hello.jsp"></a></li>
                <li><a href="/FarmStory3/board/list.jsp?group=market&cate=market"></a></li>
                <li><a href="/FarmStory3/board/list.jsp?group=croptalk&cate=story"></a></li>
                <li><a href="/FarmStory3/board/list.jsp?group=event&cate=event"></a></li>
                <li><a href="/FarmStory3/board/list.jsp?group=community&cate=notice"></a></li>
            </ul>
        </header>