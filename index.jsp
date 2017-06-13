<DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
	<%@page import="java.sql.*,
	 javax.sql.*,
	 java.io.IOException,
	 javax.servlet.http.*,
	 java.util.*,
	 javax.servlet.*"
	%>
<HTML>

<HEAD>
	<jsp:include page="header.jsp" />
	<TITLE>FabFlix</TITLE>

	<style>
    #container {
      text-align: center;
  }

  .float {
      display:inline-block;
      text-align: center;

      width:30%;
      height:500px;
      background:#CC;
      margin:5px;
  }

  .movie-title {
    font-size: 16px;
    font-weight: 700;
  }
  </style>

</HEAD>

<BODY>
	<div style="padding-bottom: 10%">
	<div class="subtitle">Latest Movie Releases</div>
	<br>

	<%
	Class.forName("com.mysql.jdbc.Driver").newInstance();
	Connection connection =
	DriverManager.getConnection("jdbc:mysql://localhost:3306/moviedb", "swag122b", "z0ttieth0ttie");
  // String query= request.getParameter("searchObject");

	Statement select = connection.createStatement();
	ResultSet result = select.executeQuery("Select * from movies ORDER BY year DESC LIMIT 6;");
	out.print("<div class='container'>");
	while (result.next()) {
		out.print("<div class='float'>");
		String title = result.getString(2);
		int year = result.getInt(3);
		String image = result.getString(5);
		int movieId = result.getInt(1);
		%>
		  <a href=<%= "\"SingleMovie.jsp?Id=" + result.getInt(1) + "\"" %> >
		<%
		out.print("<div><img src='" + result.getString(5) +"' style='padding-bottom: 20px; width: 220px; height: 350px;'></div></center>");
		out.print("<div class='movie-title'>"); out.print(result.getString(2)); out.print(" ("); out.print(result.getString(3)); out.print(")</div>");
		// out.print("<p>"); out.println("Year = "+result.getString(3)); out.print("</p>");
		out.print("<div>"); out.println("Directed by: "+result.getString(4)); out.print("</div></a>");

		%>
		<script>
		function getMovieId(){
			return movieId;
		}
		</script>

		</form>
			<%
		out.print("</div>");

	}
	%>

	<div class="subtitle">Browse</div>
	<p></p>
	<center>
	<%
	String query= "select * from genres";
	result = select.executeQuery(query);
	out.print("<div style='padding-left: 15%; padding-right: 15%; text-align: justify'>");
	out.print("<center><h3>By Genre</h3></center>");
	while (result.next()) {
		%>
		<a href=<%= "\"MovieSearch.jsp?genre=" + result.getString(2) + "\"" %> >
		<%
			out.print(result.getString(2) + "</a>, ");
	}
	%>
</div>
<hr>
	<p></p>
	<%
	out.print("<div style='padding-left: 15%; padding-right: 15%; text-align: center'>");
	out.print("<h3>Alphabetically</h3>");
	for(char alphabet = 'A'; alphabet <= 'Z';alphabet++) {
		%>
		<a href=<%= "\"MovieSearch.jsp?firstLetter=" + alphabet + "\"" %> >
		<%
    out.print(alphabet + "</a> | ");
	}
	out.print("<h3>By Number</h3>");
	for(int i= 0; i < 10 ; i++) {
		%>
		<a href=<%= "\"MovieSearch.jsp?firstNum=" + i + "\"" %> >
		<%
    out.print(i + "</a> | ");
	}




	%>
</div>
</center>
	</div>
</div>

</BODY>

</HTML>
