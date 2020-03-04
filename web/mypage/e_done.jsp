<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
	request.setCharacterEncoding("UTF-8");
	response.setCharacterEncoding("UTF-8");

    String article_noStr  = request.getParameter("article_no");
	String titleStr  = request.getParameter("title");
	String textStr  = request.getParameter("text");
    String termStr  = request.getParameter("term");
	String addressStr  = request.getParameter("address");
	String designStr  = request.getParameter("design");
	String user_noStr = (String)session.getAttribute("user_no");

	Connection con = null;
	Statement stmt = null;
	StringBuffer SQL = null;
	ResultSet rs = null;

	String USER ="root";
	String PASSWORD = "";
	String URL ="jdbc:mysql://localhost/genelogdb";

	String DRIVER = "com.mysql.jdbc.Driver";

	StringBuffer ERMSG = null;

	int upd_count = 0;
	int upd_cnt = 0;

	try{
		Class.forName(DRIVER).newInstance();
		con = DriverManager.getConnection(URL,USER,PASSWORD);
		stmt = con.createStatement();

		SQL = new StringBuffer();
        SQL.append("update article_tbl set title = '");
		SQL.append(titleStr);
		SQL.append("',text ='");
		SQL.append(textStr);
		SQL.append("',term = '");
		SQL.append(termStr);
		SQL.append("',address = '");
		SQL.append(addressStr);
		SQL.append("',design = '");
		SQL.append(designStr);
		SQL.append("' where article_no = ");
		SQL.append(article_noStr);
  	    upd_count = stmt.executeUpdate(SQL.toString());

  	    if (upd_count == 1){
		    SQL = new StringBuffer();
		    SQL.append("insert into archive_tbl(user_no,article_no,action) values('");
		    SQL.append(user_noStr);
		    SQL.append("','");
		    SQL.append(article_noStr);
		    SQL.append("','");
		    SQL.append(3);
		    SQL.append("')");
		    upd_cnt = stmt.executeUpdate(SQL.toString());
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
    <title>編集完了画面</title>
    <link rel="stylesheet" href="../css/bootstrap.css">
    <link rel="stylesheet" href="../css/common.css">
    <link rel="stylesheet" href="../css/all.css">
  </head>
  <body>
    <div class="container-fluid bg-slider">
      <div class="col-2 pt-3 position-fixed">
        <a href="../home.jsp?sort=1"><div class="col-8 text-center menu_item"><i class="fas fa-home logo"></i><div class="menu_name">HOME</div></div></a>
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
                      編集完了
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
          <div class="main offset-1 col-10">
              <div class="row my-4">
                  <div class="offset-4">
                      <a class="btn btn-outline-success" href="e_select.jsp">編集</a>
                  </div>
                  <div class="offset-2">
                      <a class="btn btn-outline-success" href="d_select.jsp">削除</a>
                  </div>
              </div>

            <% if(upd_count == 0){ %>
              <div class="alert alert-success" role="alert">
                <h4 class="alert-heading">エラー</h4>
                  <div class="disc">
                    編集処理が失敗しました
                  </div>
              </div>
            <% }else{ %>
              <div class="alert alert-success" role="alert">
                <h4 class="alert-heading">編集完了</h4>
                  <div class="disc">
                    <%= upd_count %>件編集しました
                  </div>
              </div>
            <% } %>

          </div>
      </div>

      <div class="row">
        <div class="offset-10 mt-4 mb-a">
          <a class="btn btn-primary" href="../home.jsp?sort=1" role="button">ホーム画面</a>
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
