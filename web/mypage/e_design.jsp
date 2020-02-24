<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    request.setCharacterEncoding("UTF-8");
    response.setCharacterEncoding("UTF-8");

    String article_noStr  = request.getParameter("article_no");
%>
<!DOCTYPE html>
<html lang="en" dir="ltr">
  <head>
    <meta charset="utf-8">
    <title>デザイン選択画面</title>
    <link rel="stylesheet" href="../css/bootstrap.css">
    <link rel="stylesheet" href="../css/common.css">
    <link rel="stylesheet" href="../css/all.css">
    <link rel="stylesheet" href="../css/slick.css">
    <link rel="stylesheet" href="../css/slick-theme.css">
  </head>
  <body>
    <div class="container-fluid bg-slider">
      <div class="col-2 pt-3 position-fixed">
        <a href="../home.jsp"><div class="col-8 text-center menu_item"><i class="fas fa-home logo"></i><div class="menu_name">HOME</div></div></a>
        <a href="mypage.jsp"><div class="col-8 text-center menu_item"><i class="fas fa-user logo"></i><div class="menu_name">MYPAGE</div></div></a>
        <a href="../favorite/favorite.jsp"><div class="col-8 text-center menu_item"><i class="fas fa-paw logo"></i><div class="menu_name">FAVORITE</div></div></a>
        <a href="../post/p_design.jsp"><div class="col-8 text-center menu_item"><i class="fas fa-edit logo"></i><div class="menu_name">POST</div></div></a>
        <a href="../archive/archive.jsp"><div class="col-8 text-center menu_item"><i class="fas fa-archive logo"></i><div class="menu_name">ARCHIVE</div></div></a>
        <a href="../rank/rank_hit.jsp"><div class="col-8 text-center menu_item"><i class="fas fa-award logo"></i><div class="menu_name">RANKING</div></div></a>
        <a href="#" onclick="ShowAlert()"><div class="col-8 text-center menu_item"><i class="fas fa-reply logo"></i><div class="menu_name">LOGOUT</div></div></a>
      </div>

        <div class="offset-2 p-3">
            <div class="menu_top p-3">
              <div class="row">
                  <div class="app_name col-3 text-center">
                      Genelog
                  </div>
                  <div class="search_text col-9 pr-3 text-right">
                      ワード検索
                  </div>
              </div>
              <div class="row pt-1">
                  <div class="title col-8 text-center">
                      デザイン選択画面
                  </div>
                  <div class="col-4 text-center">
                      <form action="../search.jsp">
                          <input type="text" class="form-control" placeholder="Search" name="search">
                          <input type="submit" class="btn btn-outline-success my-2 my-sm-0" value="Search">
                      </form>
                  </div>
              </div>
            </div>
        </div>

      <div class="offset-2 my-4">
        <form action="e_write.jsp">
            <input type="hidden" name="article_no" value="<%=article_noStr%>">
          <div class="main col-10 offset-1">
            <div class="offset-1 my-4 disc">
                記事のデザインを選んでください
            </div>
            <div class="select_design">
                <label><input type="radio" name="design" value=",col-6,col-5" required><img class="offset-2 col-8" src="../images/white.jpg"></label>
                <label><input type="radio" name="design" value="black,col-6,col-5"><img class="offset-2 col-8" src="../images/black.jpg"></label>
                <label><input type="radio" name="design" value="green,col-6,col-5"><img class="offset-2 col-8" src="../images/green.jpg"></label>
                <label><input type="radio" name="design" value="orange,col-6,col-5"><img class="offset-2 col-8" src="../images/orange.jpg"></label>
                <label><input type="radio" name="design" value=",col-10 my-4,col-10 my-4"><img class="offset-2 col-8" src="../images/white1.jpg"></label>
                <label><input type="radio" name="design" value="black,col-10 my-4,col-10 my-4"><img class="offset-2 col-8" src="../images/black1.jpg"></label>
                <label><input type="radio" name="design" value="green,col-10 my-4,col-10 my-4"><img class="offset-2 col-8" src="../images/green1.jpg"></label>
                <label><input type="radio" name="design" value="orange,col-10 my-4,col-10 my-4"><img class="offset-2 col-8" src="../images/orange1.jpg"></label>
            </div>

            <div class="row my-5">
              <div class="col-1 offset-3 text-center">
                <input type="submit" class="btn btn-primary mb-2" value="入力画面へ">
              </div>
              <div class="col-1 offset-2">
                <input type="reset" class="btn btn-primary mb-2" value="キャンセル">
              </div>
            </div>

          </div>
        </form>
      </div>


      <div class="row">
        <div class="offset-10 mt-4 mb-5">
          <a class="btn btn-primary" href="../home.jsp" role="button">ホーム画面</a>
        </div>
      </div>

    </div>
    <script type="text/javascript" src="../js/bootstrap.bundle.js"></script>
    <script type="text/javascript" src="../js/jquery-3.4.1.min.js"></script>
	<script type="text/javascript" src="../js/jquery.bgswitcher.js"></script>
	<script type="text/javascript" src="../js/slick.min.js"></script>
    <script type="text/javascript">
		jQuery(function($) {
			$('.bg-slider').bgSwitcher({
			  images: ['../images/bg1.jpg','../images/bg2.jpg','../images/bg3.jpg','../images/bg4.jpg','../images/bg5.jpg','../images/bg6.jpg','../images/bg7.jpg'], // 切り替える背景画像を指定
			});
		  });

      function ShowAlert(){
        if (confirm("本当にログアウトしますか")) {
          location.href = "../index.jsp";
        }
      }

      $('.select_design').slick({
          speed: 500,
          dots: true
          // prevArrow: '<div class="col-1 mt-5"><i class="fas fa-arrow-alt-circle-left"></i></div>',
          // nextArrow: '<div class="col-1 mt-5"><i class="fas fa-arrow-alt-circle-right"></i></div>'
      });
    </script>
  </body>
</html>
