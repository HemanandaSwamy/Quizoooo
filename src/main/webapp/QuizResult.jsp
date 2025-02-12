<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quiz Results - Quizooo</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="css/dashboard.css">
    <style>
        .result-container {
            max-width: 800px;
            margin: 0 auto;
            padding: 20px;
            text-align: center;
        }
        
        .score-circle {
            width: 200px;
            height: 200px;
            border-radius: 50%;
            border: 10px solid #4CAF50;
            margin: 20px auto;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 3em;
            color: #4CAF50;
        }
        
        .result-details {
            background: white;
            border-radius: 8px;
            padding: 20px;
            margin-top: 20px;
            text-align: left;
        }
        
        .correct-answer {
            color: #4CAF50;
        }
        
        .wrong-answer {
            color: #f44336;
        }
        
        .action-buttons {
            margin-top: 30px;
        }
        
        .action-btn {
            display: inline-block;
            padding: 10px 20px;
            margin: 0 10px;
            border-radius: 4px;
            text-decoration: none;
            color: white;
        }
        
        .retry-btn {
            background: #2196F3;
        }
        
        .home-btn {
            background: #4CAF50;
        }
    </style>
</head>
<body>
    <main class="result-container">
        <h1>Quiz Results</h1>
        
        <div class="score-circle">
            ${score}%
        </div>
        
        <div class="result-details">
            <h2>Summary</h2>
            <p>Time Taken: ${timeSpent} minutes</p>
            <p>Correct Answers: ${correctAnswers} out of ${totalQuestions}</p>
            
            <h2>Question Review</h2>
            <c:forEach var="question" items="${questions}" varStatus="status">
                <div class="question-review">
                    <h3>Question ${status.index + 1}</h3>
                    <p>${question.text}</p>
                    <p class="${question.correct ? 'correct-answer' : 'wrong-answer'}">
                        Your Answer: ${question.userAnswer}
                    </p>
                    <c:if test="${!question.correct}">
                        <p class="correct-answer">
                            Correct Answer: ${question.correctAnswer}
                        </p>
                    </c:if>
                </div>
            </c:forEach>
        </div>
        
        <div class="action-buttons">
            <a href="TakeQuiz.jsp" class="action-btn retry-btn">
                <i class="fas fa-redo"></i> Try Another Quiz
            </a>
            <a href="dashboard.jsp" class="action-btn home-btn">
                <i class="fas fa-home"></i> Back to Dashboard
            </a>
        </div>
    </main>
</body>
</html>