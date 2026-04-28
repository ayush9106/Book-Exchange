<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard - Book Exchange</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; }
        body { background: #f5f5f5; }
        .navbar { background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); padding: 15px 30px; display: flex; justify-content: space-between; align-items: center; color: white; box-shadow: 0 2px 10px rgba(0,0,0,0.1); }
        .navbar h1 { font-size: 24px; }
        .navbar .nav-links a { color: white; text-decoration: none; margin-left: 20px; font-weight: 500; }
        .navbar .nav-links a:hover { text-decoration: underline; }
        .user-info { display: flex; align-items: center; gap: 15px; }
        .container { max-width: 1200px; margin: 30px auto; padding: 0 20px; }
        .welcome { background: white; padding: 30px; border-radius: 15px; margin-bottom: 30px; box-shadow: 0 2px 10px rgba(0,0,0,0.1); }
        .welcome h2 { color: #333; margin-bottom: 10px; }
        .welcome p { color: #666; }
        .stats { display: grid; grid-template-columns: repeat(auto-fit, minmax(250px, 1fr)); gap: 20px; margin-bottom: 30px; }
        .stat-card { background: white; padding: 25px; border-radius: 15px; box-shadow: 0 2px 10px rgba(0,0,0,0.1); text-align: center; }
        .stat-card h3 { color: #667eea; font-size: 36px; margin-bottom: 10px; }
        .stat-card p { color: #666; font-weight: 500; }
        .quick-links { display: grid; grid-template-columns: repeat(auto-fit, minmax(200px, 1fr)); gap: 20px; }
        .quick-link { background: white; padding: 30px; border-radius: 15px; box-shadow: 0 2px 10px rgba(0,0,0,0.1); text-align: center; text-decoration: none; color: #333; transition: transform 0.2s; }
        .quick-link:hover { transform: translateY(-5px); }
        .quick-link h3 { margin-bottom: 10px; color: #667eea; }
    </style>
</head>
<body>
    <nav class="navbar">
        <h1>Book Exchange</h1>
        <div class="user-info">
            <span>Welcome, ${sessionScope.user.fullName}!</span>
            <div class="nav-links">
                <a href="dashboard.jsp">Home</a>
                <a href="books">Browse Books</a>
                <a href="books?action=myBooks">My Books</a>
                <a href="exchange">My Requests</a>
                <a href="auth?action=logout">Logout</a>
            </div>
        </div>
    </nav>
    
    <div class="container">
        <div class="welcome">
            <h2>Welcome to Book Exchange!</h2>
            <p>Trade, sell, and discover books from our community of readers.</p>
        </div>
        
        <div class="stats">
            <div class="stat-card">
                <h3>${sessionScope.user.rating > 0 ? sessionScope.user.rating : 'N/A'}</h3>
                <p>Your Rating</p>
            </div>
            <div class="stat-card">
                <h3>${sessionScope.user.totalRatings}</h3>
                <p>Total Reviews</p>
            </div>
        </div>
        
        <h2 style="margin-bottom: 20px; color: #333;">Quick Actions</h2>
        <div class="quick-links">
            <a href="books" class="quick-link">
                <h3>Browse Books</h3>
                <p>Find books to buy or exchange</p>
            </a>
            <a href="addBook.jsp" class="quick-link">
                <h3>Add Book</h3>
                <p>List your book for exchange</p>
            </a>
            <a href="exchange?action=incoming" class="quick-link">
                <h3>Incoming Requests</h3>
                <p>View requests for your books</p>
            </a>
            <a href="exchange?action=outgoing" class="quick-link">
                <h3>Outgoing Requests</h3>
                <p>Track your requests</p>
            </a>
        </div>
    </div>
</body>
</html>