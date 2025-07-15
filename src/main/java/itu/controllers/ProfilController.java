package itu.controllers;

import itu.models.Profil;
import itu.services.ProfilService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping("/profils")
public class ProfilController {

    @Autowired
    private ProfilService profilService;

    // Afficher la liste des profils
    @GetMapping
    public String listerProfils(Model model) {
        model.addAttribute("profils", profilService.listerTous());
        return "Profil/liste";
    }

    // Afficher le formulaire de création
    @GetMapping("/add")
    public String afficherFormulaireCreation(Model model) {
        model.addAttribute("profil", new Profil());
        return "Profil/form";
    }

    // Afficher le formulaire d'édition
    @GetMapping("/update/{id}")
    public String afficherFormulaireEdition(@PathVariable Long id, Model model) {
        model.addAttribute("profil", profilService.trouverParId(id));
        return "Profil/form";
    }

    // Traiter création ou mise à jour
 @PostMapping("/create")
public String enregistrerProfil(
        @RequestParam(required = false) Long id,
        @RequestParam String nomProfil,
        @RequestParam int quotaMaxSurPlace,
        @RequestParam(required = false) Integer quotaMaxEmprunter,
        @RequestParam int dureePret,
        @RequestParam(required = false, defaultValue = "0") Integer dureePenalite) {

    if (id != null) {
        // Mise à jour
        Profil existant = profilService.trouverParId(id);
        if (existant != null) {
            existant.setNomProfil(nomProfil);
            existant.setQuotaMaxSurPlace(quotaMaxSurPlace);
            existant.setQuotaMaxEmprunter(quotaMaxEmprunter);
            existant.setDureePret(dureePret);
            existant.setDureePenalite(dureePenalite);
            profilService.enregistrerProfil(existant);
        }
    } else {
        // Création
        Profil nouveau = new Profil(nomProfil, quotaMaxSurPlace, quotaMaxEmprunter, dureePret);
        nouveau.setDureePenalite(dureePenalite);
        profilService.enregistrerProfil(nouveau);
    }

    return "redirect:/profils";
}


    // Supprimer un profil
    @GetMapping("/delete/{id}")
    public String supprimerProfil(@PathVariable Long id) {
        profilService.supprimerProfil(id);
        return "redirect:/profils";
    }
}
