<!-- <!DOCTYPE html>
<html>
<head>
    <title>Take Quiz - Quizooo</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
</head>
<body>
    <div class="container">
        <h2>${quiz.title}</h2>
        <p>${quiz.description}</p>
        <div id="timer">Time remaining: <span id="time">${quiz.timeLimit}:00</span></div>

        <form action="${pageContext.request.contextPath}/SubmitQuizServlet" method="POST" id="quizForm">
            <input type="hidden" name="quizId" value="${quiz.id}">

            <c:forEach var="question" items="${quiz.questions}" varStatus="status">
                <div class="question-container">
                    <h3>Question ${status.index + 1}</h3>
                    <p>${question.questionText}</p>

                    <c:forEach var="option" items="${question.options}" varStatus="optStatus">
                        <div class="option">
                            <input type="radio"
                                   name="answers[${status.index}]"
                                   value="${optStatus.index}"
                                   required>
                            ${option}
                        </div>
                    </c:forEach>
                </div>
            </c:forEach>

            <button type="submit" class="btn btn-primary">Submit Quiz</button>
        </form>
    </div>

    <script>
        let timeLeft = ${quiz.timeLimit} * 60;

        function updateTimer() {
            const minutes = Math.floor(timeLeft / 60);
            const seconds = timeLeft % 60;
            document.getElementById('time').textContent = 
                `${minutes}:${seconds < 10 ? '0' : ''}${seconds}`;

            if (timeLeft === 0) {
                document.getElementById('quizForm').submit();
            } else {
                timeLeft--;
                setTimeout(updateTimer, 1000);
            }
        }

        updateTimer();
    </script>
</body>
</html> -->

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Available Quizzes - Quizooo</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="css/dashboard.css">
    <style>
        .quiz-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
            gap: 20px;
            padding: 20px;
        }
        
        .quiz-card {
            background: white;
            border-radius: 8px;
            padding: 20px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            transition: transform 0.2s;
        }
        
        .quiz-card:hover {
            transform: translateY(-5px);
        }
        
        .quiz-card h3 {
            margin: 0 0 10px 0;
            color: #333;
        }
        
        .quiz-meta {
            color: #666;
            font-size: 0.9em;
            margin-bottom: 15px;
        }
        
        .take-quiz-btn {
            background: #4CAF50;
            color: white;
            padding: 8px 16px;
            border-radius: 4px;
            text-decoration: none;
            display: inline-block;
        }
        
        .take-quiz-btn:hover {
            background: #45a049;
        }
    </style>
</head>
<body>
    <header>
        <!-- Same header as dashboard -->
    </header>

    <main class="dashboard-container">
        <h1><i class="fas fa-list"></i> Available Quizzes</h1>
        
        <div class="quiz-grid">
            <c:forEach var="quiz" items="${availableQuizzes}">
                <div class="quiz-card">
                    <h3>${quiz.title}</h3>
                    <div class="quiz-meta">
                        <p><i class="fas fa-question-circle"></i> Questions: ${quiz.questionCount}</p>
                        <p><i class="fas fa-clock"></i> Time Limit: ${quiz.timeLimit} minutes</p>
                        <p><i class="fas fa-user"></i> Created by: ${quiz.creatorName}</p>
                    </div>
                    <a href="QuizAttempt.jsp?quizId=${quiz.id}" class="take-quiz-btn">
                        <i class="fas fa-play"></i> Take Quiz
                    </a>
                </div>
            </c:forEach>
        </div>
    </main>

    <footer>
        <p>&copy; 2024 Quizooo. All rights reserved.</p>
    </footer>
</body>
</html> 


<!--<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Take Quiz - Quizooo</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
</head>
<body>
    <div class="container">
        <h2>General Knowledge Quiz</h2>
        <p>Test your general knowledge with this sample quiz!</p>
        <div id="timer">Time remaining: <span id="time">5:00</span></div>

        <form action="${pageContext.request.contextPath}/SubmitQuizServlet" method="POST" id="quizForm">
            <!-- Hidden input for quiz ID -->
            <input type="hidden" name="quizId" value="sampleQuiz123">

            <!-- Question 1 -->
            <div class="question-container">
                <h3>Question 1</h3>
                <p>What is the capital of France?</p>
                <div class="option">
                    <input type="radio" name="answers[0]" value="0" required> London
                </div>
                <div class="option">
                    <input type="radio" name="answers[0]" value="1"> Paris
                </div>
                <div class="option">
                    <input type="radio" name="answers[0]" value="2"> Rome
                </div>
                <div class="option">
                    <input type="radio" name="answers[0]" value="3"> Madrid
                </div>
            </div>

            <!-- Question 2 -->
            <div class="question-container">
                <h3>Question 2</h3>
                <p>Which planet is known as the Red Planet?</p>
                <div class="option">
                    <input type="radio" name="answers[1]" value="0" required> Earth
                </div>
                <div class="option">
                    <input type="radio" name="answers[1]" value="1"> Jupiter
                </div>
                <div class="option">
                    <input type="radio" name="answers[1]" value="2"> Mars
                </div>
                <div class="option">
                    <input type="radio" name="answers[1]" value="3"> Venus
                </div>
            </div>

            <!-- Additional questions can follow the same format... -->

            <button type="submit" class="btn btn-primary">Submit Quiz</button>
        </form>
    </div>

    <script>
        let timeLeft = 5 * 60; // 5 minutes in seconds

        function updateTimer() {
            const minutes = Math.floor(timeLeft / 60);
            const seconds = timeLeft % 60;
            document.getElementById('time').textContent = 
                `${minutes}:${seconds < 10 ? '0' : ''}${seconds}`;

            if (timeLeft === 0) {
                document.getElementById('quizForm').submit();
            } else {
                timeLeft--;
                setTimeout(updateTimer, 1000);
            }
        }

        updateTimer();
    </script>
</body>
</html>
  -->
