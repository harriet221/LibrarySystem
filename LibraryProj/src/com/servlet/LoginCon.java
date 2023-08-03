package com.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/loginCon")
public class LoginCon extends HttpServlet {
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html; charset=UTF-8");
		
		String driver = "oracle.jdbc.driver.OracleDriver";
		String url = "jdbc:oracle:thin:@localhost:1521:xe";
		String id = "c##lib";
		String pw = "libpass";
		
		Connection con = null;
		Statement stmt = null;
		ResultSet res = null;
		
		String mID = request.getParameter("mID"); // login.jsp에서 받아오기
		HttpSession session = request.getSession();
		session.setAttribute("memberID", mID);
		
		try {
			Class.forName(driver);
			
			con = DriverManager.getConnection(url, id, pw);
			stmt = con.createStatement();
			String sql = "SELECT members.m_name FROM members WHERE members.m_id='"+mID+"'";
			res = stmt.executeQuery(sql);
			
			while(res.next()) {
				String mName = res.getString("m_name");
				session.setAttribute("memberName", mName);
				response.sendRedirect("mainPage.jsp");
			}
			
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if(res != null) res.close();
				if(con != null) con.close();
				if(stmt != null) stmt.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
		
		
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
