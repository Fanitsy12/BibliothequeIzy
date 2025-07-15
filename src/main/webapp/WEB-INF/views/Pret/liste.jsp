<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <title>Liste des prêts - Café Littéraire</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <script src="https://cdn.tailwindcss.com"></script>
    <script>
        tailwind.config = {
            theme: {
                extend: {
                    colors: {
                        'vert-fonce': '#2c5545',
                        'vert-moyen': '#3a7d5d',
                        'vert-clair': '#7eb693',
                        'vert-pale': '#e8f5e9',
                        'beige': '#f5f5dc',
                        'accent': '#ff9f1c',
                        'error': '#d32f2f',
                    },
                    animation: {
                        'fade-in': 'fadeIn 0.5s ease-out',
                    },
                    keyframes: {
                        fadeIn: {
                            '0%': { opacity: '0' },
                            '100%': { opacity: '1' }
                        }
                    }
                }
            }
        }
    </script>
    <style>
        .status-badge {
            @apply px-2 py-1 rounded-full text-xs font-medium;
        }
        .status-rendu {
            @apply bg-green-100 text-green-800;
        }
        .status-prolonge {
            @apply bg-gray-100 text-gray-800;
        }
        .status-encours {
            @apply bg-orange-100 text-orange-800;
        }
        .action-btn {
            @apply px-3 py-1 rounded-md text-sm font-medium transition-all;
        }
        .btn-rendre {
            @apply bg-vert-moyen hover:bg-vert-fonce text-white;
        }
        .btn-prolonger {
            @apply bg-accent hover:bg-opacity-90 text-white;
        }
        .btn-valider {
            @apply bg-green-600 hover:bg-green-700 text-white;
        }
    </style>
</head>
<body class="bg-vert-pale min-h-screen p-4 md:p-8">
    <div class="max-w-7xl mx-auto animate-fade-in">
        <!-- Header -->
        <div class="flex flex-col md:flex-row justify-between items-start md:items-end mb-8">
            <div>
                <h1 class="text-3xl font-bold text-vert-fonce mb-2">
                    <i class="fas fa-bookmark mr-3"></i>
                    <c:choose>
                        <c:when test="${affichageParAdherent}">Mes prêts</c:when>
                        <c:otherwise>Gestion des prêts</c:otherwise>
                    </c:choose>
                </h1>
                <p class="text-vert-moyen">Suivi des emprunts du Café Littéraire</p>
            </div>
            
            <c:if test="${not affichageParAdherent}">
                <div class="flex gap-3 mt-4 md:mt-0">
                    <a href="${pageContext.request.contextPath}/prets/add?type=sur_place" 
                       class="flex items-center bg-vert-moyen hover:bg-vert-fonce text-white px-4 py-2 rounded-lg transition shadow-md">
                        <i class="fas fa-plus mr-2"></i> Prêt sur place
                    </a>
                    <a href="${pageContext.request.contextPath}/prets/add?type=a_domicile" 
                       class="flex items-center bg-accent hover:bg-opacity-90 text-white px-4 py-2 rounded-lg transition shadow-md">
                        <i class="fas fa-plus mr-2"></i> Prêt à domicile
                    </a>
                </div>
            </c:if>
        </div>

        <!-- Tableau des prêts -->
        <div class="bg-white rounded-xl shadow-md overflow-hidden mb-8">
            <div class="overflow-x-auto">
                <table class="min-w-full divide-y divide-gray-200">
                    <thead class="bg-vert-fonce text-white">
                        <tr>
                            <c:if test="${not affichageParAdherent}">
                                <th scope="col" class="px-6 py-3 text-left text-xs font-medium uppercase tracking-wider">
                                    <i class="fas fa-user mr-1"></i> Adhérent
                                </th>
                            </c:if>
                            <th scope="col" class="px-6 py-3 text-left text-xs font-medium uppercase tracking-wider">
                                <i class="fas fa-book mr-1"></i> Livre
                            </th>
                            <th scope="col" class="px-6 py-3 text-left text-xs font-medium uppercase tracking-wider">
                                <i class="fas fa-barcode mr-1"></i> Exemplaire
                            </th>
                            <th scope="col" class="px-6 py-3 text-left text-xs font-medium uppercase tracking-wider">
                                <i class="fas fa-calendar-day mr-1"></i> Date Emprunt
                            </th>
                            <th scope="col" class="px-6 py-3 text-left text-xs font-medium uppercase tracking-wider">
                                <i class="fas fa-calendar-check mr-1"></i> Date Retour Prévue
                            </th>
                            <th scope="col" class="px-6 py-3 text-left text-xs font-medium uppercase tracking-wider">
                                <i class="fas fa-tag mr-1"></i> Type
                            </th>
                            <th scope="col" class="px-6 py-3 text-left text-xs font-medium uppercase tracking-wider">
                                <i class="fas fa-info-circle mr-1"></i> Statut
                            </th>
                            <th scope="col" class="px-6 py-3 text-right text-xs font-medium uppercase tracking-wider">
                                <i class="fas fa-cog mr-1"></i> Actions
                            </th>
                        </tr>
                    </thead>
                    <tbody class="bg-white divide-y divide-gray-200">
                        <c:forEach var="pret" items="${prets}">
                            <tr class="hover:bg-vert-pale transition">
                                <c:if test="${not affichageParAdherent}">
                                    <td class="px-6 py-4 whitespace-nowrap">
                                        <div class="flex items-center">
                                            <div class="flex-shrink-0 h-10 w-10 rounded-full bg-vert-pale flex items-center justify-center">
                                                <i class="fas fa-user text-vert-moyen"></i>
                                            </div>
                                            <div class="ml-4">
                                                <div class="text-sm font-medium text-gray-900">
                                                    ${pret.adherent.nom} ${pret.adherent.prenom}
                                                </div>
                                                <div class="text-sm text-gray-500">
                                                    ${pret.adherent.email}
                                                </div>
                                            </div>
                                        </div>
                                    </td>
                                </c:if>
                                <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900">
                                    ${pret.exemplaireLivre.livre.titre}
                                </td>
                                <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">
                                    ${pret.exemplaireLivre.codeBarre}
                                </td>
                                <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">
                                    ${pret.dateEmprunt}
                                </td>
                                <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">
                                    ${pret.dateRenduPrevue}
                                </td>
                                <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">
                                    <c:choose>
                                        <c:when test="${pret.typePret == 'a_domicile'}">
                                            <span class="px-2 py-1 rounded-full text-xs font-medium bg-blue-100 text-blue-800">
                                                À domicile
                                            </span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="px-2 py-1 rounded-full text-xs font-medium bg-purple-100 text-purple-800">
                                                Sur place
                                            </span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td class="px-6 py-4 whitespace-nowrap">
                                    <c:choose>
                                        <c:when test="${not empty pret.dateRendu}">
                                            <span class="status-badge status-rendu">
                                                <i class="fas fa-check-circle mr-1"></i> Rendu
                                            </span>
                                        </c:when>
                                        <c:when test="${pret.isProlonged}">
                                            <span class="status-badge status-prolonge">
                                                <i class="fas fa-clock mr-1"></i> Prolongé
                                            </span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="status-badge status-encours">
                                                <i class="fas fa-hourglass-half mr-1"></i> En cours
                                            </span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td class="px-6 py-4 whitespace-nowrap text-right text-sm font-medium">
                                    <c:if test="${empty pret.dateRendu and not pret.isProlonged and not affichageParAdherent}">
                                        <form action="${pageContext.request.contextPath}/prets/rendre/${pret.idPret}" method="get" class="inline">
                                            <button type="submit" class="action-btn btn-rendre">
                                                <i class="fas fa-book mr-1"></i> Rendre
                                            </button>
                                        </form>
                                    </c:if>
                                    <c:if test="${empty pret.dateRendu and affichageParAdherent and not pret.isProlonged}">
                                        <form action="${pageContext.request.contextPath}/prets/prolonger/${pret.idPret}" method="get" class="inline">
                                            <button type="submit" class="action-btn btn-prolonger">
                                                <i class="fas fa-calendar-plus mr-1"></i> Prolonger
                                            </button>
                                        </form>
                                    </c:if>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>

        <!-- Demandes de prolongation (admin seulement) -->
        <c:if test="${not affichageParAdherent and not empty demandes}">
            <div class="bg-white rounded-xl shadow-md overflow-hidden">
                <div class="px-6 py-4 border-b border-gray-200">
                    <h2 class="text-xl font-semibold text-vert-fonce flex items-center">
                        <i class="fas fa-clock mr-3 text-accent"></i> Demandes de prolongation en attente
                    </h2>
                </div>
                <div class="overflow-x-auto">
                    <table class="min-w-full divide-y divide-gray-200">
                        <thead class="bg-vert-fonce text-white">
                            <tr>
                                <th scope="col" class="px-6 py-3 text-left text-xs font-medium uppercase tracking-wider">
                                    <i class="fas fa-hashtag mr-1"></i> Prêt
                                </th>
                                <th scope="col" class="px-6 py-3 text-left text-xs font-medium uppercase tracking-wider">
                                    <i class="fas fa-user mr-1"></i> Adhérent
                                </th>
                                <th scope="col" class="px-6 py-3 text-left text-xs font-medium uppercase tracking-wider">
                                    <i class="fas fa-calendar-plus mr-1"></i> Jours demandés
                                </th>
                                <th scope="col" class="px-6 py-3 text-right text-xs font-medium uppercase tracking-wider">
                                    <i class="fas fa-cog mr-1"></i> Action
                                </th>
                            </tr>
                        </thead>
                        <tbody class="bg-white divide-y divide-gray-200">
                            <c:forEach var="demande" items="${demandes}">
                                <tr class="hover:bg-vert-pale transition">
                                    <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900">
                                        #${demande.pret.idPret}
                                    </td>
                                    <td class="px-6 py-4 whitespace-nowrap">
                                        <div class="flex items-center">
                                            <div class="flex-shrink-0 h-10 w-10 rounded-full bg-vert-pale flex items-center justify-center">
                                                <i class="fas fa-user text-vert-moyen"></i>
                                            </div>
                                            <div class="ml-4">
                                                <div class="text-sm font-medium text-gray-900">
                                                    ${demande.pret.adherent.nom} ${demande.pret.adherent.prenom}
                                                </div>
                                                <div class="text-sm text-gray-500">
                                                    ${demande.pret.exemplaireLivre.livre.titre}
                                                </div>
                                            </div>
                                        </div>
                                    </td>
                                    <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">
                                        ${demande.jourProlongement} jours
                                    </td>
                                    <td class="px-6 py-4 whitespace-nowrap text-right text-sm font-medium">
                                        <form action="${pageContext.request.contextPath}/prets/prolongements/valider/${demande.idProlongement}" method="post" class="inline">
                                            <button type="submit" class="action-btn btn-valider">
                                                <i class="fas fa-check mr-1"></i> Valider
                                            </button>
                                        </form>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </c:if>
    </div>
</body>
</html>