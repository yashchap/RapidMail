<html>
	<head>
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<script src="JS/jquery-3.1.1.min.js"></script>
		<link rel="stylesheet" type="text/css" href="CSS/bootstrap.css"/>
		<style>
			#pwd,#fpwd,#ckb,#signinbtn,#signup
			{
				display:none;
			}
			#body
			{
				background-color:rgba(67, 191, 247, 0.58);
			}
			#signIn,#forgetpass
			{
				background-color:white;
				
			
			}
			
			.jumbotron
			{
				border-radius:0px;
			}
			#fpwd{
				float:right;
				padding-top:3.5%;
				
			}
			#ckb{
				padding-left:0px;
			}
			#backcol{
				padding-left:0px;
				
			}
			
			input[type=text]:focus,input[type=email]:focus,input[type=password]:focus{
			border:0px;
			border-bottom:3px solid rgba(67, 191, 247, 0.58);
			
			background-color:transparent;
			}
			#submitcol{
				margin-right:0px;
			}
			#createAcc
			{
				float:right;
			}
			#signuprow,#signrow{
				background-color:white;
				border-radius:0px;
				box-shadow:4px 5px 20px grey;
			}
			#invalid_email,#invalid_pass,#fne,#invalid_emails,#user_exist,#pass_match,#enter_pass,#pass_change,#dob_err,#fpass_match{
				display:none;
			}
		</style>
		
		
	</head>
	<body id="body" class="container-fluid">
	<center><img src="Images/logo.png" class="img-rounded"></center>
				<div class="col-sm-4"></div><div id="pass_change" class="alert alert-success fade in col-sm-4">
					
					<strong>Password Succesfully Changed!</strong>
				</div><div class="col-sm-4"></div>
		<div id="signIn" class="jumbotron" style="background-color:rgba(67, 191, 247, 0)">
			
		<div class="row" >
		<div class="col-sm-4"></div>
		
		<div id="signrow"  class="jumbotron col-sm-4">
			
			<form action="index" method="post" onsubmit="return signin()" role="form">
				<div  id="email" class="form-group">
				<label for="email">Email address:</label>
				<input id="emailval" class="form-control" type="text" placeholder="Email" name="Email">
				</div>
				 <div id="invalid_email" class="alert alert-danger fade in">
					<a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
					<strong>Incorrect Username</strong>
				</div>
				<div id="pwd" class="form-group">
				<label for="pwd">Password:</label>
				<input id="passval" class="form-control" type="password" placeholder="Password" name="Password">
				</div>
				<div id="invalid_pass" class="alert alert-danger fade in">
					<a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
					<strong>Incorrect Password</strong>
				</div>
				<div class="checkbox col-sm-6" id="ckb"><label><input type="checkbox" name="box" value="on">Remember Me</label></div>
				<div  class="col-sm-6" id="fpwd"><a onclick="show_forgot()">Forgot Password?</a></div>
				<div class="col-sm-4"></div><input id="nextbtn" class="btn btn-info col-sm-4" type="button" value="Next" onclick="next()"><div class="col-sm-4"></div>
				<br/><br/>
				<div id="signinbtn"><div class="col-sm-6" id="backcol"><input id="backbtn" class="btn btn-info" type="button" value="Back" onclick="back()"></div>
				<div class="col-sm-6" > <input id="submitcol" class="btn btn-info " type="submit" value="Sign in"></div></div>
			</form><br/>
		<div id="createAcc" class="btn btn-success" onclick="signup_show()">Create Account</div>
		</div>
		<div class="col-sm-4"></div>
		</div>
		</div>
		
		<!-- **************sign up************************-->
		<div id="signUp" class="jumbotron" style="background-color:rgba(67, 191, 247, 0)"><div class="row" >
		<div class="col-sm-4"></div>
		<div id="signuprow" class="jumbotron col-sm-4" >
			<form onsubmit="return signup()" action="index" method="post" role="form">
				<div class="form-group">
					<label>First Name:</label>
						<input id="fn" class="form-control" type="text" placeholder="First Name" name="fn">
				</div>
				<div id="fne" class="alert alert-danger fade in">
					<a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
					<strong>Enter Name</strong>
				</div>
				<div class="form-group">
					<label>Last Name:</label>
					<input class="form-control" type="text" placeholder="Last Name" name="ln">
				</div>
				<div class="form-group">
					<label for="email">Email address:</label>
					<input id="email_val" class="form-control" type="email" placeholder="Email" name="Email">
				</div>
				<div id="invalid_emails" class="alert alert-danger fade in">
					<a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
					<strong>Incorrect Email(use @rapidmail at end)</strong>
				</div>
				<div id="user_exist" class="alert alert-danger fade in">
					<a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
					<strong>Email already exist</strong>
				</div>
				<div class="form-group">
					<label for="pwd">Password:</label>
					<input class="form-control" id="pw" type="password" placeholder="Password" name="Password">
				</div>
				<div id="enter_pass" class="alert alert-danger fade in">
					<a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
					<strong>Enter password</strong>
				</div>
				<div class="form-group">
					<label for="pwd">Confirm Password:</label>
					<input class="form-control" id="cpwd" type="password" placeholder="Confirm Password" name="CPassword">
				</div>
				<div id="pass_match" class="alert alert-danger fade in">
					<a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
					<strong>Password Not Matched</strong>
				</div>
				<div class="form-group">
					<label >Date of Birth:</label>
					<input class="form-control" id="dob" type="date" placeholder="Date" name="DOB">
				</div>
				<div class="col-sm-4" style="float:left"><input class="btn btn-info " type="button" value="Log in" onclick="backlogin()"></div>
				
				<div class="col-sm-4"  style="float:right"><input class="btn btn-info" type="submit" value="Sign up"></div>
				
			</form>
			
		</div>
		<div class="col-sm-4"></div>
		</div></div>
		
		<div id="forgetpass" class="jumbotron" style="background-color:rgba(67, 191, 247, 0);display:none">
			
		<div class="row" >
		<div class="col-sm-4"></div>
		
		<div id="forgetrow"  class="jumbotron col-sm-4" style="background-color:white" >
			
			<form onsubmit="return forgot()" action="forgot.jsp" method="post" role="form" >
				<div id="dob_err" class="alert alert-danger fade in">
					<a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
					<strong>Wrong Email or Date of Birth!</strong>
				</div>
				<div  id="email" class="form-group">
				<label for="email">Email address:</label>
				<input id="femailval" class="form-control" type="text" placeholder="Email" name="Email">
				</div>
				<div class="form-group">
					<label >Date of Birth:</label>
					<input class="form-control" id="dob" type="date" placeholder="Date" name="DOB">
				</div> 
				<div class="form-group">
					<label for="pwd">Password:</label>
					<input class="form-control" id="fpw" type="password" placeholder="Password" name="Password">
				</div>
				<div class="form-group">
					<label for="pwd">Confirm Password:</label>
					<input class="form-control" id="fcpwd" type="password" placeholder="Confirm Password" name="CPassword">
				</div>
				<div id="fpass_match" class="alert alert-danger fade in">
					<a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
					<strong>Password Not Matched</strong>
				</div>
				<div class="col-sm-3"></div><input class="btn btn-info col-sm-6" type="submit" value="Get New Password"><div class="col-sm-3"></div>
				<br/><br/><div class="col-sm-4"></div><div class="col-sm-4" style="float:left"><input class="btn btn-success " type="button" value="Log in" onclick="backlogin()"></div><div class="col-sm-4"></div>
			</form><br/>
		
		</div>
		<div class="col-sm-4"></div>
		</div>
		</div>

		
		<script>
			var email = document.getElementById("email");
			var pwd = document.getElementById("pwd");
			var ckb = document.getElementById("ckb");
			
			function next()
			{
				//TODO: varification
				if($("#emailval").val()=="")
				{
					document.getElementById("invalid_email").style.display="block";
				}
				
				else{
				var i = $("#emailval").val().indexOf("@");
				if($("#emailval").val().substr(i+1,14)=="rapidmail.com"){
				document.getElementById("nextbtn").style.display="none";
				email.style.display="none";
				pwd.style.display="block";
				document.getElementById("fpwd").style.display="block";
				ckb.style.display="block";
				document.getElementById("signinbtn").style.display="block";
				document.getElementById("createAcc").style.marginTop="27px";
				document.getElementById("invalid_email").style.display="none";
				document.getElementById("invalid_pass").style.display="none";
				}
				else
				{
					document.getElementById("invalid_email").style.display="block";
				}
				}
				
			}
			function back()
			{
				document.getElementById("nextbtn").style.display="block";
				email.style.display="block";
				pwd.style.display="none";
				document.getElementById("fpwd").style.display="none";
				ckb.style.display="none";
				document.getElementById("signinbtn").style.display="none";
			}
			function backlogin()
			{
				document.getElementById("signIn").style.display="block";
				document.getElementById("signUp").style.display="none";
				document.getElementById("forgetpass").style.display="none";
			}
			function signin()
			{
				//TODO:varification
				
				if($("#passval").val()=="")
				{
					document.getElementById("invalid_pass").style.display="block";
					return false;
				}
				else
				{
					return true;
				}
				
			}
			function signup()
			{  var i = $("#email_val").val().indexOf("@");
				
				//TODO:varification
				if($("#fn").val()=="")
				{
					document.getElementById("fne").style.display="block";
					return false;
				}
				
				else if($("#email_val").val().substr(i+1,14)!="rapidmail.com"){
					//alert($("#pw").val());
					document.getElementById("invalid_emails").style.display="block";
					return false;
					
				}
				else if($("#pw").val()=="")
				{
					document.getElementById("enter_pass").style.display="block";
					return false;
				}
				else if($("#pw").val()!=$("#cpwd").val())
				{
					document.getElementById("pass_match").style.display="block";
					return false;
					
					
				}
				else
				{
					
					document.getElementById("fne").style.display="none";
					document.getElementById("invalid_emails").style.display="none";
					document.getElementById("pass_match").style.display="none";
					document.getElementById("enter_pass").style.display="none";
					return true;
				}
		
				
				
				
			}
			function  signup_show()
			{
				document.getElementById("signUp").style.display="block";
				document.getElementById("signIn").style.display="none";
				document.getElementById("forgetpass").style.display="none";
			}
			function showError(error)
			{
					if(error=="Invalid_email")
					{
						backlogin();
						document.getElementById("invalid_email").style.display="block";
						document.getElementById("invalid_pass").style.display="none";
					}
					else if(error=="user_exist")
					{
						signup_show();
						document.getElementById("user_exist").style.display="block";
						
					}
					else if(error=="wrong_dob")
					{
						show_forgot();
						document.getElementById("dob_err").style.display="block";
						
					}
					else
					{
						
						document.getElementById("invalid_email").style.display="none";
						document.getElementById("invalid_pass").style.display="block";
					}
			}
			function show_forgot()
			{
				document.getElementById("signUp").style.display="none";
				document.getElementById("signIn").style.display="none";
				document.getElementById("forgetpass").style.display="block";
				document.getElementById("femailval").value=document.getElementById("emailval").value;
			}
			function forgot()
			{
				if($("#fpw").val()!=$("#fcpwd").val())
				{
					document.getElementById("fpass_match").style.display="block";
					return false;
					
					
				}
				else
				{
					return true;
				}
			}
			function passchange()
			{
				document.getElementById("pass_change").style.display="block";
			}
			<% 
				if (request.getParameterMap().containsKey("Error"))
				{
					out.println("showError('"+request.getParameter("Error")+"');");
				}
				if (request.getParameterMap().containsKey("done"))
				{
					out.println("passchange();");
				}
				
			%>
		
		</script>
	</body>
</html>