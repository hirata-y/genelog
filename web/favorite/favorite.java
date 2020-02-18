language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
import="java.sql.*"
import="java.util.ArrayList"
import="java.util.HashMap"

	request.setCharacterEncoding("UTF-8");
	response.setCharacterEncoding("UTF-8");

	String user_noStr = (String) session.getAttribute("user_no");
	String article_noStr = request.getParameter("article_no");

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

	HashMap<String,String> map = null;
	ArrayList<HashMap> list = null;
	list = new ArrayList<HashMap>();

  try{
		Class.forName(DRIVER).newInstance();
		con = DriverManager.getConnection(URL,USER,PASSWORD);
		stmt = con.createStatement();

  	    SQL = new StringBuffer();
		SQL.append("insert into favorite_tbl(user_no,article_no) values('");
		SQL.append(user_noStr);
		SQL.append("','");
		SQL.append(article_noStr);
		SQL.append("')");
		ins_count = stmt.executeUpdate(SQL.toString());

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
        response.sendRedirect("../home.jsp");