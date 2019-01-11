<%@page import="java.io.*"%>
<%@page import="java.sql.*"%>
<%
	Class.forName("com.mysql.jdbc.Driver").newInstance();
	Connection con = DriverManager.getConnection("jdbc:mysql://127.0.0.1/rapidmail","root","1234");
	Statement st;
	st = con.createStatement();
	String id=request.getParameter("id");
	//out.println(id);
	id=id.substring(1,id.length());
	int i=Integer.parseInt(id);
	//out.println(i);
	st.executeUpdate("UPDATE mails SET Unread = 0 WHERE id="+i+";");
	
%>