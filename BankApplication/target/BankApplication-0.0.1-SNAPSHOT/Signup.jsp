<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Bank App Signup</title>
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

        .signup-container {
            background: #fff;
            border-radius: 10px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.2);
            max-width: 400px;
            padding: 2rem;
            text-align: center;
        }

        .signup-container h1 {
            margin-bottom: 1.5rem;
        }
     
        .signup
        {
            position: relative;
            right: 35px;
        }
        .checks
        {
            position: relative;
            right: 90px;
        }
         .header
        {
            position: absolute;
            bottom: 10px;
            width: 100%;
            text-align: center;
            font-size: 0.8rem;
            color: #666;
            font-size: 15px;
            font-weight: 700;
            position: fixed;
            padding: 20px;
            top:10px;
        }

        .header a{
            color: black;
        }
        .success {
	color: green;
}

.failure {
	color: red;
}
        
    </style>
</head>
<body style="background-image:url(https://wallpapercave.com/wp/wp2912337.jpg)">
<div class="header">
        <ul class="nav justify-content-end">
            <li class="nav-item">
              <a class="nav-link" aria-current="page" href="#">Home</a>
            </li>
            <li class="nav-item">
              <a class="nav-link" href="#">Services</a>
            </li>
            <li class="nav-item">
              <a class="nav-link" href="#">About us</a>
            </li>
          </ul>
        </div>
    <div class="signup-container container">
        <h1>Create an account</h1>
        <form  action="signup" method="post">
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
                <input type="text" class="form-control" name="name" placeholder="Enter your Name" required="required">
            </div>
            <div class="mb-3">
                <input type="tel" class="form-control" name="phone" placeholder="Enter your Phone number" required="required">
            </div>
            <div class="mb-3">
                <input type="email" class="form-control" name="mail" placeholder="Enter your Mail Id" required="required">
            </div>
            <div class="mb-3">
                <input type="password" class="form-control" name="pin" placeholder="Set a 4 digit PIN" min="4" max="4" required="required">
            </div>
             <div class="mb-3">
                <input type="password" class="form-control" name="confirm" placeholder="Confirm the PIN" min="4" max="4" required="required">
            </div>
            <div class="form-check-mb-5 checks">
                <input class="form-check-input" type="checkbox" value="accept" id="flexCheckChecked" checked>
                <label class="form-check-label" for="flexCheckChecked">
                  <b>I agree</b>
                </label>
              </div>
            <button type="submit" class="btn btn-primary w-100 login">Create a account</button>
        </form>
        <br>
        <b>Already have a account?</b><a href="login.jsp">login</a>
        </div>
		
    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>