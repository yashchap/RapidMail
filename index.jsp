<%@page import="java.sql.*"%>
<%@page import="java.io.*"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.*"%>
<%
//checking gmail user

			try{
			ResultSet rs_inbox = (ResultSet)request.getAttribute("inbox_obj");
			Class.forName("com.mysql.jdbc.Driver").newInstance();
			Connection con = DriverManager.getConnection("jdbc:mysql://127.0.0.1/rapidmail","root","1234");
			Statement st;
			st = con.createStatement();
			session=request.getSession(false);  
			String user=(String)session.getAttribute("Email");
			ResultSet GEmail = st.executeQuery("Select GEmail from userauthentication where Email='"+user+"'" );
			//ResultSet GEmail = st.exceuteQuery("Select GEmail from userauthentication where Email = '"+user+"'");
			
			
			
				
			
			

			
			
%>
<html>
	<head> 
			
			<%
			if(GEmail.next())
			out.println("<script>var GEmail = '"+GEmail.getString("GEmail")+"';</script>");
			%>
			<script type='text/javascript'  src="JS/jquery-3.1.1.min.js"></script>
		<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.12.0/jquery.min.js"></script>
		<meta name="viewport" content="width=device-width, initial-scale=1">
		
		<link rel="stylesheet" type="text/css" href="CSS/bootstrap.css"/>
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/css/bootstrap.min.css">
		<script type='text/javascript' src="JS/bootstrap.min.js"></script>
		 <script type='text/javascript' src="blog/ckeditor.js"></script>
		<link rel="stylesheet" type="text/css" href="CSS/main.css"/>
	</head>
	<body>
	<div class="container-fluid">
	<nav class="navbar navbar-inverse">
		<div class="row"><img id="logo" class="img-rounded col-sm-1" src="Images/logo.png"   >
		<div class="container-fluid col-sm-11" >
			<div class="navbar-header">
				<button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#myNavbar">
					<span class="icon-bar"></span>
					<span class="icon-bar"></span>
					<span class="icon-bar"></span>                        
				</button>
			
			</div>
			<input id="search" type="text" class="col-sm-7" onKeypress="search()" style="margin-top:1%;margin-left:9%"><span class="glyphicon glyphicon-search" style="margin-top:1%;background-color:white;padding:5px" ></span>
			<div class="collapse navbar-collapse" id="myNavbar">
				<ul class="nav navbar-nav navbar-right">
				
					<li><a href="drive">
						<span class="glyphicon glyphicon-cloud"></span> Drive
					</a></li>
					<li><div class="col-sm-12 btn btn-info btn-lg text-left" id="mcompose_div" onclick="show_compose()"> <span class="glyphicon glyphicon-pencil"></span> Compose</div></li>
					<li><div class="col-sm-12 btn btn-info btn-lg text-left" id="minbox_div" onclick="updateinbox()"><span class="glyphicon glyphicon-inbox"></span> Inbox</div></li>
					<li><div class="col-sm-12 btn btn-info btn-lg text-left" id="msent_div" onclick="updatesent()"> <span class="glyphicon glyphicon-send"></span> Sent </div></li>
					<li><div class="col-sm-12 btn btn-info btn-lg text-left" id="mtrash_div" onclick="show_delete()"><span class="glyphicon glyphicon-trash"></span> Trash</div></li>
					<li><div class="col-sm-12 btn btn-info btn-lg text-left" id="mConfig_div" onclick="show_config()"><span class="glyphicon glyphicon-cog"></span> Configuration</div>
					</li>
					<li><a onclick="logOut()">
						<span class="glyphicon glyphicon-log-out"></span> Log out
					</a></li>
				</ul>
				
				
			</div>
		</div></div>
	</nav>
	
	
	<!--**********************************-->
	
	<!--****************menu*****************-->
	<div class="col-sm-2">
		<div class="btn-group-vertical col-sm-12">
	<div class="col-sm-12 btn btn-info btn-lg text-left" id="compose_div" onclick="show_compose()"> <span class="glyphicon glyphicon-pencil"></span> Compose</div>
	<div class="col-sm-12 btn btn-info btn-lg text-left" id="inbox_div" onclick="updateinbox()"><span class="glyphicon glyphicon-inbox"></span> Inbox</div>
	<div class="col-sm-12 btn btn-info btn-lg text-left" id="sent_div" onclick="updatesent()"> <span class="glyphicon glyphicon-send"></span> Sent </div>
	<div class="col-sm-12 btn btn-info btn-lg text-left" id="trash_div" onclick="show_delete()"><span class="glyphicon glyphicon-trash"></span> Trash</div>
	<div class="col-sm-12 btn btn-info btn-lg text-left" id="Config_div" onclick="show_config()"><span class="glyphicon glyphicon-cog"></span> Configuration</div>
		</div>
	</div>
	<!--***************menu*****************-->
		<%
			
		%>
		
		<div class="col-sm-10">
			<form id="deleteElement" method="get" action = "delete.jsp"  >
				
					<div class="well well-sm">
						<div  class="btn-lg" id="back" style="display:none;cursor:pointer"><span class="glyphicon glyphicon-chevron-left"></span> Back</div>	
						<button type="submit" id="dbtn" style="background-color:transparent;border:none;"><span class="glyphicon glyphicon-trash"></span></button>
					</div>
					
				</form>
				
				<div><div class="col-sm-2"></div>
				<div id="open_mail" class="jumbotron col-sm-8">
					<b><div id='msgSub' style="float:left;font-size:22px;padding:10px">Subject: </div></b>
					<div id='msgTime' style="float:right;padding:20px"></div><br/><br/><br/><hr/>
					<b><div id='msgUser'></div></b><br/>
					<div id="msgBody"></div>
					<div id="msgAttach" class="row" style="border-top:1px dotted black">
						
					</div>
				</div>
				<div class="col-sm-2"></div></div>
				<div id="searchtable"></div>
	<table id="inbox" class="table table-hover ">
				<%
					SimpleDateFormat dateformat = new SimpleDateFormat("yyyy-MM-dd");
				%>
			
				<% 
				while(rs_inbox.next())
				{
					st = con.createStatement();
					ResultSet rs = st.executeQuery("Select Name from userauthentication where Email='"+rs_inbox.getString("Suser")+"'" );
					rs.next();
					if(rs_inbox.getInt("Unread")==1)
					{	
						out.println("<tr id='imsg"+rs_inbox.getString("id")+"'>");
							out.println("<td >");out.println("<input form='deleteElement' type='checkbox' name='delete' value='i"+rs_inbox.getString("id")+"'>");out.println("</td>");
							out.println("<td id='iu"+rs_inbox.getString("id")+"' onclick= \"showMail('i"+rs_inbox.getString("id")+"','"+rs_inbox.getString("Attachments")+"','"+rs_inbox.getString("Suser")+"')\">");
								out.println("<b>");out.println(rs.getString("Name"));out.println("</b>");
							out.println("</td>");
							out.println("<td  id='im"+rs_inbox.getString("id")+"' onclick= \"showMail('i"+rs_inbox.getString("id")+"','"+rs_inbox.getString("Attachments")+"','"+rs_inbox.getString("Suser")+"')\">");
								out.println("<div class='consise_body '><b id='is"+rs_inbox.getString("id")+"'>");out.println(rs_inbox.getString("Subject")+"-");out.println("</b>");out.println("<font id='ib"+rs_inbox.getString("id")+"' class='mail_body'>"+rs_inbox.getString("mail")+"</font>");
							out.println("</div></td>");
							if(rs_inbox.getString("Attachments").length()!=0)
							{out.println("<td id='ia"+rs_inbox.getString("id")+"'><span class='glyphicon glyphicon-paperclip '></span></td>");
							}
							else
							{
								out.println("<td id='ia"+rs_inbox.getString("id")+"'><span class='glyphicon glyphicon-paperclip clip'></span></td>");
							
							}out.println("<td  id='it"+rs_inbox.getString("id")+"'>"); 
								
								Date dates = rs_inbox.getDate("Time"); 
								Date cd  = new Date();
								String cdstr =  dateformat.format(cd);
								String dbstr = dateformat.format(dates);
								if(dbstr.equals(cdstr))
								{
									dates = rs_inbox.getTime("Time");
								}
															
							out.println("<b>");out.println(dates);out.println("</b>");
							out.println("</td>");
						out.println("</tr>");
					}
					else
					{
						out.println("<tr id='imsg"+rs_inbox.getString("id")+"'>");
							out.println("<td>");out.println("<input form='deleteElement' type='checkbox' name='delete' value='i"+rs_inbox.getString("id")+"'>");out.println("</td>");
							
							out.println("<td id='iu"+rs_inbox.getString("id")+"'  onclick= \"showMail('i"+rs_inbox.getString("id")+"','"+rs_inbox.getString("Attachments")+"','"+rs_inbox.getString("Suser")+"')\">");
								out.println(rs.getString("Name"));
							out.println("</td>");
							out.println("<td id='im"+rs_inbox.getString("id")+"' onclick= \"showMail('i"+rs_inbox.getString("id")+"','"+rs_inbox.getString("Attachments")+"','"+rs_inbox.getString("Suser")+"')\"><div class='consise_body'>");
								out.println("<font id='is"+rs_inbox.getString("id")+"'>"+rs_inbox.getString("Subject")+"</font>-");out.println("<font id='ib"+rs_inbox.getString("id")+"' class='mail_body'>"+rs_inbox.getString("mail")+"</font>");
							out.println("</div></td>");
							if(rs_inbox.getString("Attachments").length()!=0)
							{out.println("<td id='ia"+rs_inbox.getString("id")+"'><span class='glyphicon glyphicon-paperclip '></span></td>");
							}
							else
							{
								out.println("<td id='ia"+rs_inbox.getString("id")+"'><span class='glyphicon glyphicon-paperclip clip'></span></td>");
							
							}
							out.println("<td id='it"+rs_inbox.getString("id")+"'>");
								Date dates = rs_inbox.getDate("Time"); 
								Date cd  = new Date();
								String cdstr =  dateformat.format(cd);
								String dbstr = dateformat.format(dates);
								if(dbstr.equals(cdstr))
								{
									dates = rs_inbox.getTime("Time");
								}								
								out.println(dates);
								
							out.println("</td>");
						out.println("</tr>");
					}
					
				}
				%>
				
		</table>
		
		<!-- **************************delete******************-->
		<%ResultSet rs_delete = (ResultSet)request.getAttribute("delete_obj");%>
			
		<table id="delete" style="display:none" class="table table-hover">
				
				<% Statement std;
				while(rs_delete.next())
				{
					std = con.createStatement();
					ResultSet rsd = std.executeQuery("Select Name from userauthentication where Email='"+rs_delete.getString("Suser")+"'" );
					rsd.next();
					if(rs_delete.getInt("Unread")==1)
					{	out.println("<tr id='dmsg"+rs_delete.getString("id")+"'  >");
							out.println("<td>");out.println("<input type='checkbox' form='deleteElement' name='delete' value='d"+rs_delete.getString("id")+"'>");out.println("</td>");
						
							out.println("<td id='du"+rs_delete.getString("id")+"' onclick=\"showMail('d"+rs_delete.getString("id")+"','"+rs_delete.getString("Attachments")+"','"+rs_delete.getString("Suser")+"')\">");
								out.println("<b>");out.println(rsd.getString("Name"));out.println("</b>");
							out.println("</td>");
							out.println("<td id='dm"+rs_delete.getString("id")+"' onclick=\"showMail('d"+rs_delete.getString("id")+"','"+rs_delete.getString("Attachments")+"','"+rs_delete.getString("Suser")+"')\"><div class='consise_body'>");
								out.println("<b id='ds"+rs_delete.getString("id")+"'>");out.println(rs_delete.getString("Subject")+"-");out.println("</b>");out.println("<font id='db"+rs_delete.getString("id")+"' class='mail_body'>"+rs_delete.getString("mail")+"</font>");
							out.println("</div></td>");
							if(rs_delete.getString("Attachments").length()!=0)
							{	out.println("<td id='da"+rs_delete.getString("id")+"'><span class='glyphicon glyphicon-paperclip '></span></td>");
							}
							else
							{
								out.println("<td id='da"+rs_delete.getString("id")+"'><span class='glyphicon glyphicon-paperclip clip'></span></td>");
							
							}
							out.println("<td id='dt"+rs_delete.getString("id")+"'>");
								Date dates = rs_delete.getDate("Time"); 
								Date cd  = new Date();
								String cdstr =  dateformat.format(cd);
								String dbstr = dateformat.format(dates);
								if(dbstr.equals(cdstr))
								{
									dates = rs_delete.getTime("Time");
								}	
								out.println("<b>");out.println(dates);out.println("</b>");
							out.println("</td>");
						out.println("</tr>");
					}
					else
					{
						out.println("<tr id='dmsg"+rs_delete.getString("id")+"'  >");
							out.println("<td>");out.println("<input type='checkbox' form='deleteElement' name='delete' value='d"+rs_delete.getString("id")+"'>");out.println("</td>");
						
							out.println("<td id='du"+rs_delete.getString("id")+"' onclick=\"showMail('d"+rs_delete.getString("id")+"','"+rs_delete.getString("Attachments")+"','"+rs_delete.getString("Suser")+"')\">");
								out.println(rsd.getString("Name"));
							out.println("</td>");
							out.println("<td id='dm"+rs_delete.getString("id")+"'><div class='consise_body' onclick=\"showMail('d"+rs_delete.getString("id")+"','"+rs_delete.getString("Attachments")+"','"+rs_delete.getString("Suser")+"')\">");
								out.println("<font id='ds"+rs_delete.getString("id")+"'>"+rs_delete.getString("Subject")+"</font>-");out.println("<font id='db"+rs_delete.getString("id")+"' class='mail_body'>"+rs_delete.getString("mail")+"</font>");
							out.println("</div></td>");
							if(rs_delete.getString("Attachments").length()!=0)
							{	out.println("<td id='da"+rs_delete.getString("id")+"'><span class='glyphicon glyphicon-paperclip '></span></td>");
							}
							else
							{
								out.println("<td id='da"+rs_delete.getString("id")+"'><span class='glyphicon glyphicon-paperclip clip'></span></td>");
							
							}out.println("<td id='dt"+rs_delete.getString("id")+"'>");
								Date dates = rs_delete.getDate("Time"); 
								Date cd  = new Date();
								String cdstr =  dateformat.format(cd);
								String dbstr = dateformat.format(dates);
								if(dbstr.equals(cdstr))
								{
									dates = rs_delete.getTime("Time");
								}	
								out.println(dates);
								
							out.println("</td>");
						out.println("</tr>");
					}
					
				}
				%>
				
		</table>
		<!--*************************sent***********************-->
		<%
			ResultSet rs_sent = (ResultSet)request.getAttribute("sent_obj");
			
			Statement sts;
		%>
		<table id='sent' class="table table-hover" style="display:none">
				<% 
				
				while(rs_sent.next())
				{
						
					sts = con.createStatement();
					ResultSet rss = sts.executeQuery("Select Name from userauthentication where Email='"+rs_sent.getString("Ruser")+"'" );
					rss.next();
					
						out.println("<tr id='smsg"+rs_sent.getString("id")+"' >");
							out.println("<td>");out.println("<input type='checkbox' form='deleteElement' name='delete' value='s"+rs_sent.getString("id")+"'>");out.println("</td>");
							
							out.println("<td id='su"+rs_sent.getString("id")+"' onclick=\"showMail('s"+rs_sent.getString("id")+"','"+rs_sent.getString("Attachments")+"','"+rs_sent.getString("Ruser")+"')\" >");
								out.println("To: "+rss.getString("Name"));
							out.println("</td>");
							out.println("<td id='sm"+rs_sent.getString("id")+"' onclick=\"showMail('s"+rs_sent.getString("id")+"','"+rs_sent.getString("Attachments")+"','"+rs_sent.getString("Ruser")+"')\" ><div class='consise_body'>");
								out.println("<font id='ss"+rs_sent.getString("id")+"'>"+rs_sent.getString("Subject")+"</font>-");out.println("<font id='sb"+rs_sent.getString("id")+"' class='mail_body'>"+rs_sent.getString("mail")+"</font>");
							out.println("</div></td>");
							if(rs_sent.getString("Attachments").length()!=0)
							{	out.println("<td id='sa"+rs_sent.getString("id")+"'><span class='glyphicon glyphicon-paperclip'></span></td>");
							}
							else{
								out.println("<td id='sa"+rs_sent.getString("id")+"'><span class='glyphicon glyphicon-paperclip clip '></span></td>");
							
							}
							out.println("<td id='st"+rs_sent.getString("id")+"'>");
								Date dates = rs_sent.getDate("Time"); 
								Date cd  = new Date();
								String cdstr =  dateformat.format(cd);
								String dbstr = dateformat.format(dates);
								if(dbstr.equals(cdstr))
								{
									dates = rs_sent.getTime("Time");
								}	
								out.println(dates);
							out.println("</td>");
						out.println("</tr>");
					
					
				} 
				%>
			
		</table></div>
		<div id="compose" class="col-sm-5">
				<div onclick="close_compose()" ><span id="cross" class="glyphicon glyphicon-remove"></span></div>
				<div class="form-group">
					<input class="form-control" type="email" id="Ruser" placeholder="To">
				</div>
				<div class="form-group">
				<input type="text" class="form-control" id="Subject" placeholder="subject">
				</div>
				
				
				<textarea  name="Mail" id="Mail" cols="160" rows="100" style="background-color:white"></textarea>
				<div id="attachcontainer"><div id="attachfilecontainer">
					
				</div></div>
				<br/>
				<input id="rapidmail" type="radio" class="from" name="from" value="rapidmail" checked><b> Rapidmail</b><br/>
				<div id="gmail" style="display:none"><input  type="radio" class="from" name="from" value="gmail"><b> Gmail</b><br/></div><br/>
				<input id="send" type="button" class="btn btn-success" onclick="send_mail()" value="Send" >
				<form id="uploadform">
				
				<input id="upload"  type="button" class="btn btn-success" value="Send" onClick="fileUpload(this.form,'upload.jsp','upload'); return false;" >
				<label id="label1" onclick="addAttach()"  class="fileContainer">
					<span class="glyphicon glyphicon-paperclip"></span>
					<input id="filename1" name="filename" type="file" multipart/>
				</label>
				</form>
				
		</div>
		
		<div id="id01" class="modal">
  
				<form class="modal-content animate" method="POST" action="googleOAuth">
				<div class="imgcontainer">
					<span onclick="close_config()" class="close" title="Close Modal">&times;</span>
					<img src="https://storage.googleapis.com/gweb-uniblog-publish-prod/static/blog/images/google-200x200.7714256da16f.png" alt="Avatar" class="avatar">
				</div>

			<div class="formcontainer">
				<div id="oauth" class="alert alert-danger fade in" style="display:none">
					<strong>Wrong Username or Password</strong>
				</div>
				<div id="prob" class="alert alert-danger fade in" style="display:none">
					<strong>Something went wrong with server! please try again..</strong>
				</div>
				<label><b>Username</b></label>
				<input type="text" class="form-control" placeholder="Enter Username" name="uname" required><br/>

				<label><b>Password</b></label>
				<input type="password" class="form-control" placeholder="Enter Password" name="psw" required><br/>
				<input type="submit" class="btn btn-success" value="Login">
				
			</div>

			<div class="formcontainer" style="background-color:#f1f1f1">
				<button type="button" class="btn btn-danger" onclick="close_config()" class="cancelbtn">Cancel</button>
				
			</div>
			</form>
	</div>
	
<div id="sending" style="position:absolute;left:50%;background-color:#f7e52b;;padding:5px 19px 5px 21px;display:none"> sending... </div>
<div id="sent" style="position:absolute;left:50%;background-color:#f7e52b;;padding:5px 19px 5px 21px;display:none"> sent </div>
		
</div>
	<script>
		<% 
			String Errors =request.getParameter("Error");
			if(Errors!=null)
			{
				
				out.println("show_config('"+Errors+"')");
				
			}
			
		%>
		
		setInterval("updating_inbox()",1000);
		setInterval("updating_sent()",1000);
		var labelcount=1;
		var filenamecount=1;
		if(GEmail.length!=0)
		{
			document.getElementById("gmail").style.display="block";
			//fetching mails
			fetchGoogleMail();
		}
		function fetchGoogleMail()
		{
			alert('fetching mail');
		}
		function close_compose()
		{
			
			document.getElementById("compose").style.display="none";
			parent  = document.getElementById("uploadform");
			for (var i=1;i<=labelcount;i++)
			{
				child = document.getElementById("label"+i);
				parent.removeChild(child);
			}
			var label = document.createElement("label");
			label.setAttribute("onclick","addAttach()");
			label.setAttribute("class","fileContainer");
			label.setAttribute("id","label1");
			var span = document.createElement("span");
			span.setAttribute("class","glyphicon glyphicon-paperclip");
			var input =document.createElement("input");
			input.type="file";
			input.name="filename";
			input.setAttribute("id","filename1");
			label.appendChild(span);
			label.appendChild(input);
			document.getElementById("uploadform").appendChild(label);
			jQuery("input#filename1").change(function () {
					var div = document.createElement("div");
					div.setAttribute("id","attachfile1");
					div.setAttribute("class","well well-sm attachfile");
					div.innerHTML = jQuery(this).val();
					
					var crossdiv = document.createElement("div");
					crossdiv.setAttribute("id","filecross");
					crossdiv.setAttribute("onclick","deletefile('label1')");
					var cross = document.createElement("span");
					cross.setAttribute("class","glyphicon glyphicon-remove");
					crossdiv.appendChild(cross);
					div.appendChild(crossdiv);
					var main_div = document.getElementById("attachfilecontainer");
					main_div.appendChild(div);
					
					
				});
			labelcount=1;
			filenamecount=1;
			document.getElementById("attachcontainer").removeChild(document.getElementById("attachfilecontainer"));
			var div = document.createElement("div");
			div.setAttribute("id","attachfilecontainer");
			document.getElementById("attachcontainer").appendChild(div);
			
			
			
		}
		function show_compose()
		{
			document.getElementById("compose").style.display="block";
			
			$("#compose_div").css('background-color',"rgba(67, 191, 247, 0.58)");
			$("#inbox_div").css('background-color',"white");
			$("#sent_div").css('background-color',"white");
			$("#trash_div").css('background-color',"white");
			$("#Config_div").css('background-color',"white");
			
		}
		CKEDITOR.replace( 'Mail' );
		//attachments
		
		function addAttach()
		{
			labelcount = labelcount+1;
			filenamecount = filenamecount+1;
			var label = document.createElement("label");
			label.setAttribute("onclick","addAttach()");
			label.setAttribute("class","fileContainer");
			label.setAttribute("id","label"+labelcount+"");
			var span = document.createElement("span");
			span.setAttribute("class","glyphicon glyphicon-paperclip");
			var input =document.createElement("input");
			input.type="file";
			input.name="filename";
			input.setAttribute("id","filename"+filenamecount);
			label.appendChild(span);
			label.appendChild(input);
			document.getElementById("uploadform").appendChild(label);
			
			jQuery("input#filename"+filenamecount).change(function () {
					var div = document.createElement("div");
					div.setAttribute("id","attachfile"+(filenamecount-1));
					div.setAttribute("class","well well-sm attachfile");
					div.innerHTML = jQuery(this).val();
					
					var crossdiv = document.createElement("div");
					crossdiv.setAttribute("id","filecross");
					crossdiv.setAttribute("onclick","deletefile('label"+(filenamecount-1)+"')");
					var cross = document.createElement("span");
					cross.setAttribute("class","glyphicon glyphicon-remove");
					crossdiv.appendChild(cross);
					div.appendChild(crossdiv);
					var main_div = document.getElementById("attachfilecontainer");
					main_div.appendChild(div);
					if(filenamecount==4)
					{
						main_div.style.height="120px";
					}
				});
			
			
		}
		//file upload using ajax and iframe
			jQuery("input#filename1").change(function () {
					var div = document.createElement("div");
					div.setAttribute("id","attachfile1");
					
					div.setAttribute("class","well well-sm attachfile");
					div.innerHTML = jQuery(this).val();
					
					var crossdiv = document.createElement("div");
					crossdiv.setAttribute("id","filecross");
					crossdiv.setAttribute("onclick","deletefile('label1')");
					var cross = document.createElement("span");
					cross.setAttribute("class","glyphicon glyphicon-remove");
					crossdiv.appendChild(cross);
					div.appendChild(crossdiv);
					var main_div = document.getElementById("attachfilecontainer");
					main_div.appendChild(div);
					
					
				});
				
		//deleting attachments
		function deletefile(id)
		{
			parent  = document.getElementById("uploadform");
			child = document.getElementById(id);
			parent.removeChild(child);
			id=id.substr(5,id.length);
			document.getElementById("attachfile"+id).style.display="none";
		}
		function fileUpload(form, action_url, div_id) {
    // Create the iframe...
				var content;
				var iframe = document.createElement("iframe");
				iframe.setAttribute("id", "upload_iframe");
				iframe.setAttribute("name", "upload_iframe");
				iframe.setAttribute("width", "0");
				iframe.setAttribute("height", "0");
				iframe.setAttribute("border", "0");
				iframe.setAttribute("style", "width: 0; height: 0; border: none;");

    // Add to document...
				form.parentNode.appendChild(iframe);
				window.frames['upload_iframe'].name = "upload_iframe";

				iframeId = document.getElementById("upload_iframe");

    // Add event...
				var eventHandler = function () {

						if (iframeId.detachEvent) iframeId.detachEvent("onload", eventHandler);
						else iframeId.removeEventListener("load", eventHandler, false);

						// Message from server...
						if (iframeId.contentDocument) {
							content = iframeId.contentDocument.body.innerHTML;
						} else if (iframeId.contentWindow) {
							content = iframeId.contentWindow.document.body.innerHTML;
						} else if (iframeId.document) {
							content = iframeId.document.body.innerHTML;
						}

						//document.getElementById(div_id).innerHTML = content;
						//alert(content);
						// Del the iframe...
						var path = content;
						if(path =="No file uploaded")
						{
							alert("sorry! problem with attachments, Please try again.");
						}
						else{
						send_mail(path);
						}
						setTimeout('iframeId.parentNode.removeChild(iframeId)', 250);
					}

				if (iframeId.addEventListener) iframeId.addEventListener("load", eventHandler, true);
				if (iframeId.attachEvent) iframeId.attachEvent("onload", eventHandler);

    // Set properties of form...
				form.setAttribute("target", "upload_iframe");
				form.setAttribute("action", action_url);
				form.setAttribute("method", "post");
				form.setAttribute("enctype", "multipart/form-data");

				// Submit the form...
				form.submit();

    //document.getElementById(div_id).innerHTML = "Uploading...";
	

	
	//send_mail(content);
	}
		
		function none_bar(id)
		{
			document.getElementById(id).style.display="none";
		}
		function send_mail(content)
		{
			var fromid = $(".from:checked").val();
			document.getElementById("sending").style.display="block";
			if(document.getElementById("Subject").value.length==0){document.getElementById("Subject").value="(no subject)";}
			 if(document.getElementById("Ruser").value.length==0){return;}
			 $.post("compose.jsp",
				{
					Email: document.getElementById("Ruser").value,
					Subject: document.getElementById("Subject").value,
					Mail:CKEDITOR.instances.Mail.getData().substr(3,CKEDITOR.instances.Mail.getData().length),
					fromid:fromid,
					Attachment:content,
					
				},
			function(data, status)
				{
				//alert("\nStatus: " + status+" "+data);
				document.getElementById("sending").style.display="none";
				document.getElementById("sent").style.display="block";
				//setTimeout("none_bar('sent')",5000);
				});
				document.getElementById("compose").style.display="block";
				document.getElementById("uploadform").reset();
				parent  = document.getElementById("uploadform");
			for (var i=1;i<=labelcount;i++)
			{
				child = document.getElementById("label"+i);
				parent.removeChild(child);
			}
			var label = document.createElement("label");
			label.setAttribute("onclick","addAttach()");
			label.setAttribute("class","fileContainer");
			label.setAttribute("id","label1");
			var span = document.createElement("span");
			span.setAttribute("class","glyphicon glyphicon-paperclip");
			var input =document.createElement("input");
			input.type="file";
			input.name="filename";
			input.setAttribute("id","filename1");
			label.appendChild(span);
			label.appendChild(input);
			document.getElementById("uploadform").appendChild(label);
			jQuery("input#filename1").change(function () {
					var div = document.createElement("div");
					div.setAttribute("id","attachfile1");
					div.setAttribute("class","well well-sm attachfile");
					div.innerHTML = jQuery(this).val();
					
					var crossdiv = document.createElement("div");
					crossdiv.setAttribute("id","filecross");
					crossdiv.setAttribute("onclick","deletefile('label1')");
					var cross = document.createElement("span");
					cross.setAttribute("class","glyphicon glyphicon-remove");
					crossdiv.appendChild(cross);
					div.appendChild(crossdiv);
					var main_div = document.getElementById("attachfilecontainer");
					main_div.appendChild(div);
					
					
				});
			labelcount=1;
			filenamecount=1;
			document.getElementById("attachcontainer").removeChild(document.getElementById("attachfilecontainer"));
			var div = document.createElement("div");
			div.setAttribute("id","attachfilecontainer");
			document.getElementById("attachcontainer").appendChild(div);
			
		}
		function updatesent()
		{
			document.getElementById("sent").style.display="block";
			document.getElementById("inbox").style.display="none";
			document.getElementById("delete").style.display="none";
			document.getElementById("open_mail").style.display="none";
			document.getElementById("dbtn").style.display="block";
			document.getElementById("back").style.display="none";
			document.getElementById("searchtable").style.display="none";
			
			$("#compose_div").css('background-color',"white");
			$("#inbox_div").css('background-color',"white");
			$("#sent_div").css('background-color',"rgba(67, 191, 247, 0.58)");
			$("#trash_div").css('background-color',"white");
			$("#Config_div").css('background-color',"white");
			//updating_sent();
			updating_sent();
			//$("#sent").load("loaddata2.jsp");
			
		}
		
		
		function updateinbox()
		{
			document.getElementById("sent").style.display="none";
			document.getElementById("inbox").style.display="block";
			document.getElementById("delete").style.display="none";
			document.getElementById("open_mail").style.display="none";
			document.getElementById("dbtn").style.display="block";
			document.getElementById("back").style.display="none";
			document.getElementById("searchtable").style.display="none";
			$("#compose_div").css('background-color',"white");
			$("#inbox_div").css('background-color',"rgba(67, 191, 247, 0.58)");
			$("#sent_div").css('background-color',"white");
			$("#trash_div").css('background-color',"white");
			$("#Config_div").css('background-color',"white");
			updating_inbox();
		}
		<% while(rs_inbox.previous()){}%>
		<%while(rs_sent.previous()){}%>
		<%rs_inbox.next();%>
		<%rs_sent.next();%>
		var latest_id = <%if(rs_inbox.getRow()!= 0){out.print(rs_inbox.getString("id"));} else {out.print("1");}%>;
		function updating_inbox()
		{
			var i=0;
			//alert(latest_id);
			var table_content = document.getElementById("inbox").innerHTML;
			var new_data="";
			var inbox = document.getElementById("inbox");
			$.getJSON("inbox.jsp?id="+latest_id+"", function(result)
			{
				$.each(result, function(i, field)
				{
				for (i=0;i<field.length;i++)
				{	if(field[i].Unread=="1"){
						//new_data += "<tr id='imsg"+field[i].id+"'><td><input type='checkbox' name='delete' value='"+field[i].id+"'></td><td><b>"+field[i].Suser+"</b></td><td><b>"+field[i].Subject+"-"+field[i].Mail+"</b></td><td><b>"+field[i].Time+"</b></td></tr>";
						var row = inbox.insertRow(0);
						row.setAttribute("id","imsg"+field[i].id);
						
						var cell1 = row.insertCell(0);
						var cell2 = row.insertCell(1);
						cell2.setAttribute("id","iu"+field[i].id);
						cell2.setAttribute("onclick","showMail('i"+field[i].id+"','"+field[i].Attachments+"','"+field[i].Suser+"')");
						var cell3 = row.insertCell(2);
						cell3.setAttribute("id","im"+field[i].id);
						cell3.setAttribute("onclick","showMail('i"+field[i].id+"','"+field[i].Attachments+"','"+field[i].Suser+"')");
						var cell5 = row.insertCell(3);
						cell5.setAttribute("id","ia"+field[i].id);
						
						var cell4 = row.insertCell(4);
						cell4.setAttribute("id","it"+field[i].id);
						cell1.innerHTML = "<input type='checkbox' form='deleteElement' name='delete' value='i"+field[i].id+"'>";
						cell2.innerHTML ="<b>"+field[i].Name+"</b>";
						cell3.innerHTML ="<div class='consise_body'><b id='is"+field[i].id+"'>"+field[i].Subject+"</b>-<font id='ib"+field[i].id+"' class='mail_body'>"+field[i].Mail+"</font></div>";
						cell4.innerHTML ="<b>"+field[i].Time+"</b>";
						if(field[i].Attachments.length!=0)
						{cell5.innerHTML="<span class='glyphicon glyphicon-paperclip'></span>";}
						else
						{cell5.innerHTML="<span class='glyphicon glyphicon-paperclip clip'></span>";}
						}
					else{	
						//new_data += "<tr id='imsg"+field[i].id+"'><td><input type='checkbox' name='delete' value='"+field[i].id+"'></td><td>"+field[i].Suser+"</td><td>"+field[i].Subject+"-"+field[i].Mail+"</td><td>"+field[i].Time+"</td></tr>";
						var row = inbox.insertRow(0);
						row.setAttribute("id","imsg"+field[i].id);
						var cell1 = row.insertCell(0);
						var cell2 = row.insertCell(1);
						cell2.setAttribute("onclick","showMail('i"+field[i].id+"','"+field[i].Attachments+"','"+field[i].Suser+"')");
						var cell3 = row.insertCell(2);
						cell3.setAttribute("onclick","showMail('i"+field[i].id+"','"+field[i].Attachments+"','"+field[i].Suser+"')");
						var cell5 = row.insertCell(3);
						cell5.setAttribute("id","ia"+field[i].id);
						var cell4 = row.insertCell(4);
						cell1.innerHTML = "<input type='checkbox' form='deleteElement' name='delete' value='i"+field[i].id+"'>";
						cell2.innerHTML =""+field[i].Name+"";
						cell3.innerHTML ="<div class='consise_body'><font id='is"+field[i].id+"'>"+field[i].Subject+"</font>-<font id='ib"+field[i].id+"' class='mail_body'>"+field[i].Mail+"</font></div>";
						cell4.innerHTML =""+field[i].Time+"";
						if(field[i].Attachments.length!=0)
						{cell5.innerHTML="<span class='glyphicon glyphicon-paperclip'></span>";}
						else
						{cell5.innerHTML="<span class='glyphicon glyphicon-paperclip clip'></span>";}
						}
				}
				if(field.length!=0)
					latest_id = field[i-1].id;
					//document.getElementById("inbox").innerHTML=new_data+table_content;
				});
			});
			
		}
		
		
			var latest_id_sent = <%if(rs_sent.getRow()!=0){out.print(rs_sent.getString("id"));}else {out.print("1");}%>
			<%} catch(Exception e){out.println(e);}%>;
		var sent = document.getElementById("sent");
		function updating_sent()
		{
			
			var i=0;
			//alert(latest_id_sent);
			var table_content_sent = document.getElementById("sent").innerHTML;
			var new_data_sent="";
			$.getJSON("sent.jsp?id="+latest_id_sent+"", function(result)
			{
				$.each(result, function(i, field)
				{
				for (i=0;i<field.length;i++)
				{	//latest_id = latest_id+i+1;
						
					//new_data_sent += "<tr id='imsg"+field[i].id+"'><td><input type='checkbox' name='delete' value='"+field[i].id+"'></td><td>To: "+field[i].Ruser+"</td><td>"+field[i].Subject+"-"+field[i].Mail+"</td><td>"+field[i].Time+"</td></tr>";
						var row = sent.insertRow(0);
						row.setAttribute("id","smsg"+field[i].id);
						
						var cell1 = row.insertCell(0);
						var cell2 = row.insertCell(1);
						cell2.setAttribute("onclick","showMail('s"+field[i].id+"','"+field[i].Attachments+"','"+field[i].Ruser+"')");
						cell2.setAttribute("id","su"+field[i].id);
						var cell3 = row.insertCell(2);
						cell3.setAttribute("id","sm"+field[i].id);
						cell3.setAttribute("onclick","showMail('s"+field[i].id+"','"+field[i].Attachments+"','"+field[i].Ruser+"')");
						var cell5 = row.insertCell(3);
						cell5.setAttribute("id","ia"+field[i].id);
						var cell4 = row.insertCell(4);
						cell4.setAttribute("id","st"+field[i].id);
						cell1.innerHTML = "<input type='checkbox' form='deleteElement' name='delete' value='s"+field[i].id+"'>";
						cell2.innerHTML ="To: "+field[i].Name+"";
						cell3.innerHTML ="<div class='consise_body'><font id='ss"+field[i].id+"'>"+field[i].Subject+"</font>-<font id='sb"+field[i].id+"' class='mail_body'>"+field[i].Mail+"</font></div>";
						cell4.innerHTML =""+field[i].Time+"";
						if(field[i].Attachments.length!=0)
						{cell5.innerHTML="<span class='glyphicon glyphicon-paperclip'></span>";}
						else
						{cell5.innerHTML="<span class='glyphicon glyphicon-paperclip clip'></span>";}
				}
				if(field.length!=0)
					latest_id_sent = field[i-1].id;
				//document.getElementById("sent").innerHTML=new_data_sent+table_content_sent;
				});
			});
			
		}
		function show_delete()
		{
			document.getElementById("sent").style.display="none";
			document.getElementById("inbox").style.display="none";
			document.getElementById("delete").style.display="block";
			document.getElementById("open_mail").style.display="none";
			document.getElementById("dbtn").style.display="block";
			document.getElementById("back").style.display="none";
			document.getElementById("searchtable").style.display="none";
			$("#compose_div").css('background-color',"white");
			$("#inbox_div").css('background-color',"white");
			$("#sent_div").css('background-color',"white");
			$("#trash_div").css('background-color',"rgba(67, 191, 247, 0.58)");
			$("#Config_div").css('background-color',"white");
			
		}
		//alert(document.getElementById('ib64').innerHTML);
		//*******************opening mail************************
		function showMail(id,Attachments,Emailid)
		{
			document.getElementById("sent").style.display="none";
			document.getElementById("inbox").style.display="none";
			document.getElementById("delete").style.display="none";
			document.getElementById("dbtn").style.display="none";
			document.getElementById("open_mail").style.display="block";
			document.getElementById("back").style.display="inline";
			document.getElementById("searchtable").style.display="none";
			
			$.post("openmail.jsp",
				{
					id:id,
					
				},
			function(data, status)
				{
								
				//alert("\nStatus: " + status + " "+ data);
				var init = id.substr(0,1);
				document.getElementById("msgSub").innerHTML="Subject: ";
				id=	id.substr(1,id.length);
				document.getElementById("back").setAttribute("onclick","main_refresh('"+init+"')");
				document.getElementById("msgUser").innerHTML  = document.getElementById(init+"u"+id).innerHTML;
				if(init=="i")
				{
				document.getElementById("msgUser").innerHTML  = document.getElementById(init+"u"+id).innerHTML +"[" +Emailid +"]"+"<br/></b> <font style='color:#949494' class='small'>to me</font><b>";
				
				}
				else if(init=="s")
				{
					document.getElementById("msgUser").innerHTML  = document.getElementById(init+"u"+id).innerHTML+"[" +Emailid +"]"+ "<br/></b> <font style='color:#949494' class='small'>from me</font><b>";
					
				}
				else
				{
					document.getElementById("msgUser").innerHTML  = document.getElementById(init+"u"+id).innerHTML+"[" +Emailid +"]"+ "<br/></b> <font style='color:#949494' class='small'><deleted></font><b>";
				}
				document.getElementById("msgSub").innerHTML  += document.getElementById(init+"s"+id).innerHTML;
				document.getElementById("msgTime").innerHTML  = document.getElementById(init+"t"+id).innerHTML;
				document.getElementById("msgBody").innerHTML  = document.getElementById(init+"b"+id).innerHTML;
				var files = Attachments.split(";");
				for(var i=0;i<files.length-1;i++)
				{
					var open = document.createElement("a");
					open.setAttribute("href",files[i]);
					open.setAttribute("target","_Blank");
					
					var div = document.createElement("div");
					div.setAttribute("class","fileopen col-sm-3 img-thumbnail");
					div.setAttribute("style","margin-top:10px;margin-left:5px;");
					var n = files[i].lastIndexOf("/");
					div.innerHTML=files[i].substr(n+1,files[i].length);
					//files[i]  = files[i].replace(" ","%20");
					var embed = document.createElement("embed");
					embed.setAttribute("src",files[i]);
					embed.setAttribute("style","width:100%;height:160px");
					var center = document.createElement("center");
					var download = document.createElement("a");
					download.setAttribute("href",files[i]);
					download.setAttribute("class","filedownload");
					download.download=files[i];
					var span = document.createElement("span");
					span.setAttribute("class","glyphicon glyphicon-save ");
					
					download.appendChild(span);
					div.appendChild(embed);
					center.appendChild(download);
					div.appendChild(center);
					
					open.appendChild(div)
					document.getElementById("msgAttach").appendChild(open);
				}
				});
				
		}
		function main_refresh(id)
		{
			location.reload();
			
		}
		function logOut()
		{
			window.location.assign("logout.jsp");
		}
		//document.getElementById("abc").style.display="block";
		
		
//search ********************************
function search()
		{
			
			
			var new_data="";
			var searchtable = document.getElementById("searchtable");
			
			$("#searchtable").load("search.jsp?search="+document.getElementById('search').value+"");
		document.getElementById("sent").style.display="none";
			document.getElementById("inbox").style.display="none";
			document.getElementById("delete").style.display="none";
			document.getElementById("open_mail").style.display="none";
			document.getElementById("dbtn").style.display="block";
			document.getElementById("back").style.display="none";
			document.getElementById("searchtable").style.display="block";	
		}

//configuring google account
function show_config(error)
{
	$("#Config_div").css('background-color',"rgba(67, 191, 247, 0.58)");
	$("#inbox_div").css('background-color',"white");
	$("#sent_div").css('background-color',"white");
	$("#trash_div").css('background-color',"white");
	$("#compose_div").css('background-color',"white");
	document.getElementById('id01').style.display='block';
	if(error!=null)
	{
		if(error=="OAuthFailed")
		{
			document.getElementById("oauth").style.display="block";
		}
		else
		{
			//document.getElementById("prob").style.display="block";
			document.getElementById('id01').style.display='none';
			
		}
	}
	else
	{
		document.getElementById("oauth").style.display="none";
		document.getElementById("prob").style.display="none";
	}
	
}


function close_config()
{
		document.getElementById('id01').style.display='none';
}
var modal = document.getElementById('id01');

// When the user clicks anywhere outside of the modal, close it
window.onclick = function(event) {
    if (event.target == modal) {
        modal.style.display = "none";
    }
}
function update_config()
{
	
	
}

	
	</script>
	</body>
</html>
