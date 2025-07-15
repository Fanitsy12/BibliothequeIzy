package itu.controllers;

import itu.models.Abonnement;
import itu.models.Adherent;
import itu.services.AbonnementService;
import itu.services.AdherentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.List;
@Controller
@RequestMapping("/abonnements")
public class AbonnementController {

    @Autowired
    private AbonnementService abonnementService;
    
    @Autowired
    private AdherentService adherentService;
    
 @GetMapping("/add")
public String afficherFormulaireAbonnement(Model model) {
    // Récupère tous les adhérents
    List<Adherent> adherents = adherentService.listerTous();
    
    model.addAttribute("adherents", adherents);
    model.addAttribute("abonnement", new Abonnement());
    return "Abonnement/form";
}

@PostMapping("/create")
public String enregistrerAbonnement(
        @RequestParam Long adherentId,
        @RequestParam BigDecimal montant,
        @RequestParam LocalDate dateDebut,
        @RequestParam LocalDate dateFin
       ) {
    
    try {
        Abonnement abonnement = abonnementService.creerAbonnement(
            adherentId, montant, dateDebut, dateFin);

        return "redirect:/adherents";
    } catch (IllegalArgumentException | IllegalStateException e) {
  
        return "redirect:/abonnements/add";
    }
}
    
    @GetMapping("/adherent/{adherentId}")
    public String listerAbonnementsAdherent(
            @PathVariable Long adherentId,
            Model model) {
        
        model.addAttribute("abonnements", 
            abonnementService.listerAbonnementsAdherent(adherentId));
        model.addAttribute("adherent", 
            adherentService.findById(adherentId));
        return "abonnements/liste";
    }
}
