import javax.servlet.*;
import java.io.*;
import javax.servlet.http.*;
import java.sql.*;
public class CheckCookie implements Filter {
	public void doFilter(ServletRequest req,ServletResponse res, FilterChain conf) 
	{
		HttpServletRequest request = (HttpServletRequest) req;
		HttpServletResponse response = (HttpServletResponse) res;
		HttpSession session = request.getSession();
		try
		{
			int i,c=1;
			//System.out.println("1");
			Cookie ck[] = request.getCookies();
			//System.out.println("2");
			if(ck!=null)
			{
				if (request.getParameterMap().containsKey("Email"))
			{
				Class.forName("com.mysql.jdbc.Driver").newInstance();
				Connection con = DriverManager.getConnection("jdbc:mysql://127.0.0.1/rapidmail","root","1234");
				Statement st  = con.createStatement();
				if(request.getParameterMap().containsKey("fn"))
				{
					String Email = request.getParameter("Email");
					String Password = request.getParameter("Password");
					String DOB = request.getParameter("DOB");
					String Name = request.getParameter("fn") +" "+ request.getParameter("ln");
					ResultSet rs  = st.executeQuery("Select * from userauthentication where Email='"+Email+"'");
					rs.next();
					if(rs.getRow()==1)
					{
						response.sendRedirect("login.jsp?Error=user_exist");
					}
					else
					{
						
						st.executeUpdate("insert into userauthentication values('"+Name+"', '"+Email+"', '"+Password+"','"+DOB+"','','')");
						Cookie ck1  = new Cookie("Email",Email);
						ck1.setPath("/rapidmail");
						ck1.setMaxAge(60*60*24*7);
						response.addCookie(ck1);
						c=0;
						//HttpSession session=request.getSession();  
						session.setAttribute("Email",Email);  
						conf.doFilter(request,response);
					}
					
				}
				else
				{
					
					String Email = request.getParameter("Email");
					String Password = request.getParameter("Password");
					System.out.println(Email);
					System.out.println(Password);
					ResultSet rs = st.executeQuery("Select * from userauthentication where Email='"+Email+"' and Password='"+Password+"'");
					rs.next();
					//System.out.println(rs.getString("Email"));
					System.out.print(rs.getRow());
					if(rs.getRow()==1)
					{
						if (request.getParameterMap().containsKey("box"))
						{
							Cookie ck1  = new Cookie("Email",Email);
							ck1.setPath("/rapidmail");
							ck1.setMaxAge(60*60*24*7);
							response.addCookie(ck1);
							
						}
						c=0; 
						//HttpSession session=request.getSession();  
						session.setAttribute("Email",Email);
						conf.doFilter(request,response);
					}
					else
					{
						st  = con.createStatement();
						rs = st.executeQuery("Select * from userauthentication where Email='"+Email+"'");
						rs.next();
						if(rs.getRow()==0)
						response.sendRedirect("login.jsp?Error=Invalid_email");
						else
						response.sendRedirect("login.jsp?Error=Invalid_password");
						
					}
				}
			}
			
			else if(ck.length > 0)
			{	
				System.out.print("cookie checker");
				
				for(i=0;i<ck.length;i++)
				{
					System.out.println(ck[i].getName());
					if(ck[i].getName().equals("Email"))
					{
						c=0; 
						//HttpSession session=request.getSession();  
						session.setAttribute("Email",ck[i].getValue());
						conf.doFilter(request,response);
						break;
						
					}
				}
			}
			
			if(session.getAttribute("Email")!=null)
			{
				conf.doFilter(request,response);
				c=0;
			}
			if (c==1)
			{
				response.sendRedirect("login.jsp");
			}
			}
			else
			{
				response.sendRedirect("login.jsp");
			}
		}
		catch(Exception e)
		{
			System.out.println("In checkcookie");
			e.printStackTrace();
			
		}
			
		
	}
}