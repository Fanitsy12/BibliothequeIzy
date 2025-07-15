<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Liste des livres - Café Littéraire</title>
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
        .book-card {
            transition: all 0.3s ease;
            background: linear-gradient(to bottom right, rgba(255,255,255,0.9), rgba(248,250,252,0.9));
        }
        .book-card:hover {
            transform: translateY(-3px);
            box-shadow: 0 10px 20px rgba(0,0,0,0.1);
        }
        .category-tag {
            transition: all 0.2s ease;
        }
        .category-tag:hover {
            transform: scale(1.05);
        }
    </style>
</head>
<body class="bg-vert-pale min-h-screen p-4 md:p-8">
    <div class="max-w-7xl mx-auto animate-fade-in">
        <!-- Header -->
        <div class="flex flex-col md:flex-row justify-between items-start md:items-center mb-8">
            <div>
                <h1 class="text-3xl font-bold text-vert-fonce mb-2">
                    <i class="fas fa-book-open mr-3"></i>Catalogue des Livres
                </h1>
                <p class="text-vert-moyen">Explorez notre collection littéraire</p>
            </div>
            <div class="flex gap-3 mt-4 md:mt-0">
                <a href="${pageContext.request.contextPath}/prets/adherent" 
                   class="flex items-center bg-vert-moyen hover:bg-vert-fonce text-white px-4 py-2 rounded-lg transition shadow-md">
                    <i class="fas fa-bookmark mr-2"></i> Mes emprunts
                </a>
                <a href="${pageContext.request.contextPath}/reservations/add" 
                   class="flex items-center bg-accent hover:bg-opacity-90 text-white px-4 py-2 rounded-lg transition shadow-md">
                    <i class="fas fa-calendar-plus mr-2"></i> Réserver
                </a>
            </div>
        </div>

        <!-- Recherche principale -->
        <div class="bg-white rounded-xl shadow-md p-6 mb-8">
            <h2 class="text-xl font-semibold text-vert-fonce mb-4 flex items-center">
                <i class="fas fa-search mr-3 text-accent"></i>Rechercher un livre
            </h2>
            <form action="${pageContext.request.contextPath}/livres" method="get" class="grid grid-cols-1 md:grid-cols-4 gap-4">
                <div>
                    <label class="block text-sm font-medium text-vert-fonce mb-1">Titre</label>
                    <input type="text" name="titre" value="${titre != null ? titre : ''}" 
                           class="w-full px-3 py-2 border border-vert-clair rounded-lg focus:outline-none focus:ring-2 focus:ring-accent">
                </div>
                <div>
                    <label class="block text-sm font-medium text-vert-fonce mb-1">Auteur</label>
                    <input type="text" name="auteur" value="${auteur != null ? auteur : ''}" 
                           class="w-full px-3 py-2 border border-vert-clair rounded-lg focus:outline-none focus:ring-2 focus:ring-accent">
                </div>
                <div>
                    <label class="block text-sm font-medium text-vert-fonce mb-1">Année</label>
                    <input type="number" name="annee" value="${annee != null ? annee : ''}" 
                           class="w-full px-3 py-2 border border-vert-clair rounded-lg focus:outline-none focus:ring-2 focus:ring-accent">
                </div>
                <div>
                    <label class="block text-sm font-medium text-vert-fonce mb-1">Type</label>
                    <select name="typeId" class="w-full px-3 py-2 border border-vert-clair rounded-lg focus:outline-none focus:ring-2 focus:ring-accent">
                        <option value="">Tous les types</option>
                        <c:forEach var="type" items="${types}">
                            <option value="${type.idTypeLivre}" ${typeId != null && type.idTypeLivre == typeId ? 'selected' : ''}>
                                ${type.type}
                            </option>
                        </c:forEach>
                    </select>
                </div>
                <div class="md:col-span-4 flex justify-end">
                    <button type="submit" 
                            class="flex items-center bg-accent hover:bg-opacity-90 text-white px-6 py-2 rounded-lg transition shadow-md">
                        <i class="fas fa-search mr-2"></i> Rechercher
                    </button>
                </div>
            </form>
        </div>

        <!-- Filtres par catégories -->
        <div class="bg-white rounded-xl shadow-md p-6 mb-8">
            <h2 class="text-xl font-semibold text-vert-fonce mb-4 flex items-center">
                <i class="fas fa-filter mr-3 text-accent"></i>Filtrer par catégories
            </h2>
            <form action="${pageContext.request.contextPath}/livres/filtrer-categories" method="get" class="flex flex-wrap gap-3">
                <c:forEach var="categorie" items="${categories}">
                    <label class="inline-flex items-center">
                        <input type="checkbox" name="categoriesSelectionnees" value="${categorie.idCatLivre}" 
                               class="rounded border-vert-clair text-accent focus:ring-accent"
                               <c:if test="${categoriesSelectionnees != null && categoriesSelectionnees.contains(categorie.idCatLivre)}">checked</c:if>
                        />
                        <span class="ml-2 text-vert-fonce">${categorie.categorie}</span>
                    </label>
                </c:forEach>
                <div class="w-full flex justify-end mt-4">
                    <button type="submit" 
                            class="flex items-center bg-vert-moyen hover:bg-vert-fonce text-white px-6 py-2 rounded-lg transition shadow-md">
                        <i class="fas fa-check mr-2"></i> Appliquer les filtres
                    </button>
                </div>
            </form>
        </div>

        <!-- Résultats -->
        <div class="bg-white rounded-xl shadow-md overflow-hidden">
            <div class="px-6 py-4 border-b border-gray-200">
                <h2 class="text-xl font-semibold text-vert-fonce flex items-center">
                    <i class="fas fa-book mr-3 text-accent"></i>Résultats
                </h2>
            </div>
            
            <c:choose>
                <c:when test="${not empty livres}">
                    <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6 p-6">
                        <c:forEach var="livre" items="${livres}">
                            <div class="book-card rounded-xl shadow-md overflow-hidden border border-gray-100">
                                <div class="p-6">
                                    <div class="flex justify-between items-start">
                                        <div>
                                            <h3 class="text-lg font-bold text-vert-fonce mb-1">${livre.titre}</h3>
                                            <p class="text-gray-600 mb-2">${livre.auteur}</p>
                                        </div>
                                        <span class="bg-vert-pale text-vert-moyen text-xs px-2 py-1 rounded-full">
                                            ${livre.typeLivre != null ? livre.typeLivre.type : 'Non spécifié'}
                                        </span>
                                    </div>
                                    <p class="text-sm text-gray-500 mb-4">
                                        <i class="fas fa-calendar-alt mr-1"></i> ${livre.dateEdition}
                                    </p>
                                    <div class="flex flex-wrap gap-2 mb-4">
                                        <c:forEach var="cat" items="${livre.categories}">
                                            <span class="category-tag bg-vert-clair text-white text-xs px-2 py-1 rounded-full">
                                                ${cat.categorie}
                                            </span>
                                        </c:forEach>
                                    </div>
                                    <div class="flex justify-end gap-2">
                                        <a href="#" class="text-sm text-vert-moyen hover:text-vert-fonce">
                                            <i class="fas fa-info-circle mr-1"></i> Détails
                                        </a>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="p-8 text-center">
                        <i class="fas fa-book-open text-4xl text-gray-300 mb-4"></i>
                        <h3 class="text-lg font-medium text-gray-500">Aucun livre trouvé</h3>
                        <p class="text-gray-400 mt-1">Essayez de modifier vos critères de recherche</p>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</body>
</html>