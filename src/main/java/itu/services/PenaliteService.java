package itu.services;

import itu.models.Penalite;
import itu.models.Adherent;
import itu.models.Pret;
import itu.repositories.PenaliteRepository;
import itu.repositories.AdherentRepository;
import itu.repositories.PretRepository;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDate;
import java.util.List;

@Service
public class PenaliteService {

    private final PenaliteRepository penaliteRepository;
    private final AdherentRepository adherentRepository;
    private final PretRepository pretRepository;

    public PenaliteService(PenaliteRepository penaliteRepository, AdherentRepository adherentRepository, PretRepository pretRepository) {
        this.penaliteRepository = penaliteRepository;
        this.adherentRepository = adherentRepository;
        this.pretRepository = pretRepository;
    }

    @Transactional
    public Penalite creerPenalite(Long idAdherent, Long idPret, int dureeJours) {
        Adherent adherent = adherentRepository.findById(idAdherent)
                .orElseThrow(() -> new RuntimeException("Adhérent introuvable"));

        Pret pret = pretRepository.findById(idPret)
                .orElse(null); // facultatif

        LocalDate debut = LocalDate.now();
        LocalDate fin = debut.plusDays(dureeJours);

        Penalite penalite = new Penalite();
        penalite.setAdherent(adherent);
        penalite.setPret(pret);
        penalite.setDateDebutPenalite(debut);
        penalite.setDatelevePenalite(fin);

        return penaliteRepository.save(penalite);
    }

    public List<Penalite> getPenalites() {
        return penaliteRepository.findAll();
    }

    public List<Penalite> getPenalitesParAdherent(Long idAdherent) {
        return penaliteRepository.findByAdherentIdAdherent(idAdherent);
    }

        @Transactional
    public void leverPenalite(Long idPenalite) {
        Penalite penalite = penaliteRepository.findById(idPenalite)
            .orElseThrow(() -> new RuntimeException("Pénalité introuvable"));

        if (Boolean.TRUE.equals(penalite.getLeve())) {
            throw new RuntimeException("Cette pénalité a déjà été levée");
        }

        penalite.setLeve(true);
        penalite.setDatelevePenalite(LocalDate.now());
        penaliteRepository.save(penalite);
    }

    // ✅ Vérifier si un adhérent a une pénalité non levée
    public boolean aPenaliteNonLevee(Long idAdherent) {
        return penaliteRepository.existsByAdherent_IdAdherentAndLeveFalse(idAdherent);
    }
}
