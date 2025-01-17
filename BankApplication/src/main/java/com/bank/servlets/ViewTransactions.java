package com.bank.servlets;

import java.io.IOException;
import java.util.ArrayList;

import com.bank.dao.CustomerDAO;
import com.bank.dao.CustomerDAOImpl;
import com.bank.dao.TransactionDAO;
import com.bank.dao.TransactionDAOImpl;
import com.bank.dto.Customer;
import com.bank.dto.Transaction;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/viewTransactions")
public class ViewTransactions extends HttpServlet{
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String acc=req.getParameter("accno");
		long accno=Long.parseLong(acc);
		
		CustomerDAO cdao=new CustomerDAOImpl();
		Customer c=cdao.getCustomer(accno);
		
		TransactionDAO tdao=new TransactionDAOImpl();
		ArrayList<Transaction> passbook =(ArrayList<Transaction>)tdao.getTransaction(accno);
		if(passbook!=null)
		{
			req.setAttribute("customer", c);
			req.setAttribute("passbook", passbook);
			RequestDispatcher rd=req.getRequestDispatcher("passbook.jsp");
			rd.forward(req, resp);
		}
		else
		{
			req.setAttribute("failure","Error occurred. Please try later after sometime!");
			RequestDispatcher rd=req.getRequestDispatcher("dashboard.jsp");
			rd.forward(req, resp);
		}
	}
}
