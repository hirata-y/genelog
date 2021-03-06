<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
  request.setCharacterEncoding("UTF-8");
  response.setCharacterEncoding("UTF-8");

  String designStr  = request.getParameter("design");
  String[] design = designStr.split(",", -1);
%>
<!DOCTYPE html>
<html lang="en" dir="ltr">
  <head>
    <meta charset="utf-8">
    <title>記事制作画面</title>
    <link rel="stylesheet" href="../css/bootstrap.css">
    <link rel="stylesheet" href="../css/common.css">
    <link rel="stylesheet" href="../css/all.css">
  </head>
  <body>
    <div class="container-fluid bg-slider">
      <div class="col-2 pt-3 position-fixed">
        <a href="../home.jsp?sort=1"><div class="col-8 text-center menu_item"><i class="fas fa-home logo"></i><div class="menu_name">HOME</div></div></a>
        <a href="../mypage/mypage.jsp"><div class="col-8 text-center menu_item"><i class="fas fa-user logo"></i><div class="menu_name">MYPAGE</div></div></a>
        <a href="../favorite/favorite.jsp"><div class="col-8 text-center menu_item"><i class="fas fa-paw logo"></i><div class="menu_name">FAVORITE</div></div></a>
        <a href="p_design.jsp"><div class="col-8 text-center menu_item"><i class="fas fa-edit logo"></i><div class="menu_name">POST</div></div></a>
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
                      記事制作画面
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
        <form name="test" action="p_confirm.jsp">
            <input type="hidden" name="design" value="<%=designStr%>">
            <div class="main <%=design[0]%> col-10 offset-1">
                  <div class="offset-1 my-4 disc">
                      各項目に入力してください
                  </div>
                  <div class="offset-1 my-2 disc">
                      タイトル
                  </div>
                  <div class="row ml-3 mb-4">
                      <input type="text" class="form-control-lg col-8" name="title" placeholder="タイトル" required>
                  </div>

                  <div class="row my-4 ml-3">
                      <div class="<%=design[1]%> mx-2">
                        <img class="size_img" src="../images/sample.jpg">
                      </div>
                      <textarea class="<%=design[2]%> mx-2" name="text" maxlength="400" rows="8" placeholder="本文"></textarea>
                  </div>

                <div class="note mx-2 my-4 p-4">
                  <div class="row offset-1 my-2">
                      <div class="disc col-3 text-center">期間:</div><div class="col-7 article_term"><input type="text" class="form-control" name="term" placeholder="ex)30分～1時間程度" required></div>
                  </div>
                  <div class="row offset-1 my-2">
                      <div class="disc col-3 text-center">住所:</div><div class="col-7 article_term"><input type="text" class="form-control" name="address" placeholder="ex)愛知県名古屋市中村区" required></div>
                  </div>
              </div>


                <div class="row my-5">
                    <div class="col-1">
                      <input type="button" onclick="testdata()" class="btn btn-primary" value="テストデータ">　
                    </div>
                  <div class="col-1 offset-3 text-center">
                    <input type="submit" class="btn btn-primary mb-2" value="確認画面へ">
                  </div>
                  <div class="col-1 offset-2">
                    <input type="reset" class="btn btn-primary mb-2" value="キャンセル">
                  </div>
                </div>

          </div>
        </form>
      </div>


        <div class="row">
            <div class="offset-10 my-5">
                <a class="btn btn-primary" href="../home.jsp?sort=1" role="button">ホーム画面へ</a>
            </div>
        </div>

    </div>
    <script type="text/javascript" src="../js/bootstrap.bundle.js"></script>
    <script type="text/javascript" src="../js/jquery-3.4.1.min.js"></script>
	<script type="text/javascript" src="../js/jquery.bgswitcher.js"></script>
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

      function testdata() {
        document.test.title.value = "駅チカのオススメのタピオカ店";
        document.test.text.value = "スパイラルタワーズの地下にあるタピオカ店に行ってきました。とても美味しかったです。";
        document.test.term.value = "30分以内";
        document.test.address.value = "愛知県名古屋市中村区";
      }

    </script>
  </body>
</html>
