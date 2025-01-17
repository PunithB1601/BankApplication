package com.bank.servlets;

import java.io.IOException;

import com.bank.dao.CustomerDAO;
import com.bank.dao.CustomerDAOImpl;
import com.bank.dao.TransactionDAO;
import com.bank.dao.TransactionDAOImpl;
import com.bank.dto.Customer;
import com.bank.dto.Transaction;
import com.bank.dto.TransactionID;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/deposit")
public class Deposit extends HttpServlet{
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String amount=req.getParameter("amount");
		double deposit=Double.parseDouble(amount);
		
		HttpSession session=req.getSession(false);
		Customer c=(Customer)session.getAttribute("customer");
		CustomerDAO cdao=new CustomerDAOImpl();
		TransactionDAO tdao=new TransactionDAOImpl();
		if(c!=null&&deposit>0)
		{
			c.setBal(deposit+c.getBal());
			boolean result=cdao.updateCustomer(c);
			Transaction t=new Transaction();
			t.setTransactionId(TransactionID.generateTransactionId());
			t.setUser(c.getAccno());
			t.setRec_acc(c.getAccno());
			t.setTransaction("Credited from "+c.getAccno());
			t.setAmount(deposit);
			t.setBalance(c.getBal());
			boolean tran_res=tdao.insertTransaction(t);
			if(result&&tran_res)
			{
				req.setAttribute("success", "Amount of Rs."+deposit+" has been deposited successfully!");
				RequestDispatcher rd=req.getRequestDispatcher("deposit.jsp");
				rd.forward(req, resp);
			}
			else
			{
				req.setAttribute("failure", "Failed to deposit. Please try after sometime!");
				RequestDispatcher rd=req.getRequestDispatcher("deposit.jsp");
				rd.forward(req, resp);
			}
		}
		else
		{
			req.setAttribute("failure", "An error occurred. Please try after sometime!");
			RequestDispatcher rd=req.getRequestDispatcher("deposit.jsp");
			rd.forward(req, resp);
		}
}
}
