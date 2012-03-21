package com.db.interfaces;

import java.sql.ResultSet;
import java.sql.SQLException;

import com.db.jdbc.DBManager;

public interface SQLResult {

	
	public int getRows();
	public int getCols();
	public DBManager getDbMgr();
	public ResultSet getRslSet() throws SQLException;
}
