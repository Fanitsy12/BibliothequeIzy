<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Liste des adhérents - Café Littéraire</title>
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
                        'slide-up': 'slideUp 0.3s ease-out',
                    },
                    keyframes: {
                        fadeIn: {
                            '0%': { opacity: '0' },
                            '100%': { opacity: '1' }
                        },
                        slideUp: {
                            '0%': { transform: 'translateY(10px)', opacity: '0' },
                            '100%': { transform: 'translateY(0)', opacity: '1' }
                        }
                    }
                }
            }
        }
        
        document.addEventListener('DOMContentLoaded', function() {
            // Animation des lignes du tableau
            const rows = document.querySelectorAll('tbody tr');
            rows.forEach((row, index) => {
                row.style.opacity = '0';
                setTimeout(() => {
                    row.style.animation = 'slideUp 0.3s ease-out forwards';
                    row.style.animationDelay = `${index * 0.05}s`;
                }, 0);
            });
            
            // Tooltip pour les boutons
            tippy('[data-tippy-content]', {
                arrow: true,
                placement: 'top',
                animation: 'slide-up',
                duration: 200,
            });
        });
    </script>
    <style>
        .table-row-hover:hover {
            transform: translateX(4px);
            box-shadow: 4px 0 0 0 theme('colors.accent') inset;
        }
    </style>
</head>
<body class="bg-vert-pale min-h-screen p-4 md:p-8">
    <div class="max-w-7xl mx-auto">
        <!-- Header -->
        <div class="flex flex-col md:flex-row justify-between items-start md:items-end mb-8">
            <div>
                <h2 class="text-3xl font-bold text-vert-fonce mb-2">
                    <i class="fas fa-users mr-3"></i>Liste des adhérents
                </h2>
                <p class="text-vert-moyen">Gestion des membres du Café Littéraire</p>
            </div>
            <div class="mt-4 md:mt-0 text-sm text-gray-500">
                <span id="current-date"></span>
                <script>
                    document.getElementById('current-date').textContent = new Date().toLocaleDateString('fr-FR', {
                        weekday: 'long', year: 'numeric', month: 'long', day: 'numeric'
                    });
                </script>
            </div>
        </div>
        
        <!-- Boutons d'action -->
        <div class="flex flex-wrap gap-4 mb-8">
            <a href="${pageContext.request.contextPath}/adherents/add" 
               class="flex items-center bg-accent hover:bg-opacity-90 text-white font-medium py-2 px-4 rounded-lg transition transform hover:-translate-y-1 shadow-md"
               data-tippy-content="Ajouter un nouvel adhérent">
                <i class="fas fa-user-plus mr-2"></i> Inscrire un adhérent
            </a>
            
            <a href="${pageContext.request.contextPath}/abonnements/add" 
               class="flex items-center bg-vert-moyen hover:bg-vert-fonce text-white font-medium py-2 px-4 rounded-lg transition transform hover:-translate-y-1 shadow-md"
               data-tippy-content="Gérer les réabonnements">
                <i class="fas fa-calendar-check mr-2"></i> Réabonnement
            </a>
            
            <div class="relative flex-1 max-w-md">
                <input type="text" placeholder="Rechercher un adhérent..." 
                       class="w-full pl-10 pr-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-accent">
                <i class="fas fa-search absolute left-3 top-1/2 transform -translate-y-1/2 text-gray-400"></i>
            </div>
        </div>
        
        <!-- Tableau des adhérents -->
        <div class="bg-white rounded-xl shadow-md overflow-hidden animate-fade-in">
            <div class="overflow-x-auto">
                <table class="min-w-full divide-y divide-gray-200">
                    <thead class="bg-vert-fonce text-white">
                        <tr>
                            <th scope="col" class="px-6 py-3 text-left text-xs font-medium uppercase tracking-wider">
                                <i class="fas fa-id-card mr-1"></i> ID
                            </th>
                            <th scope="col" class="px-6 py-3 text-left text-xs font-medium uppercase tracking-wider">
                                <i class="fas fa-user mr-1"></i> Nom
                            </th>
                            <th scope="col" class="px-6 py-3 text-left text-xs font-medium uppercase tracking-wider">
                                Prénom
                            </th>
                            <th scope="col" class="px-6 py-3 text-left text-xs font-medium uppercase tracking-wider">
                                <i class="fas fa-birthday-cake mr-1"></i> Naissance
                            </th>
                            <th scope="col" class="px-6 py-3 text-left text-xs font-medium uppercase tracking-wider">
                                <i class="fas fa-envelope mr-1"></i> Email
                            </th>
                            <th scope="col" class="px-6 py-3 text-left text-xs font-medium uppercase tracking-wider">
                                <i class="fas fa-calendar-day mr-1"></i> Inscription
                            </th>
                            <th scope="col" class="px-6 py-3 text-left text-xs font-medium uppercase tracking-wider">
                                <i class="fas fa-user-tag mr-1"></i> Profil
                            </th>
                            <th scope="col" class="px-6 py-3 text-right text-xs font-medium uppercase tracking-wider">
                                Actions
                            </th>
                        </tr>
                    </thead>
                    <tbody class="bg-white divide-y divide-gray-200">
                        <c:forEach var="a" items="${adherents}">
                            <tr class="table-row-hover transition duration-150 ease-in-out">
                                <td class="px-6 py-4 whitespace-nowrap text-sm font-medium text-gray-900">
                                    ${a.idAdherent}
                                </td>
                                <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-800 font-medium">
                                    ${a.nom}
                                </td>
                                <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-800">
                                    ${a.prenom}
                                </td>
                                <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">
                                    ${a.dateNaissance}
                                </td>
                                <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-800">
                                    <a href="mailto:${a.email}" class="text-vert-moyen hover:text-vert-fonce">
                                        ${a.email}
                                    </a>
                                </td>
                                <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">
                                    ${a.dateInscription}
                                </td>
                                <td class="px-6 py-4 whitespace-nowrap">
                                    <span class="px-2 inline-flex text-xs leading-5 font-semibold rounded-full 
                                        ${a.profil.nomProfil == 'Premium' ? 'bg-purple-100 text-purple-800' : 
                                          a.profil.nomProfil == 'VIP' ? 'bg-yellow-100 text-yellow-800' : 
                                          'bg-blue-100 text-blue-800'}">
                                        ${a.profil.nomProfil}
                                    </span>
                                </td>
                                <td class="px-6 py-4 whitespace-nowrap text-right text-sm font-medium">
                                    <div class="flex justify-end space-x-2">
                                        <a href="${pageContext.request.contextPath}/adherents/edit?id=${a.idAdherent}" 
                                           class="text-vert-moyen hover:text-vert-fonce transition"
                                           data-tippy-content="Modifier">
                                            <i class="fas fa-edit"></i>
                                        </a>
                                        <a href="${pageContext.request.contextPath}/adherents/details?id=${a.idAdherent}" 
                                           class="text-blue-600 hover:text-blue-800 transition"
                                           data-tippy-content="Détails">
                                            <i class="fas fa-eye"></i>
                                        </a>
                                    </div>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
            
            <!-- Pagination -->
            <div class="bg-beige px-6 py-3 flex items-center justify-between border-t border-gray-200">
                <div class="flex-1 flex justify-between sm:hidden">
                    <a href="#" class="relative inline-flex items-center px-4 py-2 border border-gray-300 text-sm font-medium rounded-md text-gray-700 bg-white hover:bg-gray-50">
                        Précédent
                    </a>
                    <a href="#" class="ml-3 relative inline-flex items-center px-4 py-2 border border-gray-300 text-sm font-medium rounded-md text-gray-700 bg-white hover:bg-gray-50">
                        Suivant
                    </a>
                </div>
                <div class="hidden sm:flex-1 sm:flex sm:items-center sm:justify-between">
                    <div>
                        <p class="text-sm text-gray-700">
                            Affichage de <span class="font-medium">1</span> à <span class="font-medium">10</span> sur <span class="font-medium">${adherents.size()}</span> adhérents
                        </p>
                    </div>
                    <div>
                        <nav class="relative z-0 inline-flex rounded-md shadow-sm -space-x-px" aria-label="Pagination">
                            <a href="#" class="relative inline-flex items-center px-2 py-2 rounded-l-md border border-gray-300 bg-white text-sm font-medium text-gray-500 hover:bg-gray-50">
                                <span class="sr-only">Précédent</span>
                                <i class="fas fa-chevron-left"></i>
                            </a>
                            <a href="#" aria-current="page" class="z-10 bg-accent border-accent text-white relative inline-flex items-center px-4 py-2 border text-sm font-medium">
                                1
                            </a>
                            <a href="#" class="bg-white border-gray-300 text-gray-500 hover:bg-gray-50 relative inline-flex items-center px-4 py-2 border text-sm font-medium">
                                2
                            </a>
                            <a href="#" class="bg-white border-gray-300 text-gray-500 hover:bg-gray-50 relative inline-flex items-center px-4 py-2 border text-sm font-medium">
                                3
                            </a>
                            <span class="relative inline-flex items-center px-4 py-2 border border-gray-300 bg-white text-sm font-medium text-gray-700">
                                ...
                            </span>
                            <a href="#" class="bg-white border-gray-300 text-gray-500 hover:bg-gray-50 relative inline-flex items-center px-4 py-2 border text-sm font-medium">
                                8
                            </a>
                            <a href="#" class="relative inline-flex items-center px-2 py-2 rounded-r-md border border-gray-300 bg-white text-sm font-medium text-gray-500 hover:bg-gray-50">
                                <span class="sr-only">Suivant</span>
                                <i class="fas fa-chevron-right"></i>
                            </a>
                        </nav>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <!-- Script pour les tooltips (à ajouter si non déjà présent) -->
    <script src="https://unpkg.com/@popperjs/core@2"></script>
    <script src="https://unpkg.com/tippy.js@6"></script>
</body>
</html>