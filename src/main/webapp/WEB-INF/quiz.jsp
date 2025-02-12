<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Quiz</title>
    <style>
        .quiz-container {
            max-width: 800px;
            margin: 0 auto;
            padding: 20px;
        }
        .question {
            margin-bottom: 20px;
            padding: 15px;
            border: 1px solid #ddd;
            border-radius: 5px;
        }
        .options {
            margin-top: 10px;
        }
        .option {
            margin: 5px 0;
        }
        .submit-btn {
            background-color: #4CAF50;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }
    </style>
</head>
<body>
    <div class="quiz-container">
        <form action="quiz" method="post">
            <input type="hidden" name="quizId" value="${param.quizId}">
            
            <c:forEach var="question" items="${questions}" varStatus="status">
                <div class="question">
                    <h3>Question ${status.count}: ${question.questionText}</h3>
                    <div class="options">
                        <c:forEach var="option" items="${question.options}">
                            <div class="option">
                                <input type="radio" 
                                       name="question_${question.questionId}" 
                                       value="${option.optionId}" 
                                       required>
                                ${option.optionText}
                            </div>
                        </c:forEach>
                    </div>
                </div>
            </c:forEach>
            
            <button type="submit" class="submit-btn">Submit Quiz</button>
        </form>
    </div>
</body>
</html>