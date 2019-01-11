
		setInterval("updating_inbox()",1000);
		setInterval("updating_sent()",1000);
		function close_compose()
		{
			
			document.getElementById("compose").style.display="none";
			
		}
		function show_compose()
		{
			document.getElementById("compose").style.display="block";
			
			$("#compose_div").css('background-color',"rgba(67, 191, 247, 0.58)");
			$("#inbox_div").css('background-color',"white");
			$("#sent_div").css('background-color',"white");
			$("#trash_div").css('background-color',"white");
		}
		CKEDITOR.replace( 'Mail' );
		
		function send_mail()
		{
			if(document.getElementById("Subject").value.length==0){document.getElementById("Subject").value="(no subject)";}
			 if(document.getElementById("Ruser").value.length==0){return;}
			 $.post("compose.jsp",
				{
					Email: document.getElementById("Ruser").value,
					Subject: document.getElementById("Subject").value,
					Mail:CKEDITOR.instances.Mail.getData().substr(3,CKEDITOR.instances.Mail.getData().length),
					
				},
			function(data, status)
				{
				alert("\nStatus: " + status+" "+data);
				});
				document.getElementById("compose").style.display="none";
		}
		function updatesent()
		{
			document.getElementById("sent").style.display="block";
			document.getElementById("inbox").style.display="none";
			document.getElementById("delete").style.display="none";
			document.getElementById("open_mail").style.display="none";
			document.getElementById("dbtn").style.display="block";
			document.getElementById("back").style.display="none";
			$("#compose_div").css('background-color',"white");
			$("#inbox_div").css('background-color',"white");
			$("#sent_div").css('background-color',"rgba(67, 191, 247, 0.58)");
			$("#trash_div").css('background-color',"white");
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
			$("#compose_div").css('background-color',"white");
			$("#inbox_div").css('background-color',"rgba(67, 191, 247, 0.58)");
			$("#sent_div").css('background-color',"white");
			$("#trash_div").css('background-color',"white");
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
						cell2.setAttribute("onclick","showMail('i"+field[i].id+"')");
						var cell3 = row.insertCell(2);
						cell3.setAttribute("id","im"+field[i].id);
						cell3.setAttribute("onclick","showMail('i"+field[i].id+"')");
						var cell4 = row.insertCell(3);
						cell4.setAttribute("id","it"+field[i].id);
						cell1.innerHTML = "<input type='checkbox' form='deleteElement' name='delete' value='i"+field[i].id+"'>";
						cell2.innerHTML ="<b>"+field[i].Suser+"</b>";
						cell3.innerHTML ="<div class='consise_body'><b id='is"+field[i].id+"'>"+field[i].Subject+"</b>-<font id='ib"+field[i].id+"' class='mail_body'>"+field[i].Mail+"</font></div>";
						cell4.innerHTML ="<b>"+field[i].Time+"</b>";}
					else{	
						//new_data += "<tr id='imsg"+field[i].id+"'><td><input type='checkbox' name='delete' value='"+field[i].id+"'></td><td>"+field[i].Suser+"</td><td>"+field[i].Subject+"-"+field[i].Mail+"</td><td>"+field[i].Time+"</td></tr>";
						var row = inbox.insertRow(0);
						row.setAttribute("id","imsg"+field[i].id);
						var cell1 = row.insertCell(0);
						var cell2 = row.insertCell(1);
						cell2.setAttribute("onclick","showMail('i"+field[i].id+"')");
						var cell3 = row.insertCell(2);
						cell3.setAttribute("onclick","showMail('i"+field[i].id+"')");
						var cell4 = row.insertCell(3);
						cell1.innerHTML = "<input type='checkbox' form='deleteElement' name='delete' value='i"+field[i].id+"'>";
						cell2.innerHTML =""+field[i].Suser+"";
						cell3.innerHTML ="<div class='consise_body'><font id='is"+field[i].id+"'>"+field[i].Subject+"</font>-<font id='ib"+field[i].id+"' class='mail_body'>"+field[i].Mail+"</font></div>";
						cell4.innerHTML =""+field[i].Time+"";}
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
						cell2.setAttribute("onclick","showMail('s"+field[i].id+"')");
						cell2.setAttribute("id","su"+field[i].id);
						var cell3 = row.insertCell(2);
						cell3.setAttribute("id","sm"+field[i].id);
						cell3.setAttribute("onclick","showMail('s"+field[i].id+"')");
						var cell4 = row.insertCell(3);
						cell4.setAttribute("id","st"+field[i].id);
						cell1.innerHTML = "<input type='checkbox' form='deleteElement' name='delete' value='s"+field[i].id+"'>";
						cell2.innerHTML =""+field[i].Ruser+"";
						cell3.innerHTML ="<div class='consise_body'><font id='ss"+field[i].id+"'>"+field[i].Subject+"</font>-<font id='sb"+field[i].id+"' class='mail_body'>"+field[i].Mail+"</font></div>";
						cell4.innerHTML =""+field[i].Time+"";
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
			$("#compose_div").css('background-color',"white");
			$("#inbox_div").css('background-color',"white");
			$("#sent_div").css('background-color',"white");
			$("#trash_div").css('background-color',"rgba(67, 191, 247, 0.58)");
			
		}
		//alert(document.getElementById('ib64').innerHTML);
		//*******************opening mail************************
		function showMail(id)
		{
			document.getElementById("sent").style.display="none";
			document.getElementById("inbox").style.display="none";
			document.getElementById("delete").style.display="none";
			document.getElementById("dbtn").style.display="none";
			document.getElementById("open_mail").style.display="block";
			document.getElementById("back").style.display="inline";
			
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
				document.getElementById("msgUser").innerHTML  = document.getElementById(init+"u"+id).innerHTML;
				if(init=="i")
				{
					document.getElementById("msgUser").innerHTML  = document.getElementById(init+"u"+id).innerHTML + "<br/></b> <font style='color:#949494' class='small'>to me</font><b>";
				}
				else if(init=="s")
				{
					document.getElementById("msgUser").innerHTML  = document.getElementById(init+"u"+id).innerHTML+ "<br/></b> <font style='color:#949494' class='small'>from me</font><b>";
				}
				else
				{
					document.getElementById("msgUser").innerHTML  = document.getElementById(init+"u"+id).innerHTML+ "<br/></b> <font style='color:#949494' class='small'><deleted></font><b>";
				}
				document.getElementById("msgSub").innerHTML  += document.getElementById(init+"s"+id).innerHTML;
				document.getElementById("msgTime").innerHTML  = document.getElementById(init+"t"+id).innerHTML;
				document.getElementById("msgBody").innerHTML  = document.getElementById(init+"b"+id).innerHTML;
				document.getElementById("msgAttach").innerHTML  = "";
				});
				
		}
		function main_refresh()
		{
			location.reload();
		}
		function logOut()
		{
			window.location.assign("logout.jsp");
		}
		//document.getElementById("abc").style.display="block";
	