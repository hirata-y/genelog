<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.HashMap" %>
<%
	request.setCharacterEncoding("UTF-8");
	response.setCharacterEncoding("UTF-8");

    String user_noStr = (String) session.getAttribute("user_no");
	String titleStr  = request.getParameter("title");
	String textStr  = request.getParameter("text");
  	String termStr  = request.getParameter("term");
	String addressStr  = request.getParameter("address");
	String designStr  = request.getParameter("design");

	Connection con = null;
	Statement stmt = null;
	StringBuffer SQL = null;
	ResultSet rs = null;

	String USER ="root";
	String PASSWORD = "";
	String URL ="jdbc:mysql://localhost/genelogdb";

	String DRIVER = "com.mysql.jdbc.Driver";

	StringBuffer ERMSG = null;

	int ins_count = 0;
	int ins_cnt = 0;

	HashMap<String,String> map = null;
    ArrayList<HashMap> list = null;
    list = new ArrayList<HashMap>();

	try{
		Class.forName(DRIVER).newInstance();
		con = DriverManager.getConnection(URL,USER,PASSWORD);
		stmt = con.createStatement();
		SQL = new StringBuffer();
	  	SQL.append("insert into article_tbl(user_no,title,text,term,address,design)");
		SQL.append(" values('");
	 	SQL.append(user_noStr);
	 	SQL.append("','");
	 	SQL.append(titleStr);
	 	SQL.append("','");
	 	SQL.append(textStr);
	 	SQL.append("','");
	 	SQL.append(termStr);
	 	SQL.append("','");
	 	SQL.append(addressStr);
	 	SQL.append("','");
	 	SQL.append(designStr);
		SQL.append("')");
  		ins_count = stmt.executeUpdate(SQL.toString());

  		if (ins_count == 1){
			SQL = new StringBuffer();
			SQL.append("select article_no,user_no,title from article_tbl order by article_no desc limit 1");
			rs = stmt.executeQuery(SQL.toString());
			if (rs.next()){
				map = new HashMap<String,String>();
				map.put("article_no",rs.getString("article_no"));
				map.put("user_no",rs.getString("user_no"));
				map.put("title",rs.getString("title"));
				list.add(map);
				SQL = new StringBuffer();
				SQL.append("insert into archive_tbl(user_no,title,action)");
				SQL.append(" values('");
				SQL.append(list.get(0).get("user_no"));
				SQL.append("','");
				SQL.append(list.get(0).get("title"));
				SQL.append("','");
				SQL.append(2);
				SQL.append("')");
				ins_cnt = stmt.executeUpdate(SQL.toString());

			}
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
    <title>画像ファイル選択画面</title>
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
                      画像ファイル選択画面
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
				<% if(ERMSG != null){ %>
				<div class="alert alert-success" role="alert">
				  <h4 class="alert-heading">予期せぬエラーが発生しました</h4>
				  <%= ERMSG %>
				</div>
				<% }else{ %>
				<div class="alert alert-success" role="alert">
				  <h4 class="alert-heading">記事登録完了</h4>
				  記事のテキストデータを登録しました
				</div>
				<% } %>
                  <div class="offset-1 my-4 disc">
                      記事に挿入する画像ファイルを選択してください
                  </div>
				<form method="post" enctype="multipart/form-data" action="p_done.jsp">
					<div class="row my-4 text-center">
						<input class="offset-1" type="file" name="jpgdata">
					</div>
					<div class="file_post">
						<input type="text" name="<%=list.get(0).get("article_no")%>" value="tmp">
					</div>
                    <div class="row my-5">
                      <div class="col-1 offset-3 text-center">
                        <input type="submit" class="btn btn-primary mb-2" value="投稿">
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
