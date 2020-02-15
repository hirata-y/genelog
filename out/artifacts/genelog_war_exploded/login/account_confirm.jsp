<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	response.setCharacterEncoding("UTF-8");

	String user_nameStr  = request.getParameter("user_name");
	String user_sexStr  = request.getParameter("user_sex");
	String user_birthStr  = request.getParameter("user_birth");
	String user_mailStr  = request.getParameter("user_mail");
	String user_passStr  = request.getParameter("user_pass");
%>
<!DOCTYPE html>
<html lang="en" dir="ltr">
  <head>
    <meta charset="utf-8">
    <title>ユ－ザー情報確認画面</title>
    <link rel="stylesheet" href="../css/bootstrap.css">
    <link rel="stylesheet" href="../css/common.css">
  </head>
  <body>
    <div class="container-fluid bg-slider">

      <div class="row">
        <div class="title col-12 text-center my-5">
          ユーザー情報確認画面
        </div>
      </div>

      <div class="main col-6 offset-3 p-4">
        <form action="account_done.jsp">
          <input type="hidden" name="user_name" value="<%= user_nameStr %>">
          <input type="hidden" name="user_sex" value="<%= user_sexStr %>">
          <input type="hidden" name="user_birth" value="<%= user_birthStr %>">
          <input type="hidden" name="user_mail" value="<%= user_mailStr %>">
          <input type="hidden" name="user_pass" value="<%= user_passStr %>">

          <div class="row my-4 offset-2 input-group">
            <div class="col-3 input-group-text">
              ユーザー名
            </div>
            <input class="col-5 form-control" type="text" value="<%=user_nameStr%>" readonly>
          </div>

          <div class="row my-4 offset-2 input-group">
            <div class="col-3 input-group-text">
              性別
            </div>
            <% if (user_sexStr.equals("1")) { %>
            <input class="col-5 form-control" type="text" value="男性" readonly>
            <% }else{ %>
            <input class="col-5 form-control" type="text" value="女性" readonly>
            <% } %>
          </div>

          <div class="row my-4 offset-2 input-group">
            <div class="col-3 input-group-text">
              生年月日
            </div>
            <input class="col-5 form-control" type="text" value="<%=user_birthStr%>" readonly>
          </div>

          <div class="row my-4 offset-2 input-group">
            <div class="col-3 input-group-text">
              メールアドレス
            </div>
            <input class="col-5 form-control" type="text" value="<%=user_mailStr%>" readonly>
          </div>

          <div class="row my-4 offset-2 input-group">
            <div class="col-3 input-group-text">
              パスワード
            </div>
            <input class="col-5 form-control" type="text" value="<%=user_passStr%>" readonly>
          </div>

          <div class="row my-4">
            <div class="col-1 offset-3">
              <input type="submit" class="btn btn-primary" value="登録">
            </div>
            <div class="col-1 offset-2">
              <input type="reset" class="btn btn-primary" value="キャンセル">
            </div>
          </div>

        </form>
      </div>

        <div class="row col-2 offset-8">
            <a class="btn btn-primary my-5" href="../index.jsp" role="button">ログイン画面へ</a>
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
    </script>
  </body>
</html>
