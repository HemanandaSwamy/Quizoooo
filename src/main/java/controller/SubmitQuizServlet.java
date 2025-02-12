//package controller;
//
//import jakarta.ejb.EJB;
//import jakarta.servlet.ServletException;
//import jakarta.servlet.annotation.WebServlet;
//import jakarta.servlet.http.HttpServlet;
//import jakarta.servlet.http.HttpServletRequest;
//import jakarta.servlet.http.HttpServletResponse;
//import jakarta.servlet.http.HttpSession;
//
//import java.io.IOException;
//import java.util.Date;
//import java.util.List;
//
//import Model.Question;
//import Model.Quiz;
//import Model.QuizResult;
//import dao.QuizDAO;
//import dao.QuizResultDAO;
//import dao.User;
//
//@WebServlet("/SubmitQuizServlet")
//public class SubmitQuizServlet extends HttpServlet {
//    @EJB
//    private QuizDAO quizDAO;
//    @EJB
//    private QuizResultDAO quizResultDAO;
//    
//    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
//            throws ServletException, IOException {
//        HttpSession session = request.getSession();
//        User user = (User) session.getAttribute("user");
//        
//        if (user == null) {
//            response.sendRedirect("Login.jsp");
//            return;
//        }
//        
//        Long quizId = Long.parseLong(request.getParameter("quizId"));
//        Quiz quiz = quizDAO.find(quizId);
//        
//        int score = 0;
//        List<Question> questions = quiz.getQuestions();
//        
//        for (int i = 0; i < questions.size(); i++) {
//            String answer = request.getParameter("answers[" + i + "]");
//            if (answer != null && 
//                Integer.parseInt(answer) == questions.get(i).getCorrectAnswer()) {
//                score++;
//            }
//        }
//        
//        // Calculate percentage
//        int percentage = (score * 100) / questions.size();
//        
//        // Save result
//        QuizResult result = new QuizResult();
//        result.setQuiz(quiz);
//        result.setUser(user);
//        result.setScore(percentage);
//        result.setCompletionTime(new Date());
//        
//        quizResultDAO.create(result);
//        
//        // Store result in session for display
//        session.setAttribute("lastQuizResult", result);
//        response.sendRedirect("uizResult.jsp");
//    }
//}