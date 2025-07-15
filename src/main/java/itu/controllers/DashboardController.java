package itu.controllers;

import itu.services.DashboardService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.Map;

@Controller
@RequestMapping("/dashboard")
public class DashboardController {

    @Autowired
    private DashboardService dashboardService;

    // Affichage de la page principale du dashboard
    @GetMapping
    public String dashboard(Model model) {
        return "Dashboard/dashboard";
    }

    // Affichage des statistiques par mois/année
    @GetMapping("/stats")
    public String voirStats(
            @RequestParam int mois,
            @RequestParam int annee,
            Model model
    ) {
        Map<String, Object> stats = dashboardService.getStatistiquesMensuelles(mois, annee);
        model.addAttribute("mois", mois);
        model.addAttribute("annee", annee);
        model.addAllAttributes(stats);
        return "Dashboard/dashboard"; // Assure-toi que ce fichier JSP existe
    }
}
