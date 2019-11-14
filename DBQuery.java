package dbtest;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import java.sql.ResultSetMetaData;

public class DBQuery {

	
	String dbName = "management";
	String tableName;
	
	String url = "jdbc:mysql://127.0.0.1:3306/" + dbName;
	String user = "ilovetom";
	String password = "ilovetom";
	
	String query;
	StringBuffer queryResult;
	
	public DBQuery(){
		try {
			Class.forName("com.mysql.jdbc.Driver");
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
	}
	
	
	public String getDbName() {
		return dbName;
	}
	public void setDbName(String dbName) {
		this.dbName = dbName;
	}
	public String getTableName() {
		return tableName;
	}
	public void setTableName(String tableName) {
		this.tableName = tableName;
	}
	public String getQuery() {
		return query;
	}
	public void setQuery(String query) {
		this.query = query;
	}

	
	public StringBuffer getQueryResult() {
		String condition = "select * from " + tableName + ";";
		System.out.println(condition);
		return f(condition);
	}

	
	public StringBuffer f(String condition){
		StringBuffer s = new StringBuffer();
		Connection con;
		Statement sql;
		ResultSet rs;
		
		try{
			con = DriverManager.getConnection(url, user, password);
			sql = con.createStatement();
			rs = sql.executeQuery(condition);
			
			s.append("<table border=1>");
			
			ResultSetMetaData metaData = rs.getMetaData();
			int columnCount = metaData.getColumnCount();
			String columnName[] = new String[columnCount+1];
			s.append("<tr>");
			for(int k=1;k<=columnCount;k++){
				columnName[k] = metaData.getColumnName(k);
				s.append("<th>"+columnName[k]);
			}
			s.append("</tr>");
			while(rs.next()){
				s.append("<tr>");
				for(int k=1;k<=columnCount;k++){
					s.append("<td>");
					s.append(rs.getString(k));
					s.append("</td>");
				}
				s.append("</tr>");
			}
			s.append("</table>");
		}catch(Exception e){
			e.printStackTrace();
		}
		return s;
		
	}
}
