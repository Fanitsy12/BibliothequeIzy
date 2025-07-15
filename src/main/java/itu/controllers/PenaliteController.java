package itu.controllers;

import itu.models.Penalite;
import itu.services.PenaliteService;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;


@Controller
@RequestMapping("/penalites")
public class PenaliteController {

    private final PenaliteService penaliteService;

    public PenaliteController(PenaliteService penaliteService) {
        this.penaliteService = penaliteService;
    }

    @GetMapping
    public String lister(Model model) {
        List<Penalite> penalites = penaliteService.getPenalites();
        model.addAttribute("penalites", penalites);
        return "Penalite/liste";
    }

    @PostMapping("/add")
    public String ajouter(@RequestParam Long idAdherent,
                          @RequestParam(required = false) Long idPret,
                          @RequestParam(defaultValue = "7") int duree) {
        penaliteService.creerPenalite(idAdherent, idPret, duree);
        return "redirect:/penalites";
    }
      @PostMapping("/lever/{id}")
    public ResponseEntity<?> leverPenalite(@PathVariable Long id) {
        penaliteService.leverPenalite(id);
        return ResponseEntity.ok("Pénalité levée");
    }
}
