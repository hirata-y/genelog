<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.HashMap" %>
<%
	request.setCharacterEncoding("UTF-8");
	response.setCharacterEncoding("UTF-8");

	String user_nameStr  = request.getParameter("user_name");
	String user_sexStr  = request.getParameter("user_sex");
	String user_birthStr  = request.getParameter("user_birth");
	String user_mailStr  = request.getParameter("user_mail");
	String user_passStr  = request.getParameter("user_pass");

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

		SQL.append("select * from user_tbl where user_name = '");
		SQL.append(user_nameStr);
		SQL.append("'");

		rs = stmt.executeQuery(SQL.toString());

		if(rs.next()){
			hit_flag = 1;

		}else{
			hit_flag = 0;
			SQL = new StringBuffer();
			SQL.append("insert into user_tbl(user_name,user_pass,user_mail,user_birth,user_sex)");
			SQL.append(" values('");
			SQL.append(user_nameStr);
			SQL.append("','");
			SQL.append(user_passStr);
			SQL.append("','");
			SQL.append(user_mailStr);
			SQL.append("','");
			SQL.append(user_birthStr);
			SQL.append("','");
			SQL.append(user_sexStr);
			SQL.append("')");
			ins_count = stmt.executeUpdate(SQL.toString());
		}

		if (ins_count == 1){
			SQL = new StringBuffer();
			SQL.append("select user_no from user_tbl where user_name = '");
			SQL.append(user_nameStr);
			SQL.append("'");
			rs = stmt.executeQuery(SQL.toString());
			if (rs.next()) {
				map = new HashMap<String,String>();
				map.put("user_no",rs.getString("user_no"));
				list.add(map);
				SQL = new StringBuffer();
				SQL.append("insert into archive_tbl(user_no,action)");
				SQL.append(" values('");
				SQL.append(list.get(0).get("user_no"));
				SQL.append("','");
				SQL.append(1);
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
    <title>登録完了画面</title>
    <link rel="stylesheet" href="../css/bootstrap.css">
    <link rel="stylesheet" href="../css/common.css">
  </head>
  <body>
    <div class="container-fluid bg-slider">

      <div class="row">
        <div class="title col-12 text-center my-5">
          登録完了画面
        </div>
      </div>

      <div class="main col-6 offset-3 p-4">
		  <% if(hit_flag == 1){ %>
		  <div class="disc">
		  	すでに存在しているIDです
		  </div>
		  <% }else if(ins_count == 0){ %>
		  <div class="disc">
		  	登録処理が失敗しました
		  </div>
		  <% }else{ %>
		  <div class="disc">
		  	<%= ins_count %>件登録しました
		  </div>
		  <% } %>
      </div>

        <div class="row col-2 offset-8">
            <a class="btn btn-primary mt-5 mb-a" href="../index.jsp" role="button">ログイン画面へ</a>
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
