<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Bienvenue sur Bibliothèque</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <script>
        tailwind.config = {
            theme: {
                extend: {
                    colors: {
                        emeraldDark: '#064e3b',
                        emeraldMid: '#10b981',
                        emeraldLight: '#a7f3d0',
                    },
                    fontFamily: {
                        sans: ['"Segoe UI"', 'Roboto', 'sans-serif'],
                    }
                }
            }
        };
    </script>
</head>
<body class="bg-emerald-50 text-emeraldDark font-sans min-h-screen flex items-center justify-center">
    <div class="bg-white shadow-xl rounded-2xl p-10 w-full max-w-xl border border-emerald-100 transition-transform duration-500 hover:scale-[1.01]">
        <h1 class="text-4xl font-extrabold text-emeraldMid mb-6 text-center tracking-wide animate-pulse">
            Bienvenue sur <span class="text-emeraldDark">Bibliothèque</span>
        </h1>

        <div class="mt-8">
            <p class="text-lg text-center text-gray-700 mb-6">Vous êtes :</p>
            <div class="flex flex-col sm:flex-row justify-center items-center gap-4">
                <a href="${pageContext.request.contextPath}/adherents/login"
                   class="w-full sm:w-auto bg-emeraldMid hover:bg-emeraldDark text-white px-6 py-3 rounded-lg shadow-md transform hover:scale-105 transition-all duration-300 text-center">
                    Adhérent
                </a>
                <a href="${pageContext.request.contextPath}/users/login"
                   class="w-full sm:w-auto bg-emeraldMid hover:bg-emeraldDark text-white px-6 py-3 rounded-lg shadow-md transform hover:scale-105 transition-all duration-300 text-center">
                    Admin
                </a>
            </div>
        </div>
    </div>

    <!-- Petit effet JS pour le titre -->
    <script>
        document.addEventListener("DOMContentLoaded", () => {
            const title = document.querySelector("h1");
            title.addEventListener("mouseenter", () => {
                title.classList.add("scale-105");
            });
            title.addEventListener("mouseleave", () => {
                title.classList.remove("scale-105");
            });
        });
    </script>
</body>
</html>
