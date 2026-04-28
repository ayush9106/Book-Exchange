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
            // Invalid ID
        }
    }
    if (book == null) {
        response.sendRedirect("books?action=myBooks");
        return;
    }
    request.setAttribute("book", book);
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Book - Book Exchange</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; }
        body { background: #f5f5f5; }
        .navbar { background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); padding: 15px 30px; display: flex; justify-content: space-between; align-items: center; color: white; }
        .navbar h1 { font-size: 24px; }
        .navbar a { color: white; text-decoration: none; margin-left: 20px; font-weight: 500; }
        .container { max-width: 600px; margin: 30px auto; padding: 0 20px; }
        .form-container { background: white; padding: 30px; border-radius: 15px; box-shadow: 0 2px 10px rgba(0,0,0,0.1); }
        h2 { color: #333; margin-bottom: 25px; text-align: center; }
        .form-group { margin-bottom: 20px; }
        label { display: block; margin-bottom: 8px; color: #333; font-weight: 500; }
        input, select, textarea { width: 100%; padding: 12px; border: 2px solid #ddd; border-radius: 10px; font-size: 14px; }
        input:focus, select:focus, textarea:focus { border-color: #667eea; outline: none; }
        .btn { width: 100%; padding: 14px; background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); color: white; border: none; border-radius: 10px; font-size: 16px; font-weight: 600; cursor: pointer; }
        .btn:hover { opacity: 0.9; }
    </style>
</head>
<body>
    <nav class="navbar">
        <h1>Book Exchange</h1>
        <div>
            <a href="dashboard.jsp">Home</a>
            <a href="books">Browse Books</a>
            <a href="books?action=myBooks">My Books</a>
            <a href="auth?action=logout">Logout</a>
        </div>
    </nav>
    
    <div class="container">
        <div class="form-container">
            <h2>Edit Book</h2>
            
            <form action="books" method="post">
                <input type="hidden" name="action" value="update">
                <input type="hidden" name="bookId" value="${book.bookId}">
                
                <div class="form-group">
                    <label>Title</label>
                    <input type="text" name="title" value="${book.title}" required>
                </div>
                
                <div class="form-group">
                    <label>Author</label>
                    <input type="text" name="author" value="${book.author}" required>
                </div>
                
                <div class="form-group">
                    <label>Genre</label>
                    <select name="genre" required>
                        <option value="Fiction" ${book.genre == 'Fiction' ? 'selected' : ''}>Fiction</option>
                        <option value="Non-Fiction" ${book.genre == 'Non-Fiction' ? 'selected' : ''}>Non-Fiction</option>
                        <option value="Science" ${book.genre == 'Science' ? 'selected' : ''}>Science</option>
                        <option value="Technology" ${book.genre == 'Technology' ? 'selected' : ''}>Technology</option>
                        <option value="History" ${book.genre == 'History' ? 'selected' : ''}>History</option>
                        <option value="Biography" ${book.genre == 'Biography' ? 'selected' : ''}>Biography</option>
                        <option value="Children" ${book.genre == 'Children' ? 'selected' : ''}>Children</option>
                        <option value="Romance" ${book.genre == 'Romance' ? 'selected' : ''}>Romance</option>
                        <option value="Thriller" ${book.genre == 'Thriller' ? 'selected' : ''}>Thriller</option>
                        <option value="Other" ${book.genre == 'Other' ? 'selected' : ''}>Other</option>
                    </select>
                </div>
                
                <div class="form-group">
                    <label>Condition</label>
                    <select name="condition" required>
                        <option value="New" ${book.condition == 'New' ? 'selected' : ''}>New</option>
                        <option value="Like New" ${book.condition == 'Like New' ? 'selected' : ''}>Like New</option>
                        <option value="Good" ${book.condition == 'Good' ? 'selected' : ''}>Good</option>
                        <option value="Fair" ${book.condition == 'Fair' ? 'selected' : ''}>Fair</option>
                        <option value="Poor" ${book.condition == 'Poor' ? 'selected' : ''}>Poor</option>
                    </select>
                </div>
                
                <div class="form-group">
                    <label>Exchange Type</label>
                    <select name="exchangeType" required>
                        <option value="swap" ${book.exchangeType == 'swap' ? 'selected' : ''}>Swap/Trade</option>
                        <option value="sell" ${book.exchangeType == 'sell' ? 'selected' : ''}>Sell</option>
                        <option value="both" ${book.exchangeType == 'both' ? 'selected' : ''}>Both</option>
                    </select>
                </div>
                
                <div class="form-group">
                    <label>Price (₹)</label>
                    <input type="number" name="price" step="0.01" min="0" value="${book.price}">
                </div>
                
                <div class="form-group">
                    <label>Description</label>
                    <textarea name="description">${book.description}</textarea>
                </div>
                
                <button type="submit" class="btn">Update Book</button>
            </form>
        </div>
    </div>
</body>
</html>