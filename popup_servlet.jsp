<%@page import="java.sql.*,
 javax.sql.*,
 java.io.IOException,
 javax.servlet.http.*,
 javax.servlet.*"

 %>
<%@ page import="java.util.*" %>

<%
Class.forName("com.mysql.jdbc.Driver").newInstance();
Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/moviedb", "swag122b", "z0ttieth0ttie");
Statement select= connection.createStatement();

String movie_id = request.getParameter("id");
//String movie_id = "905";
String query = "SELECT * FROM movies where id="+movie_id;
ResultSet result = select.executeQuery(query);

result.next();
String title = result.getString(2);
String year= result.getString(3);
String image = result.getString(5);
out.print("<h4>"+title+"</h4>");
out.print("<div>Year: " + year + "</div>");
out.print("<img src='"+image+"' style='float:left; width: 200px; height: 300px;padding:15px'>");

String stars_query = "SELECT * FROM stars s, stars_in_movies sim, movies m WHERE sim.star_id = s.id AND sim.movie_id = m.id AND m.id= " + movie_id + ";";
result = select.executeQuery(stars_query);
while (result.next()) {
  %>
  <a href=<%= "\"SingleActor.jsp?Id=" + result.getString(1) + "\"" %> >
  <%
  out.print(result.getString(2) + " " + result.getString(3)+ "</a>, ");
}
%>
<div style="padding-top: 10px;">
  <form ACTION="/TomcatForm/Cart.jsp" METHOD="POST">
      <button type="submit" value = "<%=movie_id%>" name = "movieId" style="border-color: #FFFFFF; background-color: #3e61cb" class="btn btn-default btn-sm">
        <span style="color: #FFFFFF"></span> <span style="color: #FFFFFF">Add To Cart</span>
      </button>
  </form></div>
