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
	<style>
	body{
	background-color: antiquewhite;
	}
	</style>
</head>
<body>


	<div class="container border border-dark"
		style="width: 300px; background: aliceblue; border-radius: 10px; margin-top: 120px; ">

		
		<div class="text-center">
			<img src="./Images/banking.png" class="img-fluid pb-3" alt="..."
				width="100px;">
		</div>
		<form method="POST" action="./validateLogin.jsp">
			<div class="mb-3">
				<input type="text" name="username" placeholder="Username"
					class="form-control" id="exampleInputEmail1"
					aria-describedby="emailHelp">
			</div>

			<div class="mb-3">
				<input type="password" name="Password" placeholder="Password"
					class="form-control" id="exampleInputPassword1">
			</div>

			<div class="d-grid gap-2">
				<button type="submit" class="btn btn-primary mb-0 mt-3">Login</button>
				<p style="text-align: center;">
					Don't have Account a<a href="signup.jsp">&nbsp;Sign up</a>
				</p>
			</div>

		</form>


	</div>
		<c:if test="${not empty message}">
			<p style="color:red; text-align: center;" >${message}</p>
		</c:if>

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
		crossorigin="anonymous"></script>
</body>
</html>