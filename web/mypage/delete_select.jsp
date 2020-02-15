<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.HashMap" %>
<%
	request.setCharacterEncoding("UTF-8");
	response.setCharacterEncoding("UTF-8");

	String user_noStr = (String) session.getAttribute("user_no");

	//データベースに接続するために使用する変数宣言
	Connection con = null;
	Statement stmt = null;
	StringBuffer SQL = null;
	ResultSet rs = null;

	//ローカルのMySQLに接続する設定
	String USER ="root";
	String PASSWORD = "";
	String URL ="jdbc:mysql://localhost/genelogdb";

	//サーバーのMySQLに接続する設定
//	String USER = "nhs90664";
//	String PASSWORD = "b19960620";
//  String URL ="jdbc:mysql://192.168.121.16/nhs90664db";

	String DRIVER = "com.mysql.jdbc.Driver";

	//確認メッセージ
	StringBuffer ERMSG = null;

	//ヒットフラグ
	int hit_flag = 0;

	//HashMap（1件分のデータを格納する連想配列）
	HashMap<String,String> map = null;

	//ArrayList（すべての件数を格納する配列）
	ArrayList<HashMap> list = null;
	list = new ArrayList<HashMap>();

  try{	// ロードに失敗したときのための例外処理
		// JDBCドライバのロード
		Class.forName(DRIVER).newInstance();

		// Connectionオブジェクトの作成
		con = DriverManager.getConnection(URL,USER,PASSWORD);

		//Statementオブジェクトの作成
		stmt = con.createStatement();

  		//SQLステートメントの作成（選択クエリ）
  		SQL = new StringBuffer();

		//SQL文の発行（選択クエリ）
		SQL.append("select * from article_tbl where user_no = '");
		SQL.append(user_noStr);
		SQL.append("'");

		//SQL文の発行（選択クエリ）
		rs = stmt.executeQuery(SQL.toString());

		//入力したデータがデータベースに存在するか調べる
    	while(rs.next()){
    	  //検索データをHashMapへ格納する
    	  map = new HashMap<String,String>();
    	  map.put("article_no",rs.getString("article_no"));
    	  map.put("title",rs.getString("title"));
    	  //1件分のデータ(HashMap)をArrayListへ追加
    	  list.add(map);
    	}

    	if (list.size() > 0) {
    	  hit_flag = 1;
    	}
    	else{
    	  hit_flag = 0;
    	}

	}	//tryブロック終了
	catch(ClassNotFoundException e){
		ERMSG = new StringBuffer();
		ERMSG.append(e.getMessage());
	}
	catch(SQLException e){
		ERMSG = new StringBuffer();
		ERMSG.append(e.getMessage());
	}
	catch(Exception e){
		ERMSG = new StringBuffer();
		ERMSG.append(e.getMessage());
	}

	finally{
		//各種オブジェクトクローズ
	    try{
	    	if(rs != null){
	    		rs.close();
	    	}
	    	if(stmt != null){
	    		stmt.close();
			}
	    	if(con != null){
	    		con.close();
			}
	    }
		catch(SQLException e){
		ERMSG = new StringBuffer();
		ERMSG.append(e.getMessage());
		}
	}

%>
<!DOCTYPE html>
<html lang="en" dir="ltr">
  <head>
    <meta charset="utf-8">
    <title>削除記事選択</title>
    <link rel="stylesheet" href="../css/bootstrap.css">
    <link rel="stylesheet" href="../css/common.css">
    <link rel="stylesheet" href="../css/all.css">
  </head>
  <body>
    <div class="container-fluid bg-slider">
      <div class="col-2 pt-3 position-fixed">
        <a href="../home.jsp"><div class="col-8 text-center menu_item"><i class="fas fa-home logo"></i><div class="menu_name">HOME</div></div></a>
        <a href="mypage.jsp"><div class="col-8 text-center menu_item"><i class="fas fa-user logo"></i><div class="menu_name">MYPAGE</div></div></a>
        <a href="../favorite/favorite.jsp"><div class="col-8 text-center menu_item"><i class="fas fa-paw logo"></i><div class="menu_name">FAVORITE</div></div></a>
        <a href="../post/post_design.jsp"><div class="col-8 text-center menu_item"><i class="fas fa-edit logo"></i><div class="menu_name">POST</div></div></a>
        <a href="../archive/archive.jsp"><div class="col-8 text-center menu_item"><i class="fas fa-archive logo"></i><div class="menu_name">ARCHIVE</div></div></a>
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
                      選択画面
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

			<div class="main col-10 offset-1">
				<div class="row my-4">
					<div class="offset-4">
						<a class="btn btn-outline-success" href="edit_select.jsp">編集</a>
					</div>
					<div class="offset-2">
						<a class="btn btn-outline-success" href="delete_select.jsp">削除</a>
					</div>
				</div>

				<form action="delete_done.jsp">
					<% if(hit_flag == 1){ %>
					  <div class="disc my-3">
						  削除する記事を選択してください
					  </div>
					  <% for(int i = 0; i < list.size(); i++){ %>
						  <div class="row my-3">
							  <div class="offset-1 custom-control custom-checkbox">
								  <input type="checkbox" class="custom-control-input" id="customCheck<%= i %>" name="article_no" value="<%= list.get(i).get("article_no") %>">
								  <label class="custom-control-label disc" for="customCheck<%= i %>"><%= list.get(i).get("title") %></label>
							  </div>
						  </div>
					  <% } %>
					<% }else{ %>
					  <div class="mx-2 alert alert-success" role="alert">
						<h4 class="alert-heading">投稿された記事が存在しません</h4>
						投稿してね
					  </div>
					<% } %>

					<div class="row my-5">
						<div class="col-1 offset-3 text-center">
						  <input type="submit" class="btn btn-primary" value="削除">
						</div>
						<div class="col-1 offset-2">
						  <input type="reset" class="btn btn-primary" value="キャンセル">
						</div>
					</div>

				</form>
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