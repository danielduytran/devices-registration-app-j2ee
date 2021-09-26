import java.io.IOException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.*;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;



@WebServlet("/SignIn")
public class SignIn extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public SignIn() {
        super();
    }

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			//Step 1: Load the JDBC driver
			Class.forName("com.mysql.jdbc.Driver");	        
		}
		catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
		
		Connection connection = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		HttpSession session = request.getSession();
		
		try {
			//Step 2: Define / establish connection
			String dbURL = "jdbc:mysql://localhost:3306/project?autoReconnect=true&useSSL=false";
			String username = "root";
			String password = "12345";
			connection = DriverManager.getConnection(dbURL, username, password);
			
			//Step 3:Query database - using Statement 
			pstmt = connection.prepareStatement("SELECT * FROM users WHERE username = ? AND password = ?");
			pstmt.setString(1, request.getParameter("username"));
			pstmt.setString(2, generateHashPassword(request.getParameter("password")));
			rs = pstmt.executeQuery();
			
			String redirectPage = "";
			String valid = "";
			if (rs.next()) {
				if (rs.getString(9).charAt(0) == 'N') {
					redirectPage = "userDashboard.jsp";
					valid = "validUser";
					
				} else {
					redirectPage = "adminDashboard.jsp";
					valid = "validAdmin";
				}
				
				session.setAttribute(valid, true);
				session.setAttribute("username", request.getParameter("username"));
				session.setAttribute("userid", rs.getInt(1));
				response.sendRedirect(redirectPage);
			} else {
				response.sendRedirect("errorInvalidSignIn.html");
			}
		}		  
		
		catch(SQLException e){
			response.sendRedirect("errorGeneral.html");
			for(Throwable t : e) 
				t.printStackTrace();
		}	
		
		//Final step: Free the resources by closing the PreparedStatement and Connection.
		finally  {      
			try {        
				if (pstmt != null) pstmt.close(); 
				if (connection != null) connection.close();
				if (rs != null) rs.close();
			} catch(SQLException ex) {          
			ex.printStackTrace();
			}
		}
	}
	
	private String generateHashPassword(String passwordToHash) {
		String generatedPassword = null;
        try {
            // Create MessageDigest instance for MD5
            MessageDigest md = MessageDigest.getInstance("MD5");
            //Add password bytes to digest
            md.update(passwordToHash.getBytes());
            //Get the hash's bytes 
            byte[] bytes = md.digest();
            //This bytes[] has bytes in decimal format;
            //Convert it to hexadecimal format
            StringBuilder sb = new StringBuilder();
            for(int i=0; i< bytes.length ;i++)
            {
                sb.append(Integer.toString((bytes[i] & 0xff) + 0x100, 16).substring(1));
            }
            //Get complete hashed password in hex format
            generatedPassword = sb.toString();
        } 
        catch (NoSuchAlgorithmException e) 
        {
            e.printStackTrace();
        }
        return generatedPassword;
	}

}
