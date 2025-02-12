<!DOCTYPE html>
<html>
<head>
    <title>Quiz Results</title>
    <style>
        .result-container {
            max-width: 600px;
            margin: 50px auto;
            padding: 20px;
            text-align: center;
            border: 1px solid #ddd;
            border-radius: 5px;
        }
        .score {
            font-size: 24px;
            margin: 20px 0;
            color: #007bff;
        }
        .percentage {
            font-size: 48px;
            color: #28a745;
            margin: 20px 0;
        }
        .back-btn {
            display: inline-block;
            padding: 10px 20px;
            background-color: #007bff;
            color: white;
            text-decoration: none;
            border-radius: 5px;
            margin-top: 20px;
        }
    </style>
</head>
<body>
    <div class="result-container">
        <h1>Quiz Results</h1>
        <div class="score">
            You scored ${score} out of ${totalQuestions}
        </div>
        <div class="percentage">
            ${Math.round((score / totalQuestions) * 100)}%
        </div>
        <a href="quiz" class="back-btn">Take Another Quiz</a>
    </div>
</body>
</html>