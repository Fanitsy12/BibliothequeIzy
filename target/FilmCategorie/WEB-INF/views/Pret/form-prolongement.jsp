<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:if test="${not empty errorMessage}">
    <div class="error-message">${errorMessage}</div>
</c:if>
<h2>Demande de prolongation</h2>
<form method="post" action="${pageContext.request.contextPath}/prets/demander">
    <input type="hidden" name="idPret" value="${idPret}" />
    <label>Nombre de jours (max 15) :</label>
    <input type="number" name="jours" min="1" max="15" required />
    <button type="submit">Envoyer</button>
</form>
