<%@page import="java.sql.*,
 javax.sql.*,
 java.io.IOException,
 javax.servlet.http.*,
 javax.servlet.*"

 %>
<%@ page import="java.util.*,
  java.io.PrintWriter,
  java.io.FileWriter"
  %>


<head>

  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
  <jsp:include page="header.jsp" />

  <title>Movie Search</title>


  <style>

  .popbox {
    display: none;
    position: absolute;
    z-index: 99999;
    width: 400px;
    padding: 10px;
    background: #EEEFEB;
    color: #000000;
    border: 1px solid #4D4F53;
    margin: 0px;
    -webkit-box-shadow: 0px 0px 5px 0px rgba(164, 164, 164, 1);
    box-shadow: 0px 0px 5px 0px rgba(164, 164, 164, 1);
  }
  .popbox h2 {
    background-color: #4D4F53;
    color: #E3E5DD;
    font-size: 14px;
    display: block;
    width: 100%;
    margin: -10px 0px 8px -10px;
    padding: 5px 10px;
  }

    #container {
      text-align: center;
  }

  .float {
      display:inline-block;
      text-align: left;

      width:100%;
      height:350px;
      margin:5px;
      padding-left: 10%;
  }

  .movie-title {
    font-size: 16px;
    font-weight: 700;
  }
  </style>

</head>

<%

  long startTime1 = System.nanoTime();
  Class.forName("com.mysql.jdbc.Driver").newInstance();
  Connection connection =
  DriverManager.getConnection("jdbc:mysql://localhost:3306/moviedb", "swag122b", "z0ttieth0ttie");
  Connection connection2 =
  DriverManager.getConnection("jdbc:mysql://localhost:3306/moviedb", "swag122b", "z0ttieth0ttie");
  String final_query= "FROM movies m WHERE ";
  String title = request.getParameter("searchObject");
  Integer c= 0;
  //CREATING SEARCH QUERY


  String title_param= request.getParameter("searchObject");


  String year_param= request.getParameter("year");
  String director_param= request.getParameter("director");
  String first_param= request.getParameter("firstName");
  String last_param= request.getParameter("lastName");

  String letter_param= request.getParameter("firstLetter");
  String genre_param= request.getParameter("genre");
  String sort_param= request.getParameter("sort");
  String firstNum_param= request.getParameter("firstNum");

  String pageNumber = request.getParameter("pageNum");
  String amt = request.getParameter("amt");
  String offset = "0";

  ArrayList<String> query_list = new ArrayList<String>();
  ArrayList<String> time_list = new ArrayList<String>();


  //String genre_param= request.getParameter("genre");

  if ((title_param != null) && !(title_param.equals("null")))
  {
    if(c > 0)final_query += " AND "; c+= 1;
    //final_query += "m.title LIKE '%" + title_param + "%'";
    final_query += "m.title LIKE ? ";
    query_list.add("%" + title_param + "%");
  }
  //Year
  if ((year_param != "") && (year_param != null) && !(year_param.equals("null")))
  {
    if(c > 0) final_query += " AND "; c+=1;
    //final_query += "m.year = " + year_param;
    final_query += "m.year = ?";
    query_list.add(year_param);
  }
  //Director
  if ((director_param != "") && (director_param != null) && !(director_param.equals("null")))
  {
    if(c > 0) final_query += " AND "; c+=1;
    //final_query += "m.director = '" + director_param + "'";
    final_query += "m.director = ?";
    query_list.add(director_param);
  }
  //first_name or last_name
  if (    (( first_param != "") || (last_param != "")) && ((first_param != null) || last_param != null) && ( !(first_param.equals("null")) || !(last_param.equals("null"))))
  {
    if(c > 0) final_query += " AND "; c+=1;
    final_query += "m.id IN (SELECT m2.id FROM movies m2, stars s, stars_in_movies sim WHERE sim.star_id= s.id AND sim.movie_id = m2.id ";
    if ( (first_param != "") && (first_param != null) && !(first_param.equals("null")))
    {
        //final_query += "AND s.first_name= '" + first_param + "' ";
      final_query += "AND s.first_name= ?";
      query_list.add(first_param);
    }

    if ((last_param != "") && (last_param != null) && !(last_param.equals("null")))
    {
      //final_query += "AND s.last_name= '" + last_param + "'";
      final_query += "AND s.last_name= ?";
      query_list.add(last_param);
    }
    final_query += ")";
  }

  //genre
  if ((genre_param != "") && (genre_param != null) && !(genre_param.equals("null")))
  {
    if ((title_param != null) && !(title_param.equals("null")))
      final_query += " AND ";
    final_query += "m.id IN (SELECT m3.id FROM movies m3, genres g, genres_in_movies gim WHERE gim.genre_id = g.id AND gim.movie_id = m3.id AND g.name= ? )";
    query_list.add(genre_param);
  }
  // //by first letter
  if ((letter_param != "") && (letter_param != null) && !(letter_param.equals("null")))
  {
    if ((title_param != null) && !(title_param.equals("null")))
      final_query += " AND ";
    final_query += " m.title LIKE ?";
    query_list.add(letter_param + "%");
  }

  if ((firstNum_param != "") && (firstNum_param != null) && !(firstNum_param.equals("null")))
  {
    if ((title_param != null) && !(title_param.equals("null")))
      final_query += " AND ";
    final_query += " m.title LIKE ?";
    query_list.add(firstNum_param + "%");
  }




  String dropdown_title = "Sort Options";

  //by sorting
  if ((sort_param != "") && (sort_param != null) && !(sort_param.equals("null")))
  {
    if (sort_param.equals("tascend"))
      {final_query += " ORDER BY m.title ASC"; dropdown_title="Title Ascending";}
    if (sort_param.equals("tdescend"))
      {final_query += " ORDER BY m.title DESC"; dropdown_title="Title Descending";}
    if (sort_param.equals("yascend"))
      {final_query += " ORDER BY m.year ASC"; dropdown_title="Year Ascending";}
    if (sort_param.equals("ydescend"))
      {final_query += " ORDER BY m.year DESC"; dropdown_title="Year Descending";}
  }
  if ((amt == "") || (amt == null) || (amt.equals("null")))
  {
    amt = "6";
  }
  int int_amt = Integer.parseInt(amt);

  if ((pageNumber == "") || (pageNumber == null) || (pageNumber.equals("null")) || pageNumber.equals("1"))
  {
    pageNumber = "1";
  }
  else {
    int t = ((Integer.parseInt(pageNumber)-1) * int_amt );
    offset = Integer.toString(t);
  }



  int count = 0;
  if ((Integer)session.getAttribute("countNum")!= null) {
    count = (Integer)session.getAttribute("countNum");
  }
  if (request.getParameter("searchObject")==null) {
    title = (String)session.getAttribute("searchObject");
    count = 0;
  }



  //if ((String)session.getAttribute("count")) {
   //  count = Integer.parseInt((String)session.getAttribute("count"));
   //}
  //Statement select= connection.createStatement();
  Statement select2= connection2.createStatement();

%>

<script>

//Browser Support Code

$(function() {

var moveLeft = 0;
var moveDown = 0;
$('a.popper').hover(function (e) {

    ajaxFunction($(this).attr('movie_id'));
    var target = '#' + ($(this).attr('data-popbox'));
    $(target).show();
    moveLeft = $(this).outerWidth();
    moveDown = ($(target).outerHeight() / 2);


    leftD = e.pageX + parseInt(moveLeft);
    maxRight = leftD + $(target).outerWidth();
    windowLeft = $(window).width() - 40;
    windowRight = 0;
    maxLeft = e.pageX - (parseInt(moveLeft) + $(target).outerWidth() + 20);

    if (maxRight > windowLeft && maxLeft > windowRight) {
        leftD = maxLeft;
    }

    topD = e.pageY - parseInt(moveDown);
    maxBottom = parseInt(e.pageY + parseInt(moveDown) + 20);
    windowBottom = parseInt(parseInt($(document).scrollTop()) + parseInt($(window).height()));
    maxTop = topD;
    windowTop = parseInt($(document).scrollTop());
    if (maxBottom > windowBottom) {
        topD = windowBottom - $(target).outerHeight() - 20;
    } else if (maxTop < windowTop) {
        topD = windowTop + 20;
    }

    $(target).css('top', topD).css('left', leftD);



}, function () {
    var target = '#' + ($(this).attr('data-popbox'));
    if (!($("a.popper").hasClass("show"))) {
        $(target).fadeOut(1000);
    }
});

function ajaxFunction(x){
  var ajaxRequest;  // The variable that makes Ajax possible!
  var url= "../TomcatForm/popup_servlet.jsp?id=" + x;
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
  // Create a function that will receive data sent from the server
  ajaxRequest.onreadystatechange = function(){

    if(ajaxRequest.readyState == 4){
      var val= ajaxRequest.responseText;

      document.getElementById('pop1').innerHTML= val;
    }
  }
  ajaxRequest.open("GET", url, true);
  ajaxRequest.send();

}


 } );




</script>





<body>

  <%
    PreparedStatement select;
    String query1= "SELECT COUNT(*) " + final_query;

    select = connection.prepareStatement(query1);

    //Filling the prepared statement
    for (int i=0; i < query_list.size(); i++)
    {
      select.setString(i+1, query_list.get(i));
    }
    long startTime = System.nanoTime();
    ResultSet result1 = select.executeQuery();
    long endTime = System.nanoTime();
    long elapsedTime = endTime - startTime;
    String beep = " | TJ: "+ Long.toString(elapsedTime);
    time_list.add(beep);



    result1.next();
    int size = result1.getInt(1);

    String query = "SELECT *" + final_query + " LIMIT " + amt + " OFFSET " + offset + ";";
    out.print("<div>"+query+"</div>");

    select= connection.prepareStatement(query);

    //Filling the prepared statement
    for (int i=0; i < query_list.size(); i++)
    {
      select.setString(i+1, query_list.get(i));
    }
    startTime = System.nanoTime();
    ResultSet result = select.executeQuery();
    endTime = System.nanoTime();
    elapsedTime = endTime - startTime;
    beep = " | TJ: "+ Long.toString(elapsedTime);
    time_list.add(beep);
    %>
  <div class='container'>
    <div class="content-body" style="padding: 7%;">

      <div class="dropdown pull-right" style="padding: 2px">
        <button class="btn btn-primary dropdown-toggle" type="button" data-toggle="dropdown"><% out.print(dropdown_title); %>
          <span class="caret"></span></button>
            <ul class="dropdown-menu">
              <li><a href=<%= "\"MovieSearch.jsp?searchObject=" + title_param + "&year="+year_param+"&firstName="+first_param+"&lastName="+last_param+"&firstLetter="+letter_param+"&firstNum="+firstNum_param+"&genre="+genre_param+"&amt="+amt+"&pageNum="+pageNumber+"&sort=tascend\"" %> >Title Ascending</a></li>
              <li><a href=<%= "\"MovieSearch.jsp?searchObject=" + title_param + "&year="+year_param+"&firstName="+first_param+"&lastName="+last_param+"&firstLetter="+letter_param+"&firstNum="+firstNum_param+"&genre="+genre_param+"&amt="+amt+"&sort=tdescend\"" %> >Title Descending</a></li>
              <li><a href=<%= "\"MovieSearch.jsp?searchObject=" + title_param + "&year="+year_param+"&firstName="+first_param+"&lastName="+last_param+"&firstLetter="+letter_param+"&firstNum="+firstNum_param+"&genre="+genre_param+"&amt="+amt+"&sort=yascend\"" %> >Year Ascending</a></li>
              <li><a href=<%= "\"MovieSearch.jsp?searchObject=" + title_param + "&year="+year_param+"&firstName="+first_param+"&lastName="+last_param+"&firstLetter="+letter_param+"&firstNum="+firstNum_param+"&genre="+genre_param+"&amt="+amt+"&sort=ydescend\"" %> >Year Descending</a></li>
            </ul>
          </div>

          <div class="dropdown pull-right">
            <button class="btn btn-primary dropdown-toggle" type="button" data-toggle="dropdown"><% out.print("Display Amount"); %>
              <span class="caret"></span></button>
                <ul class="dropdown-menu">
                  <li><a href=<%= "\"MovieSearch.jsp?searchObject=" + title_param + "&year="+year_param+"&firstName="+first_param+"&lastName="+last_param+"&firstLetter="+letter_param+"&firstNum="+firstNum_param+"&genre="+genre_param+"&sort="+sort_param+"&pageNum="+pageNumber+"&amt=6\"" %> >6</a></li>
                  <li><a href=<%= "\"MovieSearch.jsp?searchObject=" + title_param + "&year="+year_param+"&firstName="+first_param+"&lastName="+last_param+"&firstLetter="+letter_param+"&firstNum="+firstNum_param+"&genre="+genre_param+"&sort="+sort_param+"&amt=10\"" %> >10</a></li>
                  <li><a href=<%= "\"MovieSearch.jsp?searchObject=" + title_param + "&year="+year_param+"&firstName="+first_param+"&lastName="+last_param+"&firstLetter="+letter_param+"&firstNum="+firstNum_param+"&genre="+genre_param+"&sort="+sort_param+"&amt=20\"" %> >20</a></li>
                </ul>
              </div>


      <h1>MovieHub Search</h1>
      <h4 style="padding-bottom: 20px;">
        Search results:
      </h4>

  <%



    while (result.next()){
      String movie_id = result.getString(1);
      String pic_URL= result.getString(5);
      String movie_title= result.getString(2);
      String year= result.getString(3);
      String director= result.getString(4);
      Map<String, String> actors= new HashMap<String, String>();
      ArrayList<String> genres= new ArrayList<String>();

      String stars_query = "SELECT * FROM stars s, stars_in_movies sim, movies m WHERE sim.star_id = s.id AND sim.movie_id = m.id AND m.id= " + movie_id + ";";

      startTime = System.nanoTime();
      ResultSet result2= select2.executeQuery(stars_query);
      endTime = System.nanoTime();
      elapsedTime = endTime - startTime;
      beep = " | TJ: "+ Long.toString(elapsedTime);
      time_list.add(beep);


      while (result2.next())
      {
        String name= result2.getString(2) + " " + result2.getString(3);
        String actorId = result2.getString(1);
        actors.put(actorId, name);
      }

      String genres_query= "SELECT g.name FROM genres g, genres_in_movies gin WHERE gin.genre_id= g.id AND gin.movie_id= '" + movie_id + "'";
      result2.next();

      startTime = System.nanoTime();
      result2 = select2.executeQuery(genres_query);
      endTime = System.nanoTime();
      elapsedTime = endTime - startTime;
      beep = " | TJ: "+ Long.toString(elapsedTime);
      time_list.add(beep);

      while (result2.next())
      {
        String genre= result2.getString(1);
        genres.add(genre);
      }


      out.print("<div class='float'><p>");
      %>




      <a movie_id= <% out.print(movie_id); %> class= "popper" data-popbox= "pop1" href=<%= "\"SingleMovie.jsp?Id=" + movie_id + "\"" %> >


      <div id="pop1" class="popbox">
      </div>









      <%
      out.print("<img src='" + pic_URL +"' style='float:left; width: 200px; height: 300px;'>");
      out.print("<div style='padding-left: 30%'>");
      out.print("<div class='movie-title'>"); out.print(movie_title); out.print(" ("); out.print(year); out.print(")</a></div>");
      out.print("<div><strong>"); out.println("Directed by: </strong>"+ director); out.print("</div>");
      out.print("<div>"); out.println("<strong>Movie ID</strong>: "+ movie_id); out.print("</div>");

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

    out.print("</div>");

    %>
  		<div style="padding-top: 10px;">
        <form ACTION="/TomcatForm/Cart.jsp" METHOD="POST">
            <button type="submit" value = "<%=movie_id%>" name = "movieId" style="border-color: #FFFFFF; background-color: #3e61cb" class="btn btn-default btn-sm">
              <span style="color: #FFFFFF" class="glyphicon glyphicon-shopping-cart"></span> <span style="color: #FFFFFF">Add To Cart</span>
            </button>
        </form></div>
  			<%
      out.print("</p></div></div><hr>");
    }
    out.println("</div>");
    int current_items = Integer.parseInt(pageNumber) * int_amt;
    if (size < int_amt) {
      current_items = size;
    }
  %>
  <div style='text-align:right'> Displaying <% out.print(current_items); %> out of <% out.print(size); %> results</div>
  <center>

    <nav aria-label="...">
  <ul class="pagination">
    <%
    int size2 = size;
    int counter = 1;
    while(size2 >= 0) {
      String x = Integer.toString(counter);
      if (x.equals(pageNumber)) {
        out.print("<li class='active'>");
      }
      else {
        out.print("<li class='inactive'>");
      }
    %>
        <a href=<%= "\"MovieSearch.jsp?searchObject=" + title_param + "&year="+year_param+"&firstName="+first_param+"&lastName="+last_param+"&firstLetter="+letter_param+"&genre="+genre_param+"&pageNum="+counter+"&firstNum="+firstNum_param+"&amt="+amt+"\"" %> >
        <span><%out.print(counter);%> <span class="sr-only"></span></span></a>
      </li>
    <%


    counter++;
    size2 = size2 - int_amt;
    }
    int newcount = count++;
    session.setAttribute("countNum", newcount);
    %>
    <%-- <li class="active">
      <span>1 <span class="sr-only">(current)</span></span>
    </li>
    <li class="inactive">
      <span>2 <span class="sr-only"></span></span>
    </li> --%>

  </ul>
</nav>
  </center>
  </div>

  </body>


<%
  long endTime1 = System.nanoTime();
  long openToClose = endTime1 - startTime1;
  connection.close();
  connection2.close();
  try {
    FileWriter writer = new FileWriter("/home/ubuntu/tomcat/webapps/TomcatForm/logs/log.txt");
    // writer.write("sup pussies");
    for (int i = 0; i < time_list.size(); i++) {
      writer.write("TS: "+ Long.toString(openToClose) + time_list.get(i)+"\n");
    }
    writer.write("----------------------------------");
    writer.close();
  } catch(Exception e) {
    out.print("<div> something went wrong </div>");
  }

%>
</html>
