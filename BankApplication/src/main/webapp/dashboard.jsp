<%@page import="com.bank.dao.CustomerDAOImpl"%>
<%@page import="com.bank.dao.CustomerDAO"%>
<%@page import="java.util.Iterator"%>
<%@page import="com.bank.dto.Transaction"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.bank.dao.TransactionDAOImpl"%>
<%@page import="com.bank.dao.TransactionDAO"%>
<%@page import="com.bank.dto.Customer"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Student Management</title>
<style>
.cards-list {
	justify-content: center;
	align-items: center;
	align-content: space-between;
	display: inline-flex;
}

.contents {
	justify-content: center;
	align-items: center;
	align-content: space-evenly;
}

.card {
	width: 19rem; /* Fixed width */
	height: 12rem; /* Fixed height */
	display: flex;
	flex-direction: column;
	justify-content: center; /* Center content vertically */
	align-items: center; /* Center content horizontally */
	text-align: center;
	border-radius: 10px; /* Optional rounded corners */
	box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1); /* Optional shadow */
}

.card-container {
	display: flex;
	justify-content: space-between; /* Equal spaces between cards */
	gap: 1rem; /* Space between cards (for responsiveness) */
}

.passbook {
	margin-top: 20px;
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

.sidebar {
    height: 100%;
    width: 0; /* Hidden by default */
    position: fixed;
    z-index: 1000;
    top: 0;
    left: 0;
    background-color: #111;
    overflow-x: hidden;
    transition: 0.5s;
    padding-top: 60px;
}

.sidebar a {
    padding: 10px 15px;
    text-decoration: none;
    font-size: 18px;
    color: #818181;
    display: block;
    transition: 0.3s;
}

.sidebar a:hover {
    color: #f1f1f1;
}

.sidebar .closebtn {
    position: absolute;
    top: 10px;
    right: 25px;
    font-size: 30px;
    margin-left: 50px;
}

#main {
    transition: margin-left 0.5s;
    padding: 16px;
}

.navbar-toggler-icon {
    display: inline-block;
    width: 2em;
    height: 2em;
}
.menu{
	position: relative;
	right:470px;
}

</style>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css"
	rel="stylesheet">
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css" integrity="sha512-Evv84Mr4kqVGRNSgIGL/F/aIDqQb7xQ2vcrdIwxfjThSH8CSR7PBEakCr51Ck+w+/U6swU2Im1vVX0SVk9ABhg==" crossorigin="anonymous" referrerpolicy="no-referrer" />
	<script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/js/brands.min.js" integrity="sha512-ILOQokRQNF0S8SKV6fnaLNj02CmZnDWmYUr3zlH4jwToep0lWc7twuTzF+Mm0cKPdszi0xe8KymVi2y7mAweVQ==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
</head>
<body
	style="background-image: url(https://wallpapercave.com/wp/wp2912337.jpg)">
	<%CustomerDAO cdao=new CustomerDAOImpl();%>
	<%
	Customer c = (Customer) session.getAttribute("customer");
	if (c != null) {
	%>
	<div class="navbar navbar-expand-lg navbar-dark bg-primary">
		<div class="container-fluid">
			<a class="navbar-brand navbar-primary" href="#">New Bank</a>
			<h3 class="text-light">
				Welcome
				<%=c.getName()%></h3>
			<button class="navbar-toggler" type="button"
				data-bs-toggle="collapse" data-bs-target="#navbarNav"
				aria-controls="navbarNav" aria-expanded="false"
				aria-label="Toggle navigation">
				<span class="navbar-toggler-icon"></span>
			</button>
			<form action="logout" method="post">
				<input class="btn btn-danger" type="submit" name="logout"
					value="Logout">
			</form>
		</div>
	</div>
	<div>
		<ul class="nav justify-content-center bg-warning" id="slider">
			<li class="nav-item"><a class="nav-link active text-dark"
				href="#">Home</a></li>
				<%if(c.getAccno()==1100110011){ %>
				<li class="nav-item"><a class="nav-link text-dark" href="#">View Customers</a>
			</li>
			<li class="nav-item"><a class="nav-link text-dark" href="#">View Transactions</a>
			</li>
			<%}%>
			<li class="nav-item"><a class="nav-link text-dark" href="#">Update
					Account</a></li>
			<li class="nav-item"><a class="nav-link text-dark" href="#">Reset
					Pin</a></li>
			<%if(c.getAccno()!=1100110011){%>
			<li class="nav-item"><a class="nav-link text-dark" href="#">Services</a></li>
			<li class="nav-item"><a class="nav-link text-dark" href="#">About us</a></li>
			<%}%>
		</ul>
	</div>
	<%String failure=(String)request.getAttribute("failure");
    	if(failure!=null){%>
    	<div class="alert alert-danger" role="alert">
  		<b><%=failure%></b>
		</div>
  		<%}%>
	<%if(c.getAccno()==1100110011){ %>
	<div class="contents">
		<div class="container mt-5">
			<div class="card-container">
				<div class="card bg-primary">
					<div class="card-body">
						<h5 class="card-title text-warning">Customers count</h5>
						<p class="card-text text-light">Total active customers:</p>
						<h1 class="card-title text-light"><%=cdao.getCustomersCount()%></h1>
						<a class="card-text text-warning" href="customers.jsp"
							style="text-decoration: none;">View Customers</a>
					</div>
				</div>



				<div class="card bg-primary">
					<div class="card-body">
						<h5 class="card-title text-warning">Vault Balance</h5>
						<p class="card-text text-light">Total amount in vault:</p>
						<h1 class="card-title text-light"><%=cdao.getTotalVault()%></h1>
						<a class="card-text text-warning" href="passbook.jsp"
							style="text-decoration: none;">View transactions</a>
					</div>
				</div>
				
				<div class="card bg-primary">
					<div class="card-body">
						<h5 class="card-title text-warning">Vault Balance</h5>
						<p class="card-text text-light">Total amount in vault:</p>
						<h1 class="card-title text-light"><%=cdao.getTotalVault()%></h1>
						<a class="card-text text-warning" href="passbook.jsp"
							style="text-decoration: none;">View transactions</a>
					</div>
				</div>
				
				
				<div class="card bg-primary">
					<div class="card-body">
						<h5 class="card-title text-warning">Transactions</h5>
						<p class="card-text text-light">Total Transactions done:</p>
						<h1 class="card-title text-light"><%=cdao.getTransactionsCount()%></h1>
						<a class="card-text text-warning" href="passbook.jsp"
							style="text-decoration: none;">View transactions</a>
					</div>
				</div>
			</div>
		</div>
	</div>
	<%}%>
	<div class="contents">
		<div class="container mt-5">
			<div class="card-container">
				<div class="card bg-primary">
					<div class="card-body">
						<h5 class="card-title text-warning">Current Balance</h5>
						<p class="card-text text-light">Your current balance is</p>
						<h1 class="card-title text-light"><%=c.getBal()%></h1>
						<form action="viewTransactions" method="post">
											<input type="hidden" name="accno" value="<%=c.getAccno()%>">
											<input type="submit"  class="btn btn-link text-warning" style="text-decoration: none;" value="View Transactions">
										</form>
					</div>
				</div>



				<div class="card bg-primary">
					<div class="card-body">
						<h5 class="card-title text-warning">Deposit</h5>
						<p class="card-text text-light">Some quick example text to
							build on the card title and make up the bulk of the card's
							content.</p>
						<a href="deposit.jsp" class="btn btn-warning w-100">Add amount</a>
					</div>
				</div>
				<div class="card bg-primary">
					<div class="card-body">
						<h5 class="card-title text-warning">Transfer Amount</h5>
						<p class="card-text text-light">Some quick example text to
							build on the card title and make up the bulk of the card's
							content.</p>
						<a href="transfer.jsp" class="btn btn-warning w-100">Pay now</a>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- Passbook Section -->
	<!-- Transactions Section -->
	<div class="passbook container mt-5">
		<div class="transactions">
			<h5 class="text-center bg-primary text-warning"
				style="padding: 7px; border-radius: 7px;">Recent Transactions</h5>
		</div>
		<div class="table-responsive">
			<table class="table table-bordered">
			<%TransactionDAO tdao=new TransactionDAOImpl();
			ArrayList<Transaction> transactions=(ArrayList<Transaction>)tdao.get5Transaction(c.getAccno());
			Iterator<Transaction> it=transactions.iterator();%>
				<thead class="text-dark text-center">
					<tr class="bg-warning">
						<th scope="col">Tran. ID</th>
						<th scope="col">From</th>
						<th scope="col">Date</th>
						<th scope="col">Amount</th>
						<th scope="col">Type</th>
						<th scope="col">Balance</th>
					</tr>
				</thead>
				<tbody class="bg-primary text-light text-center">
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

		<a class="btn btn-warning" href="passbook.jsp" type="submit">View
			all transactions</a>

	</div>
	<%
	} else {
	response.sendRedirect("login.jsp");
	}
	%>



	<!-- User Section -->

</body>
<script>
    // Embed the balance value from the server
    function showBalance() {
      // Update the text content dynamically
      document.getElementById('balance-text').textContent = `<%=c.getBal()%>
	`;
	}
</script>
</html>