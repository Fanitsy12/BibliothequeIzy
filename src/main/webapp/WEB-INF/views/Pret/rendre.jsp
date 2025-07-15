<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <title>Rendre un prêt - Café Littéraire</title>
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
        .book-icon {
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
    </style>
</head>
<body class="bg-vert-pale min-h-screen flex items-center justify-center p-4">
    <div class="w-full max-w-md animate-fade-in">
        <!-- Carte principale -->
        <div class="bg-white rounded-xl shadow-lg overflow-hidden">
            <!-- En-tête visuelle -->
            <div class="relative h-32 bg-gradient-to-r from-vert-fonce to-vert-moyen flex items-center justify-center">
                <div class="absolute -top-6 left-1/2 transform -translate-x-1/2">
                    <div class="book-icon bg-white p-4 rounded-full shadow-lg text-vert-moyen text-4xl">
                        <i class="fas fa-book-return"></i>
                    </div>
                </div>
                <h2 class="text-2xl font-bold text-white mt-8">Retour de prêt</h2>
            </div>
            
            <!-- Contenu -->
            <div class="p-6 pt-12">
                <!-- Message d'erreur -->
                <c:if test="${not empty errorMessage}">
                    <div class="animate-shake mb-6 bg-red-50 border-l-4 border-error text-error p-4">
                        <div class="flex items-center">
                            <i class="fas fa-exclamation-circle mr-3"></i>
                            <span>${errorMessage}</span>
                        </div>
                    </div>
                </c:if>
                
                <!-- Info livre -->
                <div class="mb-6 p-4 bg-vert-pale rounded-lg border border-vert-clair">
                    <div class="flex items-center">
                        <div class="flex-shrink-0 h-12 w-12 rounded-lg bg-vert-moyen flex items-center justify-center text-white">
                            <i class="fas fa-book text-xl"></i>
                        </div>
                        <div class="ml-4">
                            <h3 class="text-lg font-medium text-vert-fonce">${pret.exemplaireLivre.livre.titre}</h3>
                            <p class="text-sm text-gray-600">Exemplaire #${pret.exemplaireLivre.codeBarre}</p>
                        </div>
                    </div>
                </div>
                
                <!-- Formulaire -->
                <form action="${pageContext.request.contextPath}/prets/rendre" method="post" class="space-y-6">
                    <input type="hidden" name="idPret" value="${pret.idPret}" />
                    
                    <!-- Date de rendu -->
                    <div>
                        <label class="block text-sm font-medium text-vert-fonce mb-2">
                            <i class="fas fa-calendar-check mr-2 text-vert-moyen"></i>Date de retour
                        </label>
                        <input 
                            type="date" 
                            id="dateRendu" 
                            name="dateRendu" 
                            value="${dateRendu}"
                            required
                            class="input-focus w-full px-4 py-3 border border-vert-clair rounded-lg focus:outline-none transition"
                        >
                    </div>
                    
                    <!-- Boutons -->
                    <div class="flex flex-col-reverse sm:flex-row justify-between gap-4 pt-4">
                        <a href="${pageContext.request.contextPath}/prets/liste" 
                           class="flex items-center justify-center px-6 py-3 border border-gray-300 text-gray-700 font-medium rounded-lg transition hover:bg-gray-50">
                            <i class="fas fa-arrow-left mr-2"></i> Annuler
                        </a>
                        <button 
                            type="submit" 
                            class="btn-hover flex items-center justify-center px-6 py-3 bg-accent hover:bg-opacity-90 text-white font-medium rounded-lg transition shadow-md"
                        >
                            <i class="fas fa-check-circle mr-2"></i> Confirmer le retour
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</body>
</html>