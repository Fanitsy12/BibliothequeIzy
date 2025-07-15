package itu.services;

import itu.models.Reservation;

import itu.models.Adherent;
import itu.models.ExemplaireLivre;
import itu.models.Pret;
import itu.models.Penalite;
import itu.models.AdherentQuota;
import itu.models.Profil;
import itu.models.Livre;
import itu.repositories.AdherentRepository;
import itu.repositories.AbonnementRepository;
import itu.repositories.ExemplaireLivreRepository;
import itu.repositories.PenaliteRepository;
import itu.repositories.PretRepository;
import itu.repositories.AdherentQuotaRepository;
import itu.repositories.ReservationRepository;
import org.springframework.beans.factory.annotation.Autowired;

import org.springframework.transaction.annotation.Transactional;
import org.springframework.stereotype.Service;
import java.time.LocalDate;
import java.util.List;
import java.time.Period;
@Service
public class ReservationService {
    @Autowired
    private ReservationRepository reservationRepository;

        @Autowired
    private PretRepository pretRepository;

    @Autowired
    private AdherentRepository adherentRepository;

    @Autowired
    private ExemplaireLivreRepository exemplaireLivreRepository;

     @Autowired
    private AbonnementRepository abonnementRepository;

     @Autowired
    private AdherentQuotaRepository adherentQuotaRepository;

     @Autowired
    private PenaliteRepository penaliteRepository;


    public List<Reservation> findAll() {
        return reservationRepository.findAll();
    }

    public Reservation save(Reservation reservation) {
        return reservationRepository.save(reservation);
    }

    public Reservation getById(Long id) {
        return reservationRepository.findById(id).orElse(null);
    }

    public void deleteById(Long id) {
        reservationRepository.deleteById(id);
    }

    @Transactional
    public Reservation createReservation(Long idAdherent, Long idExemplaire,LocalDate Date_debut_reservation, int jourReservation) {
    Adherent adherent = adherentRepository.findById(idAdherent)
        .orElseThrow(() -> new RuntimeException("Adhérent introuvable"));



    ExemplaireLivre exemplaire = exemplaireLivreRepository.findById(idExemplaire)
        .orElseThrow(() -> new RuntimeException("Exemplaire introuvable"));

    // Vérif abonnement actif
    if (!abonnementRepository.isAbonneAlaDate(adherent,  Date_debut_reservation)) {
        throw new RuntimeException("L'adhérent n'a pas d'abonnement actif pour cette periode.");
    }

    // Vérif pénalité
    if (penaliteRepository.existsByAdherent_IdAdherentAndLeveFalse(idAdherent)) {
        throw new RuntimeException("L'adhérent est pénalisé.");
    }



     Livre livre = exemplaire.getLivre();
    // Vérif restriction d’âge
    Integer restrictionAge = livre.getRestrictionAge();
    if (restrictionAge != null) {
        int age = Period.between(adherent.getDateNaissance(), LocalDate.now()).getYears();
        if (age < restrictionAge) {
            throw new RuntimeException("L'adhérent doit avoir au moins " + restrictionAge + " ans.");
        }
    }

    // Vérif quota
    AdherentQuota quota = adherentQuotaRepository.findById(idAdherent)
        .orElseThrow(() -> new RuntimeException("Quota adhérent introuvable."));
    Profil profil = adherent.getProfil();
     if (quota.getQuotaEmprunter() >= profil.getQuotaMaxEmprunter()) {
            throw new RuntimeException("Le quota est atteint.");
        }else{
        quota.setQuotaEmprunter(quota.getQuotaEmprunter() + 1);
    }

    // Vérif conflit réservation
    LocalDate debut =  Date_debut_reservation;// date future par défaut
    LocalDate fin = debut.plusDays(jourReservation);
    boolean enConflit = reservationRepository.existsByExemplaireLivre_IdExemplaireLivreAndDateDebutReservationBetween(
        idExemplaire, debut, fin
    );
    if (enConflit) {
        throw new RuntimeException("Cet exemplaire est déjà réservé sur cette période.");
    }

    // Création de la réservation
    Reservation reservation = new Reservation();
    reservation.setAdherent(adherent);
    reservation.setLivre(livre);
    reservation.setExemplaireLivre(exemplaire);
    reservation.setDateReservation(LocalDate.now());
    reservation.setDateDebutReservation(debut);
    reservation.setDateFinReservation(fin);
    reservation.setIsApproved(false); // par défaut

    return reservationRepository.save(reservation);
}
@Transactional
public void validerReservation(Long id) {
    Reservation reservation = reservationRepository.findById(id)
        .orElseThrow(() -> new RuntimeException("Réservation introuvable."));

    if (Boolean.TRUE.equals(reservation.getIsApproved())) {
        throw new RuntimeException("Cette réservation est déjà validée.");
    }

    // Marquer la réservation comme validée
    reservation.setIsApproved(true);
    reservationRepository.save(reservation);

    // Création du prêt à partir de la réservation
    Pret pret = new Pret();
    pret.setAdherent(reservation.getAdherent());
    pret.setExemplaireLivre(reservation.getExemplaireLivre());
    pret.setDateEmprunt(reservation.getDateDebutReservation());
    pret.setDateRenduPrevue(reservation.getDateFinReservation());
    pret.setTypePret("a_domicile"); // ou une autre valeur si tu veux personnaliser

    // L’exemplaire devient indisponible
    ExemplaireLivre exemplaire = reservation.getExemplaireLivre();
    exemplaire.setStatus(0); // par exemple, 0 = indisponible
    exemplaireLivreRepository.save(exemplaire);

    // Sauvegarder le prêt
    pretRepository.save(pret);
}


}
