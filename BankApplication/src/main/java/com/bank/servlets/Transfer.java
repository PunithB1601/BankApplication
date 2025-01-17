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

@WebServlet("/transfer")
public class Transfer extends HttpServlet{
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String accno=req.getParameter("accountnumber");
		String amount=req.getParameter("amount");
		String pins=req.getParameter("pin");
		
		long benificiary_acc=Long.parseLong(accno);
		double transfer=Double.parseDouble(amount);
		int pin=Integer.parseInt(pins);
		
		HttpSession session=req.getSession(false);
		
		CustomerDAO cdao=new CustomerDAOImpl();
		TransactionDAO tdao=new TransactionDAOImpl();
		Customer sender=(Customer)session.getAttribute("customer");
		
		Customer reciever=cdao.getCustomer(benificiary_acc);
		Transaction t1=new Transaction();
		Transaction t2=new Transaction();
		
		if(sender!=null&&reciever!=null&&sender.getAccno()!=reciever.getAccno()&&sender.getBal()>transfer&&transfer>0) {
			sender.setBal(sender.getBal()-transfer);
			reciever.setBal(reciever.getBal()+transfer);
			boolean result1=cdao.updateCustomer(sender);
			t1.setTransactionId(TransactionID.generateTransactionId());
			t1.setUser(sender.getAccno());
			t1.setRec_acc(reciever.getAccno());
			t1.setTransaction("debited to "+reciever.getAccno());
			t1.setAmount(transfer);
			t1.setBalance(sender.getBal());
			boolean transaction1=tdao.insertTransaction(t1);
			boolean result2=cdao.updateCustomer(reciever);
			t2.setTransactionId(t1.getTransactionId());
			t2.setUser(reciever.getAccno());
			t2.setRec_acc(sender.getAccno());
			t2.setTransaction("credited from "+sender.getAccno());
			t2.setAmount(transfer);
			t2.setBalance(reciever.getBal());
			boolean transaction2=tdao.insertTransaction(t2);
			if(result1&&result2&&transaction1&&transaction2)
			{
				req.setAttribute("success", "Payment of Rs."+transfer+" to "+reciever.getName()+" sent successfully!");
				RequestDispatcher rd=req.getRequestDispatcher("transfer.jsp");
				rd.forward(req, resp);
			}
			else
			{
				req.setAttribute("failure", "Transaction failed!");
				RequestDispatcher rd=req.getRequestDispatcher("transfer.jsp");
				rd.forward(req, resp);
			}
		}
		else
		{
			req.setAttribute("failure", "An error occurred. Please try after sometime!");
			RequestDispatcher rd=req.getRequestDispatcher("transfer.jsp");
			rd.forward(req, resp);
		}
	}  
}
