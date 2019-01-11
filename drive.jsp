<%@page import="java.sql.*"%>
<%@page import="java.io.*"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.*"%>

<html>
	<head> 
		
						<script type='text/javascript'  src="JS/jquery-3.1.1.min.js"></script>
	
				<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.12.0/jquery.min.js"></script>
		<meta name="viewport" content="width=device-width, initial-scale=1">
		
		<link rel="stylesheet" type="text/css" href="CSS/bootstrap.css"/>
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/css/bootstrap.min.css">
		
		<script type='text/javascript' src="JS/bootstrap.min.js"></script>
		
		<script src="blog/ckeditor.js"></script>
		<link rel="stylesheet" type="text/css" href="CSS/main.css"/>
		
	</head>
	<body>
	<div class="container-fluid">
	
	<nav class="navbar navbar-inverse">
		<div class="row"><img id="logo"  class="img-rounded col-sm-1" src="Images/logo.png"   >
		<div class="container-fluid col-sm-11" >
			
			<div class="navbar-header">
				<button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#myNavbar">
					<span class="icon-bar"></span>
					<span class="icon-bar"></span>
					<span class="icon-bar"></span>                        
				</button>
     
			</div>
			
			<div class="collapse navbar-collapse" id="myNavbar">
				<ul class="nav navbar-nav navbar-right">
					
					<li><a href="index">
						<span class="glyphicon glyphicon-envelope"></span> Mail
					</a></li>
					<li><div class="col-sm-12 btn btn-info btn-lg text-left" id="received_btn_nav" onclick="show_received()"> <span class="glyphicon glyphicon-cloud-download"></span>&nbspReceived</div>
					</li><li><div class="col-sm-12 btn btn-info btn-lg text-left" id="sent_btn_nav" onclick="show_sent()"><span class="glyphicon glyphicon-cloud-upload"></span>&nbspSent</div>
					</li>
					<li><a onclick="logOut()">
						<span class="glyphicon glyphicon-log-out"></span> Log out
					</a></li>
					</ul>
				
				
			</div>
		</div></div>
	</nav>
	
	<div class="col-sm-3">
	<div class="btn-group-vertical col-sm-12">
		<div class="col-sm-12 btn btn-info btn-lg text-left" id="received_btn" onclick="show_received()"> <span class="glyphicon glyphicon-cloud-download"></span>&nbspReceived</div>
		<div class="col-sm-12 btn btn-info btn-lg text-left" id="sent_btn" onclick="show_sent()"><span class="glyphicon glyphicon-cloud-upload"></span>&nbspSent</div>
	</div>
	</div>
	<%try
	{
		ResultSet received = (ResultSet)request.getAttribute("received");
		ResultSet greceived = (ResultSet)request.getAttribute("greceived");
		ResultSet sent = (ResultSet)request.getAttribute("sent");
		ResultSet gsent = (ResultSet)request.getAttribute("gsent");
		Class.forName("com.mysql.jdbc.Driver").newInstance();
		Connection con = DriverManager.getConnection("jdbc:mysql://127.0.0.1/rapidmail","root","1234");
		ResultSet rs;
		Statement st;
		ResultSet ss;
		Statement sts;
		//received****************************************
		int rc=1;
		int grc=1;
		int sc=1;
		int gsc=1;
		out.println("<div class='col-sm-9'>");
		%><div class="col-sm-12" id="received" style="display:block"><%
		while(received.next())
		{
			st = con.createStatement();
			rs = st.executeQuery("Select Name from userauthentication where Email='"+received.getString("Suser")+"'" );
			rs.next();
			out.println("<div  onclick=\"slide('demo"+rc+"')\" style='background-color:#449d44;color:white' class='well well-md '><span class='glyphicon glyphicon-user'></span>&nbsp");out.println(rs.getString("Name"));out.println("["+received.getString("Suser")+"]");%><span style="float:right" class="glyphicon glyphicon-chevron-down"></span><%out.println("</div>");
			out.println("<div id='demo"+rc+"' class=\"collapse jumbotron\">");
			
			String Attachments = received.getString("Attachments");
			String files[] = Attachments.split(";");
			%><div class="row"><%
			for(int i=0;i<files.length;i++)
			{
				
				
				int n= files[i].lastIndexOf("/");
				 
				String name = files[i].substring(n+1,files[i].length());
				files[i] = files[i].replace(" ","%20");
				out.println("<a href="+files[i]+" target=\"_Blank\"><div class=\"fileopen col-sm-3 img-thumbnail\" style=\"margin-top:10px;margin-left:5px; \">"+name+"<embed src="+files[i]+" style=\"width:100%;height:160px\"><a href="+files[i]+" class=\"filedownload\" download><span class=\"glyphicon glyphicon-save \"></span></a></div></a>");
			}
			
			out.println("</div></div>");
			
			out.println("<br>");
			rc=rc+1;
		}
		while(greceived.next())
		{
			
			out.println("<div  onclick=\"slide('gdemo"+grc+"')\" style='background-color:#449d44;color:white' class='well well-md '><span class='glyphicon glyphicon-user'></span>&nbsp");out.println("["+greceived.getString("Suser")+"]");%><span style="float:right" class="glyphicon glyphicon-chevron-down"></span><%out.println("</div>");
			out.println("<div id='gdemo"+grc+"' class=\"collapse jumbotron\">");
			
			String Attachments = greceived.getString("Attachments");
			String files[] = Attachments.split(";");
			%><div class="row"><%
			for(int i=0;i<files.length;i++)
			{
				
				
				int n= files[i].lastIndexOf("/");
				 
				String name = files[i].substring(n+1,files[i].length());
				files[i] = files[i].replace(" ","%20");
				out.println("<a href="+files[i]+" target=\"_Blank\"><div class=\"fileopen col-sm-3 img-thumbnail\" style=\"margin-top:10px;margin-left:5px; \">"+name+"<embed src="+files[i]+" style=\"width:100%;height:160px\"><a href="+files[i]+" class=\"filedownload\" download><span class=\"glyphicon glyphicon-save \"></span></a></div></a>");
			}
			
			out.println("</div></div>");
			
			out.println("<br>");
			grc=grc+1;
		}	
			
		
			%></div>
			<div class="col-sm-12" id="sent" style="display:none"><%
			//received.first();
			//received.previous();
		while(sent.next())
		{
			st = con.createStatement();
			rs = st.executeQuery("Select Name from userauthentication where Email='"+sent.getString("Ruser")+"'" );
			rs.next();
			out.println("<div onclick=\"slide('dem"+sc+"')\" style='background-color:#449d44;color:white' class='well well-md '><span class='glyphicon glyphicon-user'></span>&nbsp");out.println(rs.getString("Name"));out.println("["+sent.getString("Ruser")+"]");%><span style="float:right" class="glyphicon glyphicon-chevron-down"></span><%out.println("</div>");
			out.println("<div id='dem"+sc+"' class=\"collapse jumbotron\">");
			
			String Attachments = sent.getString("Attachments");
			String files[] = Attachments.split(";");
			%><div class="row"><%
			for(int i=0;i<files.length;i++)
			{
				int n= files[i].lastIndexOf("/");
				 
				String name = files[i].substring(n+1,files[i].length());
				files[i] = files[i].replace(" ","%20");
				out.println("<a href="+files[i]+" target=\"_Blank\"><div class=\"fileopen col-sm-3 img-thumbnail\" style=\"margin-top:10px;margin-left:5px; \">"+name+"<embed src="+files[i]+" style=\"width:100%;height:160px\"><a href="+files[i]+" class=\"filedownload\" download><span class=\"glyphicon glyphicon-save \"></span></a></div></a>");
			}
			
			out.println("</div></div>");
			
			out.println("<br>");
			sc=sc+1;
		}
		
		while(gsent.next())
		{
			
			out.println("<div onclick=\"slide('gdem"+gsc+"')\" style='background-color:#449d44;color:white' class='well well-md '><span class='glyphicon glyphicon-user'></span>&nbsp");out.println("["+gsent.getString("Ruser")+"]");%><span style="float:right" class="glyphicon glyphicon-chevron-down"></span><%out.println("</div>");
			out.println("<div id='gdem"+gsc+"' class=\"collapse jumbotron\">");
			
			String Attachments = gsent.getString("Attachments");
			String files[] = Attachments.split(";");
			%><div class="row"><%
			for(int i=0;i<files.length;i++)
			{
				int n= files[i].lastIndexOf("/");
				 
				String name = files[i].substring(n+1,files[i].length());
				files[i] = files[i].replace(" ","%20");
				out.println("<a href="+files[i]+" target=\"_Blank\"><div class=\"fileopen col-sm-3 img-thumbnail\" style=\"margin-top:10px;margin-left:5px; \">"+name+"<embed src="+files[i]+" style=\"width:100%;height:160px\"><a href="+files[i]+" class=\"filedownload\" download><span class=\"glyphicon glyphicon-save \"></span></a></div></a>");
			}
			
			out.println("</div></div>");
			
			out.println("<br>");
			gsc=gsc+1;
		}	
			
			%></div><%
	
	out.println("</div>");
	}
	catch(Exception e)
	{
		
		System.out.println(e);
	}	
	
	%>
	
	</div>
</body>
<script>
function logOut()
		{
			window.location.assign("logout.jsp");
		}
function slide(id)
{
	  $("#"+id).slideToggle("fast");
}
function show_received()
{
	document.getElementById("received_btn").style.backgroundColor="#91dafa";
	document.getElementById("sent_btn").style.backgroundColor="white";
	document.getElementById("sent_btn").style.color="black";
	document.getElementById("received_btn").style.color="white";
	document.getElementById("received").style.display="block";
	document.getElementById("sent").style.display="none";
	
	
}
function show_sent()
{
	document.getElementById("sent_btn").style.backgroundColor="#91dafa";
	document.getElementById("received_btn").style.backgroundColor="white";
	document.getElementById("received_btn").style.color="black";
	document.getElementById("sent_btn").style.color="white";
	document.getElementById("sent").style.display="block";
	document.getElementById("received").style.display="none";
}

</script>
</html>