<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<style>
    :root {
        --cafe-creme: #fef6f0;
        --cafe-text: #4e342e;
        --cafe-button: #a1887f;
        --cafe-accent: #ff7043;
        --cafe-border: #d7ccc8;
        --cafe-table-header: #a1887f;
        --cafe-error: #d32f2f;
    }

    body {
        background-color: var(--cafe-creme);
        color: var(--cafe-text);
        font-family: 'Georgia', serif;
        padding: 2rem;
        max-width: 1000px;
        margin: 0 auto;
    }

    h2 {
        color: var(--cafe-text);
        border-bottom: 2px solid var(--cafe-button);
        padding-bottom: 0.5rem;
        margin-bottom: 1.5rem;
    }

    table {
        width: 100%;
        border-collapse: collapse;
        margin-top: 1.5rem;
        box-shadow: 0 2px 8px rgba(0,0,0,0.1);
    }

    th {
        background-color: var(--cafe-table-header);
        color: white;
        padding: 1rem;
        text-align: left;
        font-weight: 500;
    }

    td {
        padding: 0.8rem 1rem;
        border-bottom: 1px solid var(--cafe-border);
    }

    tr:nth-child(even) {
        background-color: rgba(255,255,255,0.7);
    }

    tr:hover {
        background-color: rgba(255, 112, 67, 0.1);
    }

    .date-cell {
        white-space: nowrap;
    }

    .active-penalty {
        background-color: rgba(211, 47, 47, 0.05);
    }

    .active-penalty td {
        color: var(--cafe-error);
        font-weight: 500;
    }
</style>

<h2>Liste des pénalités</h2>

<table>
    <thead>
        <tr>
            <th>Adhérent</th>
            <th>Date début</th>
            <th>Date levée</th>
            <th>Prêt lié</th>
        </tr>
    </thead>
    <tbody>
        <c:forEach var="p" items="${penalites}">
            <tr class="${empty p.datelevePenalite ? 'active-penalty' : ''}">
                <td>${p.adherent.nom} ${p.adherent.prenom}</td>
                <td class="date-cell">${p.dateDebutPenalite}</td>
                <td class="date-cell">
                    <c:choose>
                        <c:when test="${not empty p.datelevePenalite}">
                            <${p.datelevePenalite}"/>
                        </c:when>
                        <c:otherwise>
                            <span style="color: var(--cafe-error);">En cours</span>
                        </c:otherwise>
                    </c:choose>
                </td>
                <td>
                    <c:if test="${not empty p.pret}">
                        <a href="${pageContext.request.contextPath}/prets/${p.pret.idPret}"
                           style="color: var(--cafe-accent); text-decoration: none;">
                            ${p.pret.idPret}
                        </a>
                    </c:if>
                </td>
                  <td>
                            <c:if test="${not p.leve}">
                                <form action="${pageContext.request.contextPath}/penalites/lever/${p.idPenalite}" method="post">
                                    <input type="submit" value="Lever la pénalité" />
                                </form>
                            </c:if>

                            <c:if test="${p.leve}">
                                Levée
                            </c:if>
                        </td>

            </tr>
        </c:forEach>
    </tbody>
</table>
