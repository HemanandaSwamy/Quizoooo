<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Take Quiz - Quizooo</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Arial', sans-serif;
            background-color: #f5f5f5;
            line-height: 1.6;
        }

        .quiz-header {
            background: #fff;
            padding: 1rem;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            position: sticky;
            top: 0;
            z-index: 100;
        }

        .quiz-info {
            max-width: 1200px;
            margin: 0 auto;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .timer {
            background: #2196F3;
            color: white;
            padding: 0.5rem 1rem;
            border-radius: 20px;
            font-weight: bold;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .progress-bar {
            background: #e0e0e0;
            height: 4px;
            margin-top: 1rem;
        }

        .progress {
            background: #4CAF50;
            height: 100%;
            width: 0%;
            transition: width 0.3s ease;
        }

        .quiz-container {
            max-width: 800px;
            margin: 2rem auto;
            padding: 0 1rem;
        }

        .question-card {
            background: white;
            border-radius: 8px;
            padding: 2rem;
            margin-bottom: 2rem;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }

        .question-number {
            color: #2196F3;
            font-size: 0.9rem;
            margin-bottom: 1rem;
        }

        .question-text {
            font-size: 1.2rem;
            margin-bottom: 1.5rem;
            color: #333;
        }

        .options-list {
            list-style: none;
        }

        .option-item {
            margin-bottom: 1rem;
        }

        .option-label {
            display: flex;
            align-items: center;
            padding: 1rem;
            border: 2px solid #e0e0e0;
            border-radius: 8px;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        .option-label:hover {
            border-color: #2196F3;
            background: #f8f9fa;
        }

        input[type="radio"] {
            margin-right: 1rem;
        }

        input[type="radio"]:checked + .option-label {
            border-color: #2196F3;
            background: #e3f2fd;
        }

        .action-buttons {
            position: fixed;
            bottom: 0;
            left: 0;
            right: 0;
            background: white;
            padding: 1rem;
            box-shadow: 0 -2px 4px rgba(0,0,0,0.1);
            display: flex;
            justify-content: space-between;
            gap: 1rem;
        }

        .btn {
            padding: 0.8rem 1.5rem;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-weight: bold;
            transition: background-color 0.3s ease;
        }

        .btn-previous {
            background: #f5f5f5;
            color: #333;
        }

        .btn-next {
            background: #2196F3;
            color: white;
        }

        .btn-submit {
            background: #4CAF50;
            color: white;
        }

        .btn:hover {
            opacity: 0.9;
        }

        .btn:disabled {
            opacity: 0.5;
            cursor: not-allowed;
        }

        @media (max-width: 768px) {
            .quiz-container {
                padding: 0 0.5rem;
            }

            .question-card {
                padding: 1.5rem;
            }

            .action-buttons {
                padding: 0.8rem;
            }
        }
    </style>
</head>
<body>
    <div class="quiz-header">
        <div class="quiz-info">
            <h1>${quiz.title}</h1>
            <div class="timer">
                <i class="fas fa-clock"></i>
                <span id="timer">00:00</span>
            </div>
        </div>
        <div class="progress-bar">
            <div class="progress" id="progressBar"></div>
        </div>
    </div>

    <main class="quiz-container">
        <form id="quizForm" action="QuizSubmitServlet" method="post">
            <input type="hidden" name="quizId" value="${quiz.id}">
            <input type="hidden" name="timeSpent" id="timeSpent">
            
            <div id="questionsContainer">
                <c:forEach var="question" items="${quiz.questions}" varStatus="status">
                    <div class="question-card" id="question${status.index}" style="display: ${status.index == 0 ? 'block' : 'none'}">
                        <div class="question-number">
                            Question ${status.index + 1} of ${quiz.questions.size()}
                        </div>
                        <div class="question-text">
                            ${question.text}
                        </div>
                        <ul class="options-list">
                            <c:forEach var="option" items="${question.options}">
                                <li class="option-item">
                                    <input type="radio" 
                                           name="q${status.index}" 
                                           value="${option.id}" 
                                           id="q${status.index}o${option.id}"
                                           class="quiz-option">
                                    <label for="q${status.index}o${option.id}" class="option-label">
                                        ${option.text}
                                    </label>
                                </li>
                            </c:forEach>
                        </ul>
                    </div>
                </c:forEach>
            </div>

            <div class="action-buttons">
                <button type="button" id="previousBtn" class="btn btn-previous" disabled>
                    <i class="fas fa-arrow-left"></i> Previous
                </button>
                <button type="button" id="nextBtn" class="btn btn-next">
                    Next <i class="fas fa-arrow-right"></i>
                </button>
                <button type="submit" id="submitBtn" class="btn btn-submit" style="display: none;">
                    Submit Quiz <i class="fas fa-check"></i>
                </button>
            </div>
        </form>
    </main>

    <script>
        // Quiz navigation and timer functionality
        const totalQuestions = ${quiz.questions.size()};
        let currentQuestion = 0;
        let timeLeft = ${quiz.timeLimit} * 60; // Convert minutes to seconds
        let startTime = new Date().getTime();

        const questionCards = document.querySelectorAll('.question-card');
        const previousBtn = document.getElementById('previousBtn');
        const nextBtn = document.getElementById('nextBtn');
        const submitBtn = document.getElementById('submitBtn');
        const progressBar = document.getElementById('progressBar');

        function showQuestion(index) {
            questionCards.forEach(card => card.style.display = 'none');
            questionCards[index].style.display = 'block';
            
            // Update navigation buttons
            previousBtn.disabled = index === 0;
            if (index === totalQuestions - 1) {
                nextBtn.style.display = 'none';
                submitBtn.style.display = 'block';
            } else {
                nextBtn.style.display = 'block';
                submitBtn.style.display = 'none';
            }

            // Update progress bar
            const progress = ((index + 1) / totalQuestions) * 100;
            progressBar.style.width = `${progress}%`;
        }

        previousBtn.addEventListener('click', () => {
            if (currentQuestion > 0) {
                currentQuestion--;
                showQuestion(currentQuestion);
            }
        });

        nextBtn.addEventListener('click', () => {
            if (currentQuestion < totalQuestions - 1) {
                currentQuestion++;
                showQuestion(currentQuestion);
            }
        });

        // Timer functionality
        function updateTimer() {
            const minutes = Math.floor(timeLeft / 60);
            const seconds = timeLeft % 60;
            document.getElementById('timer').textContent = 
                `${minutes.toString().padStart(2, '0')}:${seconds.toString().padStart(2, '0')}`;
                
            if (timeLeft <= 0) {
                submitQuiz();
            }
            timeLeft--;
        }

        function submitQuiz() {
            const timeSpent = Math.floor((new Date().getTime() - startTime) / 1000);
            document.getElementById('timeSpent').value = timeSpent;
            document.getElementById('quizForm').submit();
        }

        // Start timer
        const timerInterval = setInterval(updateTimer, 1000);

        // Form submission
        document.getElementById('quizForm').addEventListener('submit', (e) => {
            e.preventDefault();
            
            // Check if all questions are answered
            const totalAnswered = document.querySelectorAll('input[type="radio"]:checked').length;
            if (totalAnswered < totalQuestions) {
                if (!confirm('You haven\'t answered all questions. Do you want to submit anyway?')) {
                    return;
                }
            }
            
            submitQuiz();
        });

        // Save answers to sessionStorage as backup
        document.querySelectorAll('.quiz-option').forEach(option => {
            option.addEventListener('change', () => {
                const questionId = option.name;
                const answer = option.value;
                sessionStorage.setItem(questionId, answer);
            });

            // Restore saved answers on page load
            const questionId = option.name;
            const savedAnswer = sessionStorage.getItem(questionId);
            if (savedAnswer === option.value) {
                option.checked = true;
            }
        });
    </script>
</body>
</html>