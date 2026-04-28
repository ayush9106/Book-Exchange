<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Books - Book Exchange</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; }
        body { background: #f5f5f5; }
        .navbar { background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); padding: 15px 30px; display: flex; justify-content: space-between; align-items: center; color: white; }
        .navbar h1 { font-size: 24px; }
        .navbar a { color: white; text-decoration: none; margin-left: 20px; font-weight: 500; }
        .container { max-width: 1200px; margin: 30px auto; padding: 0 20px; }
        .header { display: flex; justify-content: space-between; align-items: center; margin-bottom: 30px; }
        .header h2 { color: #333; }
        .btn-add { padding: 12px 25px; background: #667eea; color: white; text-decoration: none; border-radius: 10px; font-weight: 600; }
        .books-grid { display: grid; grid-template-columns: repeat(auto-fill, minmax(280px, 1fr)); gap: 25px; }
        .book-card { background: white; border-radius: 15px; overflow: hidden; box-shadow: 0 2px 10px rgba(0,0,0,0.1); }
        .book-header { background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); padding: 15px; color: white; }
        .book-header h3 { font-size: 18px; margin-bottom: 5px; }
        .book-header p { font-size: 14px; opacity: 0.9; }
        .book-body { padding: 20px; }
        .book-body p { margin-bottom: 10px; color: #666; }
        .book-body .label { font-weight: 600; color: #333; }
        .status { display: inline-block; padding: 5px 12px; border-radius: 20px; font-size: 12px; font-weight: 600; }
        .status.available { background: #e8f5e9; color: #2e7d32; }
        .status.sold { background: #ffebee; color: #c62828; }
        .book-footer { padding: 15px 20px; border-top: 1px solid #eee; display: flex; gap: 10px; }
        .btn { padding: 10px 15px; border-radius: 8px; text-decoration: none; font-weight: 500; border: none; cursor: pointer; font-size: 14px; }
        .btn-edit { background: #667eea; color: white; }
        .btn-delete { background: #e53935; color: white; }
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
        <div class="header">
            <h2>My Listed Books</h2>
            <a href="addBook.jsp" class="btn-add">+ Add New Book</a>
        </div>
        
        <c:choose>
            <c:when test="${empty books}">
                <div class="no-books">
                    <h2>No books listed yet</h2>
                    <p>Start by adding your first book!</p>
                    <a href="addBook.jsp" style="color: #667eea;">Add Book</a>
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
                                <p><span class="label">Type:</span> ${book.exchangeType}</p>
                                <p><span class="label">Price:</span> ${book.price > 0 ? '₹'.concat(book.price) : 'Free'}</p>
                                <p><span class="label">Status:</span> <span class="status ${book.status}">${book.status}</span></p>
                            </div>
                            <div class="book-footer">
                                <a href="editBook.jsp?bookId=${book.bookId}" class="btn btn-edit">Edit</a>
                                <a href="books?action=delete&bookId=${book.bookId}" class="btn btn-delete" onclick="return confirm('Are you sure?')">Delete</a>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
</body>
</html>