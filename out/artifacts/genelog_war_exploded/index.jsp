<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    session.removeAttribute("user_no");
    String session_name = (String)session.getAttribute("user_no");
    if(session_name != null){
      response.sendRedirect("home.jsp");
    }
%>
<!DOCTYPE html>
<html lang="en" dir="ltr">
  <head>
    <meta charset="utf-8">
    <title>ログイン画面</title>
    <link rel="stylesheet" href="css/bootstrap.css">
    <link rel="stylesheet" href="css/common.css">
  </head>
  <body>
    <div class="container-fluid bg-slider">

      <div class="row">
        <div class="title col-4 offset-4 text-center my-5">
          Genelog
        </div>
      </div>

      <form action="home.jsp">
        <div class="main col-6 offset-3">
          <div class="row">
            <div class="main_title col-12 text-center my-4">
              ログイン
            </div>
          </div>
          <div class="row">
            <div class="col-8 offset-2">
              <div class="input-group my-4">
                <div class="input-group-prepend">
                  <span class="input-group-text">ユーザー名</span>
                </div>
                <input type="text" pattern="^([a-zA-Z0-9]{6,})$" class="form-control" placeholder="Username" name="user_name" required>
              </div>
            </div>
          </div>
          <div class="row">
            <div class="col-8 offset-2">
              <div class="input-group my-4">
                <div class="input-group-prepend">
                  <span class="input-group-text">パスワード</span>
                </div>
                <input type="password" pattern="^([a-zA-Z0-9]{6,})$" class="form-control" placeholder="Password" name="user_pass" required>
              </div>
            </div>
          </div>
          <div class="row my-4">
            <div class="col-1 offset-3">
              <input type="submit" class="btn btn-primary" value="ログイン">
            </div>
            <div class="col-1 offset-2">
              <input type="reset" class="btn btn-primary" value="キャンセル">
            </div>
          </div>
        </div>
      </form>

        <div class="row col-3 offset-7">
            <a class="btn btn-primary mt-5 mb-a" href="login/account.jsp" role="button">新規会員登録</a>
        </div>

       <div class="row col-3 offset-7">
            <a class="btn btn-primary mt-5" href="login/delete.jsp" role="button">テストデータ削除</a>
        </div>


    </div>
    <script type="text/javascript" src="js/bootstrap.bundle.js"></script>
    <script type="text/javascript" src="js/jquery-3.4.1.min.js"></script>
    <script type="text/javascript" src="js/jquery.bgswitcher.js"></script>
    <script type="text/javascript">
      jQuery(function($) {
        $('.bg-slider').bgSwitcher({
          images: ['images/bg1.jpg','images/bg2.jpg','images/bg3.jpg','images/bg4.jpg','images/bg5.jpg','images/bg6.jpg','images/bg7.jpg'], // 切り替える背景画像を指定
        });
      });
    </script>
  </body>
</html>
