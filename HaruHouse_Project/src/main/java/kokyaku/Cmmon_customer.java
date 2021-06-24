package kokyaku;

import java.io.UnsupportedEncodingException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;

public class Cmmon_customer {
	private static final String ResultSet = null;
	
	   Connection conn =null;
	    static final String URL = "jdbc:mysql://localhost/harudb?useUnicode=true&characterEncoding=utf8";
	    static final String USERNAME = "root";
	    static final String PASSWORD = "";  

	 //エラーチェック
	    public static String getError(String CUST_KIND ,String CORP_NAME,String CORP_NAME_KANA,String CUST_DEPARTMENT_NAME,String CUST_L_NAME,String CUST_F_NAME,String CUST_L_NAME_KANA,String CUST_F_NAME_KANA,String CUST_ZIP,String CUST_PREFECTURE,
	    		String CUST_ADDRESS1,String CUST_ADDRESS2,String CUST_TEL1,String CUST_TEL2,String CUST_TEL3,String CUST_MOBILE1,String CUST_MOBILE2,String CUST_MOBILE3,String CUST_MAIL) throws UnsupportedEncodingException {
	    	String ERRMSG_KIND ="個人・法人区分は必須項目です";
	    	String ERRMSG_CNAME ="法人名は必須項目です";
	    	String ERRMSG_CNAME_K ="法人名カナは必須項目です";
	    	String ERRMSG_CNAME_K2 ="全角カナで入力してください";
	    	String ERRMSG_DEPARTMENT ="25文字以内で入力してください";
	    	String ERRMSG_L_NAME ="10文字以内で入力してください";
	    	String ERRMSG_F_NAME ="10文字以内で入力してください";
	    	String ERRMSG_L_NAME_KANA ="10文字以内で入力してください";
	    	String ERRMSG_F_NAME_KANA ="10文字以内で入力してください";
	    	String ERRMSG_L_NAME_KANA2 ="全角カナで入力してください";
	    	String ERRMSG_F_NAME_KANA2 ="全角カナで入力してください";
	    	String ERRMSG_ZIP ="郵便番号は必須項目です";
	    	String ERRMSG_PREFECTURE ="都道府県は必須項目です";
	    	String ERRMSG_ADDRESS1 ="50文字以内で入力してください";
	    	String ERRMSG_ADDRESS2 ="25文字以内で入力してください";
	    	String ERRMSG_TEL ="電話番号は必須項目です";
	    	String ERRMSG_MOBILE ="携帯番号は必須項目です";
	    	String ERRMSG_MAIL ="メールアドレスは必須項目です";
	    	String returnVal = "";
	    	
	 if(CUST_KIND == "") {
		returnVal = returnVal + ERRMSG_KIND+"<br>";
	}if(CUST_KIND == "2" && CORP_NAME == "") {
		returnVal = returnVal + ERRMSG_CNAME+"<br>";
	}if(!(CORP_NAME == "") && CORP_NAME_KANA == "") {
		returnVal = returnVal + ERRMSG_CNAME_K+"<br>";
	/*}if(ERRMSG_CNAME_K2 ) {*/
	}if(CUST_L_NAME_KANA.length()>10) {
		returnVal = returnVal + ERRMSG_L_NAME_KANA+"<br>";
	}if(CUST_F_NAME_KANA.length()>10) {
		returnVal = returnVal + ERRMSG_F_NAME_KANA+"<br>";	
	}if(CUST_DEPARTMENT_NAME.length()>25){
		returnVal = returnVal + ERRMSG_DEPARTMENT+"<br>";
	}if(CUST_L_NAME.length()>10) {
		returnVal = returnVal + ERRMSG_L_NAME+"<br>";
	}if(CUST_F_NAME.length()>10) {
		returnVal = returnVal + ERRMSG_F_NAME+"<br>";
	}if(CUST_ZIP == "") {
		returnVal = returnVal + ERRMSG_ZIP+"<br>";
	}if(CUST_PREFECTURE == "") {
		returnVal = returnVal + ERRMSG_PREFECTURE+"<br>";
	}if(CUST_ADDRESS1.length()>50) {
		returnVal = returnVal + ERRMSG_ADDRESS1+"<br>";
	}if(CUST_ADDRESS2.length()>25) {
		returnVal = returnVal + ERRMSG_ADDRESS2+"<br>";
	}if(CUST_TEL1 == "" || CUST_TEL2 == "" || CUST_TEL3 == "") {
		returnVal = returnVal + ERRMSG_TEL+"<br>";
	}if(CUST_MOBILE1 == "" || CUST_MOBILE2 == "" || CUST_MOBILE3 == "") {
		returnVal = returnVal + ERRMSG_MOBILE+"<br>";
	}if(CUST_MAIL == "") {
		returnVal = returnVal + ERRMSG_MAIL+"<br>";
	}
	    return returnVal;
	    
	}
	    
	    
	 
	    
	    //プルダウン 個人・法人区分
		public static ResultSet CUST_KINDAll(){
		 Connection connect = null;
		 Statement stmt = null;
		 ResultSet rs1 =null;
		 
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			connect = DriverManager.getConnection(URL, USERNAME, PASSWORD);
			 stmt = connect.createStatement();
			 
			 String getQuery ="select CODE_BRANCH_NUM, CODE_NAME from mst_code where CODE_KIND = 1 and STATUS = 1";
			
			 rs1 = stmt.executeQuery(getQuery);
			 
		} catch(Exception e){
			e.printStackTrace();
		}
		
		 
		return rs1;
	}
	
		//都道府県
		public static ResultSet CUST_PREFECTURAll(){
			 Connection connect = null;
			 Statement stmt = null;
			 ResultSet rs2 =null;
			 
			try {
				Class.forName("com.mysql.cj.jdbc.Driver");
				connect = DriverManager.getConnection(URL, USERNAME, PASSWORD);
				 stmt = connect.createStatement();
				 
				 String getQuery ="select CODE_BRANCH_NUM, CODE_NAME from mst_code where CODE_KIND = 3 and STATUS = 1";
				
				 rs2 = stmt.executeQuery(getQuery);
				 
			} catch(Exception e){
				e.printStackTrace();
			}
			
			 
			return rs2;
		}
		
		
		//ステータス
				public static ResultSet STATUSAll(){
				 Connection connect = null;
				 Statement stmt = null;
				 ResultSet rs3 =null;
				 
				try {
					Class.forName("com.mysql.cj.jdbc.Driver");
					connect = DriverManager.getConnection(URL, USERNAME, PASSWORD);
					 stmt = connect.createStatement();
					 
					 String getQuery ="select CODE_BRANCH_NUM, CODE_NAME from mst_code where CODE_KIND = 2 and STATUS = 1";
					
					 rs3 = stmt.executeQuery(getQuery);
					 
				} catch(Exception e){
					e.printStackTrace();
				}
				
				 
				return rs3;
			}
		
		public static String getCUST_KINDname(String CUST_KIND) {
			 Connection connect = null;
			 PreparedStatement ps = null;
			 String CUST_KINDname = null;
			 ResultSet rs = null;
			 try {
					Class.forName("com.mysql.cj.jdbc.Driver");
					connect = DriverManager.getConnection(URL, USERNAME, PASSWORD);
					String getQuery ="select CODE_BRANCH_NUM,CODE_NAME from mst_code where CODE_KIND = 1 and CODE_BRANCH_NUM = ? ";
					ps = connect.prepareStatement(getQuery);
				    ps.setString(1, CUST_KIND );
					 
					 rs = ps.executeQuery();
					
					 while(rs.next()) {
						 CUST_KINDname=rs.getString("CODE_NAME");
					 }
					 
					
				} catch(Exception e){
					e.printStackTrace();
				}
			 return CUST_KINDname;
			}

		public static String getCUST_PREFECTUREname(String CUST_PREFECTURE) {
			 Connection connect = null;
			 PreparedStatement ps = null;
			 String CUST_PREFECTUREname = null;
			 ResultSet rs = null;
			 try {
					Class.forName("com.mysql.jdbc.Driver");
					connect = DriverManager.getConnection(URL, USERNAME, PASSWORD);
					String getQuery ="select CODE_BRANCH_NUM,CODE_NAME from mst_code where CODE_KIND = 3 and CODE_BRANCH_NUM = ? ";
					ps = connect.prepareStatement(getQuery);
				    ps.setString(1, CUST_PREFECTURE );
					 
					 rs = ps.executeQuery();
					
					 while(rs.next()) {
						 CUST_PREFECTUREname=rs.getString("CODE_NAME");
					 }
					 
					
				} catch(Exception e){
					e.printStackTrace();
				}
			 return CUST_PREFECTUREname;
			}

}
