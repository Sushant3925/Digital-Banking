
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>

<%@ include file="/Home.html"%>
<!doctype html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Digital Netbanking</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
	crossorigin="anonymous">


</head>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Money Transfer</title>
<style>
/* Custom CSS for styling */
body {
	background-color: antiquewhite;
	padding: 20px;
}

form {
	max-width: 500px;
	margin: 0 auto;
}

label {
	margin-bottom: 0.5rem;
}

select, input[type="number"] {
	width: 100%;
	padding: 0.375rem 0.75rem;
	font-size: 1rem;
	line-height: 1.5;
	border-radius: 0.25rem;
	border: 1px solid #ced4da;
}

input[type="submit"] {
	width: 100%;
	padding: 0.75rem;
	font-size: 1rem;
	font-weight: bold;
	color: #fff;
	background-color: #007bff;
	border: 1px solid #007bff;
	border-radius: 0.25rem;
	cursor: pointer;
}

input[type="submit"]:hover {
	background-color: #0056b3;
	border-color: #0056b3;
}

.container {
	margin-top: 120px;
}

.form {
	padding: 20px;
	background: aliceblue;
}
</style>
</head>
<body>
	<%@ page import="java.sql.*"%>
	<%@ page import="javax.naming.InitialContext"%>
	<%@ page import="javax.sql.DataSource"%>
	<%@ page import="java.util.*"%>
	<%@ page import="java.io.*"%>
	<div class="container">
		<c:if test="${not empty message}">
			<h2 style="color: red; text-align: center;">${message}</h2>
		</c:if>
		<%
		Cookie[] cookies = request.getCookies();

		String accountNumber = null;
		if (cookies != null) {
			for (Cookie cookie : cookies) {
				if (cookie.getName().equals("account_number")) {
			accountNumber = cookie.getValue();
			break;
				}
			}
		}
		%>
		<h1 style="text-align: center;">Money Transfer</h1>
		<form class="form" action="passwordVerification.jsp" method="post">
			<label for="fromAccount">From Account Number:</label> <select
				id="fromAccount" name="fromAccount">
				<option value="<%=accountNumber%>"><%=accountNumber%></option>

			</select><br> <br> <label for="toAccount">To Account Number:</label>
			<select id="toAccount" name="toAccount">
				<%-- Populate the select options with account numbers from the database --%>
				<%
				Connection conn = null;
				try {
					Class.forName("org.postgresql.Driver");
					String url = "jdbc:postgresql://localhost/ajdb";
					String user = "sushant";
					String pass = "Sushant@9315";
					conn = DriverManager.getConnection(url, user, pass);

					Statement stmt = conn.createStatement();
					ResultSet rs = stmt.executeQuery("SELECT account_number FROM accounts");

					while (rs.next()) {
						String accountNumbers = rs.getString("account_number");
						if (!accountNumber.equals(accountNumbers)) {
				%>
				<option value="<%=accountNumbers%>"><%=accountNumbers%></option>
				<br><br>
				
				
				<%
				}
						rs.next();
				}
				} catch (Exception e) {
				out.println("Error: " + e.getMessage());
				} finally {
				if (conn != null) {
				try {
				conn.close();
				} catch (SQLException ex) {
				ex.printStackTrace();
				}
				}
				}
				%>
			</select><br> <br> 
			<label for="fromtoname">Transfer TO Username:</label> 
				 <input
				type="text" class="form-control" id="tousername" name="tousername"
				required> 
				<br><br>
			<label for="amount">Amount:</label> 
				 <input
				type="text" class="form-control" id="amount" name="Amount"
				required> 
				 <br><br> 
				 <label for="fromusername">Transfer From Username:</label> 
				 <input
				type="text" class="form-control" id="fromusername" name="fromusername"
				required> <br> <br>
				
			 <label for="password">Password:</label> <input
				type="password" class="form-control" id="password" name="password"
				required> <br> <br> <input type="submit"
				value="Transfer Money">

		</form>
	</div>

</body>


</html>
