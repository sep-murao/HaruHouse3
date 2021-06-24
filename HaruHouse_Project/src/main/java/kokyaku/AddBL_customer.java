package kokyaku;

import java.io.IOException;
import java.sql.Connection;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


/**
 * Servlet implementation class AddBL_customer
 */
@WebServlet("/AddBL_customer")
public class AddBL_customer extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	 Connection conn =null;
	    static final String URL = "jdbc:mysql://localhost/jyusyoroku_s";
	    static final String USERNAME = "root";
	    static final String PASSWORD = "";   
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AddBL_customer() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		//doGet(request, response);
        request.setCharacterEncoding("UTF-8");
		
		//Add_customerからデータ受け取り
		String CUST_KIND = request.getParameter("CUST_KIND");
		String CORP_NAME = request.getParameter("CORP_NAME");
		String CORP_NAME_KANA = request.getParameter("CORP_NAME_KANA");
		String CUST_DEPARTMENT_NAME = request.getParameter("CUST_DEPARTMENT_NAME");
		String CUST_L_NAME = request.getParameter("CUST_L_NAME");
		String CUST_F_NAME = request.getParameter("CUST_F_NAME");
		String CUST_L_NAME_KANA = request.getParameter("CUST_L_NAME_KANA");
	    String CUST_F_NAME_KANA = request.getParameter("CUST_F_NAME_KANA");
		String CUST_ZIP = request.getParameter("CUST_ZIP");
		String CUST_PREFECTURE = request.getParameter("CUST_PREFECTURE");
		String CUST_ADDRESS1 = request.getParameter("CUST_ADDRESS1");
		String CUST_ADDRESS2 = request.getParameter("CUST_ADDRESS2");
		String CUST_TEL1 = request.getParameter("CUST_TEL1");
		String CUST_TEL2 = request.getParameter("CUST_TEL2");
		String CUST_TEL3 = request.getParameter("CUST_TEL3");
		String CUST_MOBILE1 = request.getParameter("CUST_MOBILE1");
		String CUST_MOBILE2 = request.getParameter("CUST_MOBILE2");
		String CUST_MOBILE3 = request.getParameter("CUST_MOBILE3");
		String CUST_MAIL = request.getParameter("CUST_MAIL");
		String[] CUST_MAIL_SEND_FLG = request.getParameterValues("CUST_MAIL_SEND_FLG");

    	String errmsg = Cmmon_customer.getError(CUST_KIND , CORP_NAME, CORP_NAME_KANA, CUST_DEPARTMENT_NAME, CUST_L_NAME, CUST_F_NAME,CUST_L_NAME_KANA, CUST_F_NAME_KANA, CUST_ZIP, CUST_PREFECTURE, CUST_ADDRESS1, CUST_ADDRESS2,
    			                                  CUST_TEL1, CUST_TEL2, CUST_TEL3, CUST_MOBILE1, CUST_MOBILE2, CUST_MOBILE3, CUST_MAIL);
		
    	String nextUrl = "/AddCheck_customer.jsp";
    	
    	String CUST_TEL = CUST_TEL1 + "-" + CUST_TEL2 + "-" + CUST_TEL3;
    	String CUST_MOBILE = CUST_MOBILE1 + "-" + CUST_MOBILE2 + "-" + CUST_MOBILE3;
    	
	    //確認画面へ渡すデータ
    	request.setAttribute("CUST_KIND", CUST_KIND);
    	request.setAttribute("CORP_NAME", CORP_NAME);
    	request.setAttribute("CORP_NAME_KANA", CORP_NAME_KANA);
    	request.setAttribute("CUST_DEPARTMENT_NAME", CUST_DEPARTMENT_NAME);
    	request.setAttribute("CUST_L_NAME", CUST_L_NAME);
    	request.setAttribute("CUST_F_NAME", CUST_F_NAME);
    	request.setAttribute("CUST_L_NAME_KANA", CUST_L_NAME_KANA);
    	request.setAttribute("CUST_F_NAME_KANA", CUST_F_NAME_KANA);
    	request.setAttribute("CUST_ZIP", CUST_ZIP);
    	request.setAttribute("CUST_PREFECTURE", CUST_PREFECTURE);
    	request.setAttribute("CUST_ADDRESS1", CUST_ADDRESS1);
    	request.setAttribute("CUST_ADDRESS2", CUST_ADDRESS2);
    	request.setAttribute("CUST_TEL1", CUST_TEL1);
    	request.setAttribute("CUST_TEL2", CUST_TEL2);
    	request.setAttribute("CUST_TEL3", CUST_TEL3);
    	request.setAttribute("CUST_TEL", CUST_TEL);
    	request.setAttribute("CUST_MOBILE1", CUST_MOBILE1);
    	request.setAttribute("CUST_MOBILE2", CUST_MOBILE2);
    	request.setAttribute("CUST_MOBILE3", CUST_MOBILE3);
    	request.setAttribute("CUST_MOBILE", CUST_MOBILE);
    	request.setAttribute("CUST_MAIL", CUST_MAIL);
    	request.setAttribute("CUST_MAIL_SEND_FLG", CUST_MAIL_SEND_FLG);

    	//エラーがある場合はエラーメッセージをAdd_customerに渡す
    	if(errmsg != "") {
    		request.setAttribute("errmsg",errmsg);
    		nextUrl = "/Add_customer.jsp";
    	}
    	request.getRequestDispatcher(nextUrl).forward(request, response);
	}

}
