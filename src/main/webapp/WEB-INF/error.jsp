<!DOCTYPE html>
<html>
<head>
    <title>Error</title>
    <style>
        .error-container {
            max-width: 600px;
            margin: 50px auto;
            padding: 20px;
            text-align: center;
            border: 1px solid #dc3545;
            border-radius: 5px;
        }
        .error-message {
            color: #dc3545;
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
    <div class="error-container">
        <h1>Error</h1>
        <div class="error-message">
            ${errorMessage}
        </div>
        <a href="quiz" class="back-btn">Return to Quiz List</a>
    </div>
</body>
</html>