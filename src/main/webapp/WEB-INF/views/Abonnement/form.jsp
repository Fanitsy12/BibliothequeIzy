<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <title>Nouvel Abonnement - Café Littéraire</title>
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
                        'shake': 'shake 0.5s ease-in-out',
                    },
                    keyframes: {
                        fadeIn: {
                            '0%': { opacity: '0' },
                            '100%': { opacity: '1' }
                        },
                        shake: {
                            '0%, 100%': { transform: 'translateX(0)' },
                            '20%, 60%': { transform: 'translateX(-5px)' },
                            '40%, 80%': { transform: 'translateX(5px)' }
                        }
                    }
                }
            }
        }
        
        document.addEventListener('DOMContentLoaded', function() {
            // Validation des dates
            const form = document.querySelector('form');
            const dateDebut = document.getElementById('dateDebut');
            const dateFin = document.getElementById('dateFin');
            
            form.addEventListener('submit', function(e) {
                if (new Date(dateDebut.value) > new Date(dateFin.value)) {
                    e.preventDefault();
                    const errorDiv = document.createElement('div');
                    errorDiv.className = 'animate-shake bg-red-50 border-l-4 border-error text-error p-4 mb-4';
                    errorDiv.innerHTML = '<div class="flex items-center"><i class="fas fa-exclamation-circle mr-3"></i><span>La date de fin doit être après la date de début</span></div>';
                    
                    const existingError = document.querySelector('.date-error');
                    if (existingError) {
                        existingError.replaceWith(errorDiv);
                    } else {
                        dateFin.parentElement.insertAdjacentElement('afterend', errorDiv);
                    }
                    
                    dateFin.focus();
                    return false;
                }
            });
            
            // Animation pour les champs invalides
            const inputs = document.querySelectorAll('input, select');
            inputs.forEach(input => {
                input.addEventListener('invalid', function() {
                    this.classList.add('border-error', 'animate-shake');
                    setTimeout(() => this.classList.remove('animate-shake'), 500);
                });
                
                input.addEventListener('input', function() {
                    if (this.checkValidity()) {
                        this.classList.remove('border-error');
                    }
                });
            });
        });
    </script>
    <style>
        .required:after {
            content: " *";
            color: theme('colors.error');
        }
        
        select {
            background-image: url("data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' fill='none' viewBox='0 0 20 20'%3e%3cpath stroke='%233a7d5d' stroke-linecap='round' stroke-linejoin='round' stroke-width='1.5' d='M6 8l4 4 4-4'/%3e%3c/svg%3e");
            background-position: right 0.5rem center;
            background-repeat: no-repeat;
            background-size: 1.5em 1.5em;
            -webkit-print-color-adjust: exact;
            print-color-adjust: exact;
        }
    </style>
</head>
<body class="bg-vert-pale min-h-screen flex items-center justify-center p-4">
    <div class="w-full max-w-2xl animate-fade-in">
        <!-- Carte principale -->
        <div class="bg-white rounded-xl shadow-lg overflow-hidden">
            <!-- En-tête -->
            <div class="bg-vert-fonce px-6 py-4 text-white">
                <h1 class="text-2xl font-bold flex items-center">
                    <i class="fas fa-calendar-plus mr-3"></i> Nouvel Abonnement
                </h1>
                <p class="text-vert-clair mt-1">Enregistrez un nouvel abonnement pour un adhérent</p>
            </div>
            
            <!-- Messages d'erreur -->
            <c:if test="${not empty errorMessage}">
                <div class="animate-shake bg-red-50 border-l-4 border-error text-error p-4 mx-6 mt-4">
                    <div class="flex items-center">
                        <i class="fas fa-exclamation-circle mr-3"></i>
                        <span>${errorMessage}</span>
                    </div>
                </div>
            </c:if>
            
            <!-- Formulaire -->
            <form action="${pageContext.request.contextPath}/abonnements/create" method="post" class="px-6 py-4">
                <!-- Sélection de l'adhérent -->
                <div class="mb-6">
                    <label for="adherentId" class="block text-sm font-medium text-vert-fonce mb-2 required">
                        <i class="fas fa-user mr-2 text-vert-moyen"></i>Adhérent
                    </label>
                    <select 
                        id="adherentId" 
                        name="adherentId" 
                        required
                        class="w-full px-4 py-2 border border-vert-clair rounded-lg focus:outline-none focus:ring-2 focus:ring-accent appearance-none"
                    >
                        <option value="">-- Sélectionnez un adhérent --</option>
                        <c:forEach items="${adherents}" var="adherent">
                            <option value="${adherent.idAdherent}"
                                ${adherent.idAdherent == adherentId ? 'selected' : ''}>
                                ${adherent.nom} ${adherent.prenom} (${adherent.email})
                            </option>
                        </c:forEach>
                    </select>
                </div>
                
                <!-- Dates -->
                <div class="grid grid-cols-1 md:grid-cols-2 gap-6 mb-6">
                    <!-- Date de début -->
                    <div>
                        <label for="dateDebut" class="block text-sm font-medium text-vert-fonce mb-2 required">
                            <i class="fas fa-calendar-day mr-2 text-vert-moyen"></i>Date de début
                        </label>
                        <input 
                            type="date" 
                            id="dateDebut" 
                            name="dateDebut" 
                            value="<fmt:formatDate value="${dateDebut}" pattern="yyyy-MM-dd" />"
                            required
                            class="w-full px-4 py-2 border border-vert-clair rounded-lg focus:outline-none focus:ring-2 focus:ring-accent"
                        >
                    </div>
                    
                    <!-- Date de fin -->
                    <div>
                        <label for="dateFin" class="block text-sm font-medium text-vert-fonce mb-2 required">
                            <i class="fas fa-calendar-check mr-2 text-vert-moyen"></i>Date de fin
                        </label>
                        <input 
                            type="date" 
                            id="dateFin" 
                            name="dateFin" 
                            value="<fmt:formatDate value="${dateFin}" pattern="yyyy-MM-dd" />"
                            required
                            class="w-full px-4 py-2 border border-vert-clair rounded-lg focus:outline-none focus:ring-2 focus:ring-accent"
                        >
                    </div>
                </div>
                
                <!-- Montant -->
                <div class="mb-8">
                    <label for="montant" class="block text-sm font-medium text-vert-fonce mb-2 required">
                        <i class="fas fa-euro-sign mr-2 text-vert-moyen"></i>Montant
                    </label>
                    <div class="relative">
                        <input 
                            type="number" 
                            step="0.01" 
                            min="0" 
                            id="montant" 
                            name="montant" 
                            value="${montant}"
                            required
                            class="w-full pl-10 pr-4 py-2 border border-vert-clair rounded-lg focus:outline-none focus:ring-2 focus:ring-accent"
                            placeholder="0.00"
                        >
                        <span class="absolute left-3 top-1/2 transform -translate-y-1/2 text-vert-moyen">
                            €
                        </span>
                    </div>
                </div>
                
                <!-- Boutons -->
                <div class="flex flex-col-reverse sm:flex-row justify-between gap-4 mt-8">
                    <a 
                        href="${pageContext.request.contextPath}/abonnements" 
                        class="flex items-center justify-center px-6 py-3 bg-gray-200 hover:bg-gray-300 text-gray-800 font-medium rounded-lg transition"
                    >
                        <i class="fas fa-arrow-left mr-2"></i> Retour
                    </a>
                    <button 
                        type="submit" 
                        class="flex items-center justify-center px-6 py-3 bg-accent hover:bg-opacity-90 text-white font-medium rounded-lg transition"
                    >
                        <i class="fas fa-save mr-2"></i> Enregistrer l'abonnement
                    </button>
                </div>
            </form>
        </div>
    </div>
</body>
</html>