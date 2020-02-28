<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.File" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="org.apache.commons.fileupload.FileItem" %>
<%@ page import="org.apache.commons.fileupload.FileUploadException" %>
<%@ page import="org.apache.commons.fileupload.disk.DiskFileItemFactory" %>
<%@ page import="org.apache.commons.fileupload.servlet.ServletFileUpload" %>
<% request.setCharacterEncoding("UTF-8");
// 	 private static final long serialVersionUID = 1L;
	 FileItem fItem = null;
	 FileItem fItem1 = null; 
	 String str_name = null;
	 String str_value = null;
	 
	 	//(1)アップロードファイルを格納するPATHを取得
	    String path = getServletContext().getRealPath("./image");

	    //(2)ServletFileUploadオブジェクトを生成
	    DiskFileItemFactory factory = new DiskFileItemFactory();
	    ServletFileUpload upload = new ServletFileUpload(factory);
	    
	    //(3)アップロードする際の基準値を設定
	    factory.setSizeThreshold(1024);  //byte
	    upload.setSizeMax(-1);	//-1はファイルサイズに制限なし

	    try {
	      //出力先ファイル名を取得
	      //(4)ファイルデータ(FileItemオブジェクト)を取得し、
	      //   Listオブジェクトとして返す
	      List list = upload.parseRequest(request);

	      //(5)ファイルデータ(FileItemオブジェクト)を順に処理
	      Iterator iterator = list.iterator();
	      while(iterator.hasNext()){
	        fItem = (FileItem)iterator.next();
	      
	        //(6)フォームデータの場合
	        if((fItem.isFormField())){
	        	 //フォーム項目についての処理 
	        	 str_name = fItem.getFieldName();	// フォームのnameパラメータを取得
	        	 str_value = fItem.getString(); 	// フォームのvalueパラメータを取得
	        	if (str_name.equals("out_name")) {
	        		//出力ファイル名を変更する場合
	        		fItem1.write(new File(path + "/" + str_value + ".jpg"));
	        	}
	        }else{
	        	//ファイルデータの場合
	        	 fItem1 = fItem; //ファイルデータを退避
	        }
	      }
	    }catch (FileUploadException e) {
	      e.printStackTrace();
	    }catch (Exception e) {
	      e.printStackTrace();
	    }
 %>
 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <title>ファイルアップロード</title>
  </head>
 
<body>
  <h2>ファイルアップロード成功</h2>
  <img src="image/<%= str_value %>.jpg" width="200" alt="サンプル画像"/>
</body>
</html>
