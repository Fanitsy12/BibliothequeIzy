<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Dashboard - Système de Bibliothèque</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet" />
</head>

<body class="bg-emerald-50 min-h-screen">

    <!-- Navigation -->
    <nav class="bg-emerald-800 text-white shadow-md">
        <div class="container mx-auto px-6 py-4 flex justify-between items-center">
            <a href="#" class="flex items-center space-x-3 text-2xl font-extrabold tracking-tight">
                <i class="fas fa-book-open text-3xl"></i>
                <span>Système de Bibliothèque</span>
            </a>
            <div class="hidden md:flex space-x-8 font-semibold text-emerald-200">
                <a href="/dashboard" class="hover:text-white transition-colors flex items-center gap-1">
                    <i class="fas fa-tachometer-alt"></i> Dashboard
                </a>
                <a href="/dashboard/livres-disponibles" class="hover:text-white transition-colors flex items-center gap-1">
                    <i class="fas fa-book"></i> Livres
                </a>
                <a href="/dashboard/adherents-emprunts" class="hover:text-white transition-colors flex items-center gap-1">
                    <i class="fas fa-users"></i> Adhérents
                </a>
            </div>
            <button class="md:hidden text-3xl text-emerald-200 hover:text-white">
                <i class="fas fa-bars"></i>
            </button>
        </div>
    </nav>

    <main class="container mx-auto px-6 py-8">
        <!-- Statistiques principales -->
        <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6 mb-10">
            <!-- Total Livres -->
            <div class="bg-gradient-to-r from-emerald-600 to-emerald-800 rounded-xl shadow-lg overflow-hidden text-white">
                <div class="p-6 flex items-center gap-5">
                    <div class="bg-white bg-opacity-25 p-5 rounded-full">
                        <i class="fas fa-book text-3xl"></i>
                    </div>
                    <div>
                        <p class="text-sm opacity-90 font-semibold">Total Livres</p>
                        <h3 class="text-3xl font-extrabold"><c:out value="${totalLivres}" /></h3>
                    </div>
                </div>
            </div>

            <!-- Livres Disponibles -->
            <div class="bg-gradient-to-r from-emerald-400 to-emerald-600 rounded-xl shadow-lg overflow-hidden text-white">
                <div class="p-6 flex items-center gap-5">
                    <div class="bg-white bg-opacity-25 p-5 rounded-full">
                        <i class="fas fa-check-circle text-3xl"></i>
                    </div>
                    <div>
                        <p class="text-sm opacity-90 font-semibold">Livres Disponibles</p>
                        <h3 class="text-3xl font-extrabold"><c:out value="${totalLivresDisponibles}" /></h3>
                    </div>
                </div>
            </div>

            <!-- Total Adhérents -->
            <div class="bg-gradient-to-r from-teal-600 to-emerald-700 rounded-xl shadow-lg overflow-hidden text-white">
                <div class="p-6 flex items-center gap-5">
                    <div class="bg-white bg-opacity-25 p-5 rounded-full">
                        <i class="fas fa-users text-3xl"></i>
                    </div>
                    <div>
                        <p class="text-sm opacity-90 font-semibold">Total Adhérents</p>
                        <h3 class="text-3xl font-extrabold"><c:out value="${totalAdherents}" /></h3>
                    </div>
                </div>
            </div>

            <!-- Emprunts en Cours -->
            <div class="bg-gradient-to-r from-emerald-700 to-teal-600 rounded-xl shadow-lg overflow-hidden text-white">
                <div class="p-6 flex items-center gap-5">
                    <div class="bg-white bg-opacity-25 p-5 rounded-full">
                        <i class="fas fa-hand-holding text-3xl"></i>
                    </div>
                    <div>
                        <p class="text-sm opacity-90 font-semibold">Emprunts en Cours</p>
                        <h3 class="text-3xl font-extrabold"><c:out value="${totalEmpruntsEnCours}" /></h3>
                    </div>
                </div>
            </div>
        </div>

        <div class="grid grid-cols-1 lg:grid-cols-2 gap-8 mb-10">
            <!-- Livres disponibles -->
            <section class="bg-white rounded-xl shadow-lg overflow-hidden">
                <header class="bg-emerald-700 text-white px-6 py-4 flex justify-between items-center">
                    <h3 class="text-xl font-semibold flex items-center gap-3">
                        <i class="fas fa-book"></i> Livres Disponibles
                    </h3>
                    <a href="/dashboard/livres-disponibles" class="text-sm bg-white text-emerald-700 px-4 py-1 rounded-full font-semibold hover:bg-emerald-100 transition-colors">
                        Voir tout
                    </a>
                </header>
                <div class="max-h-96 overflow-y-auto">
                    <table class="min-w-full divide-y divide-gray-200">
                        <thead class="bg-emerald-100">
                            <tr>
                                <th class="px-6 py-3 text-left text-xs font-semibold text-emerald-700 uppercase tracking-wide">Titre</th>
                                <th class="px-6 py-3 text-left text-xs font-semibold text-emerald-700 uppercase tracking-wide">Auteur</th>
                                <th class="px-6 py-3 text-left text-xs font-semibold text-emerald-700 uppercase tracking-wide">Exemplaires</th>
                            </tr>
                        </thead>
                        <tbody class="bg-white divide-y divide-emerald-200">
                            <c:choose>
                                <c:when test="${not empty livresDisponibles}">
                                    <c:forEach items="${livresDisponibles.size() > 10 ? livresDisponibles.subList(0, 10) : livresDisponibles}" var="livre">
                                        <tr class="hover:bg-emerald-50 cursor-pointer transition-colors">
                                            <td class="px-6 py-4 whitespace-nowrap text-sm font-medium text-emerald-900"><c:out value="${livre.titre}" /></td>
                                            <td class="px-6 py-4 whitespace-nowrap text-sm text-emerald-700"><c:out value="${livre.auteur}" /></td>
                                            <td class="px-6 py-4 whitespace-nowrap text-sm text-emerald-700">
                                                <span class="bg-emerald-100 text-emerald-800 text-xs font-semibold px-2.5 py-0.5 rounded-full">
                                                    <c:out value="${livre.nombreExemplairesDisponibles}" />
                                                </span>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </c:when>
                                <c:otherwise>
                                    <tr>
                                        <td colspan="3" class="px-6 py-4 text-center text-sm text-emerald-500">Aucun livre disponible</td>
                                    </tr>
                                </c:otherwise>
                            </c:choose>
                        </tbody>
                    </table>
                </div>
            </section>

            <!-- Adhérents et leurs emprunts -->
            <section class="bg-white rounded-xl shadow-lg overflow-hidden">
                <header class="bg-emerald-600 text-white px-6 py-4 flex justify-between items-center">
                    <h3 class="text-xl font-semibold flex items-center gap-3">
                        <i class="fas fa-users"></i> Adhérents - Emprunts en Cours
                    </h3>
                    <a href="/dashboard/adherents-emprunts" class="text-sm bg-white text-emerald-700 px-4 py-1 rounded-full font-semibold hover:bg-emerald-100 transition-colors">
                        Voir tout
                    </a>
                </header>
                <div class="max-h-96 overflow-y-auto">
                    <table class="min-w-full divide-y divide-gray-200">
                        <thead class="bg-emerald-100">
                            <tr>
                                <th class="px-6 py-3 text-left text-xs font-semibold text-emerald-700 uppercase tracking-wide">Adhérent</th>
                                <th class="px-6 py-3 text-left text-xs font-semibold text-emerald-700 uppercase tracking-wide">Profil</th>
                                <th class="px-6 py-3 text-left text-xs font-semibold text-emerald-700 uppercase tracking-wide">Emprunts</th>
                            </tr>
                        </thead>
                        <tbody class="bg-white divide-y divide-emerald-200">
                            <c:choose>
                                <c:when test="${not empty adherents}">
                                    <c:forEach items="${adherents.size() > 10 ? adherents.subList(0, 10) : adherents}" var="adherent">
                                        <tr class="hover:bg-emerald-50 cursor-pointer transition-colors">
                                            <td class="px-6 py-4 whitespace-nowrap text-sm font-medium text-emerald-900"><c:out value="${adherent.nomComplet}" /></td>
                                            <td class="px-6 py-4 whitespace-nowrap text-sm text-emerald-700">
                                                <span class="bg-emerald-100 text-emerald-800 text-xs font-semibold px-2.5 py-0.5 rounded-full">
                                                    <c:out value="${adherent.profil.nomProfil}" />
                                                </span>
                                            </td>
                                            <td class="px-6 py-4 whitespace-nowrap text-sm text-emerald-700">
                                                <span class="bg-emerald-200 text-emerald-900 text-xs font-semibold px-2.5 py-0.5 rounded-full mr-1">
                                                    <c:out value="${adherent.nombreEmpruntsEnCours}" />
                                                </span>
                                                <c:if test="${not empty empruntsParAdherent[adherent.idAdherent]}">
                                                    <c:forEach items="${empruntsParAdherent[adherent.idAdherent]}" var="pret">
                                                        <span
                                                            class="text-xs font-semibold px-2 py-0.5 rounded-full ml-1
                                                            ${pret.enRetard ? 'bg-red-100 text-red-800' : (pret.joursRestants <= 2 ? 'bg-yellow-100 text-yellow-800' : 'bg-emerald-100 text-emerald-800')}">
                                                            <c:out value="${pret.exemplaireLivre.livre.titre}" />
                                                        </span>
                                                    </c:forEach>
                                                </c:if>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </c:when>
                                <c:otherwise>
                                    <tr>
                                        <td colspan="3" class="px-6 py-4 text-center text-sm text-emerald-500">Aucun adhérent trouvé</td>
                                    </tr>
                                </c:otherwise>
                            </c:choose>
                        </tbody>
                    </table>
                </div>
            </section>
        </div>

        <!-- Section des emprunts en retard ou à rendre bientôt -->
        <section class="bg-white rounded-xl shadow-lg overflow-hidden">
            <header class="bg-emerald-500 text-white px-6 py-4 flex items-center gap-3">
                <i class="fas fa-exclamation-triangle text-xl"></i>
                <h3 class="text-lg font-semibold">Emprunts Nécessitant une Attention</h3>
            </header>
            <div class="max-h-96 overflow-y-auto">
                <table class="min-w-full divide-y divide-gray-200">
                    <thead class="bg-emerald-100">
                        <tr>
                            <th class="px-6 py-3 text-left text-xs font-semibold text-emerald-700 uppercase tracking-wide">Adhérent</th>
                            <th class="px-6 py-3 text-left text-xs font-semibold text-emerald-700 uppercase tracking-wide">Livre</th>
                            <th class="px-6 py-3 text-left text-xs font-semibold text-emerald-700 uppercase tracking-wide">Date d'emprunt</th>
                            <th class="px-6 py-3 text-left text-xs font-semibold text-emerald-700 uppercase tracking-wide">Date de retour prévue</th>
                            <th class="px-6 py-3 text-left text-xs font-semibold text-emerald-700 uppercase tracking-wide">Statut</th>
                            <th class="px-6 py-3 text-left text-xs font-semibold text-emerald-700 uppercase tracking-wide">Jours</th>
                        </tr>
                    </thead>
                    <tbody class="bg-white divide-y divide-emerald-200">
                        <c:forEach items="${empruntsParAdherent}" var="entry">
                            <c:forEach items="${entry.value}" var="pret">
                                <c:if test="${pret.enRetard or pret.joursRestants <= 3}">
                                    <tr class="hover:bg-emerald-50 cursor-pointer transition-colors">
                                        <td class="px-6 py-4 whitespace-nowrap text-sm font-medium text-emerald-900"><c:out value="${pret.adherent.nomComplet}" /></td>
                                        <td class="px-6 py-4 whitespace-nowrap text-sm text-emerald-700"><c:out value="${pret.exemplaireLivre.livre.titre}" /></td>
                                        <td class="px-6 py-4 whitespace-nowrap text-sm text-emerald-700"><fmt:formatDate value="${pret.dateEmprunt}" pattern="dd/MM/yyyy" /></td>
                                        <td class="px-6 py-4 whitespace-nowrap text-sm text-emerald-700"><fmt:formatDate value="${pret.dateRenduPrevue}" pattern="dd/MM/yyyy" /></td>
                                        <td class="px-6 py-4 whitespace-nowrap text-sm text-emerald-700">
                                            <span
                                                class="${pret.enRetard ? 'bg-red-100 text-red-800' : 'bg-yellow-100 text-yellow-800'} text-xs font-semibold px-2.5 py-0.5 rounded-full">
                                                <c:out value="${pret.statusPret}" />
                                            </span>
                                        </td>
                                        <td class="px-6 py-4 whitespace-nowrap text-sm font-medium">
                                            <c:choose>
                                                <c:when test="${pret.enRetard}">
                                                    <span class="text-red-600 font-bold">-<c:out value="${pret.joursDeRetard}" /> j</span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="text-yellow-600 font-bold"><c:out value="${pret.joursRestants}" /> j</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                    </tr>
                                </c:if>
                            </c:forEach>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </section>
    </main>

    <script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/js/all.min.js"></script>
    <script>
        // Actualisation automatique des statistiques toutes les 5 minutes
        setInterval(function () {
            fetch('/dashboard/api/stats')
                .then((response) => response.json())
                .then((data) => {
                    // Mise à jour des compteurs sans recharger la page
                    console.log('Statistiques mises à jour:', data);
                })
                .catch((error) => console.error('Erreur lors de la mise à jour:', error));
        }, 300000); // 5 minutes
    </script>
</body>
</html>
