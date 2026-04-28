<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add Book - Book Exchange</title>
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
        textarea { resize: vertical; min-height: 100px; }
        .btn { width: 100%; padding: 14px; background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); color: white; border: none; border-radius: 10px; font-size: 16px; font-weight: 600; cursor: pointer; }
        .btn:hover { opacity: 0.9; }
        .error { background: #fee; color: #c33; padding: 12px; border-radius: 8px; margin-bottom: 20px; text-align: center; }
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
            <h2>Add New Book</h2>
            
            <c:if test="${not empty error}">
                <div class="error">${error}</div>
            </c:if>
            
            <form action="books" method="post">
                <input type="hidden" name="action" value="add">
                
                <div class="form-group">
                    <label>Title *</label>
                    <input type="text" name="title" required>
                </div>
                
                <div class="form-group">
                    <label>Author *</label>
                    <input type="text" name="author" required>
                </div>
                
                <div class="form-group">
                    <label>Genre *</label>
                    <select name="genre" required>
                        <option value="">Select Genre</option>
                        <option value="Fiction">Fiction</option>
                        <option value="Non-Fiction">Non-Fiction</option>
                        <option value="Science">Science</option>
                        <option value="Technology">Technology</option>
                        <option value="History">History</option>
                        <option value="Biography">Biography</option>
                        <option value="Children">Children</option>
                        <option value="Romance">Romance</option>
                        <option value="Thriller">Thriller</option>
                        <option value="Other">Other</option>
                    </select>
                </div>
                
                <div class="form-group">
                    <label>Condition *</label>
                    <select name="condition" required>
                        <option value="">Select Condition</option>
                        <option value="New">New</option>
                        <option value="Like New">Like New</option>
                        <option value="Good">Good</option>
                        <option value="Fair">Fair</option>
                        <option value="Poor">Poor</option>
                    </select>
                </div>
                
                <div class="form-group">
                    <label>Exchange Type *</label>
                    <select name="exchangeType" required>
                        <option value="">Select Type</option>
                        <option value="swap">Swap/Trade</option>
                        <option value="sell">Sell</option>
                        <option value="both">Both (Swap or Sell)</option>
                    </select>
                </div>
                
                <div class="form-group">
                    <label>Price (₹) - Enter 0 for free swap</label>
                    <input type="number" name="price" step="0.01" min="0" value="0">
                </div>
                
                <div class="form-group">
                    <label>Description</label>
                    <textarea name="description" placeholder="Describe your book..."></textarea>
                </div>
                
                <button type="submit" class="btn">Add Book</button>
            </form>
        </div>
    </div>
</body>
</html>