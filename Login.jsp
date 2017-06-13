<DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>

<HEAD>

	<script src='https://www.google.com/recaptcha/api.js'></script>

	<TITLE>FabFlix Login</TITLE>
	<jsp:include page="header.jsp" />

	<%@ page import="net.tanesha.recaptcha.ReCaptchaImpl" %>
	<%@ page import="net.tanesha.recaptcha.ReCaptchaResponse" %>

</HEAD>

<BODY>
<div class="subtitle">Your movie searching solution</div>
<br>
<%
	//request.getSession(false).invalidate();
	// out.print(session.getId());
	// out.print(session.getAttribute("email"));
	// out.print("invalid" + session.getAttribute("invalid"));
	if( session.getAttribute("invalid") == "true")
	{
		out.println("<CENTER><div style='color:red'>Invalid login information.</div></CENTER><br>");
		session.setAttribute("invalid", null);
	}
%>
<center>
<form ACTION="/TomcatForm/direct_login.jsp"
      METHOD="POST">
  <div class="form-group">
    <label for="email">Email address:</label>
    <input style="width: 25%" type="email" class="form-control" name="email">
  </div>
  <div class="form-group">
    <label for="pw">Password:</label>
    <input style="width: 25%" type="password" class="form-control" name="pw">
  </div>
  <div class="g-recaptcha" data-sitekey="6Lc0YCEUAAAAALh7SHg8BTg87QD3je3sf3k7q7G8"></div>
  <button type="submit" value="Submit" class="btn btn-default">Submit</button>
</form>
</center>

<%-- <FORM ACTION="/TomcatForm/direct_login.jsp"
      METHOD="POST">
  <CENTER>
	<div class="enterform">   Email:<INPUT TYPE="TEXT" NAME="email"><BR></div>
		<br>
	<div class="enterform">Password:<INPUT TYPE="PASSWORD" NAME="pw"><BR></div>
	<br>
    <INPUT class="button" style="top: 205px; position: relative;" TYPE="SUBMIT" VALUE="Submit">
  </CENTER>
</FORM> --%>

</BODY>
</HTML>
