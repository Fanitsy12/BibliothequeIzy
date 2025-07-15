package itu.controllers;

import itu.models.Adherent;
import itu.models.Profil;
import itu.services.AdherentService;
import itu.services.ProfilService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import jakarta.servlet.http.HttpSession;

import java.time.LocalDate;
import java.util.List;

@Controller
@RequestMapping("/adherents")
public class AdherentController {

    @Autowired
    private AdherentService adherentService;

    @Autowired
    private ProfilService profilService;

    // Afficher le formulaire de création
    @GetMapping("/add")
    public String afficherFormulaireCreation(Model model) {
        model.addAttribute("adherent", new Adherent());
        model.addAttribute("profils", profilService.listerTous());
        return "Adherent/form";
    }

    // Traiter la création
    @PostMapping("/create")
    public String creerAdherent(
            @RequestParam String nom,
            @RequestParam String prenom,
            @RequestParam String dateNaissance,
            @RequestParam String email,
            @RequestParam String motDePasse,
            @RequestParam Long idProfil) {
        
        LocalDate date = LocalDate.parse(dateNaissance);
        adherentService.creerAdherent(nom, prenom, date, email, motDePasse, idProfil);
        return "redirect:/abonnements/add";
    }

    // Lister tous les adhérents
    @GetMapping
    public String listerAdherents(Model model) {
        model.addAttribute("adherents", adherentService.listerTous());
        return "Adherent/liste";
    }

    @GetMapping("/login")
    public String showLoginForm() {
        return "Adherent/login"; // → Fichier JSP : auth/login.jsp
    }

    @PostMapping("/login")
    public String processLogin(@RequestParam String email,
                               @RequestParam String motDePasse,
                               HttpSession session,
                               Model model) {

        return adherentService.authentifier(email, motDePasse)
                .map(adherent -> {
                 session.setAttribute("idAdherent", adherent.getIdAdherent());
                    session.setAttribute("adherentConnecte", adherent);
                    return "redirect:/livres";
                })
                .orElseGet(() -> {
                    model.addAttribute("erreur", "Adhérent non trouvé ou authentification incorrecte");
                    return "Adherent/login";
                });
    }
    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/login";
    }
}
