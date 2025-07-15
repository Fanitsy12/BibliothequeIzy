<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Dashboard Café Littéraire</title>
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
                    }
                }
            }
        }
        
        // Petit script pour le menu responsive
        document.addEventListener('DOMContentLoaded', function() {
            const menuBtn = document.getElementById('menu-btn');
            const sidebar = document.getElementById('sidebar');
            
            menuBtn.addEventListener('click', function() {
                sidebar.classList.toggle('hidden');
                sidebar.classList.toggle('md:block');
            });
            
            // Animation pour les cartes de statistiques
            const statsCards = document.querySelectorAll('.stat-card');
            statsCards.forEach((card, index) => {
                card.style.opacity = '0';
                card.style.transform = 'translateY(20px)';
                setTimeout(() => {
                    card.style.transition = 'opacity 0.5s ease, transform 0.5s ease';
                    card.style.opacity = '1';
                    card.style.transform = 'translateY(0)';
                }, index * 150);
            });
        });
    </script>
    <style>
        /* Animation personnalisée pour les cartes */
        .stat-card {
            transition: all 0.3s ease;
        }
        .stat-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 20px rgba(0,0,0,0.1);
        }
        
        /* Animation pour le menu actif */
        .nav-link.active {
            position: relative;
        }
        .nav-link.active::after {
            content: '';
            position: absolute;
            right: 0;
            top: 50%;
            transform: translateY(-50%);
            width: 4px;
            height: 60%;
            background-color: #ff9f1c;
            border-radius: 2px;
        }
    </style>
</head>
<body class="bg-vert-pale">
<div class="flex min-h-screen">
    <!-- Menu mobile -->
    <div class="md:hidden fixed top-0 left-0 right-0 bg-vert-fonce z-50 p-4 flex justify-between items-center">
        <span class="text-white font-bold text-xl">Café Littéraire</span>
        <button id="menu-btn" class="text-white focus:outline-none">
            <i class="fas fa-bars text-2xl"></i>
        </button>
    </div>

    <!-- Barre latérale -->
    <nav id="sidebar" class="hidden md:block w-64 bg-vert-fonce text-white fixed h-full z-40">
        <div class="p-6 border-b border-vert-moyen">
            <h1 class="text-2xl font-bold">Café Littéraire</h1>
            <p class="text-vert-clair text-sm mt-1">Gestion de la bibliothèque</p>
        </div>
        <ul class="py-4">
            <li class="nav-link active">
                <a href="${pageContext.request.contextPath}/dashboard" class="flex items-center px-6 py-3 hover:bg-vert-moyen transition">
                    <i class="fas fa-home mr-3"></i> Accueil
                </a>
            </li>
            <li class="nav-link">
                <a href="${pageContext.request.contextPath}/adherents" class="flex items-center px-6 py-3 hover:bg-vert-moyen transition">
                    <i class="fas fa-user mr-3"></i> Voir Adhérents
                </a>
            </li>
            <li class="nav-link">
                <a href="${pageContext.request.contextPath}/prets" class="flex items-center px-6 py-3 hover:bg-vert-moyen transition">
                    <i class="fas fa-book mr-3"></i> Voir Prêts
                </a>
            </li>
            <li class="nav-link">
                <a href="${pageContext.request.contextPath}/penalites" class="flex items-center px-6 py-3 hover:bg-vert-moyen transition">
                    <i class="fas fa-ban mr-3"></i> Voir Pénalités
                </a>
            </li>
            <li class="nav-link">
                <a href="${pageContext.request.contextPath}/reservations" class="flex items-center px-6 py-3 hover:bg-vert-moyen transition">
                    <i class="fas fa-calendar-check mr-3"></i> Voir Réservations
                </a>
            </li>
            <li class="nav-link">
                <a href="${pageContext.request.contextPath}/profils" class="flex items-center px-6 py-3 hover:bg-vert-moyen transition">
                    <i class="fas fa-cogs mr-3"></i> Config
                </a>
            </li>
        </ul>
        <div class="absolute bottom-0 w-full p-4 border-t border-vert-moyen">
            <div class="flex items-center">
                <div class="w-10 h-10 rounded-full bg-vert-clair flex items-center justify-center">
                    <i class="fas fa-user text-vert-fonce"></i>
                </div>
                <div class="ml-3">
                    <p class="text-sm font-medium">Administrateur</p>
                    <p class="text-xs text-vert-clair">Connecté</p>
                </div>
            </div>
        </div>
    </nav>

    <!-- Contenu principal -->
    <main class="flex-1 md:ml-64 p-6 mt-16 md:mt-0">
        <div class="bg-white rounded-xl shadow-md p-6 mb-6">
            <div class="flex flex-col md:flex-row justify-between items-start md:items-center mb-6">
                <h1 class="text-3xl font-bold text-vert-fonce">Tableau de bord</h1>
                <div class="mt-4 md:mt-0 text-sm text-gray-500">
                    <i class="fas fa-calendar-alt mr-2"></i>
                    <span id="current-date"></span>
                    <script>
                        document.getElementById('current-date').textContent = new Date().toLocaleDateString('fr-FR', {
                            weekday: 'long', year: 'numeric', month: 'long', day: 'numeric'
                        });
                    </script>
                </div>
            </div>

            <!-- Formulaire de recherche -->
            <form method="get" action="${pageContext.request.contextPath}/dashboard/stats" class="bg-beige p-4 rounded-lg mb-8">
                <div class="flex flex-col md:flex-row gap-4">
                    <div class="flex-1">
                        <label class="block text-vert-fonce font-medium mb-2">Mois</label>
                        <select name="mois" required class="w-full p-2 border border-vert-clair rounded focus:outline-none focus:ring-2 focus:ring-accent">
                            <option value="">-- Sélectionner un mois --</option>
                            <option value="1">Janvier</option>
                            <option value="2">Février</option>
                            <option value="3">Mars</option>
                            <option value="4">Avril</option>
                            <option value="5">Mai</option>
                            <option value="6">Juin</option>
                            <option value="7">Juillet</option>
                            <option value="8">Août</option>
                            <option value="9">Septembre</option>
                            <option value="10">Octobre</option>
                            <option value="11">Novembre</option>
                            <option value="12">Décembre</option>
                        </select>
                    </div>
                    <div class="flex-1">
                        <label class="block text-vert-fonce font-medium mb-2">Année</label>
                        <input type="number" name="annee" value="2025" required 
                               class="w-full p-2 border border-vert-clair rounded focus:outline-none focus:ring-2 focus:ring-accent">
                    </div>
                    <div class="flex items-end">
                        <button type="submit" class="bg-accent hover:bg-opacity-90 text-white font-bold py-2 px-6 rounded transition h-[42px]">
                            Voir les statistiques
                        </button>
                    </div>
                </div>
            </form>

            <!-- Affichage stats -->
            <c:if test="${not empty mois and not empty annee}">
                <div class="mb-8">
                    <h2 class="text-2xl font-semibold text-vert-fonce mb-6">Statistiques de ${mois}/${annee}</h2>
                    
                    <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6 mb-8">
                        <div class="stat-card bg-white p-6 rounded-xl shadow-md border-l-4 border-accent">
                            <div class="flex items-center">
                                <div class="p-3 rounded-full bg-vert-pale text-vert-moyen mr-4">
                                    <i class="fas fa-book-open text-xl"></i>
                                </div>
                                <div>
                                    <p class="text-gray-500">Prêts effectués</p>
                                    <p class="text-2xl font-bold text-vert-fonce">${nbPrets}</p>
                                </div>
                            </div>
                        </div>
                        
                        <div class="stat-card bg-white p-6 rounded-xl shadow-md border-l-4 border-accent">
                            <div class="flex items-center">
                                <div class="p-3 rounded-full bg-vert-pale text-vert-moyen mr-4">
                                    <i class="fas fa-calendar-check text-xl"></i>
                                </div>
                                <div>
                                    <p class="text-gray-500">Réservations validées</p>
                                    <p class="text-2xl font-bold text-vert-fonce">${nbReservations}</p>
                                </div>
                            </div>
                        </div>
                        
                        <div class="stat-card bg-white p-6 rounded-xl shadow-md border-l-4 border-accent">
                            <div class="flex items-center">
                                <div class="p-3 rounded-full bg-vert-pale text-vert-moyen mr-4">
                                    <i class="fas fa-user-plus text-xl"></i>
                                </div>
                                <div>
                                    <p class="text-gray-500">Nouveaux adhérents</p>
                                    <p class="text-2xl font-bold text-vert-fonce">${nbAdherents}</p>
                                </div>
                            </div>
                        </div>
                        
                        <div class="stat-card bg-white p-6 rounded-xl shadow-md border-l-4 border-accent">
                            <div class="flex items-center">
                                <div class="p-3 rounded-full bg-vert-pale text-vert-moyen mr-4">
                                    <i class="fas fa-exclamation-triangle text-xl"></i>
                                </div>
                                <div>
                                    <p class="text-gray-500">Adhérents pénalisés</p>
                                    <p class="text-2xl font-bold text-vert-fonce">${nbPenalites}</p>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <div class="grid grid-cols-1 lg:grid-cols-2 gap-6">
                        <!-- Top 3 livres -->
                        <div class="bg-white p-6 rounded-xl shadow-md">
                            <h3 class="text-xl font-semibold text-vert-fonce mb-4 flex items-center">
                                <i class="fas fa-book mr-2 text-accent"></i> Top 3 livres les plus prêtés
                            </h3>
                            <div class="space-y-4">
                                <c:forEach var="row" items="${topLivres}" varStatus="loop">
                                    <c:set var="titreLivre" value="${row[0]}" />
                                    <c:set var="nbPret" value="${row[1]}" />
                                    <div class="flex items-center">
                                        <span class="w-8 h-8 flex items-center justify-center bg-vert-pale text-vert-fonce font-bold rounded-full mr-4">
                                            ${loop.index + 1}
                                        </span>
                                        <div class="flex-1">
                                            <p class="font-medium">${titreLivre}</p>
                                            <p class="text-sm text-gray-500">${nbPret} prêts</p>
                                        </div>
                                        <div class="w-24 bg-vert-pale rounded-full h-2">
                                            <div class="bg-accent h-2 rounded-full" 
                                                 style="width: ${(nbPret / (topLivres[0][1] + 0.0)) * 100}%"></div>
                                        </div>
                                    </div>
                                </c:forEach>
                            </div>
                        </div>
                        
                        <!-- Top 3 adhérents -->
                        <div class="bg-white p-6 rounded-xl shadow-md">
                            <h3 class="text-xl font-semibold text-vert-fonce mb-4 flex items-center">
                                <i class="fas fa-trophy mr-2 text-accent"></i> Top 3 adhérents les plus actifs
                            </h3>
                            <div class="space-y-4">
                                <c:forEach var="adherent" items="${topAdherents}" varStatus="loop">
                                    <c:set var="nomAdherent" value="${adherent[0]}" />
                                    <c:set var="nbPret" value="${adherent[1]}" />
                                    <div class="flex items-center">
                                        <span class="w-8 h-8 flex items-center justify-center bg-vert-pale text-vert-fonce font-bold rounded-full mr-4">
                                            ${loop.index + 1}
                                        </span>
                                        <div class="flex-1">
                                            <p class="font-medium">${nomAdherent}</p>
                                            <p class="text-sm text-gray-500">${nbPret} prêts</p>
                                        </div>
                                        <div class="w-24 bg-vert-pale rounded-full h-2">
                                            <div class="bg-accent h-2 rounded-full" 
                                                 style="width: ${(nbPret / (topAdherents[0][1] + 0.0)) * 100}%"></div>
                                        </div>
                                    </div>
                                </c:forEach>
                            </div>
                        </div>
                    </div>
                </div>
            </c:if>
            
            <c:if test="${empty mois or empty annee}">
                <div class="text-center py-12">
                    <i class="fas fa-chart-bar text-5xl text-vert-clair mb-4"></i>
                    <h3 class="text-xl font-medium text-vert-fonce mb-2">Aucune statistique à afficher</h3>
                    <p class="text-gray-500">Sélectionnez un mois et une année pour voir les statistiques</p>
                </div>
            </c:if>
        </div>
    </main>
</div>
</body>
</html>