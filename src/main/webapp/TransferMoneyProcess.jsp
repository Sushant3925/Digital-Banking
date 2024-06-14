<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
	<%@ page import="java.sql.*"%>
	<%@ page import="javax.naming.InitialContext"%>
	<%@ page import="javax.sql.DataSource"%>
	<%@ page import="java.util.*"%>
	<%@ page import="java.io.*"%>
	<%@ page import="java.time.LocalDate"%>
	<%@ page import="java.sql.Date"%>
	<%@ page import="java.util.Random"%>
	
	

	<%
	// Get form data
	String fromAccount = request.getParameter("fromAccount");
	String tousername = request.getParameter("tousername");
	String fromusername = request.getParameter("fromusername");

	String toAccount = request.getParameter("toAccount");
	String amountStr = request.getParameter("Amount");
	String password = request.getParameter("password");

	// Convert amount to integer
	int amount = Integer.parseInt(amountStr);

	Connection conn = null;
	try {
		// Load PostgreSQL JDBC driver
		Class.forName("org.postgresql.Driver");

		// Connect to the database
		String url = "jdbc:postgresql://localhost/ajdb";
		String user = "sushant";
		String pass = "Sushant@9315";
		conn = DriverManager.getConnection(url, user, pass);

		// Check if the password is correct (you should hash and salt passwords in a real application)
		PreparedStatement passwordStmt = conn.prepareStatement("SELECT password FROM Auth WHERE username = ?");
		passwordStmt.setString(1, fromusername);
		ResultSet passwordRs = passwordStmt.executeQuery();
		if (!passwordRs.next() || !passwordRs.getString("password").equals(password)) {
			out.println("Incorrect password");
			return;
		}

		// Check if the from account has enough balance
		PreparedStatement balanceStmt = conn.prepareStatement("SELECT balance FROM balance WHERE username = ?");
		balanceStmt.setString(1, fromusername);
		ResultSet balanceRs = balanceStmt.executeQuery();
		if (!balanceRs.next() || balanceRs.getInt("balance") < amount) {
			out.println("<script>alert('Your account does not have enoush money to transfer')</script>");
			return;
		}

		// Update balance for the from account
		PreparedStatement updateFromStmt = conn
		.prepareStatement("UPDATE balance SET balance = balance - ? WHERE username = ?");
		updateFromStmt.setInt(1, amount);
		updateFromStmt.setString(2, fromusername);
		updateFromStmt.executeUpdate();

		// Update balance for the to account
		PreparedStatement updateToStmt = conn
		.prepareStatement("UPDATE balance SET balance = balance + ? WHERE username = ?");
		updateToStmt.setInt(1, amount);
		updateToStmt.setString(2, tousername);
		updateToStmt.executeUpdate();

		//update the transaction history of from account
		Random random = new Random();
        int tr_id = random.nextInt(9000) + 1000;
		tr_id =tr_id+ 1;
		String desc= "Bill";
		LocalDate currentDate = LocalDate.now();
		Date sqlDate = Date.valueOf(currentDate);
		PreparedStatement fromhistoryUpdate = conn.prepareStatement("insert into transactions values(?,?,?,?,?)");
		fromhistoryUpdate.setInt(1, tr_id);
		fromhistoryUpdate.setString(2,fromusername);
		fromhistoryUpdate.setDate(3, sqlDate);
		fromhistoryUpdate.setString(4,desc);
		fromhistoryUpdate.setInt(5, amount);
		fromhistoryUpdate.executeUpdate();
		
		tr_id=tr_id+1;
		PreparedStatement tohistoryUpdate = conn.prepareStatement("insert into transactions values(?,?,?,?,?)");
		tohistoryUpdate.setInt(1, tr_id);
		tohistoryUpdate.setString(2,tousername);
		tohistoryUpdate.setDate(3, sqlDate);
		tohistoryUpdate.setString(4,desc);
		tohistoryUpdate.setInt(5, amount);
		tohistoryUpdate.executeUpdate();

		request.setAttribute("fromusername", fromusername);
		request.setAttribute("password", password);
		RequestDispatcher rd = request.getRequestDispatcher("validateLogin.jsp");
		rd.forward(request, response);

	} catch (Exception e) {
		out.println("Exception: " + e);
	} finally {
		// Close the database connection
		if (conn != null) {
			try {
		conn.close();
			} catch (SQLException ex) {
		ex.printStackTrace();
			}
		}

	}
	%>
</body>
</html>