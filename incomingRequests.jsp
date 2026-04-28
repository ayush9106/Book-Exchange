<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>Incoming Requests — BookSwap</title>
  <link rel="preconnect" href="https://fonts.googleapis.com"/>
  <link href="https://fonts.googleapis.com/css2?family=DM+Sans:ital,wght@0,400;0,500;0,600;1,400&family=Playfair+Display:wght@700&display=swap" rel="stylesheet"/>
  <style>
    /* ── Reset & base ── */
    *, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }
    body {
      font-family: 'DM Sans', sans-serif;
      background: #F6F6F4;
      color: #111;
      min-height: 100vh;
    }

    /* ── Page shell ── */
    .page { max-width: 740px; margin: 0 auto; padding: 2.5rem 1.25rem 5rem; }

    /* ── Top bar ── */
    .topbar { display: flex; align-items: flex-start; justify-content: space-between; margin-bottom: 2rem; gap: 1rem; }
    .title-block .eyebrow {
      font-size: 11px; font-weight: 600; letter-spacing: .08em;
      text-transform: uppercase; color: #854F0B; margin-bottom: 6px;
    }
    .title-block h1 {
      font-family: 'Playfair Display', serif; font-size: 28px;
      font-weight: 700; color: #111; line-height: 1.2;
    }
    .title-block .sub { font-size: 13px; color: #888; margin-top: 5px; }

    /* ── Stats row ── */
    .stats-row { display: grid; grid-template-columns: repeat(3, 1fr); gap: 10px; margin-bottom: 1.75rem; }
    .stat {
      background: #fff; border: 0.5px solid #e5e5e5;
      border-radius: 10px; padding: 14px 16px;
    }
    .stat-val { font-size: 24px; font-weight: 600; color: #111; }
    .stat-val.amber { color: #854F0B; }
    .stat-val.green { color: #3B6D11; }
    .stat-val.red   { color: #A32D2D; }
    .stat-lbl { font-size: 11px; color: #888; margin-top: 3px; }

    /* ── Arriving soon banner ── */
    .arriving-banner {
      background: #E1F5EE; border: 0.5px solid #9FE1CB;
      border-radius: 12px; padding: 14px 18px;
      display: flex; align-items: center; gap: 14px;
      margin-bottom: 1.75rem;
    }
    .banner-truck {
      width: 44px; height: 44px; border-radius: 10px;
      background: #0F6E56; display: flex; align-items: center;
      justify-content: center; flex-shrink: 0;
    }
    .banner-txt .b1 { font-size: 14px; font-weight: 600; color: #085041; }
    .banner-txt .b2 { font-size: 12px; color: #0F6E56; margin-top: 3px; }

    /* ── Filter tabs ── */
    .filter-tabs { display: flex; gap: 6px; margin-bottom: 1.5rem; flex-wrap: wrap; }
    .tab {
      font-size: 12px; font-weight: 500; padding: 6px 14px;
      border-radius: 20px; border: 0.5px solid #ddd;
      color: #666; cursor: pointer; background: #fff;
      text-decoration: none; transition: all .15s;
    }
    .tab:hover { border-color: #999; color: #111; }
    .tab.active { background: #0F6E56; border-color: #0F6E56; color: #fff; }

    /* ── Section labels ── */
    .section-label {
      font-size: 11px; font-weight: 600; text-transform: uppercase;
      letter-spacing: .06em; color: #aaa; margin-bottom: 10px; margin-top: 1.75rem;
    }
    .section-label:first-of-type { margin-top: 0; }

    /* ── Request card ── */
    .req-card {
      background: #fff; border: 0.5px solid #e5e5e5;
      border-radius: 14px; padding: 1.25rem 1.5rem;
      margin-bottom: 1rem; transition: border-color .2s;
    }
    .req-card:hover { border-color: #ccc; }
    .req-card.highlight { border: 1px solid #9FE1CB; }
    .req-card.faded { opacity: .85; }

    /* ── Card header ── */
    .card-head { display: flex; align-items: center; gap: 12px; margin-bottom: 1rem; }
    .avatar {
      width: 42px; height: 42px; border-radius: 50%;
      display: flex; align-items: center; justify-content: center;
      font-size: 13px; font-weight: 600; flex-shrink: 0;
    }
    .av-teal  { background: #E1F5EE; color: #0F6E56; }
    .av-amber { background: #FAEEDA; color: #854F0B; }
    .av-gray  { background: #F1EFE8; color: #5F5E5A; }
    .head-info { flex: 1; }
    .head-name { font-size: 14px; font-weight: 600; color: #111; }
    .head-time { font-size: 11px; color: #aaa; margin-top: 1px; }

    /* ── Status badges ── */
    .badge {
      display: inline-flex; align-items: center; gap: 4px;
      font-size: 11px; font-weight: 500; padding: 4px 10px; border-radius: 20px;
    }
    .b-pending  { background: #FAEEDA; color: #854F0B; }
    .b-accepted { background: #EAF3DE; color: #3B6D11; }
    .b-rejected { background: #FCEBEB; color: #A32D2D; }
    .dot { width: 5px; height: 5px; border-radius: 50%; display: inline-block; }
    .dp { background: #BA7517; }
    .da { background: #639922; }
    .dr { background: #E24B4A; }

    /* ── Book row ── */
    .book-row {
      display: flex; align-items: center; gap: 10px;
      background: #F6F6F4; border-radius: 8px;
      padding: 10px 12px; margin-bottom: 1rem;
    }
    .book-spine { width: 6px; height: 44px; border-radius: 3px; flex-shrink: 0; }
    .book-info .btitle  { font-size: 13px; font-weight: 600; color: #111; }
    .book-info .bauthor { font-size: 11px; color: #888; margin-top: 2px; }

    /* ── Message ── */
    .msg-block { margin-bottom: 1rem; }
    .msg-label {
      font-size: 10px; font-weight: 600; letter-spacing: .05em;
      text-transform: uppercase; color: #aaa; margin-bottom: 5px;
    }
    .msg-text { font-size: 13px; color: #555; line-height: 1.65; font-style: italic; }

    /* ── Tracker ── */
    .tracker { display: flex; align-items: flex-start; margin-bottom: 1rem; }
    .tstep   { display: flex; flex-direction: column; align-items: center; gap: 5px; flex: 1; }
    .tcircle {
      width: 26px; height: 26px; border-radius: 50%;
      display: flex; align-items: center; justify-content: center; border: 2px solid;
    }
    .tlabel { font-size: 10px; font-weight: 500; text-align: center; line-height: 1.3; }
    .tline  { flex: 1; height: 2px; position: relative; top: 13px; }

    .ts-done   .tcircle { background: #639922; border-color: #639922; }
    .ts-active .tcircle { background: #fff; border-color: #BA7517; box-shadow: 0 0 0 3px #FAEEDA; }
    .ts-idle   .tcircle { background: #F1EFE8; border-color: #ddd; }
    .ts-done   .tlabel  { color: #3B6D11; font-weight: 600; }
    .ts-active .tlabel  { color: #854F0B; font-weight: 600; }
    .ts-idle   .tlabel  { color: #aaa; }
    .tl-done { background: #639922; }
    .tl-idle { background: #e5e5e5; }

    /* ── Arrival & reject tags ── */
    .arrival-tag {
      display: flex; align-items: center; gap: 10px;
      background: #E1F5EE; border-radius: 8px; padding: 10px 14px;
    }
    .at-icon {
      width: 24px; height: 24px; border-radius: 50%;
      background: #0F6E56; display: flex; align-items: center;
      justify-content: center; flex-shrink: 0;
    }
    .at-main { font-size: 13px; font-weight: 600; color: #085041; }
    .at-sub  { font-size: 11px; color: #0F6E56; margin-top: 2px; }

    .reject-tag {
      display: flex; align-items: center; gap: 10px;
      background: #FCEBEB; border-radius: 8px; padding: 10px 14px;
    }
    .rt-icon {
      width: 24px; height: 24px; border-radius: 50%;
      background: #E24B4A; display: flex; align-items: center;
      justify-content: center; flex-shrink: 0;
    }
    .rt-main { font-size: 13px; font-weight: 600; color: #791F1F; }
    .rt-sub  { font-size: 11px; color: #A32D2D; margin-top: 2px; }

    /* ── Action row ── */
    .action-row {
      display: flex; gap: 8px; margin-top: 1rem;
      padding-top: 1rem; border-top: 0.5px solid #eee;
    }
    .btn {
      display: inline-flex; align-items: center; gap: 6px;
      border: 0.5px solid; border-radius: 8px; padding: 8px 16px;
      font-size: 12px; font-weight: 600; cursor: pointer;
      font-family: inherit; transition: all .15s;
    }
    .btn-ghost {
      background: #fff; border-color: #ddd; color: #666;
    }
    .btn-ghost:hover { background: #FCEBEB; border-color: #F7C1C1; color: #A32D2D; }

    /* ── Empty state ── */
    .empty-state {
      text-align: center; padding: 4rem 2rem;
      background: #fff; border: 0.5px solid #e5e5e5;
      border-radius: 14px; margin-top: 1rem;
    }
    .empty-icon {
      width: 56px; height: 56px; border-radius: 14px;
      background: #E1F5EE; display: flex; align-items: center;
      justify-content: center; margin: 0 auto 1rem;
    }
    .empty-title { font-size: 16px; font-weight: 600; color: #111; margin-bottom: 6px; }
    .empty-sub   { font-size: 13px; color: #888; line-height: 1.6; }

    /* ── Utilities ── */
    .sr-only { position: absolute; width: 1px; height: 1px; overflow: hidden; clip: rect(0,0,0,0); }
    svg { display: block; }
  </style>
</head>
<body>

<%-- ── Count requests by status ── --%>
<c:set var="totalCount"    value="0"/>
<c:set var="pendingCount"  value="0"/>
<c:set var="acceptedCount" value="0"/>
<c:set var="rejectedCount" value="0"/>
<c:set var="arrivingBook"  value=""/>

<c:forEach var="req" items="${requests}">
  <c:set var="totalCount" value="${totalCount + 1}"/>
  <c:choose>
    <c:when test="${req.status == 'pending'}">
      <c:set var="pendingCount" value="${pendingCount + 1}"/>
    </c:when>
    <c:when test="${req.status == 'accepted'}">
      <c:set var="acceptedCount" value="${acceptedCount + 1}"/>
      <c:if test="${empty arrivingBook}">
        <c:set var="arrivingBook" value="${req.bookTitle}"/>
        <c:set var="arrivingFrom" value="${req.toUser}"/>
      </c:if>
    </c:when>
    <c:when test="${req.status == 'rejected'}">
      <c:set var="rejectedCount" value="${rejectedCount + 1}"/>
    </c:when>
  </c:choose>
</c:forEach>

<div class="page">
  <h2 class="sr-only">Incoming book exchange requests — track your sent requests</h2>

  <%-- ── Top bar ── --%>
  <div class="topbar">
    <div class="title-block">
      <div class="eyebrow">Book Exchange</div>
      <h1>Incoming Requests</h1>
      <div class="sub">Books you've requested from other readers</div>
    </div>
  </div>

  <%-- ── Stats ── --%>
  <div class="stats-row">
    <div class="stat">
      <div class="stat-val">${totalCount}</div>
      <div class="stat-lbl">Total requests</div>
    </div>
    <div class="stat">
      <div class="stat-val amber">${pendingCount}</div>
      <div class="stat-lbl">Awaiting reply</div>
    </div>
    <div class="stat">
      <div class="stat-val green">${acceptedCount}</div>
      <div class="stat-lbl">Book${acceptedCount != 1 ? 's' : ''} arriving</div>
    </div>
  </div>

  <%-- ── "A book is on its way" banner — shown only if there's an accepted request ── --%>
  <c:if test="${acceptedCount > 0}">
    <div class="arriving-banner">
      <div class="banner-truck">
        <svg width="22" height="22" viewBox="0 0 24 24" fill="none" stroke="white" stroke-width="2">
          <rect x="1" y="3" width="15" height="13"/>
          <polygon points="16 8 20 8 23 11 23 16 16 16 16 8"/>
          <circle cx="5.5" cy="18.5" r="2.5"/>
          <circle cx="18.5" cy="18.5" r="2.5"/>
        </svg>
      </div>
      <div class="banner-txt">
        <c:choose>
          <c:when test="${acceptedCount == 1}">
            <div class="b1">A book is on its way to you!</div>
            <div class="b2">${arrivingBook} — from ${arrivingFrom}</div>
          </c:when>
          <c:otherwise>
            <div class="b1">${acceptedCount} books are on their way!</div>
            <div class="b2">Check below for delivery details</div>
          </c:otherwise>
        </c:choose>
      </div>
    </div>
  </c:if>

  <%-- ── Filter tabs ── --%>
  <div class="filter-tabs">
    <a href="exchange?view=incoming"           class="tab ${empty param.status ? 'active' : ''}">All (${totalCount})</a>
    <a href="exchange?view=incoming&status=pending"   class="tab ${param.status == 'pending'   ? 'active' : ''}">Pending (${pendingCount})</a>
    <a href="exchange?view=incoming&status=accepted"  class="tab ${param.status == 'accepted'  ? 'active' : ''}">Arriving (${acceptedCount})</a>
    <a href="exchange?view=incoming&status=rejected"  class="tab ${param.status == 'rejected'  ? 'active' : ''}">Rejected (${rejectedCount})</a>
  </div>

  <%-- ── Empty state ── --%>
  <c:if test="${empty requests}">
    <div class="empty-state">
      <div class="empty-icon">
        <svg width="26" height="26" viewBox="0 0 24 24" fill="none" stroke="#0F6E56" stroke-width="2">
          <path d="M4 19.5A2.5 2.5 0 0 1 6.5 17H20"/>
          <path d="M6.5 2H20v20H6.5A2.5 2.5 0 0 1 4 19.5v-15A2.5 2.5 0 0 1 6.5 2z"/>
        </svg>
      </div>
      <div class="empty-title">No requests yet</div>
      <div class="empty-sub">When you send a book exchange request,<br>you'll be able to track it here.</div>
    </div>
  </c:if>

  <%-- ══════════════════════════════════════
       ACCEPTED (Arriving) — shown first
  ══════════════════════════════════════ --%>
  <c:set var="hasAccepted" value="false"/>
  <c:forEach var="req" items="${requests}">
    <c:if test="${req.status == 'accepted'}">
      <c:if test="${!hasAccepted}">
        <div class="section-label">Arriving soon</div>
        <c:set var="hasAccepted" value="true"/>
      </c:if>

      <div class="req-card highlight">
        <div class="card-head">
          <div class="avatar av-teal">
            ${fn:toUpperCase(fn:substring(req.toUser, 0, 2))}
          </div>
          <div class="head-info">
            <div class="head-name">${req.toUser}</div>
            <div class="head-time">Accepted your request</div>
          </div>
          <span class="badge b-accepted"><span class="dot da"></span>Arriving</span>
        </div>

        <div class="book-row">
          <div class="book-spine" style="background:#0F6E56;"></div>
          <div class="book-info">
            <div class="btitle">${req.bookTitle}</div>
            <div class="bauthor">Requested book</div>
          </div>
        </div>

        <div class="msg-block">
          <div class="msg-label">Your message</div>
          <div class="msg-text">"${req.message}"</div>
        </div>

        <div class="tracker">
          <div class="tstep ts-done">
            <div class="tcircle">
              <svg width="11" height="11" viewBox="0 0 24 24" fill="none" stroke="white" stroke-width="3"><polyline points="20 6 9 17 4 12"/></svg>
            </div>
            <div class="tlabel">Sent</div>
          </div>
          <div class="tline tl-done"></div>
          <div class="tstep ts-done">
            <div class="tcircle">
              <svg width="11" height="11" viewBox="0 0 24 24" fill="none" stroke="white" stroke-width="3"><polyline points="20 6 9 17 4 12"/></svg>
            </div>
            <div class="tlabel">Accepted</div>
          </div>
          <div class="tline tl-done"></div>
          <div class="tstep ts-active">
            <div class="tcircle">
              <svg width="8" height="8" viewBox="0 0 24 24"><circle cx="12" cy="12" r="5" fill="#BA7517"/></svg>
            </div>
            <div class="tlabel">On the way</div>
          </div>
          <div class="tline tl-idle"></div>
          <div class="tstep ts-idle">
            <div class="tcircle"></div>
            <div class="tlabel">Received</div>
          </div>
        </div>

        <div class="arrival-tag">
          <div class="at-icon">
            <svg width="13" height="13" viewBox="0 0 24 24" fill="none" stroke="white" stroke-width="2.5">
              <rect x="1" y="3" width="15" height="13"/>
              <polygon points="16 8 20 8 23 11 23 16 16 16 16 8"/>
              <circle cx="5.5" cy="18.5" r="2.5"/>
              <circle cx="18.5" cy="18.5" r="2.5"/>
            </svg>
          </div>
          <div>
            <div class="at-main">Your book is arriving soon</div>
            <div class="at-sub">Coordinate with ${req.toUser} for handover details</div>
          </div>
        </div>
      </div>

    </c:if>
  </c:forEach>

  <%-- ══════════════════════════════════════
       PENDING — waiting for reply
  ══════════════════════════════════════ --%>
  <c:set var="hasPending" value="false"/>
  <c:forEach var="req" items="${requests}">
    <c:if test="${req.status == 'pending'}">
      <c:if test="${!hasPending}">
        <div class="section-label">Waiting for reply</div>
        <c:set var="hasPending" value="true"/>
      </c:if>

      <div class="req-card">
        <div class="card-head">
          <div class="avatar av-amber">
            ${fn:toUpperCase(fn:substring(req.toUser, 0, 2))}
          </div>
          <div class="head-info">
            <div class="head-name">${req.toUser}</div>
            <div class="head-time">Request sent — awaiting response</div>
          </div>
          <span class="badge b-pending"><span class="dot dp"></span>Pending</span>
        </div>

        <div class="book-row">
          <div class="book-spine" style="background:#BA7517;"></div>
          <div class="book-info">
            <div class="btitle">${req.bookTitle}</div>
            <div class="bauthor">Requested book</div>
          </div>
        </div>

        <div class="msg-block">
          <div class="msg-label">Your message</div>
          <div class="msg-text">"${req.message}"</div>
        </div>

        <div class="tracker">
          <div class="tstep ts-done">
            <div class="tcircle">
              <svg width="11" height="11" viewBox="0 0 24 24" fill="none" stroke="white" stroke-width="3"><polyline points="20 6 9 17 4 12"/></svg>
            </div>
            <div class="tlabel">Sent</div>
          </div>
          <div class="tline tl-done"></div>
          <div class="tstep ts-active">
            <div class="tcircle">
              <svg width="8" height="8" viewBox="0 0 24 24"><circle cx="12" cy="12" r="5" fill="#BA7517"/></svg>
            </div>
            <div class="tlabel">Awaiting reply</div>
          </div>
          <div class="tline tl-idle"></div>
          <div class="tstep ts-idle">
            <div class="tcircle"></div>
            <div class="tlabel">Accepted</div>
          </div>
          <div class="tline tl-idle"></div>
          <div class="tstep ts-idle">
            <div class="tcircle"></div>
            <div class="tlabel">Received</div>
          </div>
        </div>

        <div class="action-row">
          <form action="exchange" method="post" style="margin:0;">
            <input type="hidden" name="action"    value="cancelRequest"/>
            <input type="hidden" name="requestId" value="${req.requestId}"/>
            <button type="submit" class="btn btn-ghost">
              <svg width="13" height="13" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5"><line x1="18" y1="6" x2="6" y2="18"/><line x1="6" y1="6" x2="18" y2="18"/></svg>
              Cancel request
            </button>
          </form>
        </div>
      </div>

    </c:if>
  </c:forEach>

  <%-- ══════════════════════════════════════
       REJECTED — closed requests
  ══════════════════════════════════════ --%>
  <c:set var="hasRejected" value="false"/>
  <c:forEach var="req" items="${requests}">
    <c:if test="${req.status == 'rejected'}">
      <c:if test="${!hasRejected}">
        <div class="section-label">Closed</div>
        <c:set var="hasRejected" value="true"/>
      </c:if>

      <div class="req-card faded">
        <div class="card-head">
          <div class="avatar av-gray">
            ${fn:toUpperCase(fn:substring(req.toUser, 0, 2))}
          </div>
          <div class="head-info">
            <div class="head-name">${req.toUser}</div>
            <div class="head-time">Request closed</div>
          </div>
          <span class="badge b-rejected"><span class="dot dr"></span>Rejected</span>
        </div>

        <div class="book-row" style="opacity:.6;">
          <div class="book-spine" style="background:#E24B4A;"></div>
          <div class="book-info">
            <div class="btitle">${req.bookTitle}</div>
            <div class="bauthor">Requested book</div>
          </div>
        </div>

        <div class="msg-block">
          <div class="msg-label">Your message</div>
          <div class="msg-text">"${req.message}"</div>
        </div>

        <div class="reject-tag">
          <div class="rt-icon">
            <svg width="11" height="11" viewBox="0 0 24 24" fill="none" stroke="white" stroke-width="3">
              <line x1="18" y1="6" x2="6" y2="18"/>
              <line x1="6" y1="6" x2="18" y2="18"/>
            </svg>
          </div>
          <div>
            <div class="rt-main">This request was not accepted</div>
            <div class="rt-sub">The owner declined your exchange offer</div>
          </div>
        </div>
      </div>

    </c:if>
  </c:forEach>

</div><%-- /page --%>
</body>
</html>
