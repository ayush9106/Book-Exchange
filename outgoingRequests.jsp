<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8"/>
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>My Sent Requests — BookSwap</title>
  <link href="https://fonts.googleapis.com/css2?family=DM+Sans:ital,wght@0,400;0,500;0,600;1,400&family=Playfair+Display:wght@700&display=swap" rel="stylesheet"/>
  <style>
    *, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }
    body { font-family: 'DM Sans', sans-serif; background: #F6F6F4; }
    .page { max-width: 720px; margin: 0 auto; padding: 2rem 1.25rem 4rem; }

    .eyebrow { font-size: 11px; font-weight: 600; letter-spacing: .08em; text-transform: uppercase; color: #854F0B; margin-bottom: 6px; }
    h1 { font-family: 'Playfair Display', serif; font-size: 28px; font-weight: 700; color: #111; line-height: 1.2; margin-bottom: 4px; }
    .sub { font-size: 13px; color: #888; margin-bottom: 2rem; }

    .stats-row { display: grid; grid-template-columns: repeat(4, 1fr); gap: 10px; margin-bottom: 1.75rem; }
    .stat { background: #fff; border: 0.5px solid #e5e5e5; border-radius: 10px; padding: 14px 16px; }
    .stat-val { font-size: 22px; font-weight: 600; color: #111; }
    .stat-val.amber { color: #854F0B; }
    .stat-val.green { color: #3B6D11; }
    .stat-val.red   { color: #A32D2D; }
    .stat-lbl { font-size: 11px; color: #888; margin-top: 3px; }

    .alert-banner { background: #E1F5EE; border: 1px solid #9FE1CB; border-radius: 12px; padding: 14px 18px; display: flex; align-items: center; gap: 14px; margin-bottom: 1.75rem; }
    .al-icon { width: 44px; height: 44px; border-radius: 10px; background: #0F6E56; display: flex; align-items: center; justify-content: center; flex-shrink: 0; }
    .al-txt .a1 { font-size: 14px; font-weight: 600; color: #085041; }
    .al-txt .a2 { font-size: 12px; color: #0F6E56; margin-top: 3px; }

    .filter-tabs { display: flex; gap: 6px; margin-bottom: 1.5rem; flex-wrap: wrap; }
    .tab { font-size: 12px; font-weight: 500; padding: 6px 14px; border-radius: 20px; border: 0.5px solid #ddd; color: #666; cursor: pointer; background: #fff; text-decoration: none; display: inline-block; }
    .tab.active { background: #0F6E56; border-color: #0F6E56; color: #fff; }

    .section-label { font-size: 11px; font-weight: 600; text-transform: uppercase; letter-spacing: .06em; color: #aaa; margin-bottom: 10px; margin-top: 1.75rem; }

    .req-card { background: #fff; border: 0.5px solid #e5e5e5; border-radius: 14px; padding: 1.25rem 1.5rem; margin-bottom: 1rem; }
    .req-card.highlight { border: 1px solid #9FE1CB; }
    .req-card.faded { opacity: .82; }

    .card-head { display: flex; align-items: center; gap: 12px; margin-bottom: 1rem; }
    .avatar { width: 42px; height: 42px; border-radius: 50%; display: flex; align-items: center; justify-content: center; font-size: 13px; font-weight: 600; flex-shrink: 0; }
    .av-teal  { background: #E1F5EE; color: #0F6E56; }
    .av-amber { background: #FAEEDA; color: #854F0B; }
    .av-gray  { background: #F1EFE8; color: #5F5E5A; }
    .head-info { flex: 1; }
    .head-name { font-size: 14px; font-weight: 600; color: #111; }
    .head-time { font-size: 11px; color: #aaa; margin-top: 1px; }

    .badge { display: inline-flex; align-items: center; gap: 4px; font-size: 11px; font-weight: 500; padding: 4px 10px; border-radius: 20px; }
    .b-pending  { background: #FAEEDA; color: #854F0B; }
    .b-accepted { background: #EAF3DE; color: #3B6D11; }
    .b-rejected { background: #FCEBEB; color: #A32D2D; }
    .dot { width: 5px; height: 5px; border-radius: 50%; display: inline-block; }
    .dp { background: #BA7517; } .da { background: #639922; } .dr { background: #E24B4A; }

    .book-row { display: flex; align-items: center; gap: 10px; background: #F6F6F4; border-radius: 8px; padding: 10px 12px; margin-bottom: 1rem; }
    .book-spine { width: 6px; height: 44px; border-radius: 3px; flex-shrink: 0; }
    .btitle  { font-size: 13px; font-weight: 600; color: #111; }
    .bauthor { font-size: 11px; color: #888; margin-top: 2px; }

    .msg-block { margin-bottom: 1rem; }
    .msg-label { font-size: 10px; font-weight: 600; letter-spacing: .05em; text-transform: uppercase; color: #aaa; margin-bottom: 5px; }
    .msg-text  { font-size: 13px; color: #555; line-height: 1.65; font-style: italic; }

    .divider { border: none; border-top: 0.5px solid #eee; margin: 1rem 0; }

    .seller-contact-card { background: #F6F6F4; border-radius: 10px; padding: 14px 16px; margin-bottom: 1rem; }
    .sc-label { font-size: 10px; font-weight: 600; letter-spacing: .05em; text-transform: uppercase; color: #aaa; margin-bottom: 10px; }
    .sc-body  { display: flex; align-items: center; gap: 12px; }
    .seller-av { width: 40px; height: 40px; border-radius: 50%; background: #E1F5EE; display: flex; align-items: center; justify-content: center; font-size: 13px; font-weight: 600; color: #0F6E56; flex-shrink: 0; }
    .sc-info { flex: 1; }
    .sc-name  { font-size: 14px; font-weight: 600; color: #111; }
    .sc-phone { font-size: 13px; color: #555; margin-top: 2px; letter-spacing: .02em; }
    .sc-actions { display: flex; gap: 8px; margin-top: 12px; flex-wrap: wrap; }
    .cta-call { display: inline-flex; align-items: center; gap: 7px; background: #0F6E56; border: none; border-radius: 8px; padding: 9px 16px; font-size: 12px; font-weight: 600; color: #fff; cursor: pointer; font-family: inherit; text-decoration: none; }
    .cta-wa   { display: inline-flex; align-items: center; gap: 7px; background: #25D366; border: none; border-radius: 8px; padding: 9px 16px; font-size: 12px; font-weight: 600; color: #fff; cursor: pointer; font-family: inherit; text-decoration: none; }
    .cta-copy { display: inline-flex; align-items: center; gap: 7px; background: #fff; border: 0.5px solid #ddd; border-radius: 8px; padding: 9px 14px; font-size: 12px; font-weight: 600; color: #555; cursor: pointer; font-family: inherit; }

    .delivery-label { font-size: 10px; font-weight: 600; letter-spacing: .05em; text-transform: uppercase; color: #aaa; margin-bottom: 8px; }
    .delivery-opts  { display: grid; grid-template-columns: repeat(3, 1fr); gap: 8px; margin-bottom: 1rem; }
    .d-opt { border: 0.5px solid #e5e5e5; border-radius: 10px; padding: 12px; text-align: center; cursor: pointer; background: #fff; transition: all .15s; }
    .d-opt:hover  { border-color: #9FE1CB; background: #E1F5EE; }
    .d-opt.chosen { border: 1.5px solid #0F6E56; background: #E1F5EE; }
    .d-opt-icon   { width: 32px; height: 32px; border-radius: 8px; margin: 0 auto 6px; display: flex; align-items: center; justify-content: center; }
    .d-opt-name   { font-size: 12px; font-weight: 600; color: #111; }
    .d-opt-desc   { font-size: 10px; color: #888; margin-top: 2px; }

    .tracker { display: flex; align-items: flex-start; margin-bottom: 1rem; }
    .tstep   { display: flex; flex-direction: column; align-items: center; gap: 5px; flex: 1; }
    .tcircle { width: 26px; height: 26px; border-radius: 50%; display: flex; align-items: center; justify-content: center; border: 2px solid; }
    .tlabel  { font-size: 10px; font-weight: 500; text-align: center; line-height: 1.3; }
    .tline   { flex: 1; height: 2px; position: relative; top: 13px; }
    .ts-done   .tcircle { background: #639922; border-color: #639922; }
    .ts-active .tcircle { background: #fff; border-color: #BA7517; box-shadow: 0 0 0 3px #FAEEDA; }
    .ts-idle   .tcircle { background: #F1EFE8; border-color: #ddd; }
    .ts-done   .tlabel  { color: #3B6D11; font-weight: 600; }
    .ts-active .tlabel  { color: #854F0B; font-weight: 600; }
    .ts-idle   .tlabel  { color: #aaa; }
    .tl-done { background: #639922; } .tl-idle { background: #e5e5e5; }

    .reject-tag { display: flex; align-items: center; gap: 10px; background: #FCEBEB; border-radius: 8px; padding: 10px 14px; }
    .rt-icon    { width: 24px; height: 24px; border-radius: 50%; background: #E24B4A; display: flex; align-items: center; justify-content: center; flex-shrink: 0; }
    .rt-main    { font-size: 13px; font-weight: 600; color: #791F1F; }
    .rt-sub     { font-size: 11px; color: #A32D2D; margin-top: 2px; }

    .action-row  { display: flex; gap: 8px; margin-top: 1rem; padding-top: 1rem; border-top: 0.5px solid #eee; flex-wrap: wrap; }
    .btn-ghost   { display: inline-flex; align-items: center; gap: 6px; background: #fff; border: 0.5px solid #ddd; border-radius: 8px; padding: 8px 16px; font-size: 12px; font-weight: 600; color: #666; cursor: pointer; font-family: inherit; }
    .btn-confirm { display: inline-flex; align-items: center; gap: 6px; background: #0F6E56; border: none; border-radius: 8px; padding: 8px 16px; font-size: 12px; font-weight: 600; color: #fff; cursor: pointer; font-family: inherit; }

    #toast { position: fixed; bottom: 28px; right: 24px; background: #0F6E56; color: #fff; padding: 11px 20px; border-radius: 10px; font-size: 13px; font-weight: 600; box-shadow: 0 6px 20px rgba(0,0,0,.15); display: none; z-index: 999; }

    @media (max-width: 520px) {
      .stats-row { grid-template-columns: repeat(2,1fr); }
      .delivery-opts { grid-template-columns: repeat(2,1fr); }
    }
  </style>
</head>
<body>

<%-- Pre-count --%>
<c:set var="totalCount"    value="0"/>
<c:set var="pendingCount"  value="0"/>
<c:set var="actionCount"   value="0"/>
<c:set var="rejectedCount" value="0"/>
<c:set var="firstAccepted" value="${null}"/>
<c:forEach var="req" items="${requests}">
  <c:set var="totalCount" value="${totalCount + 1}"/>
  <c:choose>
    <c:when test="${req.status eq 'PENDING'}">  <c:set var="pendingCount"  value="${pendingCount  + 1}"/></c:when>
    <c:when test="${req.status eq 'ACCEPTED'}"> <c:set var="actionCount"   value="${actionCount   + 1}"/>
      <c:if test="${firstAccepted == null}"><c:set var="firstAccepted" value="${req}"/></c:if>
    </c:when>
    <c:when test="${req.status eq 'REJECTED'}"> <c:set var="rejectedCount" value="${rejectedCount + 1}"/></c:when>
  </c:choose>
</c:forEach>

<div class="page">

  <div class="eyebrow">Book Exchange</div>
  <h1>My Sent Requests</h1>
  <div class="sub">Track and manage your outgoing book requests</div>

  <div class="stats-row">
    <div class="stat"><div class="stat-val">${totalCount}</div><div class="stat-lbl">Total sent</div></div>
    <div class="stat"><div class="stat-val amber">${pendingCount}</div><div class="stat-lbl">Awaiting reply</div></div>
    <div class="stat"><div class="stat-val green">${actionCount}</div><div class="stat-lbl">Contact seller</div></div>
    <div class="stat"><div class="stat-val red">${rejectedCount}</div><div class="stat-lbl">Rejected</div></div>
  </div>

  <%-- Alert — only when at least one accepted --%>
  <c:if test="${firstAccepted != null}">
    <div class="alert-banner">
      <div class="al-icon">
        <svg width="22" height="22" viewBox="0 0 24 24" fill="none" stroke="white" stroke-width="2">
          <path d="M22 16.92v3a2 2 0 0 1-2.18 2 19.79 19.79 0 0 1-8.63-3.07A19.5 19.5 0 0 1 4.69 9.5a19.79 19.79 0 0 1-3-8.59A2 2 0 0 1 3.59 2.5h3a2 2 0 0 1 2 1.72c.13.96.36 1.9.7 2.81a2 2 0 0 1-.45 2.11L7.91 10a16 16 0 0 0 6 6l1.27-1.27a2 2 0 0 1 2.11-.45c.91.34 1.85.57 2.81.7A2 2 0 0 1 22 16.92z"/>
        </svg>
      </div>
      <div class="al-txt">
        <div class="a1">Action needed — contact the seller!</div>
        <div class="a2">${firstAccepted.bookTitle} is confirmed. Call or WhatsApp ${firstAccepted.sellerName} to arrange delivery.</div>
      </div>
    </div>
  </c:if>

  <div class="filter-tabs">
    <a href="exchange?view=outgoing"                 class="tab ${empty param.status          ? 'active' : ''}">All (${totalCount})</a>
    <a href="exchange?view=outgoing&status=PENDING"  class="tab ${param.status eq 'PENDING'  ? 'active' : ''}">Pending (${pendingCount})</a>
    <a href="exchange?view=outgoing&status=ACCEPTED" class="tab ${param.status eq 'ACCEPTED' ? 'active' : ''}">Action needed (${actionCount})</a>
    <a href="exchange?view=outgoing&status=REJECTED" class="tab ${param.status eq 'REJECTED' ? 'active' : ''}">Rejected (${rejectedCount})</a>
  </div>

  <%-- ── SECTION 1: Accepted ── --%>
  <c:set var="hasAccepted" value="false"/>
  <c:forEach var="req" items="${requests}"><c:if test="${req.status eq 'ACCEPTED'}"><c:set var="hasAccepted" value="true"/></c:if></c:forEach>
  <c:if test="${hasAccepted}">
    <div class="section-label" style="margin-top:0">Action needed — contact seller</div>
    <c:forEach var="req" items="${requests}">
      <c:if test="${req.status eq 'ACCEPTED'}">
        <div class="req-card highlight">
          <div class="card-head">
            <div class="avatar av-teal">${fn:toUpperCase(fn:substring(req.sellerName,0,1))}${fn:toUpperCase(fn:substring(fn:substringAfter(req.sellerName,' '),0,1))}</div>
            <div class="head-info">
              <div class="head-name">${req.sellerName}</div>
              <div class="head-time">Accepted on ${req.acceptedDate}</div>
            </div>
            <span class="badge b-accepted"><span class="dot da"></span>Accepted</span>
          </div>

          <div class="book-row">
            <div class="book-spine" style="background:#0F6E56"></div>
            <div class="book-info">
              <div class="btitle">${req.bookTitle}</div>
              <div class="bauthor">${req.bookAuthor}</div>
            </div>
          </div>

          <c:if test="${not empty req.message}">
            <div class="msg-block">
              <div class="msg-label">Your message</div>
              <div class="msg-text">"${req.message}"</div>
            </div>
          </c:if>

          <hr class="divider"/>

          <div class="seller-contact-card">
            <div class="sc-label">Seller contact</div>
            <div class="sc-body">
              <div class="seller-av">${fn:toUpperCase(fn:substring(req.sellerName,0,1))}</div>
              <div class="sc-info">
                <div class="sc-name">${req.sellerName}</div>
                <div class="sc-phone">${req.sellerPhone}</div>
              </div>
            </div>
            <div class="sc-actions">
              <a href="tel:${req.sellerPhone}" class="cta-call">
                <svg width="13" height="13" viewBox="0 0 24 24" fill="none" stroke="white" stroke-width="2.5"><path d="M22 16.92v3a2 2 0 0 1-2.18 2 19.79 19.79 0 0 1-8.63-3.07A19.5 19.5 0 0 1 4.69 9.5a19.79 19.79 0 0 1-3-8.59A2 2 0 0 1 3.59 2.5h3a2 2 0 0 1 2 1.72c.13.96.36 1.9.7 2.81a2 2 0 0 1-.45 2.11L7.91 10a16 16 0 0 0 6 6l1.27-1.27a2 2 0 0 1 2.11-.45c.91.34 1.85.57 2.81.7A2 2 0 0 1 22 16.92z"/></svg>
                Call seller
              </a>
              <a href="https://wa.me/${req.sellerPhone}" target="_blank" class="cta-wa">
                <svg width="13" height="13" viewBox="0 0 24 24" fill="white"><path d="M17.472 14.382c-.297-.149-1.758-.867-2.03-.967-.273-.099-.471-.148-.67.15-.197.297-.767.966-.94 1.164-.173.199-.347.223-.644.075-.297-.15-1.255-.463-2.39-1.475-.883-.788-1.48-1.761-1.653-2.059-.173-.297-.018-.458.13-.606.134-.133.298-.347.446-.52.149-.174.198-.298.298-.497.099-.198.05-.371-.025-.52-.075-.149-.669-1.612-.916-2.207-.242-.579-.487-.5-.669-.51-.173-.008-.371-.01-.57-.01-.198 0-.52.074-.792.372-.272.297-1.04 1.016-1.04 2.479 0 1.462 1.065 2.875 1.213 3.074.149.198 2.096 3.2 5.077 4.487.709.306 1.262.489 1.694.625.712.227 1.36.195 1.871.118.571-.085 1.758-.719 2.006-1.413.248-.694.248-1.289.173-1.413-.074-.124-.272-.198-.57-.347z"/><path d="M12 2C6.477 2 2 6.477 2 12c0 1.89.525 3.66 1.438 5.168L2 22l4.968-1.422A9.956 9.956 0 0 0 12 22c5.523 0 10-4.477 10-10S17.523 2 12 2zm0 18a7.946 7.946 0 0 1-4.05-1.107l-.29-.173-3.007.861.876-2.927-.19-.3A7.96 7.96 0 0 1 4 12c0-4.418 3.582-8 8-8s8 3.582 8 8-3.582 8-8 8z"/></svg>
                WhatsApp
              </a>
              <button class="cta-copy" onclick="copyPhone('${req.sellerPhone}', this)">
                <svg width="13" height="13" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><rect x="9" y="9" width="13" height="13" rx="2"/><path d="M5 15H4a2 2 0 0 1-2-2V4a2 2 0 0 1 2-2h9a2 2 0 0 1 2 2v1"/></svg>
                Copy
              </button>
            </div>
          </div>

          <form action="exchange" method="post">
            <input type="hidden" name="action"    value="setDelivery"/>
            <input type="hidden" name="requestId" value="${req.id}"/>

            <div class="delivery-label">Choose delivery method</div>
            <div class="delivery-opts" id="dopts-${req.id}">

              <label class="d-opt ${req.deliveryMethod eq 'MEET' ? 'chosen' : ''}" onclick="pickDelivery(this)">
                <input type="radio" name="deliveryMethod" value="MEET" ${req.deliveryMethod eq 'MEET' ? 'checked' : ''} style="display:none"/>
                <div class="d-opt-icon" style="background:#E1F5EE">
                  <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="#0F6E56" stroke-width="2"><path d="M17 21v-2a4 4 0 0 0-4-4H5a4 4 0 0 0-4 4v2"/><circle cx="9" cy="7" r="4"/><path d="M23 21v-2a4 4 0 0 0-3-3.87"/><path d="M16 3.13a4 4 0 0 1 0 7.75"/></svg>
                </div>
                <div class="d-opt-name">Meet up</div>
                <div class="d-opt-desc">Exchange in person</div>
              </label>

              <label class="d-opt ${req.deliveryMethod eq 'COURIER' ? 'chosen' : ''}" onclick="pickDelivery(this)">
                <input type="radio" name="deliveryMethod" value="COURIER" ${req.deliveryMethod eq 'COURIER' ? 'checked' : ''} style="display:none"/>
                <div class="d-opt-icon" style="background:#FAEEDA">
                  <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="#854F0B" stroke-width="2"><rect x="1" y="3" width="15" height="13"/><polygon points="16 8 20 8 23 11 23 16 16 16 16 8"/><circle cx="5.5" cy="18.5" r="2.5"/><circle cx="18.5" cy="18.5" r="2.5"/></svg>
                </div>
                <div class="d-opt-name">Courier</div>
                <div class="d-opt-desc">Ship via post / courier</div>
              </label>

              <label class="d-opt ${req.deliveryMethod eq 'DOORSTEP' ? 'chosen' : ''}" onclick="pickDelivery(this)">
                <input type="radio" name="deliveryMethod" value="DOORSTEP" ${req.deliveryMethod eq 'DOORSTEP' ? 'checked' : ''} style="display:none"/>
                <div class="d-opt-icon" style="background:#E6F1FB">
                  <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="#185FA5" stroke-width="2"><path d="M3 9l9-7 9 7v11a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2z"/><polyline points="9 22 9 12 15 12 15 22"/></svg>
                </div>
                <div class="d-opt-name">Doorstep</div>
                <div class="d-opt-desc">Drop off at home</div>
              </label>

            </div>

            <div class="action-row">
              <button type="submit" class="btn-confirm" onclick="showToast('Delivery method saved!')">Confirm</button>
              <button type="button" class="btn-ghost" onclick="cancelReq(${req.id})">
                <svg width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5"><line x1="18" y1="6" x2="6" y2="18"/><line x1="6" y1="6" x2="18" y2="18"/></svg>
                Cancel request
              </button>
            </div>
          </form>
        </div>
      </c:if>
    </c:forEach>
  </c:if>

  <%-- ── SECTION 2: Pending ── --%>
  <c:set var="hasPending" value="false"/>
  <c:forEach var="req" items="${requests}"><c:if test="${req.status eq 'PENDING'}"><c:set var="hasPending" value="true"/></c:if></c:forEach>
  <c:if test="${hasPending}">
    <div class="section-label">Waiting for reply</div>
    <c:forEach var="req" items="${requests}">
      <c:if test="${req.status eq 'PENDING'}">
        <div class="req-card">
          <div class="card-head">
            <div class="avatar av-amber">${fn:toUpperCase(fn:substring(req.sellerName,0,1))}${fn:toUpperCase(fn:substring(fn:substringAfter(req.sellerName,' '),0,1))}</div>
            <div class="head-info">
              <div class="head-name">${req.sellerName}</div>
              <div class="head-time">Sent ${req.requestDate}</div>
            </div>
            <span class="badge b-pending"><span class="dot dp"></span>Pending</span>
          </div>

          <div class="book-row">
            <div class="book-spine" style="background:#BA7517"></div>
            <div class="book-info">
              <div class="btitle">${req.bookTitle}</div>
              <div class="bauthor">${req.bookAuthor}</div>
            </div>
          </div>

          <c:if test="${not empty req.message}">
            <div class="msg-block">
              <div class="msg-label">Your message</div>
              <div class="msg-text">"${req.message}"</div>
            </div>
          </c:if>

          <div class="tracker">
            <div class="tstep ts-done">
              <div class="tcircle"><svg width="11" height="11" viewBox="0 0 24 24" fill="none" stroke="white" stroke-width="3"><polyline points="20 6 9 17 4 12"/></svg></div>
              <div class="tlabel">Sent</div>
            </div>
            <div class="tline tl-done"></div>
            <div class="tstep ts-active">
              <div class="tcircle"><svg width="8" height="8" viewBox="0 0 24 24"><circle cx="12" cy="12" r="5" fill="#BA7517"/></svg></div>
              <div class="tlabel">Awaiting reply</div>
            </div>
            <div class="tline tl-idle"></div>
            <div class="tstep ts-idle"><div class="tcircle"></div><div class="tlabel">Accepted</div></div>
            <div class="tline tl-idle"></div>
            <div class="tstep ts-idle"><div class="tcircle"></div><div class="tlabel">Exchanged</div></div>
          </div>

          <div class="action-row">
            <button class="btn-ghost" onclick="cancelReq(${req.id})">
              <svg width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5"><line x1="18" y1="6" x2="6" y2="18"/><line x1="6" y1="6" x2="18" y2="18"/></svg>
              Cancel request
            </button>
          </div>
        </div>
      </c:if>
    </c:forEach>
  </c:if>

  <%-- ── SECTION 3: Rejected ── --%>
  <c:set var="hasRejected" value="false"/>
  <c:forEach var="req" items="${requests}"><c:if test="${req.status eq 'REJECTED'}"><c:set var="hasRejected" value="true"/></c:if></c:forEach>
  <c:if test="${hasRejected}">
    <div class="section-label">Closed</div>
    <c:forEach var="req" items="${requests}">
      <c:if test="${req.status eq 'REJECTED'}">
        <div class="req-card faded">
          <div class="card-head">
            <div class="avatar av-gray">${fn:toUpperCase(fn:substring(req.sellerName,0,1))}${fn:toUpperCase(fn:substring(fn:substringAfter(req.sellerName,' '),0,1))}</div>
            <div class="head-info">
              <div class="head-name">${req.sellerName}</div>
              <div class="head-time">Rejected on ${req.rejectedDate}</div>
            </div>
            <span class="badge b-rejected"><span class="dot dr"></span>Rejected</span>
          </div>
          <div class="book-row" style="opacity:.6">
            <div class="book-spine" style="background:#E24B4A"></div>
            <div class="book-info">
              <div class="btitle">${req.bookTitle}</div>
              <div class="bauthor">${req.bookAuthor}</div>
            </div>
          </div>
          <div class="reject-tag">
            <div class="rt-icon"><svg width="11" height="11" viewBox="0 0 24 24" fill="none" stroke="white" stroke-width="3"><line x1="18" y1="6" x2="6" y2="18"/><line x1="6" y1="6" x2="18" y2="18"/></svg></div>
            <div>
              <div class="rt-main">This request was not accepted</div>
              <div class="rt-sub">The owner declined your exchange offer</div>
            </div>
          </div>
        </div>
      </c:if>
    </c:forEach>
  </c:if>

  <%-- Empty state --%>
  <c:if test="${empty requests}">
    <div style="text-align:center;padding:60px 20px">
      <div style="font-size:3rem;margin-bottom:12px;opacity:.3">📭</div>
      <div style="font-family:'Playfair Display',serif;font-size:1.3rem;color:#555;margin-bottom:6px">No sent requests yet</div>
      <div style="font-size:13px;color:#aaa;margin-bottom:20px">Find a book you love and send your first request!</div>
      <a href="exchange?view=browse" style="display:inline-block;background:#0F6E56;color:#fff;padding:10px 22px;border-radius:9px;text-decoration:none;font-weight:600;font-size:13px">Browse Books</a>
    </div>
  </c:if>

</div>

<div id="toast">✓ Saved!</div>

<script>
  function pickDelivery(el) {
    el.closest('.delivery-opts').querySelectorAll('.d-opt').forEach(o => o.classList.remove('chosen'));
    el.classList.add('chosen');
    el.querySelector('input[type=radio]').checked = true;
  }

  function cancelReq(id) {
    if (!confirm('Cancel this book request?')) return;
    const f = document.createElement('form');
    f.method = 'post'; f.action = 'exchange';
    [['action','cancelRequest'],['requestId',id]].forEach(([n,v]) => {
      const i = document.createElement('input'); i.type='hidden'; i.name=n; i.value=v; f.appendChild(i);
    });
    document.body.appendChild(f); f.submit();
  }

  function copyPhone(phone, btn) {
    navigator.clipboard.writeText(phone).then(() => {
      const orig = btn.innerHTML;
      btn.textContent = 'Copied!';
      setTimeout(() => btn.innerHTML = orig, 1800);
    });
  }

  function showToast(msg) {
    const t = document.getElementById('toast');
    t.textContent = '✓ ' + msg;
    t.style.display = 'block';
    setTimeout(() => t.style.display = 'none', 2800);
  }
</script>
</body>
</html>
