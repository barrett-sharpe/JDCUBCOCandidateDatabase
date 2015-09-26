package servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class UploadProfileImageServlet
 */
@WebServlet("/UploadProfileImageServlet")
public class UploadProfileImageServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public UploadProfileImageServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	}
	
}//servlet

/*
Helpful links:

https://github.com/benbai123/JSP_Servlet_Practice/blob/master/Practice/Tools/FileUpload/WebContent/fileupload_progressbar.jsp
http://commons.apache.org/proper/commons-fileupload/using.html
http://stackoverflow.com/questions/2422468/how-to-upload-files-to-server-using-jsp-servlet
http://commons.apache.org/proper/commons-fileupload/download_fileupload.cgi
http://commons.apache.org/proper/commons-io/download_io.cgi


 */

