package itu.controllers;

import itu.models.Reservation;
import itu.services.ReservationService;
import itu.services.LivreService;
import itu.services.ExemplaireLivreService;
import itu.models.Livre;
import itu.models.ExemplaireLivre;
import itu.models.Adherent;
import jakarta.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDate;
import java.util.List;

@Controller
@RequestMapping("/reservations")
public class ReservationController {

    @Autowired
    private ReservationService reservationService;

    @Autowired
    private LivreService livreService;

    @Autowired
    private ExemplaireLivreService exemplaireLivreService;

    @GetMapping("/add")
    public String showForm(Model model) {
        List<Livre> livres =livreService.listerTousAvecExemplaires() ;
        model.addAttribute("livres", livres);
        return "Reservation/form";
    }
@PostMapping("/create")
public String saveReservation(
    @RequestParam Long exemplaireId,
    @RequestParam Integer jourReservation,
    @RequestParam("dateDebutReservation") LocalDate dateDebutReservation, // ✔️ directement LocalDate
    HttpSession session,
    Model model
) {
    try {
        Adherent adherent = (Adherent) session.getAttribute("adherentConnecte");
        if (adherent == null) {
            model.addAttribute("errorMessage", "Vous devez être connecté.");
            return "redirect:/login";
        }

        reservationService.createReservation(
            adherent.getIdAdherent(),
            exemplaireId,
            dateDebutReservation,
            jourReservation
        );

        return "redirect:/livres"; // redirection vers la liste après succès

    } catch (Exception e) {
        model.addAttribute("errorMessage", e.getMessage());
        return "Reservation/form"; // la vue du formulaire
    }
}

    @GetMapping
    public String listReservations(Model model) {
        List<Reservation> reservations = reservationService.findAll();
        model.addAttribute("reservations", reservations);
        return "Reservation/liste";
    }

    @PostMapping("/valider/{id}")
    public String validerReservation(@PathVariable Long id) {
        reservationService.validerReservation(id);
        return "redirect:/reservations";
    }
}
