<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.HashMap" %>
<%
    request.setCharacterEncoding("UTF-8");
    response.setCharacterEncoding("UTF-8");

    String article_noStr  = request.getParameter("article_no");
    String designStr  = request.getParameter("design");
    String[] design = designStr.split(",", -1);

    Connection con = null;
    Statement stmt = null;
    StringBuffer SQL = null;
    ResultSet rs = null;

    String USER ="root";
    String PASSWORD = "";
    String URL ="jdbc:mysql://localhost/genelogdb";

    String DRIVER = "com.mysql.jdbc.Driver";

    StringBuffer ERMSG = null;

    HashMap<String,String> map = null;
    ArrayList<HashMap> list = null;
    list = new ArrayList<HashMap>();

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
            map.put("title",rs.getString("title"));
            map.put("text",rs.getString("text"));
            map.put("term",rs.getString("term"));
            map.put("address",rs.getString("address"));
            list.add(map);
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
    <title>編集画面</title>
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
                      編集画面
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
          <form action="e_confirm.jsp">
              <input type="hidden" name="article_no" value="<%=article_noStr%>">
              <input type="hidden" name="design" value="<%=designStr%>">
              <div class="main <%=design[0]%> col-10 offset-1">
                  <div class="offset-1 my-4 disc">
                      各項目に入力してください
                  </div>
                  <div class="offset-1 my-2 disc">
                      タイトル
                  </div>
                  <div class="row ml-3 mb-4">
                      <input type="text" class="form-control-lg col-8" name="title" value="<%=list.get(0).get("title")%>" required>
                  </div>

                  <div class="row my-4">
                      <div class="<%=design[1]%> mx-2">
                        <img class="size_img" src="../images/sample.jpg">
                      </div>
                      <textarea class="<%=design[2]%> mx-2" name="text" rows="8" value="<%=list.get(0).get("text")%>"></textarea>
                  </div>

                <div class="note mx-2 my-4 p-4">
                  <div class="row offset-1 my-2">
                      <div class="disc col-3 text-center">期間:</div><div class="col-7 article_term"><input type="text" class="form-control" name="term" value="<%=list.get(0).get("term")%>" required></div>
                  </div>
                  <div class="row offset-1 my-2">
                      <div class="disc col-3 text-center">住所:</div><div class="col-7 article_term"><input type="text" class="form-control" name="address" value="<%=list.get(0).get("address")%>" required></div>
                  </div>
                </div>

                <div class="row my-5">
                    <div class="col-1 offset-3 text-center">
                        <input type="submit" class="btn btn-primary mb-2" value="確認画面へ">
                    </div>
                    <div class="col-1 offset-2">
                        <input type="reset" class="btn btn-primary mb-2" value="キャンセル">
                    </div>
                </div>

			  </div>
			</form>
		  </div>

      <div class="row">
        <div class="offset-10 mt-4 mb-5">
          <a class="btn btn-primary mb-2" href="../home.jsp" role="button">ホーム画面</a>
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
