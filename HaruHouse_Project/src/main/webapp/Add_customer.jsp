<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="kokyaku.AddBL_customer"%>
<%@page import= "kokyaku.Cmmon_customer"%>
<%@page import="java.sql.ResultSet"%>

<%   String CUST_KIND =null;              //個人・法人区分
     String CORP_NAME =null;              //法人名
     String CORP_NAME_KANA =null;         //法人名カナ
     String CUST_DEPARTMENT_NAME =null;   //部署
     String CUST_L_NAME =null;            //姓
     String CUST_F_NAME =null;            //名
     String CUST_L_NAME_KANA =null;       //姓カナ
     String CUST_F_NAME_KANA =null;       //名カナ
     String CUST_ZIP =null;               //郵便番号
     String CUST_PREFECTURE =null;        //都道府県
     String CUST_ADDRESS1 =null;          //住所
     String CUST_ADDRESS2 =null;          //建物名
     String CUST_TEL1 =null;              //市外局番
     String CUST_TEL2 =null;              //市内局番
     String CUST_TEL3 =null;              //電話番号
     String CUST_MOBILE1 =null;           //携帯番号1
     String CUST_MOBILE2 =null;           //携帯番号2
     String CUST_MOBILE3 =null;           //携帯番号3
     String CUST_MAIL =null;              //メールアドレス
     String errmsg ="";                   //エラーメッセージ
     
     ResultSet rs1 = Cmmon_customer.CUST_KINDAll();        //個人・法人区分用プルダウン
     ResultSet rs2 = Cmmon_customer.CUST_PREFECTURAll();   //都道府県用プルダウン
     
     if( (String)request.getAttribute("CUST_L_NAME")== null){
    	 
    	 //新規登録ボタンから遷移
    	 if(request.getParameter("CUST_L_NAME")== null){
   
    	  CUST_KIND ="";
    	  CORP_NAME ="";
    	  CORP_NAME_KANA ="";
    	  CUST_DEPARTMENT_NAME ="";
    	  CUST_L_NAME ="";
    	  CUST_F_NAME ="";
    	  CUST_L_NAME_KANA ="";
    	  CUST_F_NAME_KANA ="";
    	  CUST_ZIP ="";
    	  CUST_PREFECTURE ="";
    	  CUST_ADDRESS1 ="";
    	  CUST_ADDRESS2 ="";
    	  CUST_TEL1 ="";
    	  CUST_TEL2 ="";
    	  CUST_TEL3 ="";
    	  CUST_MOBILE1 ="";
    	  CUST_MOBILE2 ="";
    	  CUST_MOBILE3 ="";
    	  CUST_MAIL ="";
    	  errmsg ="";
    	     
    	 //確認画面から遷移
    	 }else{
    	   CUST_KIND = request.getParameter("CUST_KIND");
    	   CORP_NAME = request.getParameter("CORP_NAME");
    	   CORP_NAME_KANA = request.getParameter("CORP_NAME_KANA");
    	   CUST_DEPARTMENT_NAME = request.getParameter("CUST_DEPARTMENT_NAME");
           CUST_L_NAME = request.getParameter("CUST_L_NAME");
    	   CUST_F_NAME = request.getParameter("CUST_F_NAME");
    	   CUST_L_NAME_KANA = request.getParameter("CUST_L_NAME_KANA");
    	   CUST_F_NAME_KANA = request.getParameter("CUST_F_NAME_KANA");
    	   CUST_ZIP = request.getParameter("CUST_ZIP");
    	   CUST_PREFECTURE = request.getParameter("CUST_PREFECTURE");
    	   CUST_ADDRESS1 = request.getParameter("CUST_ADDRESS1");
    	   CUST_ADDRESS2 = request.getParameter("CUST_ADDRESS2");
    	   CUST_TEL1 = request.getParameter("CUST_TEL1");
    	   CUST_TEL2 = request.getParameter("CUST_TEL2");
    	   CUST_TEL3 = request.getParameter("CUST_TEL3");
    	   CUST_MOBILE1 = request.getParameter("CUST_MOBILE1");
    	   CUST_MOBILE2 = request.getParameter("CUST_MOBILE2");
    	   CUST_MOBILE3 = request.getParameter("CUST_MOBILE3");
    	   CUST_MAIL = request.getParameter("CUST_MAIL");
    	   errmsg ="";
    	 }
    	 
     //エラーが出た場合
     }else{
    	 CUST_KIND = (String)request.getAttribute("CUST_KIND");
    	 CORP_NAME = (String)request.getAttribute("CORP_NAME");
    	 CORP_NAME_KANA = (String)request.getAttribute("CORP_NAME_KANA");
    	 CUST_DEPARTMENT_NAME = (String)request.getAttribute("CUST_DEPARTMENT_NAME");
    	 CUST_L_NAME = (String)request.getAttribute("CUST_L_NAME");
    	 CUST_F_NAME = (String)request.getAttribute("CUST_F_NAME");
    	 CUST_L_NAME_KANA = (String)request.getAttribute("CUST_L_NAME_KANA");
    	 CUST_F_NAME_KANA = (String)request.getAttribute("CUST_F_NAME_KANA");
    	 CUST_ZIP = (String)request.getAttribute("CUST_ZIP");
    	 CUST_PREFECTURE = (String)request.getAttribute("CUST_PREFECTURE");
    	 CUST_ADDRESS1 = (String)request.getAttribute("CUST_ADDRESS1");
    	 CUST_ADDRESS2 = (String)request.getAttribute("CUST_ADDRESS2");
    	 CUST_TEL1 = (String)request.getAttribute("CUST_TEL1");
    	 CUST_TEL2 = (String)request.getAttribute("CUST_TEL2");
    	 CUST_TEL3 = (String)request.getAttribute("CUST_TEL3");
    	 CUST_MOBILE1 = (String)request.getAttribute("CUST_MOBILE1");
    	 CUST_MOBILE2 = (String)request.getAttribute("CUST_MOBILE2");
    	 CUST_MOBILE3 = (String)request.getAttribute("CUST_MOBILE3");
    	 CUST_MAIL = (String)request.getAttribute("CUST_MAIL");
    	 errmsg = (String)request.getAttribute("errmsg");
     }
     
     %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Language" content="ja" />
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta name="Description" content="" />
<meta name="Keywords" content="" />
<meta http-equiv="Content-Style-Type" content="text/css" />

<meta charset="UTF-8">
<link rel="stylesheet" href="AddEdit_customer.css">
<title>顧客登録入力</title>
</head>
<body>
<form action="AddBL_customer" method="Post">
<!-- 登録項目 -->
<table>
   <tr><th align="left">個人・法人区分 </th><td><select name="CUST_KIND">
	<option ></option>
	<%while(rs1.next()) {
	%>
	   <option value=<%=rs1.getString("CODE_BRANCH_NUM") %>><%=rs1.getString("CODE_NAME") %></option>
	<%}%>
   </select></td></tr>

   <tr><th align="left">法人名</th><td><input type="text" name="CORP_NAME" style=width:300px value=<%=CORP_NAME%>></td></tr>
   <tr><th align="left">法人名カナ</th><td><input type="text" name="CORP_NAME_KANA" style=width:300px value=<%=CORP_NAME_KANA%>></td></tr>
   <tr><th align="left">部署</th><td><input type="text" name="CUST_DEPARTMENT_NAME" style=width:300px value=<%=CUST_DEPARTMENT_NAME %>></td></tr>
   <tr><th align="left">姓</th><td><input type="text" name="CUST_L_NAME" style=width:300px value=<%=CUST_L_NAME%>></td></tr>
   <tr><th align="left">名</th><td><input type="text" name="CUST_F_NAME" style=width:300px value=<%=CUST_F_NAME%>></td></tr>
   <tr><th align="left">姓カナ</th><td><input type="text" name="CUST_L_NAME_KANA" style=width:300px value=<%=CUST_L_NAME_KANA%>></td></tr>
   <tr><th align="left">名カナ</th><td><input type="text" name="CUST_F_NAME_KANA" style=width:300px value=<%=CUST_F_NAME_KANA%>></td></tr>
   <tr><th align="left">郵便番号</th><td><input type="text" name="CUST_ZIP" style=width:300px value=<%=CUST_ZIP%>></td></tr>
   <tr><th align="left">都道府県</th><td><select name="CUST_PREFECTURE">
   <option ></option>
   <%while(rs2.next()) {
   %>
   <option value=<%=rs2.getString("CODE_BRANCH_NUM") %>><%=rs2.getString("CODE_NAME") %></option>
   <%}%>
   </select></td></tr>
   
   <tr><th align="left">住所</th><td><input type="text" name="CUST_ADDRESS1" style=width:300px value=<%=CUST_ADDRESS1%>></td></tr>
   <tr><th align="left">建物名</th><td><input type="text" name="CUST_ADDRESS2" style=width:300px value=<%=CUST_ADDRESS2%>></td></tr>
   <tr><th align="left">電話番号</th><td><input type="text" name="CUST_TEL1" style=width:50px value=<%=CUST_TEL1%>>-
   		   <input type="text" name="CUST_TEL2" style=width:50px value=<%=CUST_TEL2%>>-
   		   <input type="text" name="CUST_TEL3" style=width:50px value=<%=CUST_TEL3%>></td></tr>
   <tr><th align="left">携帯番号</th><td><input type="text" name="CUST_MOBILE1" style=width:50px value=<%=CUST_MOBILE1%>>-
           <input type="text" name="CUST_MOBILE2" style=width:50px value=<%=CUST_MOBILE2%>>-
           <input type="text" name="CUST_MOBILE3" style=width:50px value=<%=CUST_MOBILE3%>></td></tr>
   <tr><th align="left">メールアドレス</th><td><input type="text" name="CUST_MAIL" style=width:300px value=<%=CUST_MAIL%>></td></tr>
</table>
<p><div class="send_mail"><input type="checkbox" name="CUST_MAIL_SEND_FLG"checked>退去立会終了後にメール送信</div></p>

<div class="Next">
<input type="submit" value="確認" >
</form>

<form method="POST" action="ListBL_customer" >
<input type="hidden" name="flg" value=1>
<input type="submit" value="一覧へ戻る">
</form>
</div>

<p><%=errmsg %></p>

</body>
</html>