<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Liste des Réservations - Café Littéraire</title>
    <!-- Tailwind CSS via CDN -->
    <script src="https://cdn.tailwindcss.com"></script>
    <!-- Font Awesome pour les icônes -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
    <script>
        // Configuration du thème vert
        tailwind.config = {
            theme: {
                extend: {
                    colors: {
                        primary: {
                            50: '#f0fdf4',
                            100: '#dcfce7',
                            200: '#bbf7d0',
                            300: '#86efac',
                            400: '#4ade80',
                            500: '#22c55e',
                            600: '#16a34a',
                            700: '#15803d',
                            800: '#166534',
                            900: '#14532d',
                        },
                        secondary: {
                            50: '#f8fafc',
                            100: '#f1f5f9',
                            200: '#e2e8f0',
                            300: '#cbd5e1',
                            400: '#94a3b8',
                            500: '#64748b',
                            600: '#475569',
                            700: '#334155',
                            800: '#1e293b',
                            900: '#0f172a',
                        }
                    }
                }
            }
        }
    </script>
    
    <style type="text/tailwindcss">
        @layer components {
            .btn-primary {
                @apply bg-primary-600 hover:bg-primary-700 text-white font-medium py-2 px-4 rounded-lg transition-all duration-200 ease-in-out shadow-sm hover:shadow-md;
            }
            
            .btn-success {
                @apply bg-green-600 hover:bg-green-700 text-white font-medium py-1.5 px-3 rounded-md transition-all duration-150 ease-in-out text-sm;
            }
            
            .status-badge {
                @apply inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium;
            }
            
            .table-row-hover {
                @apply hover:bg-primary-50 transition-colors duration-150 ease-in-out;
            }
        }
    </style>
</head>
<body class="bg-primary-50 min-h-screen">

<div class="container mx-auto px-4 py-8 max-w-7xl">
    <div class="bg-white rounded-xl shadow-md overflow-hidden p-6 mb-8">
        <div class="flex justify-between items-center mb-6">
            <h2 class="text-3xl font-bold text-primary-800">
                <i class="fas fa-calendar-check mr-2"></i> Liste des Réservations
            </h2>
            
            <div class="flex space-x-3">
                <button class="btn-primary flex items-center">
                    <i class="fas fa-filter mr-2"></i> Filtrer
                </button>
                <button class="btn-primary flex items-center">
                    <i class="fas fa-file-export mr-2"></i> Exporter
                </button>
            </div>
        </div>
        
        <div class="overflow-x-auto">
            <table class="min-w-full divide-y divide-gray-200">
                <thead class="bg-primary-700 text-white">
                    <tr>
                        <th scope="col" class="px-6 py-3 text-left text-xs font-medium uppercase tracking-wider">ID</th>
                        <th scope="col" class="px-6 py-3 text-left text-xs font-medium uppercase tracking-wider">Adhérent</th>
                        <th scope="col" class="px-6 py-3 text-left text-xs font-medium uppercase tracking-wider">Livre</th>
                        <th scope="col" class="px-6 py-3 text-left text-xs font-medium uppercase tracking-wider">Exemplaire</th>
                        <th scope="col" class="px-6 py-3 text-left text-xs font-medium uppercase tracking-wider">Date Début</th>
                        <th scope="col" class="px-6 py-3 text-left text-xs font-medium uppercase tracking-wider">Date Fin</th>
                        <th scope="col" class="px-6 py-3 text-left text-xs font-medium uppercase tracking-wider">Statut</th>
                        <th scope="col" class="px-6 py-3 text-left text-xs font-medium uppercase tracking-wider">Actions</th>
                    </tr>
                </thead>
                <tbody class="bg-white divide-y divide-gray-200">
                    <c:forEach var="r" items="${reservations}">
                        <tr class="table-row-hover">
                            <td class="px-6 py-4 whitespace-nowrap text-sm font-medium text-gray-900">${r.idReservation}</td>
                            <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-700">
                                <div class="flex items-center">
                                    <div class="flex-shrink-0 h-10 w-10 bg-primary-100 rounded-full flex items-center justify-center mr-3">
                                        <i class="fas fa-user text-primary-600"></i>
                                    </div>
                                    <div>
                                        <div class="font-medium text-gray-900">${r.adherent.prenom} ${r.adherent.nom}</div>
                                        <div class="text-gray-500 text-xs">ID: ${r.adherent.idAdherent}</div>
                                    </div>
                                </div>
                            </td>
                            <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-700">
                                <div class="font-medium">${r.livre.titre}</div>
                                <div class="text-gray-500 text-xs">${r.livre.auteur}</div>
                            </td>
                            <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-700">
                                <span class="inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium bg-blue-100 text-blue-800">
                                    <i class="fas fa-barcode mr-1"></i> ${r.exemplaireLivre.codeBarre}
                                </span>
                            </td>
                            <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-700">
                                <span class="font-medium">${r.dateDebutReservation}</span>
                            </td>
                            <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-700">
                                <span class="font-medium">${r.dateFinReservation}</span>
                            </td>
                            <td class="px-6 py-4 whitespace-nowrap text-sm">
                                <c:choose>
                                    <c:when test="${r.isApproved}">
                                        <span class="status-badge bg-green-100 text-green-800">
                                            <i class="fas fa-check-circle mr-1"></i> Validée
                                        </span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="status-badge bg-yellow-100 text-yellow-800">
                                            <i class="fas fa-clock mr-1"></i> En attente
                                        </span>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td class="px-6 py-4 whitespace-nowrap text-sm font-medium">
                                <c:if test="${not r.isApproved}">
                                    <form method="post" action="${pageContext.request.contextPath}/reservations/valider/${r.idReservation}" class="inline">
                                        <button type="submit" class="btn-success flex items-center">
                                            <i class="fas fa-check mr-1"></i> Valider
                                        </button>
                                    </form>
                                </c:if>
                                <button class="ml-2 text-primary-600 hover:text-primary-800" onclick="showReservationDetails(${r.idReservation})">
                                    <i class="fas fa-eye"></i>
                                </button>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
        
        <c:if test="${empty reservations}">
            <div class="mt-8 text-center py-12 bg-gray-50 rounded-lg">
                <i class="fas fa-calendar-times text-4xl text-primary-500 mb-4"></i>
                <h3 class="text-lg font-medium text-gray-900">Aucune réservation trouvée</h3>
                <p class="mt-2 text-sm text-gray-500">Il n'y a actuellement aucune réservation enregistrée.</p>
            </div>
        </c:if>
        
        <!-- Pagination -->
        <div class="mt-6 flex items-center justify-between">
            <div class="text-sm text-gray-500">
                Affichage de <span class="font-medium">1</span> à <span class="font-medium">10</span> sur <span class="font-medium">${reservations.size()}</span> résultats
            </div>
            <div class="flex space-x-2">
                <button class="px-3 py-1 border border-gray-300 rounded-md text-sm font-medium text-gray-700 bg-white hover:bg-gray-50">
                    Précédent
                </button>
                <button class="px-3 py-1 border border-gray-300 rounded-md text-sm font-medium text-gray-700 bg-white hover:bg-gray-50">
                    Suivant
                </button>
            </div>
        </div>
    </div>
</div>

<!-- Modal pour les détails de réservation -->
<div id="reservationModal" class="fixed inset-0 overflow-y-auto hidden z-50">
    <div class="flex items-center justify-center min-h-screen pt-4 px-4 pb-20 text-center sm:block sm:p-0">
        <div class="fixed inset-0 transition-opacity" aria-hidden="true">
            <div class="absolute inset-0 bg-gray-500 opacity-75"></div>
        </div>
        
        <div class="inline-block align-bottom bg-white rounded-lg text-left overflow-hidden shadow-xl transform transition-all sm:my-8 sm:align-middle sm:max-w-lg sm:w-full">
            <div class="bg-white px-4 pt-5 pb-4 sm:p-6 sm:pb-4">
                <div class="sm:flex sm:items-start">
                    <div class="mx-auto flex-shrink-0 flex items-center justify-center h-12 w-12 rounded-full bg-primary-100 sm:mx-0 sm:h-10 sm:w-10">
                        <i class="fas fa-info-circle text-primary-600"></i>
                    </div>
                    <div class="mt-3 text-center sm:mt-0 sm:ml-4 sm:text-left w-full">
                        <h3 class="text-lg leading-6 font-medium text-gray-900" id="modalTitle">
                            Détails de la réservation
                        </h3>
                        <div class="mt-4">
                            <div class="grid grid-cols-2 gap-4 text-sm text-gray-700" id="reservationDetails">
                                <!-- Les détails seront chargés ici via JavaScript -->
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="bg-gray-50 px-4 py-3 sm:px-6 sm:flex sm:flex-row-reverse">
                <button type="button" onclick="closeModal()" class="mt-3 w-full inline-flex justify-center rounded-md border border-gray-300 shadow-sm px-4 py-2 bg-white text-base font-medium text-gray-700 hover:bg-gray-50 focus:outline-none sm:mt-0 sm:ml-3 sm:w-auto sm:text-sm">
                    Fermer
                </button>
            </div>
        </div>
    </div>
</div>

<script>
    // Fonction pour afficher les détails d'une réservation
    function showReservationDetails(reservationId) {
        // Ici, vous devriez normalement faire un appel AJAX pour récupérer les détails complets
        // Pour l'exemple, nous allons simuler des données
        const reservationDetails = {
            id: reservationId,
            adherent: "Jean Dupont (ID: 123)",
            livre: "Le Petit Prince - Antoine de Saint-Exupéry",
            exemplaire: "EX-789456",
            dateDebut: "15/06/2023",
            dateFin: "30/06/2023",
            statut: "En attente",
            dateCreation: "10/06/2023 14:30",
            commentaires: "Aucun commentaire"
        };
        
        document.getElementById('modalTitle').textContent = `Détails de la réservation #${reservationId}`;
        
        const detailsHtml = `
            <div class="col-span-2 font-medium">Adhérent</div>
            <div class="col-span-2">${reservationDetails.adherent}</div>
            
            <div class="font-medium">Livre</div>
            <div>${reservationDetails.livre}</div>
            
            <div class="font-medium">Exemplaire</div>
            <div>${reservationDetails.exemplaire}</div>
            
            <div class="font-medium">Date Début</div>
            <div>${reservationDetails.dateDebut}</div>
            
            <div class="font-medium">Date Fin</div>
            <div>${reservationDetails.dateFin}</div>
            
            <div class="font-medium">Statut</div>
            <div>
                <span class="inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium ${reservationDetails.statut === 'Validée' ? 'bg-green-100 text-green-800' : 'bg-yellow-100 text-yellow-800'}">
                    ${reservationDetails.statut}
                </span>
            </div>
            
            <div class="font-medium">Date Création</div>
            <div>${reservationDetails.dateCreation}</div>
            
            <div class="font-medium">Commentaires</div>
            <div>${reservationDetails.commentaires}</div>
        `;
        
        document.getElementById('reservationDetails').innerHTML = detailsHtml;
        document.getElementById('reservationModal').classList.remove('hidden');
    }
    
    function closeModal() {
        document.getElementById('reservationModal').classList.add('hidden');
    }
    
    // Gestion des clics en dehors du modal pour le fermer
    window.onclick = function(event) {
        const modal = document.getElementById('reservationModal');
        if (event.target === modal) {
            closeModal();
        }
    }
</script>

</body>
</html>