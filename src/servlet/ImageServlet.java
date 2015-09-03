package servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import objects.Captcha;


/**
 * Servlet implementation class ImageServlet
 */
@WebServlet("/captcha/*")
public class ImageServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;  
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ImageServlet() {
        super();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
            		System.out.println("doGet() of Servlet");
            		
            		//OBTAIN SESSION
            		HttpSession session=request.getSession();
            		
    				//Get the "capid" paremeter from the request
    				String capidString=request.getParameter("capid").toString();
    				System.out.println("capidString (from request):"+capidString);
    				Integer capid=Integer.parseInt(capidString);
    	
    				Captcha c=new Captcha();
            		//Integer capid=c.getRandomCaptchaID();
    				
    				//Fetch the image
                    byte[] content = c.fetchImageBytes(capid);
            		//Blob image=c.fetchImage(1);
                    
                    
                    //Write image to Response's output stream
                    response.reset();
                    response.setContentType("image/jpg");
                    response.setContentLength(content.length);
                    response.getOutputStream().write(content);
                    
                    //send capid as attribute
                    request.setAttribute("capid", capidString);
                    //request.getRequestDispatcher("createCandidateCredentials.jsp").forward(request, response);
                   
    }//doGET
    
//    @Override
//    protected void doPost(HttpServletRequest request, HttpServletResponse response){
//    	try {
//    		//Collect capid
//			String capidString=request.getParameter("capid").toString();
//			Integer capid=Integer.parseInt(capidString);
//
//			Captcha c=new Captcha();
//    		//Integer capid=c.getRandomCaptchaID();
//			
//			//Fetch the image
//            byte[] content = c.fetchImageBytes(capid);
//    		//Blob image=c.fetchImage(1);
//            
//            
//            //Response Object
//            response.reset();
//            response.setContentType("image/jpg");
//            response.setContentLength(content.length);
//            response.getOutputStream().write(content);
//            
//            //send capid as attribute
//            request.setAttribute("capid", capidString);
//            request.getRequestDispatcher("createCandidateCredentials.jsp").forward(request, response);
//		} catch (ServletException | IOException e) {
//			e.printStackTrace();
//		}
//    }

}
