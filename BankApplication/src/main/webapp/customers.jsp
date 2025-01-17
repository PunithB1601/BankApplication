<%@page import="java.util.Iterator"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.bank.dao.CustomerDAOImpl"%>
<%@page import="com.bank.dao.CustomerDAO"%>
<%@page import="com.bank.dto.Customer"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
<style>
body {
	margin: 0;
	font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
	justify-content: center;
	align-items: center;
	height: 100vh;
}
/* Rounded corners for the table */
.table {
	border-radius: 10px; /* Adds rounded corners */
	overflow: hidden;
	/* Ensures content does not overflow the rounded edges */
}

/* Header row (Warning color like cards) */
thead.bg-warning th {
	font-weight: bold;
	text-transform: uppercase;
}

/* Body rows (Primary color like cards) */
tbody.bg-primary tr {
	transition: background-color 0.3s ease; /* Smooth hover effect */
}

/* Hover effect for rows */
tbody.bg-primary tr:hover {
	background-color: #0056b3; /* Slightly darker primary on hover */
}

.scroll {
	height: 500px;
}
</style>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css"
	rel="stylesheet">
</head>
<body
	style="background-image: url(https://wallpapercave.com/wp/wp2912337.jpg)">
	<%String success=(String)request.getAttribute("success");
    	if(success!=null){%>
    	
    	<div class="alert alert-success" style="position:relative;left:500px;text-align: center;width: 500px;" role="alert">
  		<b><%=success%></b>
		</div>
	
  		<%}%>
  		  <%String failure=(String)request.getAttribute("failure");
    	if(failure!=null){%>
    	<div class="alert alert-danger" role="alert">
  		<b><%=failure%></b>
		</div>
  		<%}%>
	<div class="passbook container mt-5">
		<div class="transactions">
			<%Customer c=(Customer)session.getAttribute("customer");
	if(c!=null){%>

			<div class="passbook container mt-5">
				<div class="transactions">
					<h5 class="text-center bg-primary text-warning"
						style="padding: 7px; border-radius: 7px;">Customers</h5>
				</div>
				<div class="table-responsive">
					<div class="scroll">
						<table class="table table-bordered">
							<%CustomerDAO cdao=new CustomerDAOImpl();
			ArrayList<Customer> customers=(ArrayList<Customer>)cdao.getCustomer();
			Iterator<Customer> it=customers.iterator();%>
							<thead class="text-dark text-center">
								<tr class="bg-light">
									<th scope="col">Account Number</th>
									<th scope="col">Name</th>
									<th scope="col">Phone Number</th>
									<th scope="col">Email ID</th>
									<th scope="col">Balance</th>
									<th scope="col">Transactions</th>
									<th scope="col">Remove</th>
								</tr>
							</thead>
							<tbody class="bg-light text-dark text-center">
								<%while(it.hasNext()){
				Customer c1=it.next();%>
								<tr>
									<td><%=c1.getAccno()%></td>
									<td><%=c1.getName()%></td>
									<td><%=c1.getPhone() %></td>
									<td><%=c1.getMail() %></td>
									<td><%=c1.getBal()%></td>
									<td>
										<form action="viewTransactions" method="post">
											<input type="hidden" name="accno" value="<%=c1.getAccno()%>">
											<input type="submit" class="btn btn-warning" value="View Transactions">
										</form>
									</td>
									<td>
										<form action="delete.jsp" method="post">
											<input type="hidden" name="accno" value="<%=c1.getAccno()%>">
											<input type="submit" class="btn btn-danger" value="Delete">
										</form>
									</td>
								</tr>
								<%}%>
							</tbody>
						</table>
					</div>
				</div>
				<a class="btn btn-danger justify-content-center" href="dashboard.jsp" type="submit">Back</a>
			</div>
		</div>
	</div>
	<%}else
		{
			response.sendRedirect("login.jsp");
		}%>

</body>
</html>