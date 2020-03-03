<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.HashMap" %>
<%
    request.setCharacterEncoding("UTF-8");
    response.setCharacterEncoding("UTF-8");

    String title[] = new String[5];

	Connection con = null;
	Statement stmt = null;
	StringBuffer SQL = null;
	ResultSet rs = null;

	String USER ="root";
	String PASSWORD = "";
	String URL ="jdbc:mysql://localhost/genelogdb";

	String DRIVER = "com.mysql.jdbc.Driver";

	StringBuffer ERMSG = null;

	int cnt = 0;

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
		SQL.append("select article_no,hit_cnt from hit_tbl order by cast(hit_cnt as signed) desc limit 5");
		rs = stmt.executeQuery(SQL.toString());

		while (rs.next()){
		    map = new HashMap<String, String>();
		    map.put("article_no", rs.getString("article_no"));
		    map.put("hit_cnt", rs.getString("hit_cnt"));
		    list.add(map);
        }

		SQL = new StringBuffer();
		SQL.append("select article_no,title from article_tbl order by article_no");
		rs = stmt.executeQuery(SQL.toString());

		while (rs.next()){
		    map = new HashMap<String, String>();
		    map.put("article_no", rs.getString("article_no"));
		    map.put("title", rs.getString("title"));
		    list1.add(map);
        }

		for (int i=0; i<list.size(); i++) {
		    cnt = 0;
            while (cnt < list1.size()){
                if (list.get(i).get("article_no").equals(list1.get(cnt).get("article_no"))) {
                    title[i] = String.valueOf(list1.get(cnt).get("title"));
                    cnt = list1.size();
                }else{
                    cnt = cnt + 1;
                }
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
    <title>ランキング</title>
      <link rel="stylesheet" href="../css/common.css">
    <link rel="stylesheet" href="../css/bootstrap.css">
    <link rel="stylesheet" href="../css/all.css">
  </head>
  <body>
    <div class="container-fluid bg-slider">
      <div class="col-2 pt-3 position-fixed">
        <a href="../home.jsp?sort=1"><div class="col-8 text-center menu_item"><i class="fas fa-home logo"></i><div class="menu_name">HOME</div></div></a>
        <a href="../mypage/mypage.jsp"><div class="col-8 text-center menu_item"><i class="fas fa-user logo"></i><div class="menu_name">MYPAGE</div></div></a>
        <a href="../favorite/favorite.jsp"><div class="col-8 text-center menu_item"><i class="fas fa-paw logo"></i><div class="menu_name">FAVORITE</div></div></a>
        <a href="../post/p_design.jsp"><div class="col-8 text-center menu_item"><i class="fas fa-edit logo"></i><div class="menu_name">POST</div></div></a>
        <a href="../archive/archive.jsp"><div class="col-8 text-center menu_item"><i class="fas fa-archive logo"></i><div class="menu_name">ARCHIVE</div></div></a>
        <a href="rank_hit.jsp"><div class="col-8 text-center menu_item"><i class="fas fa-award logo"></i><div class="menu_name">RANKING</div></div></a>
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
                      ランキング
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
                    <div class="offset-2">
                        <a class="btn btn-success" href="rank_hit.jsp">閲覧数</a>
                    </div>
                    <div class="offset-2">
                        <a class="btn btn-outline-success" href="rank_fav.jsp">お気に入り数</a>
                    </div>
                    <div class="offset-2">
                        <a class="btn btn-outline-success" href="rank_sea.jsp">検索ワード</a>
                    </div>
                </div>

                <div class="row mt-3">
                    <div class="col-12 text-center disc">
                        閲覧数ランキング
                    </div>
                </div>

                <canvas id="hitChart"></canvas>

                <% for (int i=0; i < title.length; i++){%>
                    <div class="row my-2">
                        <div class="offset-2 art_logo">
                            <%=i+1%>位<a class="mx-2" href="../mypage/article.jsp?article_no=<%=list.get(i).get("article_no")%>"><%=title[i]%></a>
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
	<script type="text/javascript" src="../js/Chart.bundle.min.js"></script>
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

        var hitGraph = document.getElementById("hitChart");
        var hitChart = new Chart(hitGraph, {
            type: 'bar',
            data: {
                labels: ['<%=title[0]%>', '<%=title[1]%>', '<%=title[2]%>', '<%=title[3]%>', '<%=title[4]%>'],
                datasets: [
                    {
                        label: '閲覧数',
                        data: ['<%=list.get(0).get("hit_cnt")%>', '<%=list.get(1).get("hit_cnt")%>', '<%=list.get(2).get("hit_cnt")%>', '<%=list.get(3).get("hit_cnt")%>', '<%=list.get(4).get("hit_cnt")%>'],
                        backgroundColor: "rgba(0, 141, 183, 0.8)"
                    }
                ]
            },
            options: {
                title: {
                    display: true,
                },
                scales: {
                    yAxes: [{
                        ticks: {
                            suggestedMax: 30,
                            suggestedMin: 0,
                            stepSize: 3,
                            callback: function(value, index, values){
                                return  value +  '回'
                            }
                        }
                    }]
                },
            }
        });
    </script>
  </body>
</html>
