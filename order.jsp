<%@page import="java.sql.*,
 javax.sql.*,
 java.io.IOException,
 javax.servlet.http.*,
 javax.servlet.*"

 %>
<%@ page import="java.util.*" %>

<%
  Class.forName("com.mysql.jdbc.Driver").newInstance();
  Connection connection =
  DriverManager.getConnection("jdbc:mysql://localhost:3306/moviedb", "swag122b", "z0ttieth0ttie");
  String x = "no";
%>

<html>
<body>

<script language="javascript" type="text/javascript">
<!--
//Browser Support Code
function ajaxFunction(str){
	var ajaxRequest;  // The variable that makes Ajax possible!
  var sQuery = "SELECT title FROM movies WHERE ";

	try{
		// Opera 8.0+, Firefox, Safari
		ajaxRequest = new XMLHttpRequest();
	} catch (e){
		// Internet Explorer Browsers
		try{
			ajaxRequest = new ActiveXObject("Msxml2.XMLHTTP");
		} catch (e) {
			try{
				ajaxRequest = new ActiveXObject("Microsoft.XMLHTTP");
			} catch (e){
				// Something went wrong
				alert("Your browser broke!");
				return false;
			}
		}
	}

	if (str.length == 0) {
		document.getElementById("txtHint").innerHTML = "";
		return;
	} else {
		var allWords = str.trim().split(" ");

		ajaxRequest.onreadystatechange = function() {
			if (this.readyState == 4 && this.status == 200) {
        for (i = 0; i < allWords.length; i++) {
          var temp = "title LIKE ";
          temp += allWords[i]+ " ";
        }
				document.getElementById("txtHint").innerHTML = str;
				document.getElementById("length").innerHTML = allWords.length;
        document.getElementById("searchQuery").innterHTML = sQuery;
			}
		};
	}
	// Create a function that will receive data sent from the server
	// ajaxRequest.onreadystatechange = function(){
	// 	// if(ajaxRequest.readyState == 4){
	// 	// 	document.movieresult.value = "hello";
	// 	// }
	// 	document.getElementById("txtHint").innerHTML = "sup";
	// }
	ajaxRequest.open("GET", "../TomcatForm/servlet.jsp", true);
	ajaxRequest.send();
}

//-->
</script>



<form name='myForm'>
Item Name: <input type='text' onkeyup="ajaxFunction(this.value);" name='username' /> <br />
<p>Suggestions: <span id="txtHint"></span></p>
<p>String length: <span id="length"></span></p>
<p>Search query: <span id="searchQuery"></span></p>

</form>
</body>
</html>
