<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        /* Basic styling for header */
        .navbar {
            display: flex;
            align-items: center;
            justify-content: space-between;
            background-color: #007bff;
            padding: 15px;
            color: white;
        }
        
        .navbar .brand {
            font-size: 1.5em;
            font-weight: bold;
        }
        
        .navbar .nav-links {
            display: flex;
            gap: 20px;
        }
        
        .navbar a {
            color: white;
            text-decoration: none;
            font-size: 1em;
            display: flex;
            align-items: center;
            gap: 5px;
        }
        
        .navbar a:hover {
            text-decoration: underline;
        }
        
        .navbar .user-actions {
            display: flex;
            align-items: center;
            gap: 15px;
        }
        
        .navbar .user-actions span {
            font-size: 0.9em;
        }
    </style>
</head>
<body>
    <div class="navbar">
        <!-- Brand Name or Logo -->
        <div class="brand">
            <a href="dashboard.jsp" style="color: white; text-decoration: none;">
                Quizooo
            </a>
        </div>
        
        <!-- Navigation Links -->
        <div class="nav-links">
            <a href="dashboard.jsp"><i class="fas fa-home"></i> Dashboard</a>
            <a href="CreateQuiz.jsp"><i class="fas fa-plus-circle"></i> Create Quiz</a>
            <a href="viewQuizzes.jsp"><i class="fas fa-list"></i> My Quizzes</a>
        </div>
        
        <!-- User Actions (e.g., Username and Logout) -->
        <div class="user-actions">
            <%-- Display username if available in session --%>
            <span>Welcome, <%= (String) session.getAttribute("username") %>!</span>
            <a href="logout.jsp"><i class="fas fa-sign-out-alt"></i> Logout</a>
        </div>
    </div>
</body>
</html>
