<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title><c:choose>
        <c:when test="${profil.idProfil != null}">Modifier un profil</c:when>
        <c:otherwise>Ajouter un profil</c:otherwise>
    </c:choose> - Café Littéraire</title>
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
                        'float': 'float 3s ease-in-out infinite',
                    },
                    keyframes: {
                        fadeIn: {
                            '0%': { opacity: '0' },
                            '100%': { opacity: '1' }
                        },
                        float: {
                            '0%, 100%': { transform: 'translateY(0)' },
                            '50%': { transform: 'translateY(-5px)' }
                        }
                    }
                }
            }
        }
    </script>
    <style>
        .profile-icon {
            animation: float 3s ease-in-out infinite;
        }
        .input-focus:focus {
            box-shadow: 0 0 0 3px rgba(126, 182, 147, 0.5);
            border-color: #3a7d5d;
        }
        .btn-hover:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(255, 159, 28, 0.3);
        }
        .required:after {
            content: " *";
            color: theme('colors.error');
        }
    </style>
</head>
<body class="bg-vert-pale min-h-screen flex items-center justify-center p-4">
    <div class="w-full max-w-2xl animate-fade-in">
        <!-- Carte principale -->
        <div class="bg-white rounded-xl shadow-lg overflow-hidden">
            <!-- En-tête visuelle -->
            <div class="relative h-32 bg-gradient-to-r from-vert-fonce to-vert-moyen flex items-center justify-center">
                <div class="absolute -top-6 left-1/2 transform -translate-x-1/2">
                    <div class="profile-icon bg-white p-4 rounded-full shadow-lg text-vert-moyen text-4xl">
                        <i class="fas fa-user-tag"></i>
                    </div>
                </div>
                <h2 class="text-2xl font-bold text-white mt-8">
                    <c:choose>
                        <c:when test="${profil.idProfil != null}">Modifier le profil</c:when>
                        <c:otherwise>Nouveau profil</c:otherwise>
                    </c:choose>
                </h2>
            </div>
            
            <!-- Formulaire -->
            <form method="post" action="${pageContext.request.contextPath}/profils/create" class="px-6 py-4">
                <!-- Champ ID caché (présent seulement en mode édition) -->
                <c:if test="${profil.idProfil != null}">
                    <input type="hidden" name="id" value="${profil.idProfil}" />
                </c:if>
                
                <!-- Nom du profil -->
                <div class="mb-6">
                    <label for="nomProfil" class="block text-sm font-medium text-vert-fonce mb-2 required">
                        <i class="fas fa-id-card mr-2 text-vert-moyen"></i>Nom du profil
                    </label>
                    <input 
                        type="text" 
                        id="nomProfil" 
                        name="nomProfil" 
                        value="${profil.nomProfil}" 
                        required
                        class="input-focus w-full px-4 py-3 border border-vert-clair rounded-lg focus:outline-none transition"
                        placeholder="Ex: Standard, Premium..."
                    >
                </div>
                
                <!-- Quotas et durées -->
                <div class="grid grid-cols-1 md:grid-cols-2 gap-6 mb-6">
                    <!-- Quota sur place -->
                    <div>
                        <label for="quotaMaxSurPlace" class="block text-sm font-medium text-vert-fonce mb-2 required">
                            <i class="fas fa-store mr-2 text-vert-moyen"></i>Quota max sur place
                        </label>
                        <input 
                            type="number" 
                            id="quotaMaxSurPlace" 
                            name="quotaMaxSurPlace"
                            value="${profil.quotaMaxSurPlace}" 
                            min="0" 
                            required
                            class="input-focus w-full px-4 py-3 border border-vert-clair rounded-lg focus:outline-none transition"
                        >
                    </div>
                    
                    <!-- Quota à emprunter -->
                    <div>
                        <label for="quotaMaxEmprunter" class="block text-sm font-medium text-vert-fonce mb-2">
                            <i class="fas fa-book-open mr-2 text-vert-moyen"></i>Quota max à emprunter
                        </label>
                        <input 
                            type="number" 
                            id="quotaMaxEmprunter" 
                            name="quotaMaxEmprunter"
                            value="${profil.quotaMaxEmprunter}" 
                            min="0"
                            class="input-focus w-full px-4 py-3 border border-vert-clair rounded-lg focus:outline-none transition"
                        >
                    </div>
                    
                    <!-- Durée de prêt -->
                    <div>
                        <label for="dureePret" class="block text-sm font-medium text-vert-fonce mb-2 required">
                            <i class="fas fa-calendar-alt mr-2 text-vert-moyen"></i>Durée de prêt (jours)
                        </label>
                        <input 
                            type="number" 
                            id="dureePret" 
                            name="dureePret"
                            value="${profil.dureePret}" 
                            min="1" 
                            required
                            class="input-focus w-full px-4 py-3 border border-vert-clair rounded-lg focus:outline-none transition"
                        >
                    </div>
                    
                    <!-- Durée de pénalité -->
                    <div>
                        <label for="dureePenalite" class="block text-sm font-medium text-vert-fonce mb-2">
                            <i class="fas fa-ban mr-2 text-vert-moyen"></i>Durée pénalité (jours)
                        </label>
                        <input 
                            type="number" 
                            id="dureePenalite" 
                            name="dureePenalite"
                            value="${profil.dureePenalite != null ? profil.dureePenalite : 0}" 
                            min="0"
                            class="input-focus w-full px-4 py-3 border border-vert-clair rounded-lg focus:outline-none transition"
                        >
                    </div>
                </div>
                
                <!-- Boutons -->
                <div class="flex flex-col-reverse sm:flex-row justify-between gap-4 pt-4">
                    <a href="${pageContext.request.contextPath}/profils" 
                       class="flex items-center justify-center px-6 py-3 border border-gray-300 text-gray-700 font-medium rounded-lg transition hover:bg-gray-50">
                        <i class="fas fa-arrow-left mr-2"></i> Retour
                    </a>
                    <button 
                        type="submit" 
                        class="btn-hover flex items-center justify-center px-6 py-3 bg-accent hover:bg-opacity-90 text-white font-medium rounded-lg transition shadow-md"
                    >
                        <c:choose>
                            <c:when test="${profil.idProfil != null}">
                                <i class="fas fa-save mr-2"></i> Mettre à jour
                            </c:when>
                            <c:otherwise>
                                <i class="fas fa-plus-circle mr-2"></i> Créer le profil
                            </c:otherwise>
                        </c:choose>
                    </button>
                </div>
            </form>
        </div>
    </div>
</body>
</html>