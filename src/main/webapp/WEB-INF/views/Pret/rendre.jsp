<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <title>Rendre un prêt - Café Littéraire</title>
    <style>
        :root {
            --cafe-creme: #fef6f0;
            --cafe-text: #4e342e;
            --cafe-button: #a1887f;
            --cafe-accent: #ff7043;
            --cafe-border: #d7ccc8;
            --cafe-error: #d32f2f;
        }

        body {
            background-color: var(--cafe-creme);
            color: var(--cafe-text);
            font-family: 'Georgia', serif;
            padding: 2rem;
            max-width: 600px;
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
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
            margin-bottom: 1.5rem;
        }

        label {
            display: block;
            margin-bottom: 0.8rem;
            font-weight: 500;
            color: var(--cafe-text);
        }

        input[type="date"] {
            width: 100%;
            padding: 0.7rem;
            border: 1px solid var(--cafe-border);
            border-radius: 4px;
            font-family: 'Georgia', serif;
            margin-bottom: 1.5rem;
        }

        input[type="date"]:focus {
            outline: none;
            border-color: var(--cafe-accent);
            box-shadow: 0 0 0 2px rgba(255, 112, 67, 0.2);
        }

        input[type="submit"] {
            background-color: var(--cafe-button);
            color: white;
            border: none;
            padding: 0.8rem 1.8rem;
            border-radius: 4px;
            font-family: 'Georgia', serif;
            font-size: 1rem;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        input[type="submit"]:hover {
            background-color: var(--cafe-accent);
            transform: translateY(-2px);
        }

        a {
            color: var(--cafe-accent);
            text-decoration: none;
            display: inline-block;
            margin-top: 1rem;
            padding: 0.6rem 1.2rem;
            border: 1px solid var(--cafe-accent);
            border-radius: 4px;
            transition: all 0.3s ease;
        }

        a:hover {
            background-color: rgba(255, 112, 67, 0.1);
            text-decoration: none;
        }

        .book-title {
            font-style: italic;
            color: var(--cafe-accent);
        }
    </style>
</head>
<c:if test="${not empty errorMessage}">
    <div class="error-message">${errorMessage}</div>
</c:if>
<body>
<h2>Rendre le prêt de <span class="book-title">${pret.exemplaireLivre.livre.titre}</span></h2>

<form action="${pageContext.request.contextPath}/prets/rendre" method="post">
    <input type="hidden" name="idPret" value="${pret.idPret}" />

    <label for="dateRendu">Date de rendu :</label>
    <input type="date" id="dateRendu" name="dateRendu"
           value="${dateRendu}"  />"
           required />

    <div style="text-align: right;">
        <input type="submit" value="Confirmer le rendu" />
    </div>
</form>

<a href="${pageContext.request.contextPath}/prets/liste">
    <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" viewBox="0 0 16 16" style="margin-right: 8px;">
        <path fill-rule="evenodd" d="M15 8a.5.5 0 0 0-.5-.5H2.707l3.147-3.146a.5.5 0 1 0-.708-.708l-4 4a.5.5 0 0 0 0 .708l4 4a.5.5 0 0 0 .708-.708L2.707 8.5H14.5A.5.5 0 0 0 15 8z"/>
    </svg>
    Annuler et retourner à la liste
</a>
</body>
</html>
