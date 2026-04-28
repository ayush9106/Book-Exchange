<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.bookexchange.dao.BookDAO, com.bookexchange.model.Book" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
    String bookIdStr = request.getParameter("bookId");
    Book book = null;
    if (bookIdStr != null) {
        try {
            int bookId = Integer.parseInt(bookIdStr);
            BookDAO bookDAO = new BookDAO();
            book = bookDAO.getBookById(bookId);
        } catch (NumberFormatException e) {
            // Invalid book ID
        }
    }
    request.setAttribute("book", book);
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Book Details - Book Exchange</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; }
        body { background: #f5f5f5; }
        .navbar { background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); padding: 15px 30px; display: flex; justify-content: space-between; align-items: center; color: white; }
        .navbar h1 { font-size: 24px; }
        .navbar a { color: white; text-decoration: none; margin-left: 20px; font-weight: 500; }
        .container { max-width: 800px; margin: 30px auto; padding: 0 20px; }
        .book-detail { background: white; border-radius: 15px; padding: 30px; box-shadow: 0 2px 10px rgba(0,0,0,0.1); }
        .book-header { border-bottom: 2px solid #eee; padding-bottom: 20px; margin-bottom: 20px; }
        .book-header h2 { color: #333; font-size: 28px; margin-bottom: 10px; }
        .book-header p { color: #666; font-size: 16px; }
        .book-info { display: grid; grid-template-columns: repeat(2, 1fr); gap: 20px; margin-bottom: 20px; }
        .info-item { padding: 15px; background: #f9f9f9; border-radius: 10px; }
        .info-item label { display: block; color: #999; font-size: 12px; margin-bottom: 5px; text-transform: uppercase; }
        .info-item span { color: #333; font-weight: 500; }
        .exchange-type { display: inline-block; padding: 5px 15px; border-radius: 20px; font-size: 14px; font-weight: 600; }
        .exchange-type.swap { background: #e8f5e9; color: #2e7d32; }
        .exchange-type.sell { background: #fff3e0; color: #ef6c00; }
        .exchange-type.both { background: #e3f2fd; color: #1565c0; }
        .description { margin: 20px 0; }
        .description h3 { color: #333; margin-bottom: 10px; }
        .description p { color: #666; line-height: 1.6; }
        .price-section { text-align: center; padding: 20px; background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); border-radius: 10px; color: white; margin: 20px 0; }
        .price-section .price { font-size: 36px; font-weight: 700; }
        .actions { display: flex; gap: 15px; justify-content: center; margin-top: 20px; }
        .btn { padding: 14px 30px; border-radius: 10px; text-decoration: none; font-weight: 600; cursor: pointer; border: none; font-size: 16px; }
        .btn-primary { background: #667eea; color: white; }
        .btn-secondary { background: #ddd; color: #333; }
        .btn:hover { opacity: 0.9; }
        .error { background: #fee; color: #c33; padding: 15px; border-radius: 10px; margin-bottom: 20px; text-align: center; }
    </style>
</head>
<body>
    <nav class="navbar">
        <h1>Book Exchange</h1>
        <div>
            <a href="dashboard.jsp">Home</a>
            <a href="books">Browse Books</a>
            <a href="auth?action=logout">Logout</a>
        </div>
    </nav>
    
    <div class="container">
        <c:choose>
            <c:when test="${empty book}">
                <div class="book-detail">
                    <p style="text-align: center; color: #666;">Book not found.</p>
                    <p style="text-align: center;"><a href="books" style="color: #667eea;">Back to Browse</a></p>
                </div>
            </c:when>
            <c:otherwise>
                <div class="book-detail">
                    <div class="book-header">
                        <h2>${book.title}</h2>
                        <p>by ${book.author}</p>
                    </div>
                    
                    <div class="book-info">
                        <div class="info-item">
                            <label>Genre</label>
                            <span>${book.genre}</span>
                        </div>
                        <div class="info-item">
                            <label>Condition</label>
                            <span>${book.condition}</span>
                        </div>
                        <div class="info-item">
                            <label>Exchange Type</label>
                            <span class="exchange-type ${book.exchangeType}">${book.exchangeType}</span>
                        </div>
                        <div class="info-item">
                            <label>Listed By</label>
                            <span><a href="rating?action=view&userId=${book.userId}" style="color: #667eea;">${book.username}</a></span>
                        </div>
                    </div>
                    
                    <div class="description">
                        <h3>Description</h3>
                        <p>${book.description != null ? book.description : 'No description provided.'}</p>
                    </div>
                    
                    <div class="price-section">
                        <div class="price">${book.price > 0 ? '₹'.concat(book.price) : 'Free Exchange'}</div>
                    </div>
                    
                    <c:if test="${not empty error}">
                        <div class="error">${error}</div>
                    </c:if>
                    
                    <div class="actions">
                        <form action="exchange" method="post" style="display: inline;">
                            <input type="hidden" name="action" value="create">
                            <input type="hidden" name="bookId" value="${book.bookId}">
                            <div style="margin-bottom: 15px;">
                                <textarea name="message" placeholder="Write a message to the owner..." rows="3" style="width: 100%; padding: 10px; border: 2px solid #ddd; border-radius: 10px;"></textarea>
                            </div>
                            <button type="submit" class="btn btn-primary">Send Request</button>
                        </form>
                        <a href="books" class="btn btn-secondary">Back</a>
                    </div>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
</body>
</html>