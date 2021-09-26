

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/SignOut")
public class SignOut extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public SignOut() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		
		if (session.getAttribute("validUSer") != null) {
			session.removeAttribute("validUser");
		}
		
		if (session.getAttribute("validAdmin") != null) {
			session.removeAttribute("validAdmin");
		}
		
		if (session.getAttribute("username") != null) {
			session.removeAttribute("username");
		}
		
		if (session.getAttribute("userid") != null) {
			session.removeAttribute("userid");
		}
		
		session.invalidate();
		response.sendRedirect("userSignIn.html");
	}

}
