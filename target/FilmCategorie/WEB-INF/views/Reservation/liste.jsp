<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<h2>Liste des réservations</h2>

<table border="1" cellpadding="8">
    <tr>
        <th>ID</th>
        <th>Adhérent</th>
        <th>Livre</th>
        <th>Exemplaire</th>
        <th>Date début</th>
        <th>Date Fin</th>
        <th>Statut</th>
        <th>Action</th>
    </tr>
    <c:forEach var="r" items="${reservations}">
        <tr>
            <td>${r.idReservation}</td>
            <td>${r.adherent.nom} ${r.adherent.prenom}</td>
            <td>${r.livre.titre}</td>
            <td>${r.exemplaireLivre.codeBarre}</td>
            <td>${r.dateDebutReservation}</td>
            <td>${r.dateFinReservation}</td>
            <td>
                <c:choose>
                    <c:when test="${r.isApproved}">
                        <span style="color:green;">Validée</span>
                    </c:when>
                    <c:otherwise>
                        <span style="color:orange;">En attente</span>
                    </c:otherwise>
                </c:choose>
            </td>
            <td>
                <c:if test="${not r.isApproved}">
                    <form method="post" action="${pageContext.request.contextPath}/reservations/valider/${r.idReservation}">
                        <input type="submit" value="Valider" />
                    </form>
                </c:if>
            </td>
        </tr>
    </c:forEach>
</table>
