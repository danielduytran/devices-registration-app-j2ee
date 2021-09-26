

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/AdminClaimAction")
public class AdminClaimAction extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public AdminClaimAction() {
        super();
    }


	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			//Step 1: Load the JDBC driver
			Class.forName("com.mysql.jdbc.Driver");	        
		}
		catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
		
		Connection connection = null;
		PreparedStatement pstmt = null;
		
		try {
			//Step 2: Define / establish connection
			String dbURL = "jdbc:mysql://localhost:3306/project?autoReconnect=true&useSSL=false";
			String username = "root";
			String password = "12345";
			connection = DriverManager.getConnection(dbURL, username, password);
			
			pstmt = connection.prepareStatement("UPDATE claims SET status = ? WHERE claimid = ?");
			
			if (request.getParameter("decision").charAt(0) == 'A') {
				pstmt.setString(1, "Approved");
			} else {
				pstmt.setString(1, "Rejected");
			}
			
			pstmt.setString(2, request.getParameter("claimid"));
			pstmt.executeUpdate();		
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
			} catch(SQLException ex) {          
			ex.printStackTrace();
			}
		}
		response.sendRedirect("adminViewClaims.jsp");
	}

}
