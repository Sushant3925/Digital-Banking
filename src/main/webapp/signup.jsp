<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ include file="/Home.html"%>

<!doctype html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Sign Up form</title>
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

	<div class="container" style="width: 500px; margin-top: 120px; margin-bottom:30px; background: aliceblue;">

		<h1 class="text-center pb-5">Create Account</h1>

		<form method="post" action="./mainPage.jsp">

			<div class="mb-3">

				<label for="exampleInputEmail1" class="form-label">Account no
					</label> <input type="text" name="accno" class="form-control"
					id="exampleInputEmail1" aria-describedby="emailHelp">

			</div>
			<div class="mb-3">

				<label for="exampleInputEmail1" class="form-label">PAN no</label> <input
					type="text" name="panno" class="form-control"
					id="exampleInputEmail1" aria-describedby="emailHelp">

			</div>
			<div class="mb-3">

				<label for="exampleInputEmail1" class="form-label">Name as per PAN
					</label> <input type="text" name="name" class="form-control"
					id="exampleInputEmail1" aria-describedby="emailHelp">

			</div>
			<div class="mb-3">

				<label for="exampleInputEmail1" class="form-label">Create UserId
					</label> <input type="text" name="user" class="form-control"
					id="exampleInputEmail1" aria-describedby="emailHelp">

			</div>


			<div class="mb-3">

				<label for="exampleInputEmail1" class="form-label">Create A Strong Password</label>

				<input type="text" name="password" class="form-control"
					id="exampleInputEmail1" aria-describedby="emailHelp">

			</div>


			<div class="d-grid gap-2">
				<button type="submit" class="btn btn-primary">Submit</button>
			</div>
		</form>

	</div>




	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
		crossorigin="anonymous"></script>
</body>


</html>