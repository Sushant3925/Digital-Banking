<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>

	<%
	Cookie[] cookies = request.getCookies();
	String pwd = request.getParameter("password");
	String password=null ;
	if (cookies != null) {
		for (Cookie cookie : cookies) {
			if (cookie.getName().equals("password")) {
				password = cookie.getValue();
				break;
			}
		}
	}
	
	System.out.println("password"+password);
	
	if(pwd.equals(password))
	{
		request.setAttribute("message", "successful login");	
		RequestDispatcher rd = request.getRequestDispatcher("TransferMoneyProcess.jsp");
        rd.forward(request, response);
	}
	else
	{        
        request.setAttribute("message", "Invalid username or password");
        RequestDispatcher rd = request.getRequestDispatcher("TransferMoney.jsp");
        rd.forward(request, response);       
    }
	%>

</body>
</html>