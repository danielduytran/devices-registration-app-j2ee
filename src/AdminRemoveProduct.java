

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

@WebServlet("/AdminRemoveProduct")
public class AdminRemoveProduct extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public AdminRemoveProduct() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			Class.forName("com.mysql.jdbc.Driver");	        
		}
		catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
		
		Connection connection = null;
		PreparedStatement pstmt = null;
		
		try {
			String dbURL = "jdbc:mysql://localhost:3306/project?autoReconnect=true&useSSL=false";
			String username = "root";
			String password = "12345";
			connection = DriverManager.getConnection(dbURL, username, password);
			
			pstmt = connection.prepareStatement("DELETE FROM products WHERE productid = ?");
			
			pstmt.setString(1, request.getParameter("productid"));
			int count = pstmt.executeUpdate();
			
			if (count >= 1) {
				response.sendRedirect("adminViewProducts.jsp");
			} 
		}		  
		
		catch(SQLException e){
			response.sendRedirect("errorGeneral.html");
			for(Throwable t : e) 
				t.printStackTrace();
		}	
		
		finally  {      
			try {        
				if (pstmt != null) pstmt.close(); 
				if (connection != null) connection.close();
			} catch(SQLException ex) {          
			ex.printStackTrace();
			}
		}
	}

}
