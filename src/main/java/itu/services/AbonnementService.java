package itu.services;

import itu.models.Abonnement;
import itu.models.Adherent;
import itu.models.AdherentQuota;
import itu.repositories.AbonnementRepository;
import org.springframework.beans.factory.annotation.Autowired;
import itu.repositories.AdherentQuotaRepository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.List;

@Service
public class AbonnementService {

    @Autowired
    private AbonnementRepository abonnementRepository;
    
    @Autowired
    private AdherentService adherentService;

    @Autowired
    private AdherentQuotaRepository adherentQuotaRepository;
    

@Transactional
public Abonnement creerAbonnement(Long adherentId, BigDecimal montant, 
                                 LocalDate dateDebut, LocalDate dateFin) {
    
    // Validation des dates
    if (dateDebut.isAfter(dateFin)) {
        throw new IllegalArgumentException("La date de fin doit être après la date de début");
    }

    Adherent adherent = adherentService.findById(adherentId);
     

    // 2. Initialiser le quota si nécessaire
 

    System.out.println("ID adhérent = " + adherent.getIdAdherent());

    // Vérification des conflits de dates
    if (abonnementRepository.existsByAdherentAndDates(
            adherent, dateDebut, dateFin)) {
        throw new IllegalStateException("Un abonnement existe déjà pour cet adhérent sur cette période");
    }

    // Validation du montant
    if (montant.compareTo(BigDecimal.ZERO) <= 0) {
        throw new IllegalArgumentException("Le montant doit être positif");
    }
    
    // --- Nouvelle partie : gestion quota ---
    // Vérifie si un quota existe déjà pour cet adhérent
    boolean quotaExiste = adherentQuotaRepository.existsById(adherent.getIdAdherent());
    
    if (!quotaExiste) {
      AdherentQuota quota = new AdherentQuota(adherentId,0,0);
       
        adherentQuotaRepository.save(quota);  

    }
    // ----------------------------------------

    Abonnement abonnement = new Abonnement();
    abonnement.setAdherent(adherent);
    abonnement.setMontant(montant);
    abonnement.setDateDebut(dateDebut);
    abonnement.setDateFin(dateFin);

    return abonnementRepository.save(abonnement);
}
    @Transactional(readOnly = true)
    public List<Abonnement> listerAbonnementsAdherent(Long adherentId) {
        return abonnementRepository.findByAdherentIdAdherent(adherentId);
    }
    
    @Transactional(readOnly = true)
    public boolean adherentAbonnementActif(Long adherentId) {
        return abonnementRepository.existsByAdherentIdAdherentAndDateFinAfter(adherentId, LocalDate.now());
    }
}