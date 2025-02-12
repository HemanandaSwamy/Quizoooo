<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.ReviewDao, dao.ReviewDaoImpl, dao.Review, java.util.List"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>All Reviews</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
            margin: 0;
            padding: 20px;
            min-height: 100vh;
        }

        .container {
            max-width: 800px;
            margin: 30px auto;
            padding: 20px;
        }

        h2 {
            color: #2c3e50;
            text-align: center;
            margin-bottom: 30px;
            font-size: 2.5em;
            text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.1);
        }

        .review-card {
            background: white;
            border-radius: 10px;
            padding: 20px;
            margin-bottom: 20px;
            box-shadow: 0 0 20px rgba(0, 0, 0, 0.1);
            transition: transform 0.3s ease, box-shadow 0.3s ease;
            animation: fadeIn 0.5s ease;
        }

        .review-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 20px rgba(0, 0, 0, 0.15);
        }

        .username {
            color: #3498db;
            font-size: 1.2em;
            font-weight: bold;
            margin-bottom: 10px;
        }

        .message {
            color: #2c3e50;
            line-height: 1.6;
            margin-bottom: 10px;
        }

        .timestamp {
            color: #7f8c8d;
            font-size: 0.9em;
            text-align: right;
        }

        .no-reviews {
            text-align: center;
            color: #7f8c8d;
            font-style: italic;
            margin-top: 50px;
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>All Reviews</h2>
        
        <%
            ReviewDao reviewDao = new ReviewDaoImpl();
            List<Review> reviews = reviewDao.getAllReviews();
            
            if(reviews.isEmpty()) {
        %>
            <div class="no-reviews">No reviews found.</div>
        <%
            } else {
                for(Review review : reviews) {
        %>
            <div class="review-card">
                <div class="username">@<%= review.getUsername() %></div>
                <div class="message"><%= review.getMessage() %></div>
                <div class="timestamp"><%= review.getCreatedAt() %></div>
            </div>
        <%
                }
            }
        %>
    </div>
</body>
</html>