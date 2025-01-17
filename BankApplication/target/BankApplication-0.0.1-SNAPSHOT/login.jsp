<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Bank App Login</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            margin: 0;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }

        .login-container {
            background: #fff;
            border-radius: 10px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.2);
            max-width: 400px;
            padding: 2rem;
            text-align: center;
        }

        .login-container h1 {
            margin-bottom: 1.5rem;
        }
     
        .login
        {
            position: relative;
            right: 35px;
        }
        .checks
        {
            position: relative;
            right: 90px;
        }
        
    </style>
</head>
<body style="background-image:url(https://wallpapercave.com/wp/wp2912337.jpg)">
    

    <div class="login-container container">
        <h1>Customer Login</h1>
        <form  action="login" method="post">
        <%String success=(String)request.getAttribute("success");
    	if(success!=null){%>
    	<div class="alert alert-success" role="alert">
  		<b><%=success%></b>
		</div>
  		<%}%>
  		  <%String failure=(String)request.getAttribute("failure");
    	if(failure!=null){%>
    	<div class="alert alert-danger" role="alert">
  		<b><%=failure%></b>
		</div>
  		<%}%>
            <div class="mb-3">
                <input type="text" class="form-control" name="accountnumber" placeholder="Enter your Account Number" required>
            </div>
            <div class="mb-3">
                <input type="password" class="form-control" name="pin" placeholder="Enter your PIN" required>
            </div>
            
            <div class="form-check-mb-5 checks">
                <input class="form-check-input" type="checkbox" value="accept" id="flexCheckChecked" checked>
                <label class="form-check-label" for="flexCheckChecked">
                  <b>Remember me</b>
                </label>
              </div>
            <button type="submit" class="btn btn-primary w-50 login">Login</button><a href="Signup.jsp">forgot pin?</a>
        </form>
        <br>
        <b>Don't have a account?</b><a href="Signup.jsp">Create one!</a>
        </div>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>