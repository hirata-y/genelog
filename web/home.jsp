<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.HashMap" %>
<%
    request.setCharacterEncoding("UTF-8");
    response.setCharacterEncoding("UTF-8");

    String user_nameStr  = request.getParameter("user_name");
    String user_passStr  = request.getParameter("user_pass");
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
    int art_sum = 0; //listの記事件数に入れるの変数
	int art_cnt = 0; //for文内で使用するカウント変数
	int fav_cnt = 0; //for文内で使用するカウント変数

	HashMap<String,String> map = null;
    ArrayList<HashMap> list = null;
    list = new ArrayList<HashMap>();

  try{
		Class.forName(DRIVER).newInstance();
		con = DriverManager.getConnection(URL,USER,PASSWORD);
		stmt = con.createStatement();
  	    SQL = new StringBuffer();
		SQL.append("select * from user_tbl where user_name = '"); //user_tbl内のuser_nameと入力されたユーザー名が一致するレコードを抽出.
		SQL.append(user_nameStr);
		SQL.append("'");
		rs = stmt.executeQuery(SQL.toString());
		if(rs.next()){
			hit_flg = 1;
		    if(user_passStr.equals(rs.getString("user_pass"))){ //user_nameで抽出したレコード内で、user_passと入力されたパスワードが一致すればhashmapに格納
		        map = new HashMap<String,String>();
		        map.put("user_no",rs.getString("user_no"));
		        map.put("user_name",rs.getString("user_name"));
                list.add(map);
                session.setAttribute("user_no", list.get(0).get("user_no")); //セッション開始 セッション中はuser_noがsessionに保持される。
                session.setAttribute("user_name", list.get(0).get("user_name")); //セッション開始 セッション中はuser_nameがsessionに保持される。
                user_noStr = (String)session.getAttribute("user_no");

                SQL = new StringBuffer();
                list = new ArrayList<HashMap>();
                SQL.append("select article_no,title from article_tbl");
		        rs = stmt.executeQuery(SQL.toString());
				while(rs.next()){
                  map = new HashMap<String,String>();
                  map.put("article_no",rs.getString("article_no"));
                  map.put("title",rs.getString("title"));
                  list.add(map);
                }
			}else //パスワード不一致
			      hit_flg = 2;
		}else{ //ユーザー名が存在しない
				hit_flg = 0;
		}

		if(!(user_noStr.equals(null))) { //セッション開始後の処理。
		    hit_flg = 1;
            SQL = new StringBuffer();
            list = new ArrayList<HashMap>();
            SQL.append("select article_no,title from article_tbl");
            rs = stmt.executeQuery(SQL.toString());
            while (rs.next()) {
                map = new HashMap<String, String>();
                map.put("article_no", rs.getString("article_no"));
                map.put("title", rs.getString("title"));
                list.add(map);
            }
        }
		art_sum = list.size(); //記事数を変数に格納

		if (hit_flg == 1){ // 認証OKの時、favorite_tblからuser_noをキーにarticle_noを昇順で抽出。
		    SQL = new StringBuffer();
            SQL.append("select article_no from favorite_tbl where user_no = '");
            SQL.append(user_noStr);
            SQL.append("' order by cast(article_no as signed)");
            rs = stmt.executeQuery(SQL.toString());
            while (rs.next()){
                  map = new HashMap<String,String>();
                  map.put("article_no",rs.getString("article_no"));
                  list.add(map);
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
    art_cnt = art_sum - 1;
    fav_cnt = list.size() - 1;
%>
<!DOCTYPE html>
<html lang="en" dir="ltr">
  <head>
    <meta charset="utf-8">
    <title>ホーム画面</title>
      <link rel="stylesheet" href="css/common.css">
    <link rel="stylesheet" href="css/bootstrap.css">
    <link rel="stylesheet" href="css/all.css">
  </head>
  <body>
    <div class="container-fluid bg-slider">
      <% if (hit_flg == 1) { %>
      <div class="col-2 pt-3 position-fixed">
        <a href="home.jsp"><div class="col-8 text-center menu_item"><i class="fas fa-home logo"></i><div class="menu_name">HOME</div></div></a>
        <a href="mypage/mypage.jsp"><div class="col-8 text-center menu_item"><i class="fas fa-user logo"></i><div class="menu_name">MYPAGE</div></div></a>
        <a href="favorite/favorite.jsp"><div class="col-8 text-center menu_item"><i class="fas fa-paw logo"></i><div class="menu_name">FAVORITE</div></div></a>
        <a href="post/post_design.jsp"><div class="col-8 text-center menu_item"><i class="fas fa-edit logo"></i><div class="menu_name">POST</div></div></a>
        <a href="archive/archive.jsp"><div class="col-8 text-center menu_item"><i class="fas fa-archive logo"></i><div class="menu_name">ARCHIVE</div></div></a>
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
                      <%= session.getAttribute("user_name")%>さんのホームページ
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
            <div class="main offset-1 col-10">
                <% if (list.size() > art_sum){ %>
                    <% while (art_cnt >= 0){%>
                        <% if (list.get(art_cnt).get("article_no").equals(list.get(fav_cnt).get("article_no")) && fav_cnt >= art_sum - 1){%>
                            <div class="row mx-2 alert alert-success">
                                <div class="col-10">
                                    <a class="art_logo" href="mypage/article.jsp?article_no=<%= list.get(art_cnt).get("article_no") %>"><%= list.get(art_cnt).get("title") %></a>
                                </div>
                                <div class="col-2 text-center">
                                    <a class="fav_logo" href="favorite/t_delete.jsp?article_no=<%= list.get(art_cnt).get("article_no") %>"><i class="fas fa-paw"></i></a>
                                </div>
                            </div>
                        <% fav_cnt = fav_cnt - 1; %>
                        <% }else{%>
                            <div class="row mx-2 alert alert-success">
                                <div class="col-10">
                                    <a class="art_logo" href="mypage/article.jsp?article_no=<%= list.get(art_cnt).get("article_no") %>"><%= list.get(art_cnt).get("title") %></a>
                                </div>
                                <div class="col-2 text-center">
                                    <a class="art_logo" href="favorite/t_favorite.jsp?article_no=<%= list.get(art_cnt).get("article_no") %>"><i class="fas fa-paw"></i></a>
                                </div>
                            </div>
                        <% } %>
                    <% art_cnt = art_cnt - 1; %>
                    <% } %>
                <% }else{ %>
                        <% for (int i = art_sum - 1; 0 <= i; i--){%>
                        <div class="row mx-2 alert alert-success">
                            <div class="col-10">
                                <a class="art_logo" href="mypage/article.jsp?article_no=<%= list.get(i).get("article_no") %>"><%= list.get(i).get("title") %></a>
                            </div>
                            <div class="col-2 text-center">
                                <a class="art_logo" href="favorite/t_favorite.jsp?article_no=<%= list.get(i).get("article_no") %>"><i class="fas fa-paw"></i></a>
                            </div>
                        </div>
                        <% } %>
                <% } %>
            </div>
        </div>

        <div class="row">
            <div class="offset-10 my-5">
                <a class="btn btn-primary" href="home.jsp" role="button">ホーム画面へ</a>
            </div>
        </div>

        <div class="row">
            <div class="offset-10 my-5">
                <a class="btn btn-primary" href="post/t_design.jsp" role="button">ホーム画面へ</a>
            </div>
        </div>


		<% }else if (hit_flg == 2) { %>
        <div class="row p-5">
		    <div class="main col-6 offset-3 text-center disc">
                パスワードが違います
		    </div>
        </div>
        <div class="row">
            <div class="offset-10 mt-4 mb-a">
                <a class="btn btn-primary" href="index.jsp" role="button">ログイン画面へ</a>
            </div>
        </div>

		<% }else{ %>
        <div class="row p-5">
		    <div class="main col-6 offset-3 text-center disc">
                ユーザー名が存在しません
		    </div>
        </div>
        <div class="row">
            <div class="offset-10 mt-4 mb-a">
                <a class="btn btn-primary" href="index.jsp" role="button">ログイン画面へ</a>
            </div>
        </div>
		<% } %>
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
