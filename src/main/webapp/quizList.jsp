<!DOCTYPE html>
<html>
<head>
    <title>Advanced Java Quiz</title>
    <style>
        .quiz-container {
            max-width: 800px;
            margin: 0 auto;
            padding: 20px;
        }
        .question {
            margin-bottom: 15px;
            font-size: 18px;
            color: #333;
        }
        .options {
            margin-bottom: 10px;
        }
        .submit-btn {
            background-color: #4CAF50;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }
        .result {
            font-weight: bold;
            color: green;
            margin-top: 20px;
        }
    </style>
</head>
<body>
    <div class="quiz-container">
        <h1>Advanced Java Quiz</h1>
        <form id="quizForm">
            <!-- Quiz Questions -->
            <div class="question">1. Which method is used to start a thread in Java?</div>
            <div class="options">
                <input type="radio" name="q1" value="A"> A. run()<br>
                <input type="radio" name="q1" value="B"> B. start()<br>
                <input type="radio" name="q1" value="C"> C. execute()<br>
                <input type="radio" name="q1" value="D"> D. launch()<br>
            </div>

            <div class="question">2. What does the JVM use to identify objects in memory?</div>
            <div class="options">
                <input type="radio" name="q2" value="A"> A. Hash code<br>
                <input type="radio" name="q2" value="B"> B. Unique ID<br>
                <input type="radio" name="q2" value="C"> C. Pointer<br>
                <input type="radio" name="q2" value="D"> D. None of the above<br>
            </div>

            <!-- More Questions Here -->
            <!-- ... -->

            <button type="button" class="submit-btn" onclick="submitQuiz()">Submit Quiz</button>
        </form>

        <div class="result" id="result"></div>
    </div>

    <script>
        function submitQuiz() {
            const answers = {
                q1: "B",
                q2: "A",
                // Add correct answers for questions 3-10 here
            };

            let score = 0;
            let totalQuestions = 2; // Update this as you add more questions

            for (let i = 1; i <= totalQuestions; i++) {
                let question = "q" + i;
                let selectedOption = document.querySelector(`input[name="${question}"]:checked`);

                if (selectedOption && selectedOption.value === answers[question]) {
                    score++;
                }
            }

            document.getElementById("result").innerText = `You scored ${score} out of ${totalQuestions}.`;
        }
    </script>
</body>
</html>
