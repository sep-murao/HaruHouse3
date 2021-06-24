<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="kokyaku.EditBL_customer"%>
<%@page import= "kokyaku.Cmmon_customer"%>

<%
  String CUST_OWNER = null;

  //EditBLから遷移されたデータを受け取る
  String ID = (String)request.getAttribute("ID");
  String CUST_KIND = (String)request.getAttribute("CUST_KIND");
  String CORP_NAME = (String)request.getAttribute("CORP_NAME");
  String CORP_NAME_KANA = (String)request.getAttribute("CORP_NAME_KANA");
  String CUST_DEPARTMENT_NAME = (String)request.getAttribute("CUST_DEPARTMENT_NAME");
  String CUST_L_NAME = (String)request.getAttribute("CUST_L_NAME");
  String CUST_F_NAME = (String)request.getAttribute("CUST_F_NAME");
  String CUST_L_NAME_KANA = (String)request.getAttribute("CUST_L_NAME_KANA");
  String CUST_F_NAME_KANA = (String)request.getAttribute("CUST_F_NAME_KANA");
  String CUST_ZIP = (String)request.getAttribute("CUST_ZIP");
  String CUST_PREFECTURE = (String)request.getAttribute("CUST_PREFECTURE");
  String CUST_ADDRESS1 = (String)request.getAttribute("CUST_ADDRESS1");
  String CUST_ADDRESS2 = (String)request.getAttribute("CUST_ADDRESS2");
  String CUST_TEL = (String)request.getAttribute("CUST_TEL");
  String CUST_TEL1 = (String)request.getAttribute("CUST_TEL1");
  String CUST_TEL2 = (String)request.getAttribute("CUST_TEL2");
  String CUST_TEL3 = (String)request.getAttribute("CUST_TEL3");
  String CUST_MOBILE = (String)request.getAttribute("CUST_MOBILE");
  String CUST_MOBILE1 = (String)request.getAttribute("CUST_MOBILE1");
  String CUST_MOBILE2 = (String)request.getAttribute("CUST_MOBILE2");
  String CUST_MOBILE3 = (String)request.getAttribute("CUST_MOBILE3");
  String CUST_MAIL = (String)request.getAttribute("CUST_MAIL");
  String[] CUST_MAIL_SEND_FLG = request.getParameterValues("CUST_MAIL_SEND_FLG");
  String FLG_MESSAGE ="";
  String MAIL_MESSAGE ="";
  String CUST_KINDname = Cmmon_customer.getCUST_KINDname(CUST_KIND); 
  String CUST_PREFECTUREname = Cmmon_customer.getCUST_PREFECTUREname(CUST_PREFECTURE);
  
  if(CUST_MAIL_SEND_FLG == null){
	  MAIL_MESSAGE ="メール送信しない";
	  FLG_MESSAGE ="0";
	  
     }else{
      MAIL_MESSAGE ="メール送信する";
      FLG_MESSAGE = "1";}
  %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>顧客変更確認</title>
</head>
<body>
<table>
   <tr><th>個人・法人区分 </th><td><%=CUST_KINDname%></td></tr>
   <tr><th>法人名</th><td><%=CORP_NAME%></td></tr>
   <tr><th>法人名カナ</th><td><%=CORP_NAME_KANA %></td></tr>
   <tr><th>部署</th><td><%=CUST_DEPARTMENT_NAME %></td></tr>
   <tr><th>姓</th><td><%=CUST_L_NAME %></td></tr>
   <tr><th>名</th><td><%=CUST_F_NAME%></td></tr>
   <tr><th>姓カナ</th><td><%=CUST_L_NAME_KANA %></td></tr>
   <tr><th>名カナ</th><td><%=CUST_F_NAME_KANA%></td></tr>
   <tr><th>郵便番号</th><td><%=CUST_ZIP %></td></tr>
   <tr><th>都道府県</th><td><%=CUST_PREFECTUREname %></td></tr> 
   <tr><th>住所</th><td><%=CUST_ADDRESS1 %></td></tr>
   <tr><th>建物名</th><td><%=CUST_ADDRESS2 %></td></tr>
   <tr><th>電話番号</th><td><%=CUST_TEL %></td></tr>
   <tr><th>携帯番号</th><td><%=CUST_MOBILE %></td></tr>
   <tr><th>メールアドレス</th><td><%=CUST_MAIL %></td></tr>
   <tr><th>退去立会終了後にメール送信</th><td><%=MAIL_MESSAGE%></td></tr>
   <tr><th><input type="checkbox" name="CUST_OWNER" value=<%=CUST_OWNER%>>同じ内容をオーナー情報にも登録する</th></tr>
</table>
<p>この情報で変更します。よろしいですか？</p>

<!--AddCommitBL_customerへデータを遷移-->
<form action="EditCommitBL_customer" method="Post">
<input type="hidden" name="ID" value=<%=ID %>>
<input type="hidden" name="CUST_KIND" value=<%=CUST_KIND %>>
<input type="hidden" name="CORP_NAME" value=<%=CORP_NAME%>>
<input type="hidden" name="CORP_NAME_KANA" value=<%=CORP_NAME_KANA %>>
<input type="hidden" name="CUST_DEPARTMENT_NAME" value="<%=CUST_DEPARTMENT_NAME%>">
<input type="hidden" name="CUST_L_NAME" value=<%=CUST_L_NAME %>>
<input type="hidden" name="CUST_F_NAME" value=<%=CUST_F_NAME %>>
<input type="hidden" name="CUST_L_NAME_KANA" value=<%=CUST_L_NAME_KANA %>>
<input type="hidden" name="CUST_F_NAME_KANA" value=<%=CUST_F_NAME_KANA %>>
<input type="hidden" name=CUST_ZIP value=<%=CUST_ZIP%>>
<input type="hidden" name="CUST_PREFECTURE" value=<%=CUST_PREFECTURE%>>
<input type="hidden" name="CUST_ADDRESS1" value=<%=CUST_ADDRESS1 %>>
<input type="hidden" name="CUST_ADDRESS2" value=<%=CUST_ADDRESS2 %>>
<input type="hidden" name="CUST_TEL1" value=<%=CUST_TEL1 %>>
<input type="hidden" name="CUST_TEL2" value=<%=CUST_TEL2 %>>
<input type="hidden" name="CUST_TEL3" value=<%=CUST_TEL3 %>>
<input type="hidden" name="CUST_MOBILE1" value=<%=CUST_MOBILE1 %>>
<input type="hidden" name="CUST_MOBILE2" value=<%=CUST_MOBILE2 %>>
<input type="hidden" name="CUST_MOBILE3" value=<%=CUST_MOBILE3 %>>
<input type="hidden" name="CUST_MAIL" value=<%=CUST_MAIL %>>
<input type="hidden" name="FLG_MESSAGE" value=<%=FLG_MESSAGE %>>
<input type="hidden" name="CUST_OWNER" value=<%=CUST_OWNER %>>

<input type="submit" value="変更" style="width:150px" id="button">
</form>

<!--Edit_customerへデータを遷移-->
<form method="POST" action="Edit_customer.jsp" >
<input type="hidden" name="ID" value=<%=ID %>>
<input type="hidden" name="CUST_KIND" value=<%=CUST_KIND %>>
<input type="hidden" name="CORP_NAME" value=<%=CORP_NAME%>>
<input type="hidden" name="CORP_NAME_KANA" value=<%=CORP_NAME_KANA %>>
<input type="hidden" name="CUST_DEPARTMENT_NAME" value=<%=CUST_DEPARTMENT_NAME%>>
<input type="hidden" name="CUST_L_NAME" value=<%=CUST_L_NAME %>>
<input type="hidden" name="CUST_F_NAME" value=<%=CUST_F_NAME %>>
<input type="hidden" name="CUST_L_NAME_KANA" value=<%=CUST_L_NAME_KANA %>>
<input type="hidden" name="CUST_F_NAME_KANA" value=<%=CUST_F_NAME_KANA %>>
<input type="hidden" name="CUST_ZIP" value=<%=CUST_ZIP%>>
<input type="hidden" name="CUST_PREFECTURE" value=<%=CUST_PREFECTURE%>>
<input type="hidden" name="CUST_ADDRESS1" value=<%=CUST_ADDRESS1 %>>
<input type="hidden" name="CUST_ADDRESS2" value=<%=CUST_ADDRESS2 %>>
<input type="hidden" name="CUST_TEL1" value=<%=CUST_TEL1 %>>
<input type="hidden" name="CUST_TEL2" value=<%=CUST_TEL2 %>>
<input type="hidden" name="CUST_TEL3" value=<%=CUST_TEL3 %>>
<input type="hidden" name="CUST_MOBILE1" value=<%=CUST_MOBILE1 %>>
<input type="hidden" name="CUST_MOBILE2" value=<%=CUST_MOBILE2 %>>
<input type="hidden" name="CUST_MOBILE3" value=<%=CUST_MOBILE3 %>>
<input type="hidden" name="CUST_MAIL" value=<%=CUST_MAIL %>>
<input type="hidden" name="FLG_MESSAGE" value=<%=FLG_MESSAGE %>>

<input type="submit" value="戻る" style="width:150px" >
</form>
</body>
</html>