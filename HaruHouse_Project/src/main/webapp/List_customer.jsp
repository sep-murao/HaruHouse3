<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="kokyaku.ListBL_customer"%>
<%@page import= "kokyaku.Cmmon_customer"%>
<%ResultSet rs = null;
  int listCnt = 0;
  String nowPage = null;
  String updFlg = "0";
  int maxPage = 0;
  
  Statement stmt = null;
  Connection con = null;
  
  nowPage = (String)request.getAttribute("nowPage");
  if(nowPage == null){
	  nowPage = "1";

  }
  
  listCnt = (int)request.getAttribute("listCnt");
  updFlg = (String)request.getAttribute("updFlg");
  
  rs = (ResultSet)request.getAttribute("Result");
  
  ResultSet rs1 = Cmmon_customer.CUST_KINDAll();          //個人・法人プルダウン
  ResultSet rs2 = Cmmon_customer.CUST_PREFECTURAll();    //都道府県プルダウン
  ResultSet rs3 = Cmmon_customer.STATUSAll();           //ステータスプルダウン
   
  //maxPageに余りがあった時
  maxPage = listCnt / 10;
  int DivisionMaxPage = listCnt % 10;
  
  if(!(DivisionMaxPage == 0)){
	  maxPage ++;
  }
  
  if(maxPage == 0){
	  maxPage = 1;
  }
  
  rs = (ResultSet)request.getAttribute("Result");
  
  try{
      Class.forName("com.mysql.cj.jdbc.Driver");
      con = DriverManager.getConnection("jdbc:mysql://localhost:3306/harudb","root","");
      
      stmt = con.createStatement();

     //内部結合は全項目セレクト
      String sql = "select * from mst_customer ";
      
      
  }catch(Exception e){
		e.printStackTrace();
   }
  
  String SearchCUST_KIND=(String)request.getAttribute("SearchCUST_KIND");
  String SearchCORP_NAME=(String)request.getAttribute("SearchCORP_NAME");
  String SearchCORP_NAME_KANA=(String)request.getAttribute("SearchCORP_NAME_KANA");
  String SearchCUST_NAME=(String)request.getAttribute("SearchCUST_NAME");
  String SearchCUST_NAME_KANA=(String)request.getAttribute("SearchCUST_NAME_KANA");
  String SearchCUST_ZIP=(String)request.getAttribute("SearchCUST_ZIP");
  String SearchCUST_PREFECTURE=(String)request.getAttribute("SearchCUST_PREFECTURE");
  String SearchCUST_ADDRESS1=(String)request.getAttribute("SearchCUST_ADDRESS1");
  String SearchCUST_ADDRESS2=(String)request.getAttribute("SearchCUST_ADDRESS2");
  String SearchCUST_TEL=(String)request.getAttribute("SearchCUST_TEL");
  String SearchCUST_MOBILE=(String)request.getAttribute("SearchCUST_MOBILE");
  String SearchCUST_MAIL=(String)request.getAttribute("SearchCUST_MAIL");
  String SearchSTATUS=(String)request.getAttribute("SearchSTATUS");
  
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
<link rel="stylesheet" href="${pageContext.request.contextPath}/List_customer.css">
<title>顧客管理</title>
</head>
<body>
<!--検索機能 -->
<form action="ListBL_customer" method="Post">
<input type="hidden" name="flg" value=1>

<!--検索項目テーブル -->
<table class="S_table">
	<tr>
		<td>個人・法人区分</td><td><select name="SearchCUST_KIND"><option ></option>
			<%while(rs1.next()) {%>
			   <option value=<%=rs1.getString("CODE_BRANCH_NUM") %>><%=rs1.getString("CODE_NAME") %></option>
			<%}%>
		   </select>
		</td>
		
		<td>法人名</td><td><input type="text" name="SearchCORP_NAME" ></td>
		<td>法人名カナ</td><td><input type="text" name="SearchCORP_NAME_KANA" ></td>
	</tr>
	<tr>
		<td>顧客名</td><td><input type="text" name="SearchCUST_NAME" ></td>		
		<td>顧客名カナ</td><td><input type="text" name="SearchCUST_NAME_KANA" ></td>
		<td>郵便番号</td><td><input type="text" name="SearchCUST_ZIP" ></td>
	</tr>
	<tr>
		<td>都道府県</td><td><select name="SearchCUST_PREFECTURE"><option ></option>
		   <%while(rs2.next()) {%>
		   <option value=<%=rs2.getString("CODE_BRANCH_NUM") %>><%=rs2.getString("CODE_NAME") %></option>
		   <%}%>
		   </select>
		</td>
		<td>住所</td><td><input type="text" name="SearchCUST_ADDRESS1" ></td>
		<td>建物名</td><td><input type="text" name="SearchCUST_ADDRESS2" ></td>
	</tr>
	<tr>	
		<td>電話番号</td><td><input type="text" name="SearchCUST_TEL" ></td>
		<td>携帯番号</td><td><input type="text" name="SearchCUST_MOBILE" ></td>
		<td>メールアドレス</td><td><input type="text" name="SearchCUST_MAIL" ></td>
	</tr>
	<tr>	
	    <td>ステータス</td><td><select name="SearchSTATUS"><option ></option>
		   <%while(rs3.next()) {%>
		   <option value=<%=rs3.getString("CODE_BRANCH_NUM") %>><%=rs3.getString("CODE_NAME") %></option>
		   <%}%>
		   </select>
		</td>	
	</tr>
</table>
</div>
<input type="hidden" name="updFlg" value=0>
<input type="submit" value="検索"id="search">
<input type="submit" value="リセット"id="search">
</form>

<!--新規登録 -->
<form method="POST" action="Add_customer.jsp" name="">
<input type="submit" value="新規登録" style="width:100px" id="">
</form>

<!--ページング -->
<ul class="Paging">
<%int now = Integer.parseInt(nowPage); %>
		
		<!-- nowPage=1 の時文字列にする -->
	<%if(now == 1){ %>
	<li> 前へ</li>
	
	<%}else{ %>
	<form method="post" name="Return_Search" action="ListBL_customer">
		<input type="hidden" name="SearchCUST_KIND" value=<%=SearchCUST_KIND%>>
		<input type="hidden" name="	SearchCORP_NAME" value=<%=SearchCORP_NAME%>>
		<input type="hidden" name="SearchCORP_NAME_KANA" value=<%=SearchCORP_NAME_KANA%>>
		<input type="hidden" name="SearchCUST_NAME"	value=<%=SearchCUST_NAME%>>
		<input type="hidden" name="SearchCUST_NAME_KANA" value=<%=SearchCUST_NAME_KANA%>>
		<input type="hidden" name="SearchCUST_ZIP" value=<%=SearchCUST_ZIP%>>
		<input type="hidden" name="SearchCUST_PREFECTURE" value=<%=SearchCUST_PREFECTURE%>>
		<input type="hidden" name="SearchCUST_ADDRESS1"	value=<%=SearchCUST_ADDRESS1%>>
		<input type="hidden" name="SearchCUST_ADDRESS2"	value=<%=SearchCUST_ADDRESS2%>>
		<input type="hidden" name="SearchCUST_TEL" value=<%=SearchCUST_TEL%>>
		<input type="hidden" name="SearchCUST_MOBILE" value=<%=SearchCUST_MOBILE%>>
		<input type="hidden" name="SearchCUST_MAIL"	value=<%=SearchCUST_MAIL%>>
		<input type="hidden" name="SearchSTATUS" value=<%=SearchSTATUS%>>
		<input type="hidden" name="nowPage" value=<%=now - 1%>>
	
	<li> <a href= "javascript:Return_Search.submit()" > 前へ</a> </li>
	</form>
	<%} %>

		<!--ページ数が１か２の時 -->
	 <%if(now == 1 || now == 2){
	 
		    for (int i = 1; i <= 5; i++){        // 5になるまで1を足して繰り返す
		    	
		    	if(i <= maxPage){                  // maxPageよりiが大きいと表示しない
		    	
			    	if(i == now){                    // 見ているページ数とiが同じ場合リンクを生成しない %> 
			    	<li> [<%=i %>]</li>
			    	
			    	<% }else{%>
						<form method="post" name="1to2_Search<%=i %>" action="ListBL_customer">
						<input type="hidden" name="SearchCUST_KIND" value=<%=SearchCUST_KIND%>>
						<input type="hidden" name="	SearchCORP_NAME" value=<%=SearchCORP_NAME%>>
						<input type="hidden" name="SearchCORP_NAME_KANA" value=<%=SearchCORP_NAME_KANA%>>
						<input type="hidden" name="SearchCUST_NAME"	value=<%=SearchCUST_NAME%>>
						<input type="hidden" name="SearchCUST_NAME_KANA" value=<%=SearchCUST_NAME_KANA%>>
						<input type="hidden" name="SearchCUST_ZIP" value=<%=SearchCUST_ZIP%>>
						<input type="hidden" name="SearchCUST_PREFECTURE" value=<%=SearchCUST_PREFECTURE%>>
						<input type="hidden" name="SearchCUST_ADDRESS1"	value=<%=SearchCUST_ADDRESS1%>>
						<input type="hidden" name="SearchCUST_ADDRESS2"	value=<%=SearchCUST_ADDRESS2%>>
						<input type="hidden" name="SearchCUST_TEL" value=<%=SearchCUST_TEL%>>
						<input type="hidden" name="SearchCUST_MOBILE" value=<%=SearchCUST_MOBILE%>>
						<input type="hidden" name="SearchCUST_MAIL"	value=<%=SearchCUST_MAIL%>>
						<input type="hidden" name="SearchSTATUS" value=<%=SearchSTATUS%>>
						<input type="hidden" name="nowPage" value=<%=i %>>
			    	
			        <li> <a href= "javascript:1to2_Search<%=i %>.submit()" ><%=i%></a> </li>
			        </form>
				<% }%>
			 <%}
	 }%>

		<!--ページ数が３～(maxPage - 2)の時 -->
	<%}else if( now >= 3 && now <= maxPage - 2  ){
	    for (int i = now -2 ; i <= now +2; i++){        // now - 2になるまで1を足して繰り返す
	    	
	    	if(i <= maxPage){                  // maxPageよりiが大きいと表示しない
	    	
		    	if(i == now){                    // 見ているページ数とiが同じ場合リンクを生成しない %> 
		    	<li>[ <%=i %>]</li>
		    	
			    	<% }else{%>
			    	<form method="post" name="3_Search<%=i %>" action="ListBL_customer">
						<input type="hidden" name="SearchCUST_KIND" value=<%=SearchCUST_KIND%>>
						<input type="hidden" name="	SearchCORP_NAME" value=<%=SearchCORP_NAME%>>
						<input type="hidden" name="SearchCORP_NAME_KANA" value=<%=SearchCORP_NAME_KANA%>>
						<input type="hidden" name="SearchCUST_NAME"	value=<%=SearchCUST_NAME%>>
						<input type="hidden" name="SearchCUST_NAME_KANA" value=<%=SearchCUST_NAME_KANA%>>
						<input type="hidden" name="SearchCUST_ZIP" value=<%=SearchCUST_ZIP%>>
						<input type="hidden" name="SearchCUST_PREFECTURE" value=<%=SearchCUST_PREFECTURE%>>
						<input type="hidden" name="SearchCUST_ADDRESS1"	value=<%=SearchCUST_ADDRESS1%>>
						<input type="hidden" name="SearchCUST_ADDRESS2"	value=<%=SearchCUST_ADDRESS2%>>
						<input type="hidden" name="SearchCUST_TEL" value=<%=SearchCUST_TEL%>>
						<input type="hidden" name="SearchCUST_MOBILE" value=<%=SearchCUST_MOBILE%>>
						<input type="hidden" name="SearchCUST_MAIL"	value=<%=SearchCUST_MAIL%>>
						<input type="hidden" name="SearchSTATUS" value=<%=SearchSTATUS%>>
						<input type="hidden" name="nowPage" value=<%=i %>>
						
			        <li> <a href= "javascript:3_Search<%=i %>.submit()" ><%=i%></a> </li>
			        </form>
				<% }%>     
	    	<% }
	
	    }%>
	
		<!--ページ数が最終ぺージか最終ページ1つ前の時 -->	
	<%}else{ 
	    for (int i = maxPage -4 ; i <= maxPage; i++){        // now - 2になるまで1を足して繰り返す
	    	
	    	if(1 <= i){                  // maxPageよりiが大きいと表示しない
	    	
		    	if(i == now){                    // 見ているページ数とiが同じ場合リンクを生成しない %> 
		    	<li> [<%=i %>]</li>
		    	
			    	<% }else{%>
			    	<form method="post" name="last_Search" action="ListBL_customer">
						<input type="hidden" name="SearchCUST_KIND" value=<%=SearchCUST_KIND%>>
						<input type="hidden" name="	SearchCORP_NAME" value=<%=SearchCORP_NAME%>>
						<input type="hidden" name="SearchCORP_NAME_KANA" value=<%=SearchCORP_NAME_KANA%>>
						<input type="hidden" name="SearchCUST_NAME"	value=<%=SearchCUST_NAME%>>
						<input type="hidden" name="SearchCUST_NAME_KANA" value=<%=SearchCUST_NAME_KANA%>>
						<input type="hidden" name="SearchCUST_ZIP" value=<%=SearchCUST_ZIP%>>
						<input type="hidden" name="SearchCUST_PREFECTURE" value=<%=SearchCUST_PREFECTURE%>>
						<input type="hidden" name="SearchCUST_ADDRESS1"	value=<%=SearchCUST_ADDRESS1%>>
						<input type="hidden" name="SearchCUST_ADDRESS2"	value=<%=SearchCUST_ADDRESS2%>>
						<input type="hidden" name="SearchCUST_TEL" value=<%=SearchCUST_TEL%>>
						<input type="hidden" name="SearchCUST_MOBILE" value=<%=SearchCUST_MOBILE%>>
						<input type="hidden" name="SearchCUST_MAIL"	value=<%=SearchCUST_MAIL%>>
						<input type="hidden" name="SearchSTATUS" value=<%=SearchSTATUS%>>
						<input type="hidden" name="nowPage" value=<%=i %>>
						
			        <li> <a href= "javascript:last_Search.submit()" ><%=i%></a> </li>
			        </form>
				<% }
	    	}
	
	    }
	} %>
	
		<!-- nowPage=maxPage の時文字列にする -->
	<%if(now == maxPage){%>
	<li> 次へ</li>
	
	<%}else{ %>
	<form method="post" name="Next_Search" action="ListBL_customer">
		<input type="hidden" name="SearchCUST_KIND" value=<%=SearchCUST_KIND%>>
		<input type="hidden" name="	SearchCORP_NAME" value=<%=SearchCORP_NAME%>>
		<input type="hidden" name="SearchCORP_NAME_KANA" value=<%=SearchCORP_NAME_KANA%>>
		<input type="hidden" name="SearchCUST_NAME"	value=<%=SearchCUST_NAME%>>
		<input type="hidden" name="SearchCUST_NAME_KANA" value=<%=SearchCUST_NAME_KANA%>>
		<input type="hidden" name="SearchCUST_ZIP" value=<%=SearchCUST_ZIP%>>
		<input type="hidden" name="SearchCUST_PREFECTURE" value=<%=SearchCUST_PREFECTURE%>>
		<input type="hidden" name="SearchCUST_ADDRESS1"	value=<%=SearchCUST_ADDRESS1%>>
		<input type="hidden" name="SearchCUST_ADDRESS2"	value=<%=SearchCUST_ADDRESS2%>>
		<input type="hidden" name="SearchCUST_TEL" value=<%=SearchCUST_TEL%>>
		<input type="hidden" name="SearchCUST_MOBILE" value=<%=SearchCUST_MOBILE%>>
		<input type="hidden" name="SearchCUST_MAIL"	value=<%=SearchCUST_MAIL%>>
		<input type="hidden" name="SearchSTATUS" value=<%=SearchSTATUS%>>
		<input type="hidden" name="nowPage" value=<%=now + 1 %>>
		
	<li> <a href= "javascript:Next_Search.submit()" > 次へ </a> </li>
	</form>
	<%} %>
</ul>

<!-- 一覧表示 -->
<table class="L_table" border="2" style="border-collapse: collapse">
	<tr>
		<th> </th>
		<th>ステータス</th>
		<th>顧客名<p>顧客名カナ</p></th>
		<th>法人名<p>法人名カナ</p></th>
		<th>郵便番号<p>住所</p><p>建物名</p></th>
		<th>メールアドレス</th>
		<th>電話番号<p>携帯番号</p></th>
		<th>登録日<p>更新日</p></th>
	</tr>
	<%while(rs.next()){
		int ID = rs.getInt("ID");
		String CUST_KIND =rs.getString("CUST_KIND");
	    String CORP_NAME =rs.getString("CUST_CORP_NAME");
	    String CORP_NAME_KANA =rs.getString("CUST_CORP_NAME_KANA");
	    String CUST_DEPARTMENT_NAME =rs.getString("CUST_DEPARTMENT_NAME");
	    String CUST_L_NAME =rs.getString("CUST_L_NAME");
        String CUST_F_NAME =rs.getString("CUST_F_NAME");
	    String CUST_L_NAME_KANA =rs.getString("CUST_L_NAME_KANA");
	    String CUST_F_NAME_KANA =rs.getString("CUST_F_NAME_KANA");
	    String CUST_ZIP =rs.getString("CUST_ZIP");
	    String CUST_PREFECTURE =rs.getString("CUST_PREFECTURE");
	    String CUST_ADDRESS1 =rs.getString("CUST_ADDRESS1");
        String CUST_ADDRESS2 =rs.getString("CUST_ADDRESS2");
	    String CUST_TEL1 =rs.getString("CUST_TEL1");
	    String CUST_TEL2 =rs.getString("CUST_TEL2");
	    String CUST_TEL3 =rs.getString("CUST_TEL3");
	    String CUST_MOBILE1 =rs.getString("CUST_MOBILE1");
	    String CUST_MOBILE2 =rs.getString("CUST_MOBILE2");
	    String CUST_MOBILE3 =rs.getString("CUST_MOBILE3");
	    String CUST_MAIL =rs.getString("CUST_MAIL");
	    String STATUS =rs.getString("STATUS");
	    String REGIST_DATE =rs.getString("REGIST_DATE");
	    String UPDATE_DATE =rs.getString("UPDATE_DATE");
	    
	    String CUST_TEL = CUST_TEL1 + "-" + CUST_TEL2 + "-" + CUST_TEL3;
    	String CUST_MOBILE = CUST_MOBILE1 + "-" + CUST_MOBILE2 + "-" + CUST_MOBILE3;
	  
	%>
	<tr>
	<!-- 変更画面へ送るデータ -->
	 <form method="GET" name="form_<%=ID %>">
		<input type="hidden" name="ID" value=<%=ID %>>
		<input type="hidden" name="CUST_KIND" value=<%=CUST_KIND %>>
		<input type="hidden" name="CORP_NAME" value=<%=CORP_NAME%>>
		<input type="hidden" name="CORP_NAME_KANA" value=<%=CORP_NAME_KANA %>>
		<input type="hidden" name="CUST_DEPARTMENT_NAME" value=<%=CUST_DEPARTMENT_NAME%>>
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
		
		<td><input type="submit" value="変更" formaction="Edit_customer.jsp"></td>
	 </form>
	 
	 <!-- ステータス更新 -->
	 <form action="ListBL_customer" method="POST">
	 <input type="hidden" name="flg" value=2>
	 <input type="hidden" name="ID" value=<%=ID %>>
	 <input type="hidden" name="nowPage" value=<%=nowPage %>>
	 <input type="hidden" name="updFlg" value=1>
		<td><select name="STATUS"><option ></option>
		   <%rs3.beforeFirst(); %>
		   	<%while(rs3.next()){%>
		   	<% String bNum = rs3.getString("CODE_BRANCH_NUM"); %>
		   	
		   <option value=<%=rs3.getString("CODE_BRANCH_NUM") %> 
		   <% if(rs3.getString("CODE_BRANCH_NUM").equals(STATUS)){ %>
		    selected
		    <%}%>
		   ><%=rs3.getString("CODE_NAME") %></option>
			<%}%>
		  </select>
		   <p><input type="submit" value="実行"id=""></p>
		</td>
		<!-- hiddenでnowpage追加 -->
	 </form>
	 
	 <!-- DB情報表示 -->
		<td><%=CUST_L_NAME %> <%=CUST_F_NAME %>
		 <p><%=CUST_L_NAME_KANA %> <%=CUST_F_NAME_KANA %></p></td>
		<td><%=CORP_NAME%><p><%=CORP_NAME_KANA %></p></td>
		<td><%=CUST_ZIP%><p><%=CUST_ADDRESS1 %></p><p><%=CUST_ADDRESS2 %></p></td>
		<td><%=CUST_MAIL %></td>
		<td><%=CUST_TEL %><p><%=CUST_MOBILE %></p></td>
		<td><%=REGIST_DATE %><p><%=UPDATE_DATE %></p></td>
	 </tr>
		
		<%}%>
 </table>
 <%if(updFlg.equals("1")){%>
 <script>
 alert("ステータス更新が完了しました。");
 </script>
 <% }%>
</body>
</html>