<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.HashMap" %>
<%
    request.setCharacterEncoding("UTF-8");
    response.setCharacterEncoding("UTF-8");

    String user_nameStr  = request.getParameter("user_name");
    String user_passStr  = request.getParameter("user_pass");
    String sortStr  = request.getParameter("sort");
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
	int check_flg = 0; //お気に入りの記事をカウントする変数

	HashMap<String,String> map = new HashMap<String, String>();
    ArrayList<HashMap> all_list = new ArrayList<HashMap>(); //すべての記事を格納するリスト
    ArrayList<HashMap> my_list = new ArrayList<HashMap>(); //自分の記事を格納するリスト
    ArrayList<HashMap> fav_list = new ArrayList<HashMap>(); //お気に入りの記事を格納するリスト
    ArrayList<HashMap> check_list = new ArrayList<HashMap>(); //認証用リスト
    all_list.add(map);
    my_list.add(map);
    fav_list.add(map);

  try{
		Class.forName(DRIVER).newInstance();
		con = DriverManager.getConnection(URL,USER,PASSWORD);
		stmt = con.createStatement();
  	    SQL = new StringBuffer();
		SQL.append("select * from user_tbl where user_name = '" + user_nameStr + "'"); //user_tbl内のuser_nameと入力されたユーザー名が一致するレコードを抽出.
		rs = stmt.executeQuery(SQL.toString());

		if(rs.next()){
		    if(user_passStr.equals(rs.getString("user_pass"))){ //user_nameで抽出したレコード内で、user_passと入力されたパスワードが一致すればhashmapに格納
		        map = new HashMap<String,String>();
		        map.put("user_no",rs.getString("user_no"));
		        map.put("user_name",rs.getString("user_name"));
                check_list.add(map);
                session.setAttribute("user_no", check_list.get(0).get("user_no")); //セッション開始 セッション中はuser_noがsessionに保持される。
                session.setAttribute("user_name", check_list.get(0).get("user_name")); //セッション開始 セッション中はuser_nameがsessionに保持される。
                user_noStr = (String)session.getAttribute("user_no");
                sortStr = "1";

			}else //パスワード不一致
			      hit_flg = 2;
		}else{ //ユーザー名が存在しない
				hit_flg = 0;
		}

		if(!(user_noStr.equals(null))) { //セッション開始後の処理。すべての記事をlistに昇順で格納する
		    hit_flg = 1;
		    SQL = new StringBuffer();
		    if (sortStr.equals("1")){ //新着順
                SQL.append("select article_no,title from article_tbl");
            }else if (sortStr.equals("2")){ //閲覧数順
                SQL.append(" select art.article_no,art.title from article_tbl as art inner join hit_tbl as hit on art.article_no = hit.article_no order by cast(hit_cnt as signed)");
            }else if (sortStr.equals("3")){ //お気に入り数順
                SQL.append("select article_no,count(article_no) as art_cnt from favorite_tbl group by article_no order by art_cnt desc");
            }

		    rs = stmt.executeQuery(SQL.toString());
		    while (rs.next()) {
		        map = new HashMap<String, String>();
		        map.put("article_no", rs.getString("article_no"));
		        map.put("title", rs.getString("title"));
		        all_list.add(map);
		    }
        }

		if (hit_flg == 1){ //自分の記事のarticle_noをmy_listに昇順で格納
		    SQL = new StringBuffer();
            SQL.append("select article_no from article_tbl where user_no = '" + user_noStr + "' order by cast(article_no as signed)");
            rs = stmt.executeQuery(SQL.toString());

            while (rs.next()){
                  map = new HashMap<String,String>();
                  map.put("article_no",rs.getString("article_no"));
                  my_list.add(map);
            }

            //お気に入りのarticle_noをfav_listに昇順で格納
		    SQL = new StringBuffer();
            SQL.append("select article_no from favorite_tbl where user_no = '" + user_noStr + "' order by cast(article_no as signed)");
            rs = stmt.executeQuery(SQL.toString());

            while (rs.next()){
                  map = new HashMap<String,String>();
                  map.put("article_no",rs.getString("article_no"));
                  fav_list.add(map);
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
    <title>ホーム画面</title>
      <link rel="stylesheet" href="css/common.css">
    <link rel="stylesheet" href="css/bootstrap.css">
    <link rel="stylesheet" href="css/all.css">
  </head>
  <body>
    <div class="container-fluid bg-slider">
      <% if (hit_flg == 1) { %>
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

                <div class="row my-4">
                    <div class="offset-2">
                        <a class="btn btn-outline-success" href="home.jsp?sort=1">新着順</a>
                    </div>
                    <div class="offset-2">
                        <a class="btn btn-outline-success" href="home.jsp?sort=2">閲覧数順</a>
                    </div>
                    <div class="offset-2">
                        <a class="btn btn-outline-success" href="home.jsp?sort=3">お気に入り数順</a>
                    </div>
                </div>

                <% for (int all_cnt = all_list.size() - 1; 0 < all_cnt; all_cnt--){%>
                <% check_flg = 0; %>
                <% for (int my_cnt = my_list.size() - 1; 0 < my_cnt; my_cnt--){ %>
                <% if (all_list.get(all_cnt).get("article_no").equals(my_list.get(my_cnt).get("article_no"))){ %>
                <div class="row mx-2 alert alert-success">
                    <div class="col-10">
                        <a class="art_logo" href="mypage/article.jsp?article_no=<%= all_list.get(all_cnt).get("article_no") %>"><%= all_list.get(all_cnt).get("title") %></a>
                    </div>
                    <div class="col-2　text-center">
                        自分の記事
                    </div>
                </div>
                <% check_flg = 1; %>
                <% } %>
                <% } %>
                <% for (int fav_cnt = fav_list.size() - 1; 0 < fav_cnt; fav_cnt--){ %>
                <% if (all_list.get(all_cnt).get("article_no").equals(fav_list.get(fav_cnt).get("article_no"))){ %>
                <div class="row mx-2 alert alert-success">
                    <div class="col-10">
                        <a class="art_logo" href="mypage/article.jsp?article_no=<%= all_list.get(all_cnt).get("article_no") %>"><%= all_list.get(all_cnt).get("title") %></a>
                    </div>
                    <div class="col-2 text-center">
                        <a class="fav_logo" href="favorite/f_delete.jsp?article_no=<%= all_list.get(all_cnt).get("article_no") %>"><i class="fas fa-paw"></i></a>
                    </div>
                </div>
                <% check_flg = 1; %>
                <% } %>
                <% } %>
                <% if (check_flg == 0){%>
                <div class="row mx-2 alert alert-success">
                    <div class="col-10">
                        <a class="art_logo" href="mypage/article.jsp?article_no=<%= all_list.get(all_cnt).get("article_no") %>"><%= all_list.get(all_cnt).get("title") %></a>
                    </div>
                    <div class="col-2 text-center">
                        <a class="art_logo" href="favorite/f_done.jsp?article_no=<%= all_list.get(all_cnt).get("article_no") %>"><i class="fas fa-paw"></i></a>
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
                <a class="btn btn-primary" href="tmp.jsp" role="button">テスト</a>
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