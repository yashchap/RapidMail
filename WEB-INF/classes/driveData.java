import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.sql.*;


public class driveData extends HttpServlet
{
	public void service(HttpServletRequest req, HttpServletResponse res)
	{
		try
		{
			//res.setIntHeader("Refresh",5);
			HttpSession session=req.getSession(false);  
			String user=(String)session.getAttribute("Email");
			//session.invalidate();
			Class.forName("com.mysql.jdbc.Driver").newInstance();
			Connection con = DriverManager.getConnection("jdbc:mysql://127.0.0.1/rapidmail","root","1234");
			
			Statement st  = con.createStatement();
			st.executeQuery("SET group_concat_max_len=100000000");
			st  = con.createStatement();
			ResultSet received = st.executeQuery("SELECT GROUP_CONCAT(Attachments SEPARATOR '') as Attachments,Suser FROM `mails` WHERE Ruser='"+user+"' and Attachments!='' GROUP BY Suser");
			req.setAttribute("received",received);
			
			st  = con.createStatement();
			st.executeQuery("SET group_concat_max_len=100000000");
			st  = con.createStatement();
			ResultSet sent = st.executeQuery("SELECT GROUP_CONCAT(Attachments SEPARATOR '') as Attachments, Ruser FROM `mails` WHERE Suser='"+user+"' and Attachments!='' GROUP BY Ruser");
			req.setAttribute("sent",sent);
			
			st  = con.createStatement();
			ResultSet rs = st.executeQuery("Select * from userauthentication where Email='"+user+"'");
			rs.next();
			st  = con.createStatement();
			st.executeQuery("SET group_concat_max_len=100000000");
			st  = con.createStatement();
			ResultSet gsent = st.executeQuery("SELECT GROUP_CONCAT(Attachments SEPARATOR '') as Attachments, Ruser FROM `mails` WHERE Suser='"+rs.getString("GEmail")+"' and Attachments!='' GROUP BY Ruser");
			req.setAttribute("gsent",gsent);
			//
			st  = con.createStatement();
			rs = st.executeQuery("Select * from userauthentication where Email='"+user+"'");
			rs.next();
			st  = con.createStatement();
			st.executeQuery("SET group_concat_max_len=100000000");
			st  = con.createStatement();
			ResultSet greceived = st.executeQuery("SELECT GROUP_CONCAT(Attachments SEPARATOR '') as Attachments,Suser FROM `mails` WHERE Ruser='"+rs.getString("GEmail")+"' and Attachments!='' GROUP BY Suser");
			req.setAttribute("greceived",greceived);
			
			RequestDispatcher rd = req.getRequestDispatcher("drive.jsp");
			rd.forward(req,res);
			con.close();
			
		}
		catch(Exception e)
		{
			
		}
	}
	 	
}