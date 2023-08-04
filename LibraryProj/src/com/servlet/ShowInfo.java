package com.servlet;

import java.io.IOException;
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

@WebServlet("/show_info")
public class ShowInfo extends HttpServlet {
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html; charset=UTF-8");
		
		String driver = "oracle.jdbc.driver.OracleDriver";
		String url = "jdbc:oracle:thin:@localhost:1521:xe";
		String id = "c##lib";
		String pw = "libpass";
		
		Connection con = null;
		Statement stmt = null;
		ResultSet res = null;
		
		HttpSession session = request.getSession();
		String m_id = (String)session.getAttribute("memberID");
		
		try {
			Class.forName(driver);
			
			con = DriverManager.getConnection(url, id, pw);
			stmt = con.createStatement();
			String sql = "SELECT members.phone, members.status FROM members WHERE members.m_id='"+m_id+"'";
			res = stmt.executeQuery(sql);
			
			while(res.next()) {
				String mPhone = res.getString("phone");
				session.setAttribute("memberPhone", mPhone);
				String mStatus = res.getString("status");
				session.setAttribute("memberStatus", mStatus);
				
				response.sendRedirect("memberInfo.jsp");
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
