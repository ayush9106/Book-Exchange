<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Request Accepted</title>
    <style>
        body {
            font-family: Arial;
            background: linear-gradient(135deg, #4CAF50, #2E7D32);
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }
        .card {
            background: white;
            padding: 40px;
            border-radius: 15px;
            text-align: center;
            box-shadow: 0 10px 30px rgba(0,0,0,0.2);
        }
        .check {
            font-size: 60px;
            color: green;
        }
        h2 {
            margin-top: 15px;
        }
        .btn {
            margin-top: 20px;
            padding: 10px 20px;
            border: none;
            background: #4CAF50;
            color: white;
            border-radius: 8px;
            cursor: pointer;
        }
    </style>
</head>
<body>

<div class="card">
    <div class="check">✔</div>
    <h2>Request Accepted!</h2>
    <p>The book exchange request has been accepted successfully.</p>

    <a href="dashboard.jsp">
        <button class="btn">Go to Dashboard</button>
    </a>
</div>

</body>
</html>