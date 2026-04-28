<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Browse Books - Book Exchange</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; }
        body { background: #f5f5f5; }
        .navbar { background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); padding: 15px 30px; display: flex; justify-content: space-between; align-items: center; color: white; }
        .navbar h1 { font-size: 24px; }
        .navbar a { color: white; text-decoration: none; margin-left: 20px; font-weight: 500; }
        .container { max-width: 1200px; margin: 30px auto; padding: 0 20px; }
        .search-bar { background: white; padding: 20px; border-radius: 15px; margin-bottom: 30px; box-shadow: 0 2px 10px rgba(0,0,0,0.1); display: flex; gap: 10px; }
        .search-bar input { flex: 1; padding: 12px; border: 2px solid #ddd; border-radius: 10px; }
        .search-bar button { padding: 12px 30px; background: #667eea; color: white; border: none; border-radius: 10px; cursor: pointer; font-weight: 600; }
        .books-grid { display: grid; grid-template-columns: repeat(auto-fill, minmax(280px, 1fr)); gap: 25px; }
        .book-card { background: white; border-radius: 15px; overflow: hidden; box-shadow: 0 2px 10px rgba(0,0,0,0.1); transition: transform 0.2s; }
        .book-card:hover { transform: translateY(-5px); }
        .book-header { background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); padding: 15px; color: white; }
        .book-header h3 { font-size: 18px; margin-bottom: 5px; }
        .book-header p { font-size: 14px; opacity: 0.9; }
        .book-body { padding: 20px; }
        .book-body p { margin-bottom: 10px; color: #666; }
        .book-body .label { font-weight: 600; color: #333; }
        .exchange-type { display: inline-block; padding: 5px 12px; border-radius: 20px; font-size: 12px; font-weight: 600; }
        .exchange-type.swap { background: #e8f5e9; color: #2e7d32; }
        .exchange-type.sell { background: #fff3e0; color: #ef6c00; }
        .exchange-type.both { background: #e3f2fd; color: #1565c0; }
        .book-footer { padding: 15px 20px; border-top: 1px solid #eee; display: flex; justify-content: space-between; align-items: center; }
        .price { font-size: 20px; font-weight: 700; color: #667eea; }
        .btn { padding: 10px 20px; background: #667eea; color: white; text-decoration: none; border-radius: 8px; font-weight: 500; }
        .no-books { text-align: center; padding: 50px; color: #666; }
    </style>
</head>
<body>
    <nav class="navbar">
        <h1>Book Exchange</h1>
        <div>
            <a href="dashboard.jsp">Home</a>
            <a href="books">Browse Books</a>
            <a href="books?action=myBooks">My Books</a>
            <a href="exchange">My Requests</a>
            <a href="auth?action=logout">Logout</a>
        </div>
    </nav>
    
    <div class="container">
        <form class="search-bar" action="books" method="get">
            <input type="hidden" name="action" value="search">
            <input type="text" name="query" placeholder="Search by title, author, or genre..." value="${searchQuery}">
            <button type="submit">Search</button>
        </form>
        
        <c:choose>
            <c:when test="${empty books}">
                <div class="no-books">
                    <h2>No books found</h2>
                    <p>Try a different search or check back later.</p>
                </div>
            </c:when>
            <c:otherwise>
                <div class="books-grid">
                    <c:forEach var="book" items="${books}">
                        <div class="book-card">
                            <div class="book-header">
                                <h3>${book.title}</h3>
                                <p>by ${book.author}</p>
                            </div>
                            <div class="book-body">
                                <p><span class="label">Genre:</span> ${book.genre}</p>
                                <p><span class="label">Condition:</span> ${book.condition}</p>
                                <p><span class="label">Owner:</span> ${book.username}</p>
                                <p><span class="label">Type:</span> <span class="exchange-type ${book.exchangeType}">${book.exchangeType}</span></p>
                            </div>
                            <div class="book-footer">
                                <span class="price">${book.price > 0 ? '₹'.concat(book.price) : 'Free'}</span>
                                <a href="bookDetail.jsp?bookId=${book.bookId}" class="btn">View</a>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
</body>
</html>