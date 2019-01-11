import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.sql.*;


public class LoadData extends HttpServlet
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
			ResultSet rs_inbox = st.executeQuery("Select * from mails where Ruser='"+user+"' and Rdelete = 0 ORDER BY id DESC" );
			req.setAttribute("inbox_obj",rs_inbox);
			st  = con.createStatement();
			ResultSet rs_sent = st.executeQuery("Select * from mails where Suser='"+user+"' and Sdelete = 0 ORDER BY id DESC" );
			req.setAttribute("sent_obj",rs_sent);
			st  = con.createStatement();
			ResultSet rs_delete = st.executeQuery("Select * from mails where Ruser='"+user+"' and Rdelete = 1 and Trash=0 ORDER BY id DESC" );
			req.setAttribute("delete_obj",rs_delete);
			RequestDispatcher rd = req.getRequestDispatcher("index.jsp");
			rd.forward(req,res);
			//con.close();
			
		}
		catch(Exception e)
		{
			
		}
	}
	 	
}