<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <title>Liste des pénalités - Café Littéraire</title>
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
        .penalty-row {
            transition: all 0.2s ease;
        }
        .penalty-row:hover {
            transform: translateX(4px);
        }
    </style>
</head>
<body class="bg-vert-pale min-h-screen p-4 md:p-8">
    <div class="max-w-6xl mx-auto animate-fade-in">
        <!-- Header -->
        <div class="flex flex-col md:flex-row justify-between items-start md:items-end mb-8">
            <div>
                <h1 class="text-3xl font-bold text-vert-fonce mb-2">
                    <i class="fas fa-ban mr-3"></i>Gestion des Pénalités
                </h1>
                <p class="text-vert-moyen">Suivi des restrictions appliquées aux adhérents</p>
            </div>
            <div class="mt-4 md:mt-0">
                <span class="inline-flex items-center px-3 py-1 rounded-full text-sm font-medium bg-red-100 text-red-800">
                    <i class="fas fa-exclamation-triangle mr-1"></i>
                    ${penalites.stream().filter(p -> empty p.datelevePenalite).count()} pénalité(s) active(s)
                </span>
            </div>
        </div>

        <!-- Tableau des pénalités -->
        <div class="bg-white rounded-xl shadow-md overflow-hidden">
            <div class="overflow-x-auto">
                <table class="min-w-full divide-y divide-gray-200">
                    <thead class="bg-vert-fonce text-white">
                        <tr>
                            <th scope="col" class="px-6 py-3 text-left text-xs font-medium uppercase tracking-wider">
                                <i class="fas fa-user mr-1"></i> Adhérent
                            </th>
                            <th scope="col" class="px-6 py-3 text-left text-xs font-medium uppercase tracking-wider">
                                <i class="fas fa-calendar-day mr-1"></i> Date début
                            </th>
                            <th scope="col" class="px-6 py-3 text-left text-xs font-medium uppercase tracking-wider">
                                <i class="fas fa-calendar-check mr-1"></i> Date levée
                            </th>
                            <th scope="col" class="px-6 py-3 text-left text-xs font-medium uppercase tracking-wider">
                                <i class="fas fa-book mr-1"></i> Prêt lié
                            </th>
                            <th scope="col" class="px-6 py-3 text-right text-xs font-medium uppercase tracking-wider">
                                Actions
                            </th>
                        </tr>
                    </thead>
                    <tbody class="bg-white divide-y divide-gray-200">
                        <c:forEach var="p" items="${penalites}">
                            <tr class="penalty-row ${empty p.datelevePenalite ? 'bg-red-50' : ''}">
                                <!-- Adhérent -->
                                <td class="px-6 py-4 whitespace-nowrap">
                                    <div class="flex items-center">
                                        <div class="flex-shrink-0 h-10 w-10 rounded-full bg-vert-pale flex items-center justify-center">
                                            <i class="fas fa-user text-vert-moyen"></i>
                                        </div>
                                        <div class="ml-4">
                                            <div class="text-sm font-medium ${empty p.datelevePenalite ? 'text-error' : 'text-gray-900'}">
                                                ${p.adherent.nom} ${p.adherent.prenom}
                                            </div>
                                            <div class="text-sm text-gray-500">
                                                ${p.adherent.email}
                                            </div>
                                        </div>
                                    </div>
                                </td>
                                
                                <!-- Date début -->
                                <td class="px-6 py-4 whitespace-nowrap text-sm ${empty p.datelevePenalite ? 'text-error font-medium' : 'text-gray-500'}">
                                    <fmt:formatDate value="${p.dateDebutPenalite}" pattern="dd/MM/yyyy" />
                                </td>
                                
                                <!-- Date levée -->
                                <td class="px-6 py-4 whitespace-nowrap text-sm ${empty p.datelevePenalite ? 'text-error font-medium' : 'text-gray-500'}">
                                    <c:choose>
                                        <c:when test="${not empty p.datelevePenalite}">
                                            <fmt:formatDate value="${p.datelevePenalite}" pattern="dd/MM/yyyy" />
                                        </c:when>
                                        <c:otherwise>
                                            <span class="inline-flex items-center px-2 py-0.5 rounded text-xs font-medium bg-red-100 text-red-800">
                                                <i class="fas fa-clock mr-1"></i> En cours
                                            </span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                
                                <!-- Prêt lié -->
                                <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">
                                    <c:if test="${not empty p.pret}">
                                        <a href="${pageContext.request.contextPath}/prets/${p.pret.idPret}" 
                                           class="text-accent hover:text-vert-fonce hover:underline">
                                            <i class="fas fa-external-link-alt mr-1"></i> Prêt #${p.pret.idPret}
                                        </a>
                                    </c:if>
                                </td>
                                
                                <!-- Actions -->
                                <td class="px-6 py-4 whitespace-nowrap text-right text-sm font-medium">
                                    <c:choose>
                                        <c:when test="${empty p.datelevePenalite}">
                                            <form action="${pageContext.request.contextPath}/penalites/lever/${p.idPenalite}" method="post" class="inline">
                                                <button type="submit" 
                                                        class="inline-flex items-center px-3 py-1 border border-transparent text-xs font-medium rounded-full shadow-sm text-white bg-accent hover:bg-opacity-90 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-accent">
                                                    <i class="fas fa-check mr-1"></i> Lever
                                                </button>
                                            </form>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="inline-flex items-center px-2 py-0.5 rounded text-xs font-medium bg-green-100 text-green-800">
                                                <i class="fas fa-check-circle mr-1"></i> Levée
                                            </span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
            
            <!-- Aucun résultat -->
            <c:if test="${empty penalites}">
                <div class="text-center p-8">
                    <i class="fas fa-check-circle text-4xl text-vert-clair mb-4"></i>
                    <h3 class="text-lg font-medium text-gray-500">Aucune pénalité enregistrée</h3>
                    <p class="text-gray-400 mt-1">Tous les adhérents sont en règle</p>
                </div>
            </c:if>
        </div>
    </div>
</body>
</html>