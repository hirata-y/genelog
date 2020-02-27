<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.HashMap" %>
<%
	request.setCharacterEncoding("UTF-8");
	response.setCharacterEncoding("UTF-8");

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

	int del_count = 0;

  try{
		Class.forName(DRIVER).newInstance();
		con = DriverManager.getConnection(URL,USER,PASSWORD);
		stmt = con.createStatement();

  	    SQL = new StringBuffer();
  	    SQL.append("select user_no from user_tbl where user_name = 'suzuki'");
  	    rs = stmt.executeQuery(SQL.toString());

  	    if (rs.next()){
  	    	map = new HashMap<String,String>();
            map.put("user_no",rs.getString("user_no"));
            list.add(map);
		}

		SQL = new StringBuffer();
  	    SQL.append("delete from user_tbl where user_name = 'suzuki'");
		del_count = stmt.executeUpdate(SQL.toString());
		SQL = new StringBuffer();
  	    SQL.append("delete from article_tbl where user_no = '");
  	    SQL.append(list.get(0).get("user_no"));
  	    SQL.append("'");
		del_count = stmt.executeUpdate(SQL.toString());
		SQL = new StringBuffer();
  	    SQL.append("delete from favorite_tbl where user_no = '");
  	    SQL.append(list.get(0).get("user_no"));
  	    SQL.append("'");
		del_count = stmt.executeUpdate(SQL.toString());
		SQL = new StringBuffer();
  	    SQL.append("delete from archive_tbl where user_no = '");
  	    SQL.append(list.get(0).get("user_no"));
  	    SQL.append("'");
		del_count = stmt.executeUpdate(SQL.toString());
		SQL = new StringBuffer();
  	    SQL.append("alter table article_tbl auto_increment = 20");
		del_count = stmt.executeUpdate(SQL.toString());

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
    <title>テストデータ削除完了</title>
    <link rel="stylesheet" href="../css/bootstrap.css">
    <link rel="stylesheet" href="../css/common.css">
    <link rel="stylesheet" href="../css/all.css">
  </head>
  <body>
    <div class="container-fluid bg-slider">
		<div class="row p-4">
            <div class="main col-10 offset-1">
				<div class="row">
					<div class="col-12 text-center disc my-5">
						削除完了
					</div>
				</div>
            </div>
		</div>

        <div class="row">
            <div class="offset-10 mt-4 mb-a">
                <a class="btn btn-primary" href="../index.jsp" role="button">ログイン画面</a>
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
    </script>
  </body>
</html>
