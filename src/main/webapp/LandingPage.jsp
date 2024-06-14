<%@page import="java.sql.PreparedStatement"%>
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
	
<link rel="stylesheet" type="text/css" href="./LandingPage.css">

</head>
<body>

	<%
	String uname = (String) request.getAttribute("username");
	String password = (String) request.getAttribute("password");
	%>
	<%@page import="java.sql.DriverManager"%>
	<%@page import="java.sql.ResultSet"%>
	<%@page import="java.sql.Statement"%>
	<%@page import="java.sql.Connection"%>

	<div class="main">
		<div class="nav" id="nav">
			<div class="nav-content">
				<h3>Menu</h3>
				<ul>
					<li><a href="#">Home</a></li>
					<li><a href="#account-details">Account</a></li>
					<li><a href="#transaction-history">Transactions</a></li>
					<li><a href="./TransferMoney.jsp">Transfer Money</a></li>
					<li><a href="#current-balance">Bank Statement</a></li>
					<li><a href="./Logout.jsp">Logout</a></li>
					<li><a href="#">Bank Statement</a></li>
				</ul>
			</div>
		</div>
		<div class="page-content">
			<div class="container">

				<%
				String username = (String) request.getAttribute("username");

				String url = "jdbc:postgresql://localhost/ajdb";
				String user = "sushant";
				String pass = "Sushant@9315";

				Connection conn = null;
				PreparedStatement pstmt = null;
				ResultSet rs = null;
				try {
					Class.forName("org.postgresql.Driver");
					conn = DriverManager.getConnection(url, user, pass);

				} catch (Exception e) {
					System.out.println(e);
					out.println("Exception: " + e.getMessage());
				}
				%>
				<%
				// Assuming the transactions table has columns: date, description, amount
				String transactionQuery = "SELECT date, description, amount FROM transactions WHERE username=?";
				PreparedStatement transactionStmt = conn.prepareStatement(transactionQuery);
				transactionStmt.setString(1, username);
				ResultSet transactionRs = transactionStmt.executeQuery();

				// Assuming the accounts table has columns: account_number, account_type, branch
				String accountQuery = "SELECT account_number, account_type, branch FROM accounts WHERE username=?";
				PreparedStatement accountStmt = conn.prepareStatement(accountQuery);
				accountStmt.setString(1, username);
				ResultSet accountRs = accountStmt.executeQuery();

				// Assuming the balances table has columns: balance
				String balanceQuery = "SELECT balance FROM balance WHERE username=?";
				PreparedStatement balanceStmt = conn.prepareStatement(balanceQuery);
				balanceStmt.setString(1, username);
				ResultSet balanceRs = balanceStmt.executeQuery();
				%>
				<h1>
					Welcome
					<%=username%>
				</h1>
				<div class="account-details" id="account-details">
					<h2>Account Details</h2>
					<%
					if (accountRs.next()) {
					%>
					<p>
						Account Number:
						<%=accountRs.getString("account_number")%></p>

					<%
							String acc = accountRs.getString("account_number");
							
							//request.setAttribute("account_number", acc);
							Cookie ck = new Cookie("account_number",acc);
							ck.setMaxAge(60*60*60*7);
							response.addCookie(ck);
							
							Cookie ck1 = new Cookie("password",password);
							ck1.setMaxAge(60*60*60*7);
							response.addCookie(ck1);
							System.out.println(password);
							
					%>
					<p>
						Account Type:
						<%=accountRs.getString("account_type")%></p>
					<p>
						Branch:
						<%=accountRs.getString("branch")%></p>
					<%
					}
					%>
				</div>
				<div class="transaction-history" id="transaction-history">
					<h2>Transaction History</h2>
					<table>
						<thead>
							<tr>
								<th>Date</th>
								<th>Description</th>
								<th>Amount</th>
							</tr>
						</thead>
						<tbody>
							<%
							while (transactionRs.next()) {
							%>
							<tr>
								<td><%=transactionRs.getString("date")%></td>
								<td><%=transactionRs.getString("description")%></td>
								<td><%=transactionRs.getString("amount")%></td>
							</tr>
							<%
							}
							%>
						</tbody>
					</table>
				</div>



				<div class="current-balance" id="current-balance">
					<h2>Current Account Balance</h2>
					<%
					if (balanceRs.next()) {
					%>
					<p>
						Rs.<%=balanceRs.getString("balance")%></p>
					<%
					}
					%>
				</div>

				<%
				try {
					transactionRs.close();
					transactionStmt.close();
					accountRs.close();
					accountStmt.close();
					balanceRs.close();
					balanceStmt.close();

				} catch (Exception e) {
					out.println(e);
				} finally {
					conn.close();
				}
				%>
			</div>
		</div>
	</div>

	<script>
		
	</script>

</body>
</html>
