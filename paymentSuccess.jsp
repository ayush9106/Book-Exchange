<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Payment Successful</title>
    <style>
        body {
            font-family: 'Segoe UI';
            background: #0F9D58;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            color: white;
        }

        .card {
            text-align: center;
        }

        .circle {
            width: 100px;
            height: 100px;
            background: white;
            border-radius: 50%;
            display: flex;
            justify-content: center;
            align-items: center;
            margin: auto;
        }

        .tick {
            font-size: 50px;
            color: #0F9D58;
        }

        h1 {
            margin-top: 20px;
        }

        .amount {
            font-size: 30px;
            font-weight: bold;
        }

        .btn {
            margin-top: 30px;
            padding: 12px 25px;
            background: white;
            color: #0F9D58;
            border: none;
            border-radius: 10px;
            cursor: pointer;
        }
    </style>
</head>
<body>

<div class="card">
    <div class="circle">
        <div class="tick">✔</div>
    </div>

    <h1>Payment Successful</h1>
    <p class="amount">₹ ${param.amount != null ? param.amount : "200"}</p>

    <p>Book purchased successfully!</p>

    <a href="dashboard.jsp">
        <button class="btn">Back to Home</button>
    </a>
</div>

</body>
</html>