<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ page import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Login Validation</title>
</head>
<body>

	<%@page import="java.sql.DriverManager"%>
	<%@page import="java.sql.ResultSet"%>
	<%@page import="java.sql.Statement"%>
	<%@page import="java.sql.Connection"%>
	<%
	String uname = (String) request.getAttribute("fromusername");
	String pwd = (String) request.getAttribute("password");

	String username = request.getParameter("username");
	String password = request.getParameter("Password");

	System.out.println(uname + "\t" + pwd);
	System.out.println(username + "\t" + password);

	String url = "jdbc:postgresql://localhost/ajdb";
	String user = "sushant";
	String pass = "Sushant@9315";

	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	if (uname != null) {
		request.setAttribute("username", uname);
		request.setAttribute("password", pwd);
		RequestDispatcher rd = request.getRequestDispatcher("LandingPage.jsp");
		rd.forward(request, response);

	} 
	else {
		try {
			Class.forName("org.postgresql.Driver");
			conn = DriverManager.getConnection(url, user, pass);
			String sql = "SELECT * FROM Auth WHERE username=? AND password=?";
			pstmt = conn.prepareStatement(sql);

			pstmt.setString(1, username);
			pstmt.setString(2, password);
			rs = pstmt.executeQuery();

			if (rs.next()) {
		// User found, redirect to main page

		//response.sendRedirect("Loading.jsp");
		request.setAttribute("username", username);
		request.setAttribute("password", password);
		RequestDispatcher rd = request.getRequestDispatcher("LandingPage.jsp");
		rd.forward(request, response);
			}
			else {
		// User not found, display alert
		//out.println("<script>alert('Invalid username or password')</script>");
		//response.sendRedirect("Login.jsp");
		request.setAttribute("message", "Invalid username or password");
		RequestDispatcher rd = request.getRequestDispatcher("Login.jsp");
		rd.forward(request, response);
		// You can also redirect back to the login page
		// response.sendRedirect("login.jsp");
			}
		} catch (Exception e) {
			System.out.println(e);
			out.println("Exception: " + e.getMessage());
		} finally {
			if (rs != null)
		rs.close();
			if (pstmt != null)
		pstmt.close();
			if (conn != null)
		conn.close();
		}
	}
	%>
</body>
</html>
