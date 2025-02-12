<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Quiz Maker</title>
    <style>
        .question-block {
            border: 1px solid #ccc;
            padding: 15px;
            margin: 10px 0;
            border-radius: 5px;
        }
        .option-block {
            margin: 5px 0;
        }
    </style>
</head>
<body>
    <form action="QuizServlet" method="post" id="quizForm">
        <div>
            <label for="quizName">Quiz Name:</label>
            <input type="text" id="quizName" name="quizName" required>
        </div>
        
        <div id="questionsContainer">
            <!-- Questions will be added here -->
        </div>
        
        <button type="button" onclick="addQuestion()">Add Question</button>
        <button type="submit">Save Quiz</button>
    </form>

    <script>
        let questionCount = 0;

        function addQuestion() {
            questionCount++;
            const questionDiv = document.createElement('div');
            questionDiv.className = 'question-block';
            questionDiv.innerHTML = `
                <div>
                    <label for="question${questionCount}">Question ${questionCount}:</label>
                    <input type="text" id="question${questionCount}" 
                           name="question${questionCount}" required>
                </div>
                <div class="option-block">
                    <input type="text" name="q${questionCount}option1" 
                           placeholder="Option 1" required>
                    <input type="radio" name="correct${questionCount}" 
                           value="1" required> Correct
                </div>
                <div class="option-block">
                    <input type="text" name="q${questionCount}option2" 
                           placeholder="Option 2" required>
                    <input type="radio" name="correct${questionCount}" 
                           value="2"> Correct
                </div>
                <div class="option-block">
                    <input type="text" name="q${questionCount}option3" 
                           placeholder="Option 3" required>
                    <input type="radio" name="correct${questionCount}" 
                           value="3"> Correct
                </div>
                <div class="option-block">
                    <input type="text" name="q${questionCount}option4" 
                           placeholder="Option 4" required>
                    <input type="radio" name="correct${questionCount}" 
                           value="4"> Correct
                </div>
            `;
            document.getElementById('questionsContainer').appendChild(questionDiv);
            
            // Add hidden field to track number of questions
            const countInput = document.getElementById('questionCountInput');
            if (countInput) {
                countInput.value = questionCount;
            } else {
                const input = document.createElement('input');
                input.type = 'hidden';
                input.id = 'questionCountInput';
                input.name = 'questionCount';
                input.value = questionCount;
                document.getElementById('quizForm').appendChild(input);
            }
        }
    </script>
</body>
</html>