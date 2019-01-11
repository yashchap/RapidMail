<%@page contentType="application/json; charset=UTF-8"%>
<%@page import="java.io.*"%>
<%@page import="java.sql.*"%>


<%
   try{
	Class.forName("com.mysql.jdbc.Driver").newInstance();
	Connection con = DriverManager.getConnection("jdbc:mysql://127.0.0.1/rapidmail","root","1234");
	Statement st;
	st = con.createStatement();
	session=request.getSession(false);  
	String user=(String)session.getAttribute("Email");
	ResultSet rs = st.executeQuery("Select * from mails where Suser='"+user+"' and id > "+request.getParameter("id")+" and Sdelete = 0 ORDER BY id DESC" );
	String text="{\"records\":[";
	while(rs.next()){
		st = con.createStatement();	
	ResultSet rsi =st.executeQuery("Select Name from userauthentication where Email='"+rs.getString("Ruser")+"'");
	rsi.next();
	text +="{\"Name\":\""+rsi.getString("Name")+"\",\"id\":\""+rs.getString("id")+"\",\"Suser\":\""+rs.getString("Suser")+"\",\"Ruser\":\""+rs.getString("Ruser")+"\",\"Subject\":\""+rs.getString("Subject")+"\",\"Mail\":\""+rs.getString("Mail")+"\",\"Unread\":\""+rs.getString("Unread")+"\",\"Time\":\""+rs.getTime("Time")+"\",\"Attachments\":\""+rs.getString("Attachments")+"\"}";
	if(rs.next())
	{
		text+=",";
		rs.previous();
	}
  }
   text = text + "]}";
   out.println(text);
	rs.close();
	st.close();
	con.close();
   }
   catch(Exception e){System.out.println(e);}
 %> 