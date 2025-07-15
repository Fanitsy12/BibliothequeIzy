<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Liste des Profils - Café Littéraire</title>
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
            padding: 20px;
        }

        h2 {
            color: var(--cafe-text);
            text-align: center;
            border-bottom: 2px solid var(--cafe-button);
            padding-bottom: 10px;
            margin-bottom: 20px;
        }

        table {
            border-collapse: collapse;
            width: 90%;
            margin: 20px auto;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
        }

        th {
            background-color: var(--cafe-button);
            color: white;
            padding: 12px;
            text-align: center;
        }

        td {
            border-bottom: 1px solid var(--cafe-border);
            padding: 10px;
            text-align: center;
        }

        tr:nth-child(even) {
            background-color: rgba(255,255,255,0.7);
        }

        tr:hover {
            background-color: rgba(255, 112, 67, 0.1);
        }

        .btn-ajout {
            display: inline-block;
            margin: 20px;
            padding: 10px 15px;
            background-color: var(--cafe-button);
            color: white;
            text-decoration: none;
            border-radius: 4px;
            transition: all 0.3s ease;
            font-weight: 500;
        }

        .btn-ajout:hover {
            background-color: var(--cafe-accent);
            transform: translateY(-2px);
        }

        .action-link {
            color: var(--cafe-accent);
            margin: 0 8px;
            padding: 2px 5px;
            transition: all 0.2s ease;
        }

        .action-link:hover {
            text-decoration: underline;
            color: var(--cafe-error);
        }

        .container {
            max-width: 1200px;
            margin: 0 auto;
            text-align: center;
        }
    </style>
</head>
<body>

<div class="container">
    <h2>Liste des Profils</h2>

    <a class="btn-ajout" href="${pageContext.request.contextPath}/profils/add">
        <i class="fas fa-plus"></i> Ajouter un nouveau profil
    </a>

    <table>
        <thead>
            <tr>
                <th>ID</th>
                <th>Nom</th>
                <th>Quota sur place</th>
                <th>Quota emprunt</th>
                <th>Durée prêt (jours)</th>
                <th>Durée pénalité (jours)</th>
                <th>Actions</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="profil" items="${profils}">
                <tr>
                    <td>${profil.idProfil}</td>
                    <td>${profil.nomProfil}</td>
                    <td>${profil.quotaMaxSurPlace}</td>
                    <td>${profil.quotaMaxEmprunter}</td>
                    <td>${profil.dureePret}</td>
                    <td>${profil.dureePenalite}</td>
                    <td>
                        <a class="action-link" href="${pageContext.request.contextPath}/profils/update/${profil.idProfil}">Modifier</a>
                        <span>|</span>
                        <a class="action-link" href="${pageContext.request.contextPath}/profils/delete/${profil.idProfil}"
                           onclick="return confirm('Êtes-vous sûr de vouloir supprimer ce profil ?')">Supprimer</a>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
</div>

<!-- Pour les icônes Font Awesome -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">

<script>
    // Confirmation améliorée pour la suppression
    document.querySelectorAll('a[onclick]').forEach(link => {
        link.addEventListener('click', function(e) {
            if(!confirm(this.getAttribute('data-confirm') || 'Êtes-vous sûr ?')) {
                e.preventDefault();
            }
        });
    });
</script>

</body>
</html>
