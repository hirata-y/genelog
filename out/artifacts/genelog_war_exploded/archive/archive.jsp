<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.HashMap" %>
<%
    request.setCharacterEncoding("UTF-8");
    response.setCharacterEncoding("UTF-8");

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

	int hit_flag = 0;

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
		SQL.append("select * from archive_tbl where user_no = '");
		SQL.append(user_noStr);
		SQL.append("'");
		rs = stmt.executeQuery(SQL.toString());

        while(rs.next()){
          map = new HashMap<String,String>();
          map.put("article_no",rs.getString("article_no"));
          map.put("insert_time",rs.getString("insert_time"));
          map.put("action",rs.getString("action"));
          list.add(map);
        }

      SQL = new StringBuffer();
      SQL.append("select * from article_tbl where user_no = '");
      SQL.append(user_noStr);
      SQL.append("'");
      rs = stmt.executeQuery(SQL.toString());

      while (rs.next()){
          map = new HashMap<String,String>();
          map.put("article_no",rs.getString("article_no"));
          map.put("title",rs.getString("title"));
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

%>
<!DOCTYPE html>
<html lang="en" dir="ltr">
  <head>
    <meta charset="utf-8">
    <title>アーカイブ</title>
      <link rel="stylesheet" href="../css/common.css">
    <link rel="stylesheet" href="../css/bootstrap.css">
    <link rel="stylesheet" href="../css/all.css">
  </head>
  <body>
    <div class="container-fluid bg-slider">
      <div class="col-2 pt-3 position-fixed">
        <a href="../home.jsp"><div class="col-8 text-center menu_item"><i class="fas fa-home logo"></i><div class="menu_name">HOME</div></div></a>
        <a href="../mypage/mypage.jsp"><div class="col-8 text-center menu_item"><i class="fas fa-user logo"></i><div class="menu_name">MYPAGE</div></div></a>
        <a href="../favorite/favorite.jsp"><div class="col-8 text-center menu_item"><i class="fas fa-paw logo"></i><div class="menu_name">FAVORITE</div></div></a>
        <a href="../post/p_design.jsp"><div class="col-8 text-center menu_item"><i class="fas fa-edit logo"></i><div class="menu_name">POST</div></div></a>
        <a href="archive.jsp"><div class="col-8 text-center menu_item"><i class="fas fa-archive logo"></i><div class="menu_name">ARCHIVE</div></div></a>
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
                      <%= session.getAttribute("user_name")%>さんのアーカイブ
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
                <% for(int i = list.size() - 1; 0 <= i; i--){ %>
                <div class="row mx-2 alert alert-success">
                    <div class="col-10">
                        <% if (list.get(i).get("action").equals("1")){ %>
                            <p>ユーザー登録が完了しました</p>
                        <% }else if (list.get(i).get("action").equals("2")){%>

                            <% for (int j = list1.size() - 1; 0 <= j; j--){%>
                                <% if (list.get(i).get("article_no").equals(list1.get(j).get("article_no"))){%>
                                    <p>【<%= list1.get(j).get("title") %>】を投稿しました</p>
                                <% } %>
                            <% } %>

                        <% }else if (list.get(i).get("action").equals("3")){%>

                            <% for (int j = list1.size() - 1; 0 <= j; j--){%>
                                <% if (list.get(i).get("article_no").equals(list1.get(j).get("article_no"))){%>
                                    <p>【<%= list1.get(j).get("title") %>】を編集しました</p>
                                <% } %>
                            <% } %>

                        <% }else{ %>

                            <% for (int j = list1.size() - 1; 0 <= j; j--){%>
                                <% if (list.get(i).get("article_no").equals(list1.get(j).get("article_no"))){%>
                                    <p>【<%= list.get(i).get("action") %>】を削除しました</p>
                                <% } %>
                            <% } %>
                        
                        <% } %>
                        <p><%= list.get(i).get("insert_time") %></p>
                    </div>
                </div>
                <% } %>

            </div>
        </div>

        <div class="row">
            <div class="offset-10 mt-4 mb-a">
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
