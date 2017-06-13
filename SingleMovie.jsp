<%@page import="java.sql.*,
 javax.sql.*,
 java.io.IOException,
 javax.servlet.http.*,
 javax.servlet.*"

 %>
<%@ page import="java.util.*" %>

<html>
<head>
  <jsp:include page="header.jsp" />
  <title>Single Movie Page</title>

  <style>
    #container {
      position: relative;
      height: 100%;
      width: 100%;
  }

  .floatLeft {
    width: 300px;
    vertical-align: middle;
    display: inline-block;

    position: absolute;
    left: 20%;
    top:15%;


  }

  .floatRight {
    width: 300px;
    vertical-align: middle;
    display: inline-block;

    position: absolute;
    left: 50%;
    top: 20%;
  }

  .movie-title {
    font-size: 30px;
    font-weight: 700;
  }
  </style>



</head>


<%
  Class.forName("com.mysql.jdbc.Driver").newInstance();
  Connection connection =
  DriverManager.getConnection("jdbc:mysql://localhost:3306/moviedb", "swag122b", "z0ttieth0ttie");
  String movie_id= request.getParameter("Id");
  Statement select= connection.createStatement();


%>


<body>

  <center>
  <div id='container'>
  <%

    String query= "SELECT * FROM movies WHERE id= " + movie_id;
    ResultSet result = select.executeQuery(query);

    result.next();
    String ID = result.getString(1);
    String title= result.getString(2);
    String year= result.getString(3);
    String director= result.getString(4);
    String pic_URL= result.getString(5);
    String trailer_URL= result.getString(6);
    Map<String, String> actors= new HashMap<String, String>();
    ArrayList<String> genres= new ArrayList<String>();


    String stars_query = "SELECT * FROM stars s, stars_in_movies sim, movies m WHERE sim.star_id = s.id AND sim.movie_id = m.id AND m.id= " + movie_id + ";";

    result= select.executeQuery(stars_query);

    while (result.next())
    {
      String name= result.getString(2) + " " + result.getString(3);
      String actorId = result.getString(1);
      actors.put(actorId, name);
    }

    String genres_query= "SELECT g.name FROM genres g, genres_in_movies gin WHERE gin.genre_id= g.id AND gin.movie_id= '" + movie_id + "'";

    result= select.executeQuery(genres_query);

    while (result.next())
    {
      String genre= result.getString(1);
      genres.add(genre);
    }

    out.print("<div class='floatLeft'>");
    out.print("<div><img src='" + pic_URL +"' style='padding-bottom: 20px; width: 300px; height: 450px;'></div>");
    out.print("</div>");

    out.print("<div class='floatRight'>");
    out.print("<div class='movie-title'>"); out.print(title); out.print(" ("); out.print(year); out.print(")</div>");
    out.print("<div>"); out.println("<strong>Directed by</strong>: "+ director); out.print("</div>");
    out.print("<div>"); out.println("<strong>Movie ID</strong>: "+ ID); out.print("</div>");
    String star_list= "";

    out.print("<div> <b>Actors:</b>");
    //Formatting all of the actors into a single string
    Iterator it = actors.entrySet().iterator();
    while (it.hasNext()) {
      Map.Entry pair = (Map.Entry)it.next();
      %>
      <a href=<%= "\"SingleActor.jsp?Id=" + pair.getKey() + "\"" %> >
      <%
      out.print(pair.getValue()+ "</a>, ");

    }
    out.print("</div>");



    //Formatting all the genres into a single string

    out.print("<div> <b>Genres:</b> ");

    for (int i=0; i < genres.size(); i++)
    {
      %>
        <a href=<%= "\"MovieSearch.jsp?genre=" + genres.get(i) + "\"" %> >
      <%
          out.print(genres.get(i) + "</a>, ");
    }

    out.print("<div>");

  %>

  <div style="padding-top: 10px;">
  <form ACTION="/TomcatForm/Cart.jsp" METHOD="POST">
      <button type="submit" value = "<%=movie_id%>" name = "movieId" style="border-color: #FFFFFF; background-color: #3e61cb" class="btn btn-default btn-sm">
        <span style="color: #FFFFFF" class="glyphicon glyphicon-shopping-cart"></span> <span style="color: #FFFFFF">Add To Cart</span>
      </button>
  </form>
  <a href="<%=trailer_URL%>">
  <button type="button" style="border-color: #FFFFFF; background-color: #3e61cb" class="btn btn-default btn-sm">
        <span style="color: #FFFFFF" class="glyphicon glyphicon-play"></span> <span style="color: #FFFFFF">View Trailer</span>
      </button></a>
    </div>

  </div>



</div>
</center>
</body>
<%
  connection.close();
%>
<html>
