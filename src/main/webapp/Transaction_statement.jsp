<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
	<%@ page language="java" contentType="text/html; charset=UTF-8"
		pageEncoding="UTF-8"%>
	<%@ page import="java.sql.*"%>
	<!DOCTYPE html>

<html>
<head>
<meta charset="UTF-8">
    <meta name="viewport"
	content="width=device-width, initial-scale=1.0">
    <title>Transaction History</title>
    <link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
	rel="stylesheet">
    <style>
body {
	background-color: #f8f9fa;
	padding-top: 5rem;
}

th {
	background-color: #343a40;
	color: #fff;
}

.btn-primary {
	margin-top: 1rem;
}
</style>
</head>
<body>
    <div class="container">
        <h1 class="text-center mb-5">Transaction History</h1>

        <table class="table table-striped">
            <thead>
                <tr>
                    <th>Date</th>
                    <th>Description</th>
                    <th>Amount</th>
                </tr>
            </thead>
            <tbody>
                <%
                try {
                	Class.forName("org.postgresql.Driver");
                	Connection conn = DriverManager.getConnection("jdbc:postgresql://localhost/ajdb",
                	"sushant", "Sushant@9315");
                	Statement stmt = conn.createStatement();
                	ResultSet rs = stmt.executeQuery("SELECT * FROM transactions");

                	while (rs.next()) {
                		String date = rs.getString("date");
                		String description = rs.getString("description");
                		String amount = rs.getString("amount");
                %>
                            <tr>
                                <td><%=date%></td>
                                <td><%=description%></td>
                                <td><%=amount%></td>
                            </tr>
                            <%
                            }
                            conn.close();
                            } catch (Exception e) {
                            out.println("Error: " + e.getMessage());
                            }
                            %>
            </tbody>
        </table>

        <div class="text-center">
            <form action="GeneratePDF.jsp" method="post">
                <input type="submit" class="btn btn-primary"
					value="Download PDF">
            </form>
        </div>
    </div>
</body>
</html>

</body>
</html>