<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Nouvelle Réservation - Café Littéraire</title>
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
            
            .input-field {
                @apply w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-primary-500 focus:border-primary-500 transition-all duration-200;
            }
            
            .error-message {
                @apply bg-red-50 border-l-4 border-red-500 text-red-700 p-4 mb-6 rounded;
            }
            
            .select-label {
                @apply block text-sm font-medium text-gray-700 mb-1;
            }
        }
    </style>
</head>
<body class="bg-primary-50 min-h-screen py-12">

<div class="max-w-2xl mx-auto px-4 sm:px-6 lg:px-8">
    <div class="bg-white shadow-xl rounded-lg overflow-hidden">
        <!-- En-tête du formulaire -->
        <div class="bg-primary-700 px-6 py-4">
            <h2 class="text-2xl font-bold text-white flex items-center">
                <i class="fas fa-calendar-plus mr-3"></i> Nouvelle Réservation
            </h2>
        </div>
        
        <!-- Messages d'erreur -->
        <c:if test="${not empty errorMessage}">
            <div class="error-message flex items-start">
                <i class="fas fa-exclamation-circle mt-1 mr-2"></i>
                <div>${errorMessage}</div>
            </div>
        </c:if>
        
        <!-- Formulaire -->
        <form method="post" action="${pageContext.request.contextPath}/reservations/create" class="px-6 py-8">
            <!-- Sélection du livre -->
            <div class="mb-6">
                <label for="livreSelect" class="select-label">
                    <i class="fas fa-book mr-2"></i> Livre
                </label>
                <select id="livreSelect" name="livreId" required
                        class="input-field">
                    <option value="">-- Sélectionner un livre --</option>
                    <c:forEach var="livre" items="${livres}">
                        <option value="${livre.idLivre}" data-auteur="${livre.auteur}">
                            ${livre.titre}
                        </option>
                    </c:forEach>
                </select>
                <div id="livreAuteur" class="text-sm text-gray-500 mt-1 pl-2"></div>
            </div>
            
            <!-- Sélection de l'exemplaire -->
            <div class="mb-6">
                <label for="exemplaireSelect" class="select-label">
                    <i class="fas fa-barcode mr-2"></i> Exemplaire
                </label>
                <select id="exemplaireSelect" name="exemplaireId" required
                        class="input-field" disabled>
                    <option value="">-- Sélectionnez d'abord un livre --</option>
                </select>
                <div id="exemplaireStatus" class="text-sm text-gray-500 mt-1 pl-2"></div>
            </div>
            
            <!-- Dates de réservation -->
            <div class="grid grid-cols-1 md:grid-cols-2 gap-6 mb-6">
                <div>
                    <label for="dateDebut" class="select-label">
                        <i class="far fa-calendar-alt mr-2"></i> Date de début
                    </label>
                    <input type="date" id="dateDebut" name="dateDebutReservation" required
                           class="input-field" 
                           min="${java.time.LocalDate.now()}">
                </div>
                <div>
                    <label for="joursReservation" class="select-label">
                        <i class="far fa-clock mr-2"></i> Durée (jours)
                    </label>
                    <div class="relative">
                        <input type="number" id="joursReservation" name="jourReservation" 
                               min="1" max="15" value="1" required
                               class="input-field pr-12">
                        <span class="absolute right-3 top-2 text-gray-400">jours</span>
                    </div>
                </div>
            </div>
            
            <!-- Date de fin calculée -->
            <div class="mb-8 p-4 bg-primary-50 rounded-lg border border-primary-100">
                <div class="flex items-center">
                    <i class="fas fa-info-circle text-primary-600 mr-2"></i>
                    <span class="font-medium text-primary-800">La réservation se terminera le :</span>
                    <span id="dateFinCalcul" class="ml-2 font-bold">--/--/----</span>
                </div>
            </div>
            
            <!-- Boutons -->
            <div class="flex justify-between items-center mt-8">
                <a href="${pageContext.request.contextPath}/reservations" 
                   class="text-primary-600 hover:text-primary-800 font-medium">
                    <i class="fas fa-arrow-left mr-2"></i> Retour à la liste
                </a>
                <button type="submit" class="btn-primary flex items-center">
                    <i class="fas fa-check-circle mr-2"></i> Confirmer la réservation
                </button>
            </div>
        </form>
    </div>
</div>

<!-- Conteneur caché pour les exemplaires -->
<div class="hidden">
    <c:forEach var="livre" items="${livres}">
        <select id="exemplaires-for-livre-${livre.idLivre}">
            <c:forEach var="exemplaire" items="${livre.exemplaires}">
                <option value="${exemplaire.idExemplaireLivre}" 
                        data-disponible="${exemplaire.disponible}">
                    ${exemplaire.codeBarre}
                    <c:if test="${not exemplaire.disponible}"> (Non disponible)</c:if>
                </option>
            </c:forEach>
        </select>
    </c:forEach>
</div>

<script>
    // Gestion de la sélection du livre et des exemplaires
    document.getElementById('livreSelect').addEventListener('change', function() {
        const livreId = this.value;
        const exemplaireSelect = document.getElementById('exemplaireSelect');
        const auteur = this.options[this.selectedIndex]?.dataset.auteur || '';
        
        // Afficher l'auteur du livre sélectionné
        document.getElementById('livreAuteur').textContent = auteur;
        
        // Réinitialiser le select des exemplaires
        exemplaireSelect.innerHTML = '<option value="">-- Sélectionner un exemplaire --</option>';
        exemplaireSelect.disabled = !livreId;
        document.getElementById('exemplaireStatus').textContent = '';
        
        if (!livreId) return;
        
        // Remplir avec les exemplaires du livre sélectionné
        const hiddenSelect = document.getElementById(`exemplaires-for-livre-${livreId}`);
        if (!hiddenSelect) return;
        
        let disponibleCount = 0;
        for (let option of hiddenSelect.options) {
            const newOption = option.cloneNode(true);
            exemplaireSelect.appendChild(newOption);
            
            if (option.dataset.disponible === 'true') {
                disponibleCount++;
            }
        }
        
        // Afficher le statut de disponibilité
        const statusElement = document.getElementById('exemplaireStatus');
        if (disponibleCount === 0) {
            statusElement.innerHTML = '<span class="text-red-600"><i class="fas fa-exclamation-triangle mr-1"></i> Aucun exemplaire disponible</span>';
        } else {
            statusElement.innerHTML = `<span class="text-primary-600"><i class="fas fa-check-circle mr-1"></i> ${disponibleCount} exemplaire(s) disponible(s)</span>`;
        }
    });
    
    // Calcul automatique de la date de fin
    function calculateEndDate() {
        const startDateInput = document.getElementById('dateDebut');
        const daysInput = document.getElementById('joursReservation');
        const endDateSpan = document.getElementById('dateFinCalcul');
        
        if (!startDateInput.value || !daysInput.value) {
            endDateSpan.textContent = '--/--/----';
            return;
        }
        
        const startDate = new Date(startDateInput.value);
        const days = parseInt(daysInput.value);
        
        if (isNaN(days) || days < 1) {
            endDateSpan.textContent = '--/--/----';
            return;
        }
        
        const endDate = new Date(startDate);
        endDate.setDate(startDate.getDate() + days);
        
        // Formatage de la date en JJ/MM/AAAA
        const formattedDate = endDate.toLocaleDateString('fr-FR', {
            day: '2-digit',
            month: '2-digit',
            year: 'numeric'
        });
        
        endDateSpan.textContent = formattedDate;
    }
    
    // Écouteurs d'événements pour le calcul de la date
    document.getElementById('dateDebut').addEventListener('change', calculateEndDate);
    document.getElementById('joursReservation').addEventListener('input', calculateEndDate);
    
    // Initialiser le calcul au chargement
    document.addEventListener('DOMContentLoaded', function() {
        // Définir la date minimale (aujourd'hui)
        const today = new Date().toISOString().split('T')[0];
        document.getElementById('dateDebut').min = today;
        
        calculateEndDate();
    });
</script>

</body>
</html>