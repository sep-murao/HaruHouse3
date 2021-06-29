package kokyaku;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class ListBL_customer
 */
@WebServlet("/ListBL_customer")
public class ListBL_customer extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	Connection conn =null;
    static final String URL = "jdbc:mysql://localhost/harudb?useUnicode=true&characterEncoding=utf8";
    static final String USERNAME = "root";
    static final String PASSWORD = "";  
    private String updFlg = "0";
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ListBL_customer() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String nowPage;
		int limitSta;
		
		if(request.getParameter("flg") == null) {
			if( request.getParameter("nowPage")== null){
				nowPage = "1";
			}else {
				nowPage = request.getParameter("nowPage");
			}
			
			int nowPage2 = Integer.parseInt(nowPage);
			limitSta = (nowPage2 - 1)*10;

			initProc(request,response,nowPage,limitSta);   //126行目

			//request.getRequestDispatcher("/List_customer.jsp").forward(request, response);
}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String nowPage = null;
		int limitSta = 0;
		
		updFlg = request.getParameter("updFlg");
		
		if( (String)request.getParameter("nowPage")== null){
			nowPage = "1";
		}else {
			nowPage = request.getParameter("nowPage");
		}

		int nowPage2 = Integer.parseInt(nowPage);
		limitSta = (nowPage2 - 1)*10;
		
		
		
		String STATUS = request.getParameter("STATUS");
		String ID = request.getParameter("ID");
		
		Connection connect = null;
		PreparedStatement stmt = null;
		
		      //ステータス更新
		 try {
 			 Class.forName("com.mysql.cj.jdbc.Driver");
				connect = DriverManager.getConnection(URL, USERNAME, PASSWORD);
				stmt = connect.prepareStatement(
				"UPDATE mst_customer SET STATUS = ? where id= ? ;");
			
				stmt.setString(1, STATUS);
				stmt.setString(2, ID);

			   int rs = stmt.executeUpdate();
				 
			 } catch(Exception e){
					e.printStackTrace();
		}
		 //updFlg = "1";
		 
		initProc(request,response,nowPage,limitSta);
		 
		 request.getRequestDispatcher("/List_customer.jsp").forward(request, response);
	}

	protected  ResultSet getList(String pQuery, int limitVal) {
		Connection connect = null;
		PreparedStatement ps = null;
		ResultSet rs = null;

		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			connect = DriverManager.getConnection(URL, USERNAME, PASSWORD);
			
			String MainQuery = "select*from mst_customer where 1=1";
			
			 
			pQuery += " limit ?,10; ";
			ps = connect.prepareStatement(MainQuery + pQuery);
			ps.setInt(1, limitVal);
			rs = ps.executeQuery();
		
		 }catch(Exception e){
				e.printStackTrace();
		 }
		return rs;
		
		
	}
	
	protected  String  nullChk(String Val) {
		String wk = "";
		if(Val == null || Val == "") {
		}else{
			wk = Val;
		}
		return wk;
	}
	protected  String initProc(HttpServletRequest request, HttpServletResponse response, String nowPage, int limitSta) {
		// TODO Auto-generated method stub
		//response.getWriter().append("Served at: ").append(request.getContextPath());
		Connection connect = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		int listCnt = 0;
		
		//全件取得
		try {
			 Class.forName("com.mysql.cj.jdbc.Driver");
				connect = DriverManager.getConnection(URL, USERNAME, PASSWORD);
				
				//全件数取得
				String CntQuery = "select count(*) cnt from mst_customer ;";
				
				ps = connect.prepareStatement(CntQuery);
				rs = ps.executeQuery();
				rs.next();
				listCnt = rs.getInt("cnt");
				
		 } catch(Exception e){
				e.printStackTrace();
		 }
		String SelectQuery = "";
		
		String SearchCUST_KIND =nullChk(request.getParameter("SearchCUST_KIND"));
		String SearchCORP_NAME =nullChk(request.getParameter("SearchCORP_NAME"));
		String SearchCORP_NAME_KANA =nullChk(request.getParameter("SearchCORP_NAME_KANA"));
		String SearchCUST_NAME =nullChk(request.getParameter("SearchCUST_NAME"));
		String SearchCUST_NAME_KANA =nullChk(request.getParameter("SearchCUST_NAME_KANA"));
		String SearchCUST_ZIP =nullChk(request.getParameter("SearchCUST_ZIP"));
		String SearchCUST_PREFECTURE =nullChk(request.getParameter("SearchCUST_PREFECTURE"));
		String SearchCUST_ADDRESS1 =nullChk(request.getParameter("SearchCUST_ADDRESS1"));
		String SearchCUST_ADDRESS2 =nullChk(request.getParameter("SearchCUST_ADDRESS2"));
		String SearchCUST_TEL =nullChk(request.getParameter("SearchCUST_TEL"));
		String SearchCUST_MOBILE =nullChk(request.getParameter("SearchCUST_MOBILE"));
		String SearchCUST_MAIL =nullChk(request.getParameter("SearchCUST_MAIL"));
		String SearchSTATUS =nullChk(request.getParameter("SearchSTATUS"));
		
		//個人・法人区分
		 if(SearchCUST_KIND == null || SearchCUST_KIND == "") {
		 }else{
				SelectQuery += " and CUST_KIND = " + SearchCUST_KIND;
		 }
		//法人名
		 if(SearchCORP_NAME == "" || SearchCORP_NAME == null) {
		 }else{
				SelectQuery += " and CUST_CORP_NAME like '%" + SearchCORP_NAME + "%'";
		 }
		//法人名カナ
		 if(SearchCORP_NAME_KANA == "" || SearchCORP_NAME_KANA == null) {
		 }else{
			    SelectQuery += " and CUST_CORP_NAME_KANA like '%" + SearchCORP_NAME_KANA + "%'";
		 }
		//顧客名
		 if(SearchCUST_NAME == "" || SearchCUST_NAME == null) {
		 }else{
				SelectQuery += " and CUST_L_NAME like '%" + SearchCUST_NAME + "%' || CUST_F_NAME like '%" + SearchCUST_NAME + "%'";
		 }
		//顧客名カナ
		 if(SearchCUST_NAME_KANA == "" || SearchCUST_NAME_KANA == null) {
		 }else{
				SelectQuery += " and CUST_L_NAME_KANA like '%" + SearchCUST_NAME_KANA + "%' || CUST_F_NAME_KANA like '%" + SearchCUST_NAME_KANA + "%'";
		 }
		//郵便番号
		 if(SearchCUST_ZIP == "" || SearchCUST_ZIP == null) {
		 }else{
				SelectQuery += " and CUST_ZIP like '%" + SearchCUST_ZIP + "%'";
		 }
		//都道府県
		 if(SearchCUST_PREFECTURE == "" || SearchCUST_PREFECTURE == null) {
		 }else{
				SelectQuery += " and CUST_PREFECTURE = " + SearchCUST_PREFECTURE;
		 }
		//住所
		 if(SearchCUST_ADDRESS1 == "" || SearchCUST_ADDRESS1 == null) {
		 }else{
				SelectQuery += " and CUST_ADDRESS1 like '%" + SearchCUST_ADDRESS1 + "%'";
		 }
		//建物名
		 if(SearchCUST_ADDRESS2 == "" || SearchCUST_ADDRESS2 == null) {
		 }else{
				SelectQuery += " and CUST_ADDRESS2 like '%" + SearchCUST_ADDRESS2 + "%'";
		 }
		//電話番号
		 if(SearchCUST_TEL == "" || SearchCUST_TEL == null) {
		 }else{
				SelectQuery += " and CUST_TEL1 like '%" + SearchCUST_TEL + "%' || CUST_TEL2 like '%" + SearchCUST_TEL + "%' || CUST_TEL3 like '%" + SearchCUST_TEL + "%'";
		 }
		//携帯番号
		 if(SearchCUST_MOBILE == "" || SearchCUST_MOBILE == null) {
		 }else{
				SelectQuery += " and CUST_MOBILE1 like '%" + SearchCUST_MOBILE + "%' || CUST_MOBILE2 like '%" + SearchCUST_MOBILE + "%' || CUST_MOBILE3 like '%" + SearchCUST_MOBILE + "%'";
		 }
		//メールアドレス
		 if(SearchCUST_MAIL == "" || SearchCUST_MAIL == null) {
		 }else{
				SelectQuery += " and CUST_MAIL like '%" + request.getParameter("SearchCUST_MAIL") + "%'";
		 }
		//ステータス
		 if(SearchSTATUS == "" || SearchSTATUS == null) {
		 }else{
				SelectQuery += " and STATUS = " + SearchSTATUS;
		 }
		
		 rs = this.getList(SelectQuery, limitSta);
		
		 request.setAttribute("updFlg", updFlg);
		 request.setAttribute("listCnt", listCnt);
		 request.setAttribute("Result", rs);
		 request.setAttribute("nowPage", nowPage);
		 
		 request.setAttribute("SearchCUST_KIND",SearchCUST_KIND);
		 request.setAttribute("SearchCORP_NAME",SearchCORP_NAME);
		 request.setAttribute("SearchCORP_NAME_KANA",SearchCORP_NAME_KANA);
		 request.setAttribute("SearchCUST_NAME",SearchCUST_NAME);
		 request.setAttribute("SearchCUST_NAME_KANA",SearchCUST_NAME_KANA);
		 request.setAttribute("SearchCUST_ZIP",SearchCUST_ZIP);
		 request.setAttribute("SearchCUST_PREFECTURE",SearchCUST_PREFECTURE);
		 request.setAttribute("SearchCUST_ADDRESS1",SearchCUST_ADDRESS1);
		 request.setAttribute("SearchCUST_ADDRESS2",SearchCUST_ADDRESS2);
		 request.setAttribute("SearchCUST_TEL",SearchCUST_TEL);
		 request.setAttribute("SearchCUST_MOBILE",SearchCUST_MOBILE);
		 request.setAttribute("SearchCUST_MAIL",SearchCUST_MAIL);
		 request.setAttribute("SearchSTATUS",SearchSTATUS);
		 
		 updFlg = "0";
		 
		 try {
			request.getRequestDispatcher("/List_customer.jsp").forward(request, response);
		} catch (ServletException e) {
			// TODO 自動生成された catch ブロック
			e.printStackTrace();
		} catch (IOException e) {
			// TODO 自動生成された catch ブロック
			e.printStackTrace();
		}
		 return SelectQuery;
	}


}

