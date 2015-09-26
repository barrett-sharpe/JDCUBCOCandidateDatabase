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
 * Servlet implementation class ProfileImageServlet
 */
@WebServlet("/profilePicture/*")
public class ProfileImageServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;  
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ProfileImageServlet() {
        super();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
            		
            		//OBTAIN SESSION
            		HttpSession session=request.getSession();
            		
    				//Get the "uid" parameter from the request
    				String uidString=request.getParameter("uid").toString();
    				Integer uid=Integer.parseInt(uidString);
    				//System.out.println("uidString (from request):"+uidString);
    				
    				//Fetch the image. on condition that it exists
    				DataAccessObject dao=new DataAccessObject();
    				byte[] content={};
    				if(dao.checkForProfileImage(uid)){
    					//image
    					content = dao.fetchProfileImageBytes(uid);
    				}
                    //Write image to Response's output stream
                    response.reset();
                    response.setContentType("image/jpg");
                    response.setContentLength(content.length);
                    response.getOutputStream().write(content);
                    response.getOutputStream().flush();
                    response.getOutputStream().close();
                    
    }//doGET

}//servlet
