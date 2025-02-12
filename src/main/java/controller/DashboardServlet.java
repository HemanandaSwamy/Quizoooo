package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;
import dao.UserDao;
import dao.UserDaoImpl;
import Model.Quiz;
import Model.QuizResult;
import dao.QuizDAO;
import dao.QuizResultDAO;
import dao.User;

@WebServlet("/DashboardServlet")
public class DashboardServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        String username = (String) session.getAttribute("username");

        if (username == null) {
            response.sendRedirect("Login.jsp");
            return;
        }

        UserDao userDao = new UserDaoImpl();
        QuizDAO quizDao = new QuizDAO();
        QuizResultDAO resultDao = new QuizResultDAO();

        try {
            User user = userDao.getUserByUsername(username);
            
            // Fetch quizzes created by the current user
            List<Quiz> createdQuizzes = quizDao.findByCreator(user);
            
            // Fetch recent quiz results for the current user (limit to 5 results)
            List<QuizResult> recentResults = resultDao.getRecentResults(user, 5);
            
            request.setAttribute("user", user);
            request.setAttribute("createdQuizzes", createdQuizzes);
            request.setAttribute("recentResults", recentResults);

            request.getRequestDispatcher("dashboard.jsp").forward(request, response);
        } catch (Exception e) {
            throw new ServletException("Error loading dashboard", e);
        }
    }
}
