package itu.controllers;

import itu.models.Adherent;
import itu.models.ExemplaireLivre;
import itu.models.Livre;
import itu.models.Pret;
import itu.services.AdherentService;
import itu.services.ExemplaireLivreService;
import itu.services.PretProlongementService;
import itu.repositories.ExemplaireLivreRepository;
import itu.services.LivreService;
import itu.services.PretService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.http.ResponseEntity;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import jakarta.servlet.http.HttpSession;
import java.time.LocalDate;
import org.springframework.format.annotation.DateTimeFormat;


import java.util.Set;
import java.util.HashSet;
import java.util.Map;

import java.util.List;
import java.util.ArrayList;
import java.util.HashMap;


@Controller
@RequestMapping("/prets")
public class PretController {

    @Autowired
    private PretService pretService;

    @Autowired
    private LivreService livreService;

    @Autowired
    private ExemplaireLivreService exemplaireLivreService;

    @Autowired
    private ExemplaireLivreRepository exemplaireLivreRepository;

    @Autowired
    private AdherentService adherentService;

     @Autowired
    private  PretProlongementService prolongementService;

    @GetMapping
    public String listerPrets(Model model) {
        List<Pret> prets = pretService.listerTous();
        model.addAttribute("affichageParAdherent", false);
         model.addAttribute("demandes", prolongementService.getDemandesNonValidees());
        model.addAttribute("prets", prets);
        return "Pret/liste";
    }

     @GetMapping("/adherent")
    public String listerPretsAdherent(Model model, HttpSession session) {
        Long idAdherent = (Long) session.getAttribute("idAdherent");

        if (idAdherent == null) {
            model.addAttribute("erreur", "Vous devez être connecté");
            return "redirect:/adherents/login";
        }
  model.addAttribute("affichageParAdherent", true);
        List<Pret> prets = pretService.getPretsParAdherent(idAdherent);
        model.addAttribute("prets", prets);

        return "Pret/liste"; // JSP à créer
    }

@GetMapping("/add")
public String afficherFormulaire(@RequestParam("type") String typePret, Model model) {
    // Charge les livres AVEC leurs exemplaires
    model.addAttribute("livres", livreService.listerTousAvecExemplaires());
    model.addAttribute("adherents", adherentService.listerTous());
    model.addAttribute("typePret", typePret);
    return "Pret/form";
}

  

   
    @PostMapping("/save")
    public String enregistrerPret(
            @RequestParam Long adherentId,
            @RequestParam Long exemplaireId,
            @RequestParam String typePret,
            @RequestParam LocalDate date,
            @RequestParam(required = false, defaultValue = "1") int joursPret,
            Model model,
            RedirectAttributes redirectAttributes
    ) {
        try {
            pretService.creerPretSimple(adherentId, exemplaireId, typePret, date ,joursPret);
            return "redirect:/prets";
           
    } catch (RuntimeException e) {
        redirectAttributes.addFlashAttribute("errorMessage", e.getMessage());
        return "redirect:/prets/add?type=" + typePret;
       
        }
    }


 @GetMapping("/exemplaires/by-livre/{idLivre}")
    public ResponseEntity<List<Map<String, Object>>> getExemplaireParLivre(@PathVariable Long idLivre) {
        List<ExemplaireLivre> exemplaires = exemplaireLivreRepository.findByLivreIdLivre(idLivre);
        List<Map<String, Object>> response = new ArrayList<>();

        for (ExemplaireLivre e : exemplaires) {
            Map<String, Object> exemplaireData = new HashMap<>();
            exemplaireData.put("idExemplaireLivre", e.getIdExemplaireLivre());
            exemplaireData.put("codeBarre", e.getCodeBarre());
            // Ajoute d’autres champs si nécessaire, par ex. état, dateAcquisition, etc.
            response.add(exemplaireData);
        }

        return ResponseEntity.ok(response);
    }

@GetMapping("/rendre/{idPret}")
public String afficherFormRendu(@PathVariable Long idPret, Model model) {
    Pret pret = pretService.getById(idPret);
    model.addAttribute("pret", pret);
    model.addAttribute("dateRendu", LocalDate.now()); // valeur par défaut
    return "Pret/rendre"; // vers le fichier JSP
}

@PostMapping("/rendre")
public String rendrePretAvecDate(@RequestParam Long idPret,
                                 @RequestParam @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate dateRendu,
                                 RedirectAttributes redirectAttributes) {
    try {
        pretService.rendre(idPret, dateRendu);
        redirectAttributes.addFlashAttribute("message", "Prêt rendu avec succès !");
    } catch (Exception e) {
        redirectAttributes.addFlashAttribute("errorMessage", e.getMessage());
    }
    return "redirect:/prets";
}
  @GetMapping("/prolonger/{idPret}")
    public String formulaireDemande(@PathVariable Long idPret, Model model) {
        model.addAttribute("idPret", idPret);
        return "Pret/form-prolongement";
    }
@PostMapping("/demander")
public String envoyerDemande(@RequestParam Long idPret,
                             @RequestParam Integer jours,
                             RedirectAttributes redirectAttributes,
                             HttpSession session) {
    try {
        Pret pret = pretService.getById(idPret);

        // Vérifie si l'utilisateur est connecté
        Adherent adherent = (Adherent) session.getAttribute("adherentConnecte");
        if (adherent == null || !pret.getAdherent().getIdAdherent().equals(adherent.getIdAdherent())) {
            redirectAttributes.addFlashAttribute("errorMessage", "Accès non autorisé à ce prêt");
            return "redirect:adherent";
        }

        // Vérifie et envoie la demande de prolongement
        prolongementService.demanderProlongement(pret, jours);

        redirectAttributes.addFlashAttribute("successMessage", "Demande de prolongement envoyée avec succès.");
    } catch (RuntimeException e) {
        redirectAttributes.addFlashAttribute("errorMessage", e.getMessage());
    }
    return "redirect:adherent";
}
@PostMapping("/prolongements/valider/{id}")
public String validerProlongement(@PathVariable Long id, RedirectAttributes redirectAttributes) {
    try {
        prolongementService.validerProlongement(id);
        redirectAttributes.addFlashAttribute("successMessage", "Prolongement validé avec succès !");
    } catch (RuntimeException e) {
        redirectAttributes.addFlashAttribute("errorMessage", e.getMessage());
    }
    return "redirect:/";
}


}
