import java.io.*;
import java.util.Calendar;
import javax.servlet.*;
import javax.servlet.http.*;

public class AjaxTest extends HttpServlet {

  public void doGet(HttpServletRequest req, HttpServletResponse res)
                               throws ServletException, IOException {

	Calendar c = Calendar.getInstance ();


    res.setContentType("text/html");

    PrintWriter out = res.getWriter();
    out.println(c.get(Calendar.HOUR) + ":" + c.get(Calendar.MINUTE) + ":" + c.get(Calendar.SECOND));

    //out.println("Hello World" + Calendar.getInstance().get(Calendar.SECOND));
  }
}
