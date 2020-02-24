<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="org.apache.commons.fileupload.FileItem" %>
<%@ page import="org.apache.commons.fileupload.FileUploadException" %>
<%@ page import="org.apache.commons.fileupload.disk.DiskFileItemFactory" %>
<%@ page import="org.apache.commons.fileupload.servlet.ServletFileUpload" %>
<%@ page import="java.io.File" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="java.util.List" %>
<%@ page import="java.nio.file.Paths" %>
<%@ page import="java.nio.file.Path" %>
<%@ page import="java.sql.*" %>
<%
	request.setCharacterEncoding("UTF-8");
	response.setCharacterEncoding("UTF-8");

	FileItem fItem = null;
	FileItem fItem1 = null;
	String str_name = null;

	//(1)アップロードファイルを格納するPATHを取得
	Path path = Paths.get("C:/Users/nhs90664/IdeaProjects/genelog/web/image");

	//(2)ServletFileUploadオブジェクトを生成
	DiskFileItemFactory factory = new DiskFileItemFactory();
	ServletFileUpload upload = new ServletFileUpload(factory);

	//(3)アップロードする際の基準値を設定
	factory.setSizeThreshold(1024);  //byte
	upload.setSizeMax(-1);	//-1はファイルサイズに制限なし

	try {
		//出力先ファイル名を取得
		//(4)ファイルデータ(FileItemオブジェクト)を取得し、
		//   Listオブジェクトとして返す
		List list = upload.parseRequest(request);

		//(5)ファイルデータ(FileItemオブジェクト)を順に処理
		Iterator iterator = list.iterator();
		while(iterator.hasNext()){
			fItem = (FileItem)iterator.next();
			//(6)フォームデータの場合
			if((fItem.isFormField())){
				//フォーム項目についての処理
				str_name = fItem.getFieldName();	// フォームのnameパラメータを取得
				fItem1.write(new File(path + "/" + str_name + ".jpg"));
			}else{
	        	//ファイルデータの場合
	        	 fItem1 = fItem; //ファイルデータを退避
	        }
		}
	}catch (FileUploadException e) {
		e.printStackTrace();
	}catch (Exception e) {
		e.printStackTrace();
	}
 %>
<!DOCTYPE html>
<html lang="en" dir="ltr">
  <head>
    <meta charset="utf-8">
    <title>画像ファイル送信完了</title>
    <link rel="stylesheet" href="../css/bootstrap.css">
      <link rel="stylesheet" href="../css/common.css">
    <link rel="stylesheet" href="../css/all.css">
  </head>

  <body>
   <div class="container-fluid bg-slider">
      <div class="col-2 pt-3 position-fixed">
        <a href="../home.jsp"><div class="col-8 text-center menu_item"><i class="fas fa-home logo"></i><div class="menu_name">HOME</div></div></a>
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
                      画像ファイル送信完了
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

      <div class="my-4 offset-2">
          <div class="main offset-1 col-10">
              <div class="offset-1 disc">
                  記事の投稿が完了しました
              </div>
          </div>
      </div>

      <div class="row">
        <div class="offset-10 mt-4 mb-a">
          <a class="btn btn-primary" href="../home.jsp" role="button">ホーム画面</a>
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
    </script>
  </body>
</html>
