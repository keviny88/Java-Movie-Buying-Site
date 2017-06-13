<DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
	<%@page import="java.sql.*,
	 javax.sql.*,
	 java.io.IOException,
	 javax.servlet.http.*,
	 java.util.*,
	 javax.servlet.*"
	%>

	<%
	Class.forName("com.mysql.jdbc.Driver").newInstance();
	Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/moviedb", "swag122b", "z0ttieth0ttie");
	Statement select = connection.createStatement();
	%>

<HEAD>

	<TITLE>Cart</TITLE>
	<jsp:include page="header.jsp" />

	<style>
		#container {
			width: 100%;
	}

	.movie-name {
		font-size: 16px;
		font-weight: 700;
		padding-bottom: 10px;
	}

	.float {
      display:inline-block;
      text-align: left;

      width:20%;
      height:30%;
      margin:5px;
  }
	.float2 {
      display:inline-block;
      text-align: left;

      width:40%;
      height:30%;
      margin:5px;
  }
	</style>

</head>


<body>
    	<div class="content-body" style="padding: 7%;">
				<h2> Your items: </h2>


	<%!
	public static class movieIdCart{
		public static ArrayList cart = new ArrayList();
		public static ArrayList count = new ArrayList();

		private static String cookieId;
		public movieIdCart(String cookie){
			if( cookie != cookieId ){
				cart = new ArrayList();
				count = new ArrayList();
			}
			cookieId = cookie;
		}
		public void addToCart(String movieId){
			if(cart.contains(movieId)){
				int newCount = (Integer)count.get(cart.indexOf(movieId));
				count.set(cart.indexOf(movieId), newCount+1);
			}else{
				cart.add(movieId);
				count.add(1);
			}
		}
		public void deleteFromCart(String movieId){
			int index = cart.indexOf(movieId);
			count.remove(index);
			cart.remove(movieId);
		}
		public ArrayList getCart(){
			return cart;
		}
		public ArrayList getCount(){
			return count;
		}
	}
	%>

	<%
	movieIdCart cart = new movieIdCart(session.getId());

	if(request.getParameter("movieId") != null ){
		cart.addToCart(request.getParameter("movieId"));
	}

	if(request.getParameter("cartQuantity") != null && request.getParameter("cartQuantity") != ""){
   		int index = cart.getCart().indexOf(request.getParameter("checkId"));
   		if( index > -1){
   			cart.getCount().set(index, Integer.parseInt(request.getParameter("cartQuantity")));
   		}
   	}

   	if(request.getParameter("cartRemove") != null && request.getParameter("cartRemove") != ""){
		cart.deleteFromCart(request.getParameter("cartRemove"));	
	}

	if (cart.getCart().size() == 0) {
		out.print("<div>Your cart is empty. Start shopping!</div>");
	}
	else {
		out.print("<p> You currently have " + cart.getCart().size() + " items in cart.</p>");
		//out.print("<div"+request.getParameter("checkId")+"</div>");
	}

    for( int i =0; i < cart.getCart().size(); i++){
   		String query = String.format("SELECT * FROM movies WHERE id = \"%s\";",cart.getCart().get(i));
   		ResultSet result = select.executeQuery(query);
   		result.next();
   		String id = result.getString(1);
   		String title = result.getString(2);
   		String year = result.getString(3);
   		String director = result.getString(4);
   		String banner_url = result.getString(5);
   		String trailer_url = result.getString(6);
   		//int countIndex = (Integer)cart.getCart().indexOf(cart.getCart().get(i));

			out.print("<div class='float'>");
			out.print("<div><img src='" + banner_url +"' style='padding-bottom: 20px; width: 120px; height: 200px;'></div></div>");
			out.print("<div class='float2'><div class='movie-name'>"); out.print(title); out.print(" ("); out.print(year); out.print(")</div>");

			%>
		<div class="form-group">
		<form ACTION="/TomcatForm/Cart.jsp" METHOD="POST">

	      	<label for="cartQuantity">Quantity: (<%out.println(cart.getCount().get(i)); %>)</label>
			<div>
	      	<input style="width: 15%" type="number" min= "1" class="form-control" name="cartQuantity">
	      	<input type="hidden" value="<%=id%>" name="checkId">

			<button type="submit" value="Submit" class="btn btn-default btn-sm">Submit</button>
		</form>
		</div>

		<div class ="form-group">
		<form ACTION="/TomcatForm/Cart.jsp" METHOD="POST">
			<button type='submit' value="<%=id%>"name="cartRemove" class='btn btn-danger btn-sm'>Remove</button>			
		</form>
		</div>
		</div>
			</div>
			<p></p>

			<%
	}
	//out.println(request.getParameter(quantity));

	session.setAttribute("cart", cart.getCart());
	session.setAttribute("cartCount", cart.getCount());
	connection.close();


	if (cart.getCart().size() > 0) {
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



		</div>
</body>
</HTML>
