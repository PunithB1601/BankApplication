package com.bank.dao;

import java.util.List;

import com.bank.dto.Transaction;

public interface TransactionDAO {
	public boolean insertTransaction(Transaction t);
	public List getTransaction(long user);
	public List getTransaction();
	public List get5Transaction(long user);
}
