<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Connexion Adhérent - Café Littéraire</title>
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
        
        document.addEventListener('DOMContentLoaded', function() {
            // Animation pour les inputs au focus
            const inputs = document.querySelectorAll('input');
            inputs.forEach(input => {
                input.addEventListener('focus', function() {
                    this.parentElement.classList.add('ring-2', 'ring-accent');
                    this.parentElement.classList.remove('ring-1', 'ring-gray-300');
                });
                input.addEventListener('blur', function() {
                    this.parentElement.classList.remove('ring-2', 'ring-accent');
                    this.parentElement.classList.add('ring-1', 'ring-gray-300');
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
        .login-container {
            background-image: url('https://images.unsplash.com/photo-1507842217343-583bb7270b66?ixlib=rb-1.2.1&auto=format&fit=crop&w=1350&q=80');
            background-size: cover;
            background-position: center;
            background-blend-mode: overlay;
        }
        
        .form-enter {
            animation: formEnter 0.6s ease-out forwards;
        }
        
        @keyframes formEnter {
            from {
                opacity: 0;
                transform: translateY(20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }
        
        .error-shake {
            animation: shake 0.5s ease-in-out;
        }
        
        @keyframes shake {
            0%, 100% { transform: translateX(0); }
            20%, 60% { transform: translateX(-5px); }
            40%, 80% { transform: translateX(5px); }
        }
    </style>
</head>
<body class="bg-vert-pale min-h-screen flex items-center justify-center p-4">
    <div class="login-container absolute inset-0 bg-vert-fonce bg-opacity-50"></div>
    
    <div class="form-enter relative w-full max-w-md bg-white rounded-xl shadow-2xl overflow-hidden z-10">
        <!-- Header de la carte -->
        <div class="bg-vert-fonce py-6 px-8 text-center">
            <h1 class="text-3xl font-bold text-white">
                <i class="fas fa-book-open mr-2"></i> Café Littéraire
            </h1>
            <p class="text-vert-clair mt-1">Espace Adhérent</p>
        </div>
        
        <!-- Messages d'erreur -->
        <c:if test="${not empty erreur}">
            <div id="errorMessage" class="error-shake bg-red-50 border-l-4 border-red-500 text-red-700 p-4 mb-6">
                <div class="flex items-center">
                    <i class="fas fa-exclamation-circle mr-3"></i>
                    <span>${erreur}</span>
                </div>
            </div>
        </c:if>
        
        <!-- Formulaire -->
        <form action="${pageContext.request.contextPath}/adherents/login" method="post" class="px-8 pt-6 pb-8">
            <!-- Champ Email -->
            <div class="mb-6 rounded-lg ring-1 ring-gray-300 px-3 py-2 focus-within:ring-2 focus-within:ring-accent transition">
                <label class="block text-vert-fonce text-sm font-medium mb-1">
                    <i class="fas fa-envelope mr-2 text-vert-moyen"></i>Email
                </label>
                <input 
                    type="email" 
                    name="email" 
                    required 
                    class="w-full px-3 py-2 text-gray-700 focus:outline-none bg-transparent"
                    placeholder="votre@email.com"
                >
            </div>
            
            <!-- Champ Mot de passe -->
            <div class="mb-8 rounded-lg ring-1 ring-gray-300 px-3 py-2 focus-within:ring-2 focus-within:ring-accent transition">
                <label class="block text-vert-fonce text-sm font-medium mb-1">
                    <i class="fas fa-lock mr-2 text-vert-moyen"></i>Mot de passe
                </label>
                <div class="relative">
                    <input 
                        id="motDePasse"
                        type="password" 
                        name="motDePasse" 
                        required 
                        class="w-full px-3 py-2 text-gray-700 focus:outline-none bg-transparent pr-10"
                        placeholder="••••••••"
                    >
                    <button 
                        type="button"
                        id="togglePassword"
                        class="absolute right-3 top-1/2 transform -translate-y-1/2 text-gray-400 hover:text-vert-moyen"
                    >
                        <i class="fas fa-eye"></i>
                    </button>
                </div>
            </div>
            
            <!-- Bouton de connexion -->
            <div class="mb-6">
                <button 
                    type="submit"
                    class="w-full bg-accent hover:bg-opacity-90 text-white font-bold py-3 px-4 rounded-lg transition duration-300 flex items-center justify-center"
                >
                    <i class="fas fa-sign-in-alt mr-2"></i> Se connecter
                </button>
            </div>
            
            <!-- Lien optionnel -->
            <div class="text-center text-sm text-gray-600">
                <a href="#" class="text-vert-moyen hover:text-vert-fonce transition">
                    Mot de passe oublié ?
                </a>
            </div>
        </form>
        
        <!-- Footer de la carte -->
        <div class="bg-beige px-8 py-4 text-center text-sm text-gray-600">
            <p>Pas encore adhérent ? <a href="#" class="text-vert-moyen font-medium hover:text-vert-fonce transition">Contactez-nous</a></p>
        </div>
    </div>
    
    <!-- Animation de fond -->
    <div class="fixed bottom-0 left-0 right-0 h-16 bg-vert-fonce opacity-20"></div>
</body>
</html>