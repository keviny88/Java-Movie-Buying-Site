<DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>

<HEAD>
	<meta charset="utf-8">
  <link rel="stylesheet" href="style.css">
	<link href="https://fonts.googleapis.com/css?family=Open+Sans:300,400" rel="stylesheet">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.0/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
	<script src="jquery.js"></script>
	<TITLE>FabFlix Login</TITLE>
  <link rel=icon href="/MovieHub-logo.png">

</HEAD>

<BODY>

  <nav style="padding-top: 40px; background-color: #fcfcfc" class="navbar navbar-default">
    <div class="container">
      <div class="navbar-header">
        <button type="button" class="navbar-toggle" data-toggle="collapse"
                data-target=".navbar-ex1-collapse">
            <span class="sr-only">Toggle navigation</span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
        </button>
        <a class="navbar-brand" rel="home" href="../TomcatForm/index.jsp">
            <img style="max-width:100px; margin-top: -45px;"
                 src="MovieHub-logo.png">
        </a>
    </div>
    <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
     <ul class="nav navbar-nav">
       <li><a href="../TomcatForm/index.jsp">Home</a></li>
       <li><a href="../TomcatForm/AdvancedSearch.jsp">Advanced Search</a></li>
       <li><a href="../TomcatForm/Cart.jsp">Cart</a></li>
  <%
    if( session.getAttribute("email") == null){
  %>
    <form class="navbar-form navbar-right" ACTION="/TomcatForm/Login.jsp" METHOD="POST">
       <button type="submit" class="btn btn-default navbar-btn">Sign in</button>
     </form>
     <%
    }else{
    %>
    <form class="navbar-form navbar-right" ACTION="/TomcatForm/Logout.jsp" METHOD="POST">
       <button type="submit" class="btn btn-default navbar-btn">Sign out</button>
     </form>
    <%
    }
    %>
     </ul>
     <%
     if (session.getAttribute("name") != null) {
       out.print("<div style='text-align: right;'>Hello, "+ session.getAttribute("name") + "!</div>");
     }
      %>
       <form class="navbar-form navbar-right"
                  ACTION="/TomcatForm/MovieSearch.jsp"
                  METHOD="POST">
        <div class="form-group">
          <input type="text" name="searchObject" class="form-control" placeholder="Search">
        </div>
        <button type="submit" class="btn btn-default">Submit</button>
      </form>
    </div>
  </div>

  <%
  if(session.getAttribute("email") != null){
  %>
    <div>
    <a href ="../TomcatForm/Checkout.jsp">
      <button type="submit" style="border-color: #FFFFFF; background-color: #3e61cb" class="btn btn-default pull-right">
        <span style="color: #FFFFFF" class="glyphicon glyphicon-shopping-cart"></span> <span style="color: #FFFFFF">Checkout</span>
      </button>
    </a>
      </div>
  <%
    }
  %>


  </nav>
	<%-- <nav style="padding-top: 40px; background-color: white" class="navbar navbar-default">
	  <div class="container">
	    <div class="navbar-header">
	      <button type="button" class="navbar-toggle" data-toggle="collapse"
	              data-target=".navbar-ex1-collapse">
	          <span class="sr-only">Toggle navigation</span>
	          <span class="icon-bar"></span>
	          <span class="icon-bar"></span>
	          <span class="icon-bar"></span>
	      </button>
	      <a class="navbar-brand" rel="home" href="#">
	          <img style="max-width:100px; margin-top: -45px;"
	               src="MovieHub-logo.png">
	      </a>
	  </div>
	  <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
	   <ul class="nav navbar-nav">
	     <li><a href="../TomcatForm/index.jsp">Home</a></li>
	     <li><a href="#">Search</a></li>
	     <li><a href="#">Cart</a></li>
			 <form class="navbar-form navbar-right" ACTION="/TomcatForm/Login.jsp" METHOD="POST">
	     <button type="submit" class="btn btn-default navbar-btn">Sign in</button>
		 </form>
		 </ul>
	     <form class="navbar-form navbar-right"
	                ACTION="/TomcatForm/MovieSearch.jsp"
	                METHOD="POST">
	      <div class="form-group">
	        <input type="text" name="searchObject" class="form-control" placeholder="Search">
	      </div>
	      <button type="submit" class="btn btn-default">Submit</button>
	    </form>
	  </div>
	</div>
	</nav> --%>
</body>
