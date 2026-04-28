


















<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Requests - Book Exchange</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; }
        body { background: #f5f5f5; }
        .navbar { background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); padding: 15px 30px; display: flex; justify-content: space-between; align-items: center; color: white; }
        .navbar h1 { font-size: 24px; }
        .navbar a { color: white; text-decoration: none; margin-left: 20px; font-weight: 500; }
        .container { max-width: 1000px; margin: 30px auto; padding: 0 20px; }
        .tabs { display: flex; gap: 10px; margin-bottom: 30px; }
        .tab { padding: 12px 25px; background: white; border: none; border-radius: 10px; cursor: pointer; font-weight: 600; color: #666; text-decoration: none; }
        .tab.active { background: #667eea; color: white; }
        .requests-list { display: flex; flex-direction: column; gap: 20px; }
        .request-card { background: white; border-radius: 15px; padding: 20px; box-shadow: 0 2px 10px rgba(0,0,0,0.1); }
        .request-header { display: flex; justify-content: space-between; align-items: center; margin-bottom: 15px; }
        .request-header h3 { color: #333; }
        .status { padding: 5px 15px; border-radius: 20px; font-size: 12px; font-weight: 600; }
        .status.pending { background: #fff3e0; color: #ef6c00; }
        .status.accepted { background: #e8f5e9; color: #2e7d32; }
        .status.rejected { background: #ffebee; color: #c62828; }
        .request-body { color: #666; margin-bottom: 15px; }
        .request-body p { margin-bottom: 8px; }
        .request-actions { display: flex; gap: 10px; }
        .btn { padding: 10px 20px; border-radius: 8px; text-decoration: none; font-weight: 500; border: none; cursor: pointer; }
        .btn-accept { background: #4caf50; color: white; }
        .btn-reject { background: #f44336; color: white; }
        .no-requests { text-align: center; padding: 50px; color: #666; }
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
        <div class="tabs">
            <a href="exchange" class="tab active">All Requests</a>
            <a href="exchange?action=incoming" class="tab">Incoming</a>
            <a href="exchange?action=outgoing" class="tab">Outgoing</a>
        </div>
        
        <c:choose>
            <c:when test="${empty requests}">
                <div class="no-requests">
                    <h2>No requests yet</h2>
                    <p>When someone requests your books, you'll see them here.</p>
                </div>
            </c:when>
            <c:otherwise>
                <div class="requests-list">
                    <c:forEach var="req" items="${requests}">
                        <div class="request-card">
                            <div class="request-header">
                                <h3>${req.bookTitle}</h3>
                                <span class="status ${req.status}">${req.status}</span>
                            </div>
                            <div class="request-body">
                                <p><strong>From:</strong> ${req.requesterName}</p>
                                <p><strong>To:</strong> ${req.ownerName}</p>
                                <p><strong>Message:</strong> ${req.message}</p>
                            </div>
                            <c:if test="${sessionScope.user.userId == req.ownerId && req.status == 'pending'}">
                                <div class="request-actions">
                                    <form action="exchange" method="post">
                                        <input type="hidden" name="action" value="updateStatus">
                                        <input type="hidden" name="requestId" value="${req.requestId}">
                                        <input type="hidden" name="status" value="accepted">
                                        <input type="hidden" name="bookId" value="${req.bookId}">
                                        <button type="submit" class="btn btn-accept">Accept</button>
                                    </form>
                                    <form action="exchange" method="post">
                                        <input type="hidden" name="action" value="updateStatus">
                                        <input type="hidden" name="requestId" value="${req.requestId}">
                                        <input type="hidden" name="status" value="rejected">
                                        <button type="submit" class="btn btn-reject">Reject</button>
                                    </form>
                                </div>
                            </c:if>
                        </div>
                    </c:forEach>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
</body>
</html>