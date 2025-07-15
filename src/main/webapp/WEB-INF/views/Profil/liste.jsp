<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Liste des Profils - Café Littéraire</title>
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
            
            .btn-danger {
                @apply bg-red-600 hover:bg-red-700 text-white font-medium py-2 px-4 rounded-lg transition-all duration-200 ease-in-out shadow-sm hover:shadow-md;
            }
            
            .action-link {
                @apply text-primary-600 hover:text-primary-800 font-medium transition-colors duration-150 ease-in-out;
            }
            
            .table-row-hover {
                @apply hover:bg-primary-50 transition-colors duration-150 ease-in-out;
            }
        }
    </style>
</head>
<body class="bg-primary-50 min-h-screen">

<div class="container mx-auto px-4 py-8 max-w-6xl">
    <div class="bg-white rounded-xl shadow-md overflow-hidden p-6 mb-8">
        <div class="flex justify-between items-center mb-6">
            <h2 class="text-3xl font-bold text-primary-800">
                <i class="fas fa-user-group mr-2"></i> Liste des Profils
            </h2>
            
            <a href="${pageContext.request.contextPath}/profils/add" 
               class="btn-primary flex items-center">
                <i class="fas fa-plus mr-2"></i> Ajouter un nouveau profil
            </a>
        </div>
        
        <div class="overflow-x-auto">
            <table class="min-w-full divide-y divide-gray-200">
                <thead class="bg-primary-700 text-white">
                    <tr>
                        <th scope="col" class="px-6 py-3 text-left text-xs font-medium uppercase tracking-wider">ID</th>
                        <th scope="col" class="px-6 py-3 text-left text-xs font-medium uppercase tracking-wider">Nom</th>
                        <th scope="col" class="px-6 py-3 text-left text-xs font-medium uppercase tracking-wider">Quota sur place</th>
                        <th scope="col" class="px-6 py-3 text-left text-xs font-medium uppercase tracking-wider">Quota emprunt</th>
                        <th scope="col" class="px-6 py-3 text-left text-xs font-medium uppercase tracking-wider">Durée prêt (jours)</th>
                        <th scope="col" class="px-6 py-3 text-left text-xs font-medium uppercase tracking-wider">Durée pénalité (jours)</th>
                        <th scope="col" class="px-6 py-3 text-left text-xs font-medium uppercase tracking-wider">Actions</th>
                    </tr>
                </thead>
                <tbody class="bg-white divide-y divide-gray-200">
                    <c:forEach var="profil" items="${profils}">
                        <tr class="table-row-hover">
                            <td class="px-6 py-4 whitespace-nowrap text-sm font-medium text-gray-900">${profil.idProfil}</td>
                            <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-700">${profil.nomProfil}</td>
                            <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-700">${profil.quotaMaxSurPlace}</td>
                            <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-700">${profil.quotaMaxEmprunter}</td>
                            <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-700">${profil.dureePret}</td>
                            <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-700">${profil.dureePenalite}</td>
                            <td class="px-6 py-4 whitespace-nowrap text-sm font-medium">
                                <div class="flex space-x-4">
                                    <a href="${pageContext.request.contextPath}/profils/update/${profil.idProfil}" 
                                       class="action-link text-primary-600 hover:text-primary-800">
                                        <i class="fas fa-edit mr-1"></i> Modifier
                                    </a>
                                    <a href="${pageContext.request.contextPath}/profils/delete/${profil.idProfil}" 
                                       class="action-link text-red-600 hover:text-red-800 delete-btn"
                                       data-id="${profil.idProfil}"
                                       data-name="${profil.nomProfil}">
                                        <i class="fas fa-trash-alt mr-1"></i> Supprimer
                                    </a>
                                </div>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
        
        <c:if test="${empty profils}">
            <div class="mt-8 text-center py-12 bg-gray-50 rounded-lg">
                <i class="fas fa-info-circle text-4xl text-primary-500 mb-4"></i>
                <h3 class="text-lg font-medium text-gray-900">Aucun profil trouvé</h3>
                <p class="mt-2 text-sm text-gray-500">Commencez par ajouter un nouveau profil.</p>
                <div class="mt-6">
                    <a href="${pageContext.request.contextPath}/profils/add" class="btn-primary inline-flex items-center">
                        <i class="fas fa-plus mr-2"></i> Ajouter un profil
                    </a>
                </div>
            </div>
        </c:if>
    </div>
</div>

<!-- Toast notification -->
<div id="toast" class="fixed bottom-4 right-4 hidden">
    <div class="bg-primary-600 text-white px-4 py-3 rounded-lg shadow-lg flex items-start">
        <i class="fas fa-check-circle mr-2 mt-1"></i>
        <div>
            <p class="font-medium" id="toast-message">Opération réussie</p>
        </div>
        <button onclick="hideToast()" class="ml-4 text-white hover:text-primary-200">
            <i class="fas fa-times"></i>
        </button>
    </div>
</div>

<script>
    // Gestion des confirmations de suppression avec SweetAlert
    document.querySelectorAll('.delete-btn').forEach(btn => {
        btn.addEventListener('click', function(e) {
            e.preventDefault();
            const id = this.getAttribute('data-id');
            const name = this.getAttribute('data-name');
            
            Swal.fire({
                title: 'Confirmer la suppression',
                html: `Êtes-vous sûr de vouloir supprimer le profil <strong>${name}</strong> ?`,
                icon: 'warning',
                showCancelButton: true,
                confirmButtonColor: '#d33',
                cancelButtonColor: '#3085d6',
                confirmButtonText: 'Oui, supprimer',
                cancelButtonText: 'Annuler'
            }).then((result) => {
                if (result.isConfirmed) {
                    window.location.href = btn.href;
                }
            });
        });
    });
    
    // Gestion des notifications toast
    function showToast(message, type = 'success') {
        const toast = document.getElementById('toast');
        const toastMessage = document.getElementById('toast-message');
        
        toastMessage.textContent = message;
        
        // Changer la couleur selon le type
        if (type === 'error') {
            toast.classList.remove('bg-primary-600');
            toast.classList.add('bg-red-600');
        } else {
            toast.classList.remove('bg-red-600');
            toast.classList.add('bg-primary-600');
        }
        
        toast.classList.remove('hidden');
        setTimeout(hideToast, 5000);
    }
    
    function hideToast() {
        document.getElementById('toast').classList.add('hidden');
    }
    
    // Afficher un toast si un paramètre success ou error est présent dans l'URL
    document.addEventListener('DOMContentLoaded', function() {
        const urlParams = new URLSearchParams(window.location.search);
        if (urlParams.has('success')) {
            showToast(urlParams.get('success'));
        }
        if (urlParams.has('error')) {
            showToast(urlParams.get('error'), 'error');
        }
    });
</script>

<!-- SweetAlert pour de belles boîtes de dialogue -->
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

</body>
</html>