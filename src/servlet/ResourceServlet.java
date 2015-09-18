package servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import objects.Captcha;
import objects.DataAccessObject;

/**
 * Servlet implementation class ResourceServlet
 */
@WebServlet("/resource/*")
public class ResourceServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ResourceServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		
		//OBTAIN SESSION
		HttpSession session=request.getSession();
		
		//Get the "rid" paremeter from the request
		String ridString=request.getParameter("rid").toString();
		Integer rid=Integer.parseInt(ridString);
		//System.out.println("ridString (from request):"+ridString);//TEST
		
		//Fetch the image
		DataAccessObject dao=new DataAccessObject();
        byte[] content = dao.fetchResourceImageBytes(rid);        
//        //TEST NULL
//        System.out.print("Rid:"+rid+" ");
//        if(content==null){
//        	System.out.println("| content null");
//        }else{
//        	System.out.println("| Size:"+content.length);
//        }
        
        //Write image to Response's output stream
        response.reset();
        response.setContentType("image/jpg");
        response.setContentLength(content.length);
        response.getOutputStream().write(content);
        response.getOutputStream().flush();
        response.getOutputStream().close();
        
 		//Close dao
        dao.closeConnection();
		
	}//DOGET

}//SERVLET
