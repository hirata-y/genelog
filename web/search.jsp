<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.HashMap" %>
<%
	request.setCharacterEncoding("UTF-8");
	response.setCharacterEncoding("UTF-8");

	String searchStr = request.getParameter("search");

	Connection con = null;
	Statement stmt = null;
	StringBuffer SQL = null;
	ResultSet rs = null;

	String USER ="root";
	String PASSWORD = "";
	String URL ="jdbc:mysql://localhost/genelogdb";

	String DRIVER = "com.mysql.jdbc.Driver";

	StringBuffer ERMSG = null;

	int hit_flag = 0;
	int ins_cnt = 0;
	int upd_cnt = 0;
	int search_count = 0;

	HashMap<String,String> map = null;
	ArrayList<HashMap> list = null;
	list = new ArrayList<HashMap>();
	ArrayList<HashMap> list1 = null;
	list1 = new ArrayList<HashMap>();

  try{
		Class.forName(DRIVER).newInstance();
		con = DriverManager.getConnection(URL,USER,PASSWORD);
		stmt = con.createStatement();

	  	SQL = new StringBuffer();
		SQL.append("select * from search_tbl where word = '");
		SQL.append(searchStr);
		SQL.append("'");
		rs = stmt.executeQuery(SQL.toString());

		if (rs.next()){ //登録検索ワードのカウントを1増やす処理
			map = new HashMap<String,String>();
			map.put("search_cnt",rs.getString("search_cnt"));
			list1.add(map);
			search_count = Integer.parseInt(String.valueOf(list1.get(0).get("search_cnt"))) + 1;

			SQL = new StringBuffer();
			SQL.append("update search_tbl set search_cnt = '");
			SQL.append(search_count);
			SQL.append("' where word = '");
			SQL.append(searchStr);
			SQL.append("'");
  	    	upd_cnt = stmt.executeUpdate(SQL.toString());

		}else{ 	//検索ワード登録
			SQL = new StringBuffer();
			SQL.append("insert into search_tbl(word,search_cnt) values('");
			SQL.append(searchStr);
			SQL.append("','");
			SQL.append(1);
			SQL.append("')");
  	    	ins_cnt = stmt.executeUpdate(SQL.toString());
		}

		//検索処理
	  	SQL = new StringBuffer();
		SQL.append("select article_no,title from article_tbl where address like '%");
		SQL.append(searchStr);
		SQL.append("%' or term like '%");
		SQL.append(searchStr);
		SQL.append("%' or title like '%");
		SQL.append(searchStr);
		SQL.append("%' or text like '%");
		SQL.append(searchStr);
		SQL.append("%'");
		rs = stmt.executeQuery(SQL.toString());

    while(rs.next()){
      map = new HashMap<String,String>();
      map.put("article_no",rs.getString("article_no"));
      map.put("title",rs.getString("title"));
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

	finally {
	  try {
		  if (rs != null) {
			  rs.close();
		  }
		  if (stmt != null) {
			  stmt.close();
		  }
		  if (con != null) {
			  con.close();
		  }
	  } catch (SQLException e) {
		  ERMSG = new StringBuffer();
		  ERMSG.append(e.getMessage());
	  }
  }
%>
<!DOCTYPE html>
<html lang="en" dir="ltr">
  <head>
    <meta charset="utf-8">
    <title>ホーム画面</title>
    <link rel="stylesheet" href="css/bootstrap.css">
	  <link rel="stylesheet" href="css/common.css">
    <link rel="stylesheet" href="css/all.css">
  </head>
  <body>
    <div class="container-fluid bg-slider">
      <div class="col-2 pt-3 position-fixed">
        <a href="home.jsp?sort=1"><div class="col-8 text-center menu_item"><i class="fas fa-home logo"></i><div class="menu_name">HOME</div></div></a>
        <a href="mypage/mypage.jsp"><div class="col-8 text-center menu_item"><i class="fas fa-user logo"></i><div class="menu_name">MYPAGE</div></div></a>
        <a href="favorite/favorite.jsp"><div class="col-8 text-center menu_item"><i class="fas fa-paw logo"></i><div class="menu_name">FAVORITE</div></div></a>
        <a href="post/p_design.jsp"><div class="col-8 text-center menu_item"><i class="fas fa-edit logo"></i><div class="menu_name">POST</div></div></a>
        <a href="archive/archive.jsp"><div class="col-8 text-center menu_item"><i class="fas fa-archive logo"></i><div class="menu_name">ARCHIVE</div></div></a>
        <a href="rank/rank_hit.jsp"><div class="col-8 text-center menu_item"><i class="fas fa-award logo"></i><div class="menu_name">RANKING</div></div></a>
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
                      検索結果
                  </div>
                  <div class="col-4 text-center">
                      <form action="search.jsp">
                          <input type="text" class="form-control" placeholder="Search" name="search">
                          <input type="submit" class="btn btn-outline-success my-2 my-sm-0" value="Search">
                      </form>
                  </div>
              </div>
            </div>
        </div>

		<div class="offset-2 my-4">
			<div class="main col-10 offset-1">
				<h3 class="my-3">検索ワード: <%= searchStr %></h3>
				<% if(hit_flag == 1){ %>
				  <% for(int i = list.size() - 1; 0 <= i; i--){ %>
				  <div class="alert alert-success" role="alert">
                      <a class="art_logo" href="mypage/article.jsp?article_no=<%= list.get(i).get("article_no") %>"><%= list.get(i).get("title") %></a>
				  </div>
				  <% } %>
				<% }else{ %>
				  <div class="alert alert-success" role="alert">
					<h4 class="alert-heading">投稿された記事が存在しません</h4>
					投稿してね
				  </div>
				<% } %>
			</div>
		</div>

        <div class="row">
            <div class="offset-10 mt-5 mb-a">
                <a class="btn btn-primary" href="home.jsp" role="button">ホーム画面へ</a>
            </div>
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

      function ShowAlert(){
        if (confirm("本当にログアウトしますか")) {
          location.href = "index.jsp";
        }
      }
    </script>
  </body>
</html>
