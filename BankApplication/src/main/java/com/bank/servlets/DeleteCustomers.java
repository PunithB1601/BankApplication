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

@WebServlet("/deleteCustomer")
public class DeleteCustomers extends HttpServlet{
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String acc=req.getParameter("accountNumber");
		String nominee=req.getParameter("nominee");
		System.out.println(acc);
		long accno=Long.parseLong(acc);
		long nomineeAccno=Long.parseLong(nominee);

		HttpSession session=req.getSession(false);
		Customer admin=(Customer)session.getAttribute("customer");

		CustomerDAO cdao=new CustomerDAOImpl();
		TransactionDAO tdao=new TransactionDAOImpl(); 
		Customer c=cdao.getCustomer(accno);
		Customer alt_acc=cdao.getCustomer(nomineeAccno);
		if(c!=null&alt_acc.getAccno()!=c.getAccno()) 
		{
			double amount=c.getBal();
			c.setBal(c.getBal()-amount);
			alt_acc.setBal(alt_acc.getBal()+amount);
			boolean bal1=cdao.updateCustomer(c);
			Transaction t1=new Transaction();
			t1.setTransactionId(TransactionID.generateTransactionId());
			t1.setUser(c.getAccno());
			t1.setRec_acc(alt_acc.getAccno());
			t1.setTransaction("debited to "+alt_acc.getAccno());
			t1.setAmount(amount);
			t1.setBalance(c.getBal());
			boolean transaction1=tdao.insertTransaction(t1);
			boolean bal2=cdao.updateCustomer(alt_acc);
			Transaction t2=new Transaction();
			t2.setTransactionId(TransactionID.generateTransactionId());
			t2.setUser(alt_acc.getAccno());
			t2.setRec_acc(c.getAccno());
			t2.setTransaction("credited from "+c.getAccno());
			t2.setAmount(amount);
			t2.setBalance(alt_acc.getBal());
			boolean transaction2=tdao.insertTransaction(t2);
			boolean res=cdao.deleteCustomer(c);
			if(bal1&&bal2&&res)
			{
				req.setAttribute("success", "Account deleted successfully!");
				RequestDispatcher rd=req.getRequestDispatcher("delete.jsp");
				rd.forward(req, resp);
			}
			else
			{
				req.setAttribute("failure", "failed to delete the account");
				RequestDispatcher rd=req.getRequestDispatcher("delete.jsp");
				rd.forward(req, resp);
			}
		}
		req.setAttribute("failure", "Cannot delete the admin account");
		RequestDispatcher rd=req.getRequestDispatcher("delete.jsp");
		rd.forward(req, resp);
	}
}
