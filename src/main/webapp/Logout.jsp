<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
	
	 <script>
        
            // Perform logout process (invalidate session)
            <% session.invalidate(); %>
            
            // Redirect to login page
            window.location.replace("./Login.jsp");

        // Disable back button after logout
        history.pushState(null, null, location.href);
        window.onpopstate = function () {
            history.go(1);
        };
    </script>
	
</body>
</html>