<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title><c:choose>
        <c:when test="${profil.idProfil != null}">Modifier un profil</c:when>
        <c:otherwise>Ajouter un profil</c:otherwise>
    </c:choose> - Café Littéraire</title>
    <style>
        :root {
            --cafe-creme: #fef6f0;
            --cafe-text: #4e342e;
            --cafe-button: #a1887f;
            --cafe-accent: #ff7043;
            --cafe-error: #d32f2f;
            --cafe-border: #d7ccc8;
        }

        body {
            background-color: var(--cafe-creme);
            color: var(--cafe-text);
            font-family: 'Georgia', serif;
            padding: 2rem;
            max-width: 800px;
            margin: 0 auto;
        }

        h2 {
            color: var(--cafe-text);
            border-bottom: 2px solid var(--cafe-button);
            padding-bottom: 0.5rem;
            margin-bottom: 1.5rem;
        }

        form {
            background-color: white;
            padding: 2rem;
            border-radius: 8px;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
        }

        label {
            display: block;
            margin-top: 1.2rem;
            margin-bottom: 0.5rem;
            font-weight: 500;
            color: var(--cafe-text);
        }

        input[type="text"],
        input[type="number"] {
            width: 100%;
            padding: 0.7rem;
            border: 1px solid var(--cafe-border);
            border-radius: 4px;
            font-family: 'Georgia', serif;
            transition: border-color 0.3s;
        }

        input[type="text"]:focus,
        input[type="number"]:focus {
            outline: none;
            border-color: var(--cafe-accent);
            box-shadow: 0 0 0 2px rgba(255, 112, 67, 0.2);
        }

        button {
            background-color: var(--cafe-button);
            color: white;
            border: none;
            padding: 0.7rem 1.5rem;
            border-radius: 4px;
            font-family: 'Georgia', serif;
            font-size: 1rem;
            cursor: pointer;
            margin-top: 1.5rem;
            transition: all 0.3s ease;
        }

        button:hover {
            background-color: var(--cafe-accent);
            transform: translateY(-2px);
        }

        a {
            color: var(--cafe-accent);
            text-decoration: none;
            display: inline-block;
            margin-top: 1.5rem;
        }

        a:hover {
            text-decoration: underline;
        }

        .required-field::after {
            content: " *";
            color: var(--cafe-error);
        }
    </style>
</head>
<body>

<h2>
    <c:choose>
        <c:when test="${profil.idProfil != null}">Modifier un profil</c:when>
        <c:otherwise>Ajouter un nouveau profil</c:otherwise>
    </c:choose>
</h2>

<form method="post" action="${pageContext.request.contextPath}/profils/create">
    <!-- Champ ID caché (présent seulement en mode édition) -->
    <c:if test="${profil.idProfil != null}">
        <input type="hidden" name="id" value="${profil.idProfil}" />
    </c:if>

    <label for="nomProfil" class="required-field">Nom du profil :</label>
    <input type="text" id="nomProfil" name="nomProfil" value="${profil.nomProfil}" required />

    <label for="quotaMaxSurPlace" class="required-field">Quota max sur place :</label>
    <input type="number" id="quotaMaxSurPlace" name="quotaMaxSurPlace"
           value="${profil.quotaMaxSurPlace}" min="0" required />

    <label for="quotaMaxEmprunter">Quota max à emprunter :</label>
    <input type="number" id="quotaMaxEmprunter" name="quotaMaxEmprunter"
           value="${profil.quotaMaxEmprunter}" min="0" />

    <label for="dureePret" class="required-field">Durée de prêt (jours) :</label>
    <input type="number" id="dureePret" name="dureePret"
           value="${profil.dureePret}" min="1" required />

    <label for="dureePenalite">Durée pénalité (jours) :</label>
    <input type="number" id="dureePenalite" name="dureePenalite"
           value="${profil.dureePenalite != null ? profil.dureePenalite : 0}" min="0" />

    <button type="submit">
        <c:choose>
            <c:when test="${profil.idProfil != null}">Mettre à jour</c:when>
            <c:otherwise>Créer</c:otherwise>
        </c:choose>
    </button>
</form>

<p><a href="${pageContext.request.contextPath}/profils">⬅ Retour à la liste des profils</a></p>

</body>
</html>
