<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Nouveau Prêt - Café Littéraire</title>
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
            <!-- En-tête visuelle -->
            <div class="relative h-32 bg-gradient-to-r from-vert-fonce to-vert-moyen flex items-center justify-center">
                <div class="absolute -top-6 left-1/2 transform -translate-x-1/2">
                    <div class="book-icon bg-white p-4 rounded-full shadow-lg text-vert-moyen text-4xl">
                        <i class="fas fa-book"></i>
                    </div>
                </div>
                <h2 class="text-2xl font-bold text-white mt-8">
                    <c:choose>
                        <c:when test="${typePret == 'a_domicile'}">Nouveau prêt à domicile</c:when>
                        <c:otherwise>Nouveau prêt sur place</c:otherwise>
                    </c:choose>
                </h2>
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
                
                <!-- Formulaire -->
                <form method="post" action="${pageContext.request.contextPath}/prets/save" class="space-y-4">
                    <input type="hidden" name="typePret" value="${typePret}" />
                    
                    <!-- Adhérent -->
                    <div>
                        <label class="block text-sm font-medium text-vert-fonce mb-2">
                            <i class="fas fa-user mr-2 text-vert-moyen"></i>Adhérent
                        </label>
                        <select name="adherentId" required class="w-full px-4 py-2 border border-vert-clair rounded-lg focus:outline-none focus:ring-2 focus:ring-accent appearance-none">
                            <option value="">-- Sélectionner un adhérent --</option>
                            <c:forEach var="adherent" items="${adherents}">
                                <option value="${adherent.idAdherent}">${adherent.nom} ${adherent.prenom}</option>
                            </c:forEach>
                        </select>
                    </div>
                    
                    <!-- Livre -->
                    <div>
                        <label class="block text-sm font-medium text-vert-fonce mb-2">
                            <i class="fas fa-book mr-2 text-vert-moyen"></i>Livre
                        </label>
                        <select id="livreSelect" name="livreId" required class="w-full px-4 py-2 border border-vert-clair rounded-lg focus:outline-none focus:ring-2 focus:ring-accent appearance-none">
                            <option value="">-- Sélectionner un livre --</option>
                            <c:forEach var="livre" items="${livres}">
                                <option value="${livre.idLivre}">${livre.titre} (${livre.auteur})</option>
                            </c:forEach>
                        </select>
                    </div>
                    
                    <!-- Exemplaire -->
                    <div>
                        <label class="block text-sm font-medium text-vert-fonce mb-2">
                            <i class="fas fa-barcode mr-2 text-vert-moyen"></i>Exemplaire
                        </label>
                        <select id="exemplaireSelect" name="exemplaireId" required class="w-full px-4 py-2 border border-vert-clair rounded-lg focus:outline-none focus:ring-2 focus:ring-accent appearance-none">
                            <option value="">-- Sélectionner un exemplaire --</option>
                        </select>
                    </div>
                    
                    <!-- Date du prêt -->
                    <div>
                        <label class="block text-sm font-medium text-vert-fonce mb-2">
                            <i class="fas fa-calendar-day mr-2 text-vert-moyen"></i>Date du prêt
                        </label>
                        <input 
                            type="date" 
                            name="datePret" 
                            required 
                            class="w-full px-4 py-2 border border-vert-clair rounded-lg focus:outline-none focus:ring-2 focus:ring-accent"
                        >
                    </div>
                    
                    <!-- Nombre de jours (si prêt à domicile) -->
                    <c:if test="${typePret == 'a_domicile'}">
                        <div>
                            <label class="block text-sm font-medium text-vert-fonce mb-2">
                                <i class="fas fa-clock mr-2 text-vert-moyen"></i>Durée du prêt (jours)
                            </label>
                            <input 
                                type="number" 
                                name="joursPret" 
                                min="1" 
                                max="15" 
                                value="1" 
                                required 
                                class="w-full px-4 py-2 border border-vert-clair rounded-lg focus:outline-none focus:ring-2 focus:ring-accent"
                            >
                            <p class="text-xs text-gray-500 mt-1">Durée maximale: 15 jours</p>
                        </div>
                    </c:if>
                    
                    <!-- Bouton de soumission -->
                    <div class="pt-4">
                        <button 
                            type="submit" 
                            class="btn-hover w-full flex items-center justify-center px-6 py-3 bg-accent hover:bg-opacity-90 text-white font-medium rounded-lg transition shadow-md"
                        >
                            <i class="fas fa-save mr-2"></i> Enregistrer le prêt
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <!-- Caché : pour chaque livre, on crée un <select> d'exemplaires -->
    <div class="hidden">
        <c:forEach var="livre" items="${livres}">
            <select id="exemplaires-for-livre-${livre.idLivre}">
                <c:forEach var="exemplaire" items="${livre.exemplaires}">
                    <option value="${exemplaire.idExemplaireLivre}">${exemplaire.codeBarre}</option>
                </c:forEach>
            </select>
        </c:forEach>
    </div>

    <script>
        document.getElementById('livreSelect').addEventListener('change', function() {
            const livreId = this.value;
            const exemplaireSelect = document.getElementById('exemplaireSelect');

            // Vider la liste actuelle
            exemplaireSelect.innerHTML = '<option value="">-- Sélectionner un exemplaire --</option>';

            if (!livreId) return;

            // Trouver la liste cachée correspondante
            const hiddenSelect = document.getElementById('exemplaires-for-livre-' + livreId);
            if (!hiddenSelect) return;

            // Copier les options de la liste cachée dans la liste visible
            for (let option of hiddenSelect.options) {
                exemplaireSelect.appendChild(option.cloneNode(true));
            }
        });
    </script>
</body>
</html>