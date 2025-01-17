<%@page import="java.util.Iterator"%>
<%@page import="com.bank.dto.Transaction"%>
<%@page import="com.bank.dao.TransactionDAOImpl"%>
<%@page import="com.bank.dao.TransactionDAO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.bank.dto.Customer"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
 <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
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
       .scroll{
       height:300px;
  
       } 
     </style>
</head>
<body style="background-image:url(https://wallpapercave.com/wp/wp2912337.jpg)">
<div class="passbook container mt-5">
<div class="transactions">

<%Customer c=(Customer)request.getAttribute("customer");
	if(c!=null){%>
			<h5 class="text-center bg-primary text-warning"
				style="padding: 7px; border-radius: 7px;">Account Overview</h5>
		</div>
	<div class="table-responsive">
	
			<table class="table table-bordered">
				<tbody class="bg-warning text-dark text-center">
					<tr>
						<td style="width:50%;">Account Number</td>
						<td style="width:50%;"><%=c.getAccno() %></td>
					</tr>
					<tr>
						<td>Account holder</td>
						<td><%=c.getName()%></td>
					</tr>
					<tr>	
						<td>Phone Number</td>
						<td><%=c.getPhone()%>
					</tr>
					<tr>	
						<td>Email ID</td>
						<td><%=c.getMail() %></td>
					</tr>
			</table>
			<a class="btn btn-danger justify-content-center" href="dashboard.jsp" type="submit">Back</a>
		</div>
		
		</div>
		
		
		<div class="passbook container mt-5">
		
		<div class="transactions">
			<h5 class="text-center bg-primary text-warning"
				style="padding: 7px; border-radius: 7px;">Recent Transactions</h5>
		</div>
		<div class="table-responsive">
		<div class="scroll">
			<table class="table table-bordered">
			<%
			ArrayList<Transaction> passbook=(ArrayList<Transaction>)request.getAttribute("passbook");
			Iterator<Transaction> it=passbook.iterator();%>
				<thead class="text-dark text-center">
					<tr class="bg-light">
						<th scope="col">Tran. ID</th>
						<th scope="col">From</th>
						<th scope="col">Date</th>
						<th scope="col">Amount</th>
						<th scope="col">Type</th>
						<th scope="col">Balance</th>
					</tr>
				</thead>
				<tbody class="bg-light text-dark text-center">
				<%while(it.hasNext()){
				Transaction t=it.next();%>
					<tr>
						<td><%=t.getTransactionId() %></td>
						<td><%=t.getRec_acc()%></td>
						<td><%=t.getDate() %></td>
						<td><%=t.getTransaction() %></td>
						<td><%=t.getAmount()%></td>
						<td><%=t.getBalance() %></td>
					</tr>
					<%}%>
				</tbody>
			</table>
			</div>
		</div>
		</div>
		<%}else
		{
			response.sendRedirect("login.jsp");
		}%>
</body>
</html>