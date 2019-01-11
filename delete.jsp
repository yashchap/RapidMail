<%@page import="java.io.*"%>
<%@page import="java.sql.*"%>
<%
	Class.forName("com.mysql.jdbc.Driver").newInstance();
	Connection con = DriverManager.getConnection("jdbc:mysql://127.0.0.1/rapidmail","root","1234");
	Statement st;
	st = con.createStatement(); 
	String deleted[];
	deleted = request.getParameterValues("delete");
	if (deleted != null) 
	{
	  
		for (int i = 0; i < deleted.length; i++) 
		{
			if(deleted[i].charAt(0)=='i')
			{
				int id=Integer.parseInt(deleted[i].substring(1,deleted[i].length()));
				//out.println ("<b>"+id+"<b><br/>");
				st.executeUpdate("UPDATE `mails` SET `Rdelete`= 1 WHERE id="+id+"");
			
			}
			else if(deleted[i].charAt(0)=='s')
			{
				int id=Integer.parseInt(deleted[i].substring(1,deleted[i].length()));
				//out.println ("<b>"+id+"<b><br/>");
				st.executeUpdate("UPDATE `mails` SET `Sdelete`= 1 WHERE id="+id+"");
			}
			else
			{
				int id=Integer.parseInt(deleted[i].substring(1,deleted[i].length()));
				//out.println ("<b>"+id+"<b><br/>");
				st.executeUpdate("UPDATE `mails` SET `Trash`= 1 WHERE id="+id+"");
				//out.println("delte");
			}
		 
		}
		response.sendRedirect("index");
	}
   else
   {
	   out.println("failed");
	   response.sendRedirect("index");
	  // RequestDispatcher rd = req.getRequestDispatcher("index.jsp");

   }
   st.close();
   con.close();
 %>
 