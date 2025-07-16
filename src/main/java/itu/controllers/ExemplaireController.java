package itu.controllers;
import itu.models.*;
import itu.repositories.*;
import itu.services.*;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import com.fasterxml.jackson.annotation.JsonManagedReference;
import com.fasterxml.jackson.annotation.JsonBackReference;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

@RestController
@RequestMapping("/api/livre")
public class ExemplaireController {

    @Autowired
    private LivreService livreService;
 @Autowired
    private AdherentRepository adherentRepository;

    // Autres injections
    @Autowired
    private AbonnementRepository abonnementRepository;

    @Autowired
    private PenaliteRepository penaliteRepository;




   @GetMapping("/{id}/exemplaire")
public ResponseEntity<Livre> getLivreAvecExemplaire(@PathVariable Long id) {
    Optional<Livre> livreOpt = livreService.findByIdWithExemplaires(id);
    if (livreOpt.isEmpty()) {
        return ResponseEntity.notFound().build(); // 404 Not Found si le livre n'existe pas
    } else {
        return ResponseEntity.ok(livreOpt.get());
    }
}

@GetMapping("/adherent/{id}/infos")
public ResponseEntity<?> getInfosAdherent(@PathVariable Long id) {
    Optional<Adherent> adherentOpt = adherentRepository.findById(id);
    if (adherentOpt.isEmpty()) {
        return ResponseEntity.notFound().build();
    }

    Adherent adherent = adherentOpt.get();

    Map<String, Object> data = new HashMap<>();
    data.put("id", adherent.getIdAdherent());
    data.put("nom", adherent.getNom());
    data.put("prenom", adherent.getPrenom());
    data.put("email", adherent.getEmail());

    // Profil
    Map<String, Object> profil = new HashMap<>();
    profil.put("nomProfil", adherent.getProfil().getNomProfil());
    profil.put("quotaMaxSurPlace", adherent.getProfil().getQuotaMaxSurPlace());
    profil.put("quotaMaxEmprunter", adherent.getProfil().getQuotaMaxEmprunter());
    profil.put("dureePret", adherent.getProfil().getDureePret());
    profil.put("dureePenalite", adherent.getProfil().getDureePenalite());
    data.put("profil", profil);

    // Quotas actuels (via AdherentQuota)
    AdherentQuota quota = adherent.getQuota();
    if (quota != null) {
        data.put("quotaSurPlace", quota.getQuotaSurPlace());
        data.put("quotaEmprunter", quota.getQuotaEmprunter());
    }

    // Dernier abonnement actif (optionnel, à adapter selon ton service)
    Abonnement dernierAbonnement = abonnementRepository.findTopByAdherentOrderByDateFinDesc(adherent);
    if (dernierAbonnement != null) {
        Map<String, Object> abo = new HashMap<>();
        abo.put("dateDebut", dernierAbonnement.getDateDebut());
        abo.put("dateFin", dernierAbonnement.getDateFin());
        abo.put("montant", dernierAbonnement.getMontant());
        abo.put("actif", dernierAbonnement.isActif());
        data.put("abonnement", abo);
    }

    // Pénalités actives
    List<Penalite> penalites = penaliteRepository.findByAdherentIdAdherentAndLeveFalse(id);
    List<Map<String, Object>> penalitesJson = penalites.stream().map(p -> {
        Map<String, Object> pen = new HashMap<>();
        pen.put("dateDebut", p.getDateDebutPenalite());
        pen.put("dateFin", p.getDatelevePenalite());
        return pen;
    }).toList();
    data.put("penalites", penalitesJson);

    return ResponseEntity.ok(data);
}



}
