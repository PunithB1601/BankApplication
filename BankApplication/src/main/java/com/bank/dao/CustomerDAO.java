package com.bank.dao;

import java.util.List;
import java.util.Map;

import com.bank.dto.Customer;

public interface CustomerDAO {
	public boolean insertCustomer(Customer c);
	public com.bank.dto.Customer getCustomer(long accno,int pin);
	public Customer getCustomer(long phone,String mail);
	public Customer getCustomer(long accno);
	public List getCustomer();
	public boolean updateCustomer(Customer c);
	public boolean deleteCustomer(Customer c);
	public int getCustomersCount();
	public double getTotalVault();
	public int getTransactionsCount();
}
