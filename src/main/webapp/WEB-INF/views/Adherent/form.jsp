<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Nouvel Adhérent - Café Littéraire</title>
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
            // Validation des champs
            const form = document.querySelector('form');
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
            
            // Toggle password visibility
            const togglePassword = document.querySelector('#togglePassword');
            if (togglePassword) {
                togglePassword.addEventListener('click', function() {
                    const password = document.querySelector('#motDePasse');
                    const type = password.getAttribute('type') === 'password' ? 'text' : 'password';
                    password.setAttribute('type', type);
                    this.classList.toggle('fa-eye-slash');
                    this.classList.toggle('fa-eye');
                });
            }
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
                    <i class="fas fa-user-plus mr-3"></i> Nouvel Adhérent
                </h1>
                <p class="text-vert-clair mt-1">Enregistrez un nouveau membre du Café Littéraire</p>
            </div>
            
            <!-- Formulaire -->
            <form action="${pageContext.request.contextPath}/adherents/create" method="post" class="px-6 py-4">
                <!-- Nom et Prénom -->
                <div class="grid grid-cols-1 md:grid-cols-2 gap-6 mb-6">
                    <!-- Nom -->
                    <div>
                        <label for="nom" class="block text-sm font-medium text-vert-fonce mb-2 required">
                            <i class="fas fa-user-tag mr-2 text-vert-moyen"></i>Nom
                        </label>
                        <input 
                            type="text" 
                            id="nom" 
                            name="nom" 
                            required
                            class="w-full px-4 py-2 border border-vert-clair rounded-lg focus:outline-none focus:ring-2 focus:ring-accent"
                        >
                    </div>
                    
                    <!-- Prénom -->
                    <div>
                        <label for="prenom" class="block text-sm font-medium text-vert-fonce mb-2">
                            <i class="fas fa-user mr-2 text-vert-moyen"></i>Prénom
                        </label>
                        <input 
                            type="text" 
                            id="prenom" 
                            name="prenom" 
                            class="w-full px-4 py-2 border border-vert-clair rounded-lg focus:outline-none focus:ring-2 focus:ring-accent"
                        >
                    </div>
                </div>
                
                <!-- Date de Naissance -->
                <div class="mb-6">
                    <label for="dateNaissance" class="block text-sm font-medium text-vert-fonce mb-2">
                        <i class="fas fa-birthday-cake mr-2 text-vert-moyen"></i>Date de Naissance
                    </label>
                    <input 
                        type="date" 
                        id="dateNaissance" 
                        name="dateNaissance" 
                        class="w-full px-4 py-2 border border-vert-clair rounded-lg focus:outline-none focus:ring-2 focus:ring-accent"
                    >
                </div>
                
                <!-- Email -->
                <div class="mb-6">
                    <label for="email" class="block text-sm font-medium text-vert-fonce mb-2 required">
                        <i class="fas fa-envelope mr-2 text-vert-moyen"></i>Email
                    </label>
                    <input 
                        type="email" 
                        id="email" 
                        name="email" 
                        required
                        class="w-full px-4 py-2 border border-vert-clair rounded-lg focus:outline-none focus:ring-2 focus:ring-accent"
                    >
                </div>
                
                <!-- Mot de passe -->
                <div class="mb-6">
                    <label for="motDePasse" class="block text-sm font-medium text-vert-fonce mb-2 required">
                        <i class="fas fa-lock mr-2 text-vert-moyen"></i>Mot de passe
                    </label>
                    <div class="relative">
                        <input 
                            type="password" 
                            id="motDePasse" 
                            name="motDePasse" 
                            maxlength="10" 
                            required
                            class="w-full px-4 py-2 border border-vert-clair rounded-lg focus:outline-none focus:ring-2 focus:ring-accent pr-10"
                        >
                        <button 
                            type="button"
                            id="togglePassword"
                            class="absolute right-3 top-1/2 transform -translate-y-1/2 text-gray-400 hover:text-vert-moyen"
                        >
                            <i class="fas fa-eye"></i>
                        </button>
                    </div>
                    <p class="text-xs text-gray-500 mt-1">Maximum 10 caractères</p>
                </div>
                
                <!-- Profil -->
                <div class="mb-8">
                    <label for="idProfil" class="block text-sm font-medium text-vert-fonce mb-2 required">
                        <i class="fas fa-user-tag mr-2 text-vert-moyen"></i>Profil
                    </label>
                    <select 
                        id="idProfil" 
                        name="idProfil" 
                        required
                        class="w-full px-4 py-2 border border-vert-clair rounded-lg focus:outline-none focus:ring-2 focus:ring-accent appearance-none"
                    >
                        <option value="">-- Sélectionnez un profil --</option>
                        <c:forEach items="${profils}" var="profil">
                            <option value="${profil.idProfil}">${profil.nomProfil}</option>
                        </c:forEach>
                    </select>
                </div>
                
                <!-- Boutons -->
                <div class="flex flex-col-reverse sm:flex-row justify-between gap-4 mt-8">
                    <a 
                        href="${pageContext.request.contextPath}/adherents" 
                        class="flex items-center justify-center px-6 py-3 bg-gray-200 hover:bg-gray-300 text-gray-800 font-medium rounded-lg transition"
                    >
                        <i class="fas fa-arrow-left mr-2"></i> Annuler
                    </a>
                    <button 
                        type="submit" 
                        class="flex items-center justify-center px-6 py-3 bg-accent hover:bg-opacity-90 text-white font-medium rounded-lg transition"
                    >
                        <i class="fas fa-save mr-2"></i> Enregistrer l'adhérent
                    </button>
                </div>
            </form>
        </div>
    </div>
</body>
</html>