package com.bank.servlets;

import java.io.IOException;

import com.bank.dao.CustomerDAO;
import com.bank.dao.CustomerDAOImpl;
import com.bank.dto.Customer;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/signup")
public class Signup extends HttpServlet{
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String name=req.getParameter("name");
		String phone=req.getParameter("phone");
		String mail=req.getParameter("mail");
		String pins=req.getParameter("pin");
		String confirms=req.getParameter("confirm");
		
		long phonenumber=Long.parseLong(phone);
		int pin=Integer.parseInt(pins);
		int confirm=Integer.parseInt(confirms);
		
		Customer c=new Customer();
		CustomerDAO cdao=new CustomerDAOImpl();
		if(pin==confirm)
		{
			c.setName(name);
			c.setPhone(phonenumber);
			c.setMail(mail);
			c.setPin(pin);
			boolean result=cdao.insertCustomer(c);
			if(result)
			{
				c=cdao.getCustomer(phonenumber, mail);
				req.setAttribute("success", "Account created successfully! Your account number is"+c.getAccno()+".");
				RequestDispatcher rd=req.getRequestDispatcher("Signup.jsp");
				rd.forward(req, resp);
			}
			else
			{
				req.setAttribute("failure", "Failed to create account. Please try after sometime!");
				RequestDispatcher rd=req.getRequestDispatcher("Signup.jsp");
				rd.forward(req, resp);
			}
		}
		else
		{
			req.setAttribute("failure", "PIN mismatch!");
			RequestDispatcher rd=req.getRequestDispatcher("Signup.jsp");
			rd.forward(req, resp);
		}
	}
}
