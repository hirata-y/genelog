<!DOCTYPE html>
<html lang="en" dir="ltr">
  <head>
    <meta charset="utf-8">
    <title>新規登録画面</title>
    <link rel="stylesheet" href="../css/bootstrap.css">
    <link rel="stylesheet" href="../css/common.css">
  </head>
  <body>
    <div class="container-fluid bg-slider">

      <div class="row">
        <div class="title col-12 text-center my-5">
          新規登録画面
        </div>
      </div>

      <div class="main col-6 offset-3 p-4">
        <form name="test" action="account_confirm.jsp">

          <div class="row my-4 offset-2 input-group">
            <div class="col-3 input-group-text">
              ユーザー名
            </div>
            <input class="col-5 form-control" type="text" name="user_name" pattern="^([a-zA-Z0-9]{6,})$" placeholder="半角英数字6文字以上" required>
          </div>

          <div class="row my-4 offset-2 input-group">
            <div class="col-3 input-group-text">
              性別
            </div>
            <div class="custom-control custom-radio offset-1">
              <input type="radio" name="user_sex" id="customControlValidation1" class="custom-control-input" value="1" required>
              <label class="custom-control-label" for="customControlValidation1">男性</label>
            </div>
            <div class="custom-control custom-radio">
              <input type="radio" name="user_sex" id="customControlValidation2" class="custom-control-input" value="2">
              <label class="custom-control-label" for="customControlValidation2">女性</label>
            </div>
          </div>

          <div class="row my-4 offset-2 input-group">
            <div class="col-3 input-group-text">
              生年月日
            </div>
            <input class="col-5 form-control" type="text" name="user_birth" placeholder="yyyy-mm-dd" required>
          </div>

          <div class="row my-4 offset-2 input-group">
            <div class="col-3 input-group-text">
              メールアドレス
            </div>
            <input class="col-5 form-control" type="text" name="user_mail" required>
          </div>

          <div class="row my-4 offset-2 input-group">
            <div class="col-3 input-group-text">
              パスワード
            </div>
            <input class="col-5 form-control" type="text" name="user_pass" pattern="^([a-zA-Z0-9]{6,})$" placeholder="半角英数字6文字以上" required>
          </div>

          <div class="row my-4">
            <div class="col-1">
              <input type="button" onclick="testdata()" class="btn btn-primary" value="テストデータ">　
            </div>
            <div class="col-1 offset-2">
              <input type="submit" class="btn btn-primary" value="確認画面へ">
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

      function testdata() {
        document.test.user_name.value = "suzuki";
        document.test.user_sex[0].checked = true;
        document.test.user_birth.value = "2000-02-21";
        document.test.user_mail.value = "suzuki@gmail.com";
        document.test.user_pass.value = "suzuki";
      }
    </script>
  </body>
</html>
