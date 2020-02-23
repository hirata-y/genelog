<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.HashMap" %>
<%
	request.setCharacterEncoding("UTF-8");
	response.setCharacterEncoding("UTF-8");

	String article_noStr  = request.getParameter("article_no");
	String user_noStr = (String) session.getAttribute("user_no");

	Connection con = null;
	Statement stmt = null;
	StringBuffer SQL = null;
	ResultSet rs = null;

	String USER ="root";
	String PASSWORD = "";
	String URL ="jdbc:mysql://localhost/genelogdb";

	String DRIVER = "com.mysql.jdbc.Driver";

	StringBuffer ERMSG = null;

	int hit_flg = 0;

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
		SQL.append("select * from article_tbl where article_no = '");
		SQL.append(article_noStr);
		SQL.append("'");
		rs = stmt.executeQuery(SQL.toString());

		if(rs.next()){
            map = new HashMap<String,String>();
            map.put("article_no",rs.getString("article_no"));
            map.put("user_no",rs.getString("user_no"));
            map.put("title",rs.getString("title"));
            map.put("text",rs.getString("text"));
            map.put("term",rs.getString("term"));
            map.put("address",rs.getString("address"));
            map.put("design",rs.getString("design"));
            list.add(map);
        }

		SQL = new StringBuffer();
		SQL.append("select user_name from user_tbl where user_no = ");
		SQL.append(list.get(0).get("user_no"));
		rs = stmt.executeQuery(SQL.toString());

		if (rs.next()){
		    map = new HashMap<String,String>();
		    map.put("user_name",rs.getString("user_name"));
		    list.add(map);
		}

		SQL = new StringBuffer();
		SQL.append("select user_no,article_no from favorite_tbl where user_no = '");
		SQL.append(user_noStr);
		SQL.append("' and article_no = '");
		SQL.append(article_noStr);
		SQL.append("'");
		rs = stmt.executeQuery(SQL.toString());

        if (rs.next()){
            hit_flg = 1;
        }

		SQL = new StringBuffer();
		SQL.append("select insert_time from archive_tbl where article_no = '");
		SQL.append(article_noStr);
		SQL.append("'");
		rs = stmt.executeQuery(SQL.toString());

		if (rs.next()){
		    map = new HashMap<String,String>();
		    map.put("insert_time",rs.getString("insert_time"));
		    list1.add(map);
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
    String designStr = String.valueOf(list.get(0).get("design"));
    String[] design = designStr.split(",", -1);
%>
<!DOCTYPE html>
<html lang="en" dir="ltr">
  <head>
    <meta charset="utf-8">
    <title><%= list.get(0).get("title") %></title>
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
        <a href="../post/p_design.jsp"><div class="col-8 text-center menu_item"><i class="fas fa-edit logo"></i><div class="menu_name">POST</div></div></a>
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
                      <%= list.get(0).get("title") %>
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
          <div class="main <%=design[0]%> col-10 offset-1">

              <div class="row my-4">
                  <div class="offset-1 article_title">
                      <%=list.get(0).get("title")%>
                  </div>
              </div>

              <div class="row">
                  <% if (hit_flg == 1){ %>
                      <a class="btn btn-success offset-8" href="../favorite/f_delete.jsp?article_no=<%=article_noStr%>">お気に入り解除</a>
                  <% }else{ %>
                      <a class="btn btn-secondary offset-8" href="../favorite/f_done.jsp?article_no=<%=article_noStr%>">お気に入り登録</a>
                  <% } %>
              </div>

              <div class="row my-4">
                  <div class="<%=design[1]%> mx-2">
                      <img class="size_img" src="../image/<%=article_noStr%>.jpg">
                  </div>
                  <div class="<%=design[2]%> mx-2 article_text">
                      <%=list.get(0).get("text")%>
                  </div>
              </div>

              <div class="note mx-2 my-4 p-4">
                  <div class="row offset-1 my-2">
                      <div class="disc">期間:</div><div class="offset-1 article_term"><%=list.get(0).get("term")%></div>
                  </div>
                  <div class="row offset-1 my-2">
                      <div class="disc">住所:</div><div class="offset-1 article_term"><%=list.get(0).get("address")%></div>
                  </div>
                  <div class="row offset-1 my-2">
                      <div class="disc">投稿者:</div><div class="offset-1 article_term"><%=list.get(1).get("user_name")%></div>
                  </div>
                  <div class="row offset-1 my-2">
                      <div class="disc">投稿日時:</div><div class="offset-1 article_term"><%=list1.get(0).get("insert_time")%></div>
                  </div>
              </div>

          </div>
      </div>

        <div class="row">
            <div class="offset-10 my-5">
                <a class="btn btn-primary" href="../home.jsp" role="button">ホーム画面へ</a>
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
