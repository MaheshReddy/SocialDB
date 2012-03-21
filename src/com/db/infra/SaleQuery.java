package com.db.infra;

import java.sql.ResultSet;
import java.sql.SQLException;

import com.db.interfaces.SQLResult;
import com.db.jdbc.DBManager;

public class SaleQuery implements SQLResult {

	  private int cols=-1;
	  private int rows=0;
	  private ResultSet rslSet = null;
	  private String query= null;
	  private DBManager dbMgr = null;
	  
	public SaleQuery() {
	}
		
	
	public int getCols() {
		return cols;
	}

	public void setCols(int cols) {
		this.cols = cols;
	}

	public int getRows() {
		return rows;
	}

	public void setRows(int rows) {
		this.rows = rows;
	}


	@Override
	public ResultSet getRslSet() throws SQLException {
		ResultSet rslSet = dbMgr.executeQuery(query);
		if(rslSet!=null)
			cols=rslSet.getMetaData().getColumnCount();
		return rslSet;
	}


	public void setQuery(String query) {
		this.query = query;
	}


	public String getQuery() {
		return query;
	}


	public void setDbMgr(DBManager dbMgr) {
		this.dbMgr = dbMgr;
	}

	@Override
	public DBManager getDbMgr() {
		return dbMgr;
	}

	
}
