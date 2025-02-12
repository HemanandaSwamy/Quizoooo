package controller;


import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;


@WebServlet("/QuizServlet")
public class QuizServlet extends HttpServlet {
	 private static final String JDBC_URL = "jdbc:mysql://localhost:3306/quiz_db";
	    private static final String JDBC_USER = "root1";
	    private static final String JDBC_PASSWORD = "1234";
	    
	    protected void doPost(HttpServletRequest request, HttpServletResponse response)
	            throws ServletException, IOException {
	        
	        Connection conn = null;
	        try {
	            // Load MySQL JDBC Driver
	            Class.forName("com.mysql.cj.jdbc.Driver");
	            
	            // Get form data
	            String quizName = request.getParameter("quizName");
	            int questionCount = Integer.parseInt(request.getParameter("questionCount"));
	            
	            System.out.println("Attempting to connect to database...");
	            // Establish database connection
	            conn = DriverManager.getConnection(JDBC_URL, JDBC_USER, JDBC_PASSWORD);
	            System.out.println("Database connection established successfully");
	            
	            // Start transaction
	            conn.setAutoCommit(false);
	            
	            try {
	                // Insert quiz
	                String insertQuizSQL = "INSERT INTO quizzes (quiz_name) VALUES (?)";
	                System.out.println("Executing query: " + insertQuizSQL);
	                
	                PreparedStatement quizStmt = conn.prepareStatement(insertQuizSQL, 
	                                                                 Statement.RETURN_GENERATED_KEYS);
	                quizStmt.setString(1, quizName);
	                quizStmt.executeUpdate();
	                
	                // Get the generated quiz ID
	                ResultSet rs = quizStmt.getGeneratedKeys();
	                int quizId = -1;
	                if (rs.next()) {
	                    quizId = rs.getInt(1);
	                    System.out.println("Generated quiz ID: " + quizId);
	                }
	                
	                // Insert questions and options
	                for (int i = 1; i <= questionCount; i++) {
	                    // Get question data
	                    String questionText = request.getParameter("question" + i);
	                    String option1 = request.getParameter("q" + i + "option1");
	                    String option2 = request.getParameter("q" + i + "option2");
	                    String option3 = request.getParameter("q" + i + "option3");
	                    String option4 = request.getParameter("q" + i + "option4");
	                    int correctOption = Integer.parseInt(request.getParameter("correct" + i));
	                    
	                    // Insert question
	                    String insertQuestionSQL = "INSERT INTO questions (quiz_id, question_text, " +
	                        "option1, option2, option3, option4, correct_option) " +
	                        "VALUES (?, ?, ?, ?, ?, ?, ?)";
	                    PreparedStatement questionStmt = conn.prepareStatement(insertQuestionSQL);
	                    questionStmt.setInt(1, quizId);
	                    questionStmt.setString(2, questionText);
	                    questionStmt.setString(3, option1);
	                    questionStmt.setString(4, option2);
	                    questionStmt.setString(5, option3);
	                    questionStmt.setString(6, option4);
	                    questionStmt.setInt(7, correctOption);
	                    questionStmt.executeUpdate();
	                }
	                
	                // Commit transaction
	                conn.commit();
	                System.out.println("Transaction committed successfully");
	                
	                // Redirect to success page
	                response.sendRedirect("quiz-success.jsp");
	                
	            } catch (SQLException e) {
	                // Rollback transaction on error
	                if (conn != null) {
	                    conn.rollback();
	                }
	                throw e;
	            }
	        } catch (Exception e) {
	            System.err.println("Error in QuizServlet: " + e.getMessage());
	            e.printStackTrace();
	            throw new ServletException("Database error: " + e.getMessage(), e);
	        } finally {
	            try {
	                if (conn != null) {
	                    conn.close();
	                    System.out.println("Database connection closed");
	                }
	            } catch (SQLException e) {
	                System.err.println("Error closing connection: " + e.getMessage());
	            }
	        }
	    }
}
