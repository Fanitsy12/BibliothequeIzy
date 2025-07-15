<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <title>Liste des prêts - Café Littéraire</title>
    <style>
        body {
            background-color: #fef6f0;
            color: #4e342e;
            font-family: 'Georgia', serif;
            margin: 0;
            padding: 20px;
        }

        h2 {
            color: #4e342e;
            border-bottom: 2px solid #a1887f;
            padding-bottom: 5px;
        }

        a {
            color: #ff7043;
            text-decoration: none;
            margin: 0 10px;
            font-weight: bold;
        }

        a:hover {
            text-decoration: underline;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }

        th {
            background-color: #a1887f;
            color: white;
            padding: 12px;
            text-align: left;
        }

        td {
            padding: 10px;
            border-bottom: 1px solid #d7ccc8;
        }

        tr:hover {
            background-color: rgba(255, 112, 67, 0.1);
        }

        input[type="submit"] {
            background-color: #a1887f;
            color: white;
            border: none;
            padding: 6px 12px;
            border-radius: 3px;
            cursor: pointer;
            transition: background-color 0.3s;
            font-family: 'Georgia', serif;
        }

        input[type="submit"]:hover {
            background-color: #ff7043;
        }

        .rendu {
            color: #2e7d32;
            font-weight: bold;
        }
         .prolonge {
            color: gray;
            font-weight: bold;
        }


        .en-cours {
            color: #ff7043;
            font-weight: bold;
        }
    </style>

</head>
<c:if test="${not empty errorMessage}">
    <div class="error-message">${errorMessage}</div>
</c:if>

<body>
<h2>
    <c:choose>
        <c:when test="${affichageParAdherent}">
            Mes prêts
        </c:when>
        <c:otherwise>
            Liste des prêts (admin)
        </c:otherwise>
    </c:choose>
</h2>

<c:if test="${not affichageParAdherent}">
    <div style="margin-bottom: 20px;">
        <a href="${pageContext.request.contextPath}/prets/add?type=sur_place">Créer prêt sur place</a>
        <a href="${pageContext.request.contextPath}/prets/add?type=a_domicile">Créer prêt à domicile</a>
    </div>
</c:if>

<table>
    <thead>
        <tr>
            <c:if test="${not affichageParAdherent}">
        <th>Adhérent</th>
    </c:if>
            <th>Livre</th>
            <th>Exemplaire</th>
            <th>Date Emprunt</th>
            <th>Date Rendu Prévue</th>
            <th>Type</th>
            <th>Status rendu</th>
            <th>Actions</th>
        </tr>
    </thead>
    <tbody>
        <c:forEach var="pret" items="${prets}">
            <tr>
               <c:if test="${not affichageParAdherent}">
    <td>${pret.adherent.nom} ${pret.adherent.prenom}</td>
</c:if>
                <td>${pret.exemplaireLivre.livre.titre}</td>
                <td>${pret.exemplaireLivre.codeBarre}</td>
         <td>${pret.dateEmprunt}</td>
                <td>${pret.dateRenduPrevue}</td>
                <td>${pret.typePret}</td>
                <td>
                    <c:choose>
                        <c:when test="${not empty pret.dateRendu}">
                            <span class="rendu">Rendu</span>
                        </c:when>
                          <c:when test="${ pret.isProlonged}">
                            <span class="prolonge">Prolongé</span>
                        </c:when>
                        <c:otherwise>
                            <span class="en-cours">En cours</span>
                        </c:otherwise>
                    </c:choose>
                </td>
                <td>
                    <c:if test="${empty pret.dateRendu  and not pret.isProlonged and not affichageParAdherent}">
                        <form action="${pageContext.request.contextPath}/prets/rendre/${pret.idPret}" method="get" style="display:inline;">
                            <input type="submit" value="Rendre" />
                        </form>
                         </c:if>
                           <c:if test="${empty pret.dateRendu and  affichageParAdherent and not pret.isProlonged}">
                        <form action="${pageContext.request.contextPath}/prets/prolonger/${pret.idPret}" method="get" style="display:inline;">
                            <input type="submit" value="Prolonger" />
                        </form>
                        </c:if>

                </td>
            </tr>
        </c:forEach>
    </tbody>
</table>
      <c:if test="${ not affichageParAdherent}">
<h2>Demandes de prolongation en attente</h2>
<table>
    <thead>
        <tr>
            <th>Prêt</th>
            <th>Adhérent</th>
            <th>Jours demandés</th>
            <th>Action</th>
        </tr>
    </thead>
    <tbody>
        <c:forEach var="demande" items="${demandes}">
            <tr>
                <td>#${demande.pret.idPret}</td>
                <td>${demande.pret.adherent.nom} ${demande.pret.adherent.prenom}</td>
                <td>${demande.jourProlongement}</td>
                <td>
                    <form action="${pageContext.request.contextPath}/prets/prolongements/valider/${demande.idProlongement}" method="post">
                        <button type="submit">Valider</button>
                    </form>
                </td>
            </tr>
        </c:forEach>
    </tbody>
</table>
  </c:if>
</body>
</html>
