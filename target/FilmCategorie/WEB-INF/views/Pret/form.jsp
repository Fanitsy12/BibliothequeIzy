<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<style>
    :root {
        --cafe-creme: #fef6f0;
        --cafe-text: #4e342e;
        --cafe-button: #a1887f;
        --cafe-accent: #ff7043;
        --cafe-error: #d32f2f;
    }

    body {
        background-color: var(--cafe-creme);
        color: var(--cafe-text);
        font-family: 'Georgia', serif;
        padding: 20px;
    }

    form {
        max-width: 600px;
        margin: 0 auto;
        background-color: white;
        padding: 2rem;
        border-radius: 8px;
        box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
    }

    label {
        display: block;
        margin-bottom: 0.5rem;
        font-weight: 500;
        color: var(--cafe-text);
    }

    select, input[type="number"], input[type="submit"] {
        width: 100%;
        padding: 0.6rem 1rem;
        margin-bottom: 1.5rem;
        border: 1px solid var(--cafe-button);
        border-radius: 4px;
        background-color: white;
        font-family: 'Georgia', serif;
    }

    select:focus, input[type="number"]:focus {
        outline: none;
        border-color: var(--cafe-accent);
        box-shadow: 0 0 0 2px rgba(255, 112, 67, 0.25);
    }

    input[type="submit"] {
        background-color: var(--cafe-button);
        color: white;
        border: none;
        cursor: pointer;
        font-weight: 500;
        transition: all 0.3s ease;
        margin-top: 1rem;
    }

    input[type="submit"]:hover {
        background-color: var(--cafe-accent);
        transform: translateY(-2px);
    }

    .error-message {
        color: var(--cafe-error);
        background-color: rgba(211, 47, 47, 0.1);
        padding: 0.75rem 1rem;
        border-radius: 4px;
        margin-bottom: 1.5rem;
        border-left: 3px solid var(--cafe-error);
    }

    .hidden-selects {
        display: none;
    }
</style>

<c:if test="${not empty errorMessage}">
    <div class="error-message">${errorMessage}</div>
</c:if>

<form method="post" action="${pageContext.request.contextPath}/prets/save">
    <input type="hidden" name="typePret" value="${typePret}" />

    <label>Adhérent :</label>
    <select name="adherentId" required>
        <option value="">-- Sélectionner un adhérent --</option>
        <c:forEach var="adherent" items="${adherents}">
            <option value="${adherent.idAdherent}">${adherent.nom} ${adherent.prenom}</option>
        </c:forEach>
    </select>

    <label>Livre :</label>
    <select id="livreSelect" name="livreId" required>
        <option value="">-- Sélectionner un livre --</option>
        <c:forEach var="livre" items="${livres}">
            <option value="${livre.idLivre}">${livre.titre}</option>
        </c:forEach>
    </select>

    <label>Exemplaire :</label>
    <select id="exemplaireSelect" name="exemplaireId" required>
        <option value="">-- Sélectionner un exemplaire --</option>
    </select>

    <!-- Caché : pour chaque livre, on crée un <select> d'exemplaires -->
    <div class="hidden-selects">
        <c:forEach var="livre" items="${livres}">
            <select id="exemplaires-for-livre-${livre.idLivre}">
                <c:forEach var="exemplaire" items="${livre.exemplaires}">
                    <option value="${exemplaire.idExemplaireLivre}">${exemplaire.codeBarre}</option>
                </c:forEach>
            </select>
        </c:forEach>
    </div>
    <div>
    <label>Date du prêt :</label>
        <input type="date" name="datePret" required />
        </div>

    <c:if test="${typePret == 'a_domicile'}">
        <label>Nombre de jours (1 à 15) :</label>
        <input type="number" name="joursPret" min="1" max="15" value="1" required />
    </c:if>

    <input type="submit" value="Enregistrer le prêt" />
</form>

<script>
    document.getElementById('livreSelect').addEventListener('change', function() {
        const livreId = this.value;
        const exemplaireSelect = document.getElementById('exemplaireSelect');

        // Vider la liste actuelle
        exemplaireSelect.innerHTML = '<option value="">-- Sélectionner un exemplaire --</option>';

        if (!livreId) return;

        // Trouver la liste cachée correspondante
        const hiddenSelect = document.getElementById('exemplaires-for-livre-' + livreId);
        if (!hiddenSelect) return;

        // Copier les options de la liste cachée dans la liste visible
        for (let option of hiddenSelect.options) {
            exemplaireSelect.appendChild(option.cloneNode(true));
        }
    });
</script>
