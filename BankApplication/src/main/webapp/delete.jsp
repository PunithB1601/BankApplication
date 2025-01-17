<%@page import="com.bank.dto.Customer"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Delete Customer</title>
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
    
<%Customer c=(Customer)session.getAttribute("customer");
if(c!=null){%>
    <div class="login-container container">
        <h1>Share the amount here!</h1>
        <form  action="deleteCustomer" method="post">
        	
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
  		<input type="hidden" name="accountNumber" value="<%=request.getParameter("accno")%>">
  		 	<div class="mb-3">
                <input type="text" class="form-control" name="nominee" value="1100110011" placeholder="Nominee's account number" required>
            </div>
            <div class="form-check-mb-5 checks">
                <input class="form-check-input" type="checkbox" value="accept" id="flexCheckChecked" checked>
                <label class="form-check-label" for="flexCheckChecked">
                  <b>Confirm delete</b>
                </label>
              </div>
            <button type="submit" class="btn btn-primary w-100" style="margin-top: 20px;">Delete Account</button>
            <a class="btn btn-danger w-100" style="margin-top: 10px;" href="dashboard.jsp">Back</a>
        </form>
        </div>
<%}
else
{
	response.sendRedirect("login.jsp");
}%>
    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>