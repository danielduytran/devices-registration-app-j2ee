

import java.io.IOException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/SignUp")
public class SignUp extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public SignUp() {
        super();
    }

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String paramPassword = request.getParameter("password");
		String generatedPassword = generateHashPassword(paramPassword);

		
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
			pstmt = connection.prepareStatement("INSERT INTO users (username, password, phone, email, firstName, "
					+ "lastName, address, isAdmin) VALUES (?, ?, ?, ?, ?, ?, ?, ?)");
			pstmt.setString(1, request.getParameter("username"));
			pstmt.setString(2, generatedPassword);
			pstmt.setString(3, request.getParameter("phone"));
			pstmt.setString(4, request.getParameter("email"));
			pstmt.setString(5, request.getParameter("firstName"));
			pstmt.setString(6, request.getParameter("lastName"));
			pstmt.setString(7, request.getParameter("address"));
			pstmt.setString(8, "N");
			int count = pstmt.executeUpdate();
			
			if (count >= 1) {
				session.setAttribute("validUser", true);
				session.setAttribute("username", request.getParameter("username")); 
				response.sendRedirect("userSignUpSuccess.jsp");
			} else {
				response.sendRedirect("errorGeneral.html");
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
