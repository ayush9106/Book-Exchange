<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User Profile - Book Exchange</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; }
        body { background: #f5f5f5; }
        .navbar { background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); padding: 15px 30px; display: flex; justify-content: space-between; align-items: center; color: white; }
        .navbar h1 { font-size: 24px; }
        .navbar a { color: white; text-decoration: none; margin-left: 20px; font-weight: 500; }
        .container { max-width: 800px; margin: 30px auto; padding: 0 20px; }
        .profile-card { background: white; border-radius: 15px; padding: 30px; box-shadow: 0 2px 10px rgba(0,0,0,0.1); margin-bottom: 30px; }
        .profile-header { display: flex; align-items: center; gap: 20px; margin-bottom: 20px; }
        .avatar { width: 80px; height: 80px; background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); border-radius: 50%; display: flex; align-items: center; justify-content: center; color: white; font-size: 32px; font-weight: 700; }
        .profile-info h2 { color: #333; }
        .profile-info p { color: #666; }
        .rating { display: flex; align-items: center; gap: 10px; margin-top: 10px; }
        .rating-stars { color: #ffc107; font-size: 20px; }
        .rating-count { color: #666; }
        .user-details { display: grid; grid-template-columns: repeat(2, 1fr); gap: 15px; }
        .detail-item { padding: 15px; background: #f9f9f9; border-radius: 10px; }
        .detail-item label { display: block; color: #999; font-size: 12px; margin-bottom: 5px; }
        .detail-item span { color: #333; font-weight: 500; }
        .rate-section { margin-top: 30px; padding-top: 20px; border-top: 1px solid #eee; }
        .rate-section h3 { color: #333; margin-bottom: 15px; }
        .rate-form { display: flex; flex-direction: column; gap: 15px; }
        .rate-form select, .rate-form textarea { width: 100%; padding: 12px; border: 2px solid #ddd; border-radius: 10px; }
        .btn { padding: 12px 25px; background: #667eea; color: white; border: none; border-radius: 10px; font-weight: 600; cursor: pointer; }
        .ratings-list { background: white; border-radius: 15px; padding: 20px; box-shadow: 0 2px 10px rgba(0,0,0,0.1); }
        .ratings-list h3 { color: #333; margin-bottom: 20px; }
        .rating-item { padding: 15px; border-bottom: 1px solid #eee; }
        .rating-item:last-child { border-bottom: none; }
        .rating-header { display: flex; justify-content: space-between; align-items: center; margin-bottom: 10px; }
        .rating-header strong { color: #333; }
        .rating-stars { color: #ffc107; }
        .rating-comment { color: #666; font-style: italic; }
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
        <div class="profile-card">
            <div class="profile-header">
                <div class="avatar">${profileUser.username.substring(0,1).toUpperCase()}</div>
                <div class="profile-info">
                    <h2>${profileUser.fullName}</h2>
                    <p>@${profileUser.username}</p>
                    <div class="rating">
                        <span class="rating-stars">
                            <c:forEach begin="1" end="5" var="i">
                                <c:if test="${i <= profileUser.rating}">★</c:if>
                                <c:if test="${i > profileUser.rating}">☆</c:if>
                            </c:forEach>
                        </span>
                        <span class="rating-count">(${profileUser.rating}) - ${profileUser.totalRatings} reviews</span>
                    </div>
                </div>
            </div>
            
            <div class="user-details">
                <div class="detail-item">
                    <label>Email</label>
                    <span>${profileUser.email}</span>
                </div>
                <div class="detail-item">
                    <label>Phone</label>
                    <span>${profileUser.phone != null ? profileUser.phone : 'Not provided'}</span>
                </div>
            </div>
            
            <c:if test="${sessionScope.user.userId != profileUser.userId}">
                <div class="rate-section">
                    <h3>Rate this User</h3>
                    <c:if test="${not empty sessionScope.error}">
                        <p style="color: red; margin-bottom: 10px;">${sessionScope.error}</p>
                    </c:if>
                    <form class="rate-form" action="rating" method="post">
                        <input type="hidden" name="action" value="add">
                        <input type="hidden" name="ratedUserId" value="${profileUser.userId}">
                        <select name="rating" required>
                            <option value="">Select Rating</option>
                            <option value="5">★★★★★ - Excellent</option>
                            <option value="4">★★★★☆ - Good</option>
                            <option value="3">★★★☆☆ - Average</option>
                            <option value="2">★★☆☆☆ - Poor</option>
                            <option value="1">★☆☆☆☆ - Very Poor</option>
                        </select>
                        <textarea name="comment" placeholder="Write a review..."></textarea>
                        <button type="submit" class="btn">Submit Rating</button>
                    </form>
                </div>
            </c:if>
        </div>
        
        <div class="ratings-list">
            <h3>Reviews</h3>
            <c:choose>
                <c:when test="${empty ratings}">
                    <p style="color: #666; text-align: center; padding: 20px;">No reviews yet.</p>
                </c:when>
                <c:otherwise>
                    <c:forEach var="r" items="${ratings}">
                        <div class="rating-item">
                            <div class="rating-header">
                                <strong>${r.raterUsername}</strong>
                                <span class="rating-stars">
                                    <c:forEach begin="1" end="5" var="i">
                                        <c:if test="${i <= r.rating}">★</c:if>
                                        <c:if test="${i > r.rating}">☆</c:if>
                                    </c:forEach>
                                </span>
                            </div>
                            <c:if test="${not empty r.comment}">
                                <p class="rating-comment">${r.comment}</p>
                            </c:if>
                        </div>
                    </c:forEach>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</body>
</html>