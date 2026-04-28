<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Book Exchange - Register</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; }
        body { background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); min-height: 100vh; display: flex; justify-content: center; align-items: center; padding: 20px; }
        .container { background: white; border-radius: 20px; box-shadow: 0 20px 60px rgba(0,0,0,0.3); width: 100%; max-width: 450px; padding: 40px; }
        h1 { text-align: center; color: #333; margin-bottom: 10px; }
        .subtitle { text-align: center; color: #666; margin-bottom: 30px; }
        .form-group { margin-bottom: 18px; }
        label { display: block; margin-bottom: 8px; color: #333; font-weight: 500; }
        input { width: 100%; padding: 12px 15px; border: 2px solid #ddd; border-radius: 10px; font-size: 14px; transition: all 0.3s; }
        input:focus { border-color: #667eea; outline: none; }
        .btn { width: 100%; padding: 14px; background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); color: white; border: none; border-radius: 10px; font-size: 16px; font-weight: 600; cursor: pointer; transition: transform 0.2s; }
        .btn:hover { transform: translateY(-2px); }
        .link { text-align: center; margin-top: 20px; color: #666; }
        .link a { color: #667eea; text-decoration: none; font-weight: 500; }
        .link a:hover { text-decoration: underline; }
        .error { background: #fee; color: #c33; padding: 12px; border-radius: 8px; margin-bottom: 20px; text-align: center; }
    </style>
</head>
<body>
    <div class="container">
        <h1>Create Account</h1>
        <p class="subtitle">Join the Book Exchange Community</p>
        
        <c:if test="${not empty error}">
            <div class="error">${error}</div>
        </c:if>
        
        <form action="auth" method="post">
            <input type="hidden" name="action" value="register">
            <div class="form-group">
                <label>Username *</label>
                <input type="text" name="username" required>
            </div>
            <div class="form-group">
                <label>Password *</label>
                <input type="password" name="password" required>
            </div>
            <div class="form-group">
                <label>Email *</label>
                <input type="email" name="email" required>
            </div>
            <div class="form-group">
                <label>Full Name *</label>
                <input type="text" name="fullName" required>
            </div>
            <div class="form-group">
                <label>Phone</label>
                <input type="tel" name="phone">
            </div>
            <button type="submit" class="btn">Register</button>
        </form>
        
        <p class="link">Already have an account? <a href="index.jsp">Login here</a></p>
    </div>
</body>
</html>