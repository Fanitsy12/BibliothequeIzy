package itu.services;

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
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import org.springframework.transaction.annotation.Transactional;
import java.time.LocalDate;
import java.time.Period;


import java.util.List;

@Service
public class PretService {

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



public Pret creerPretSimple(Long idAdherent, Long idExemplaire, String typePret,LocalDate date, int joursPret) {
    Adherent adherent = adherentRepository.findById(idAdherent)
            .orElseThrow(() -> new RuntimeException("Adhérent introuvable"));

    ExemplaireLivre exemplaire = exemplaireLivreRepository.findById(idExemplaire)
            .orElseThrow(() -> new RuntimeException("Exemplaire introuvable"));

    // Vérification disponibilité
    if (exemplaire.getStatus() != 1) {
        throw new RuntimeException("L'exemplaire sélectionné n'est pas disponible.");
    }

    if(penaliteRepository.existsByAdherent_IdAdherentAndLeveFalse( idAdherent)){
    throw new RuntimeException("L'adherent est pénalisé.");
    }


    // Vérification quota
    AdherentQuota quota = adherentQuotaRepository.findById(idAdherent)
            .orElseThrow(() -> new RuntimeException("Quota de l'adhérent introuvable."));

    Profil profil = adherent.getProfil(); // ou adherentRepository.findById(...).getProfil();


     Livre livre = exemplaire.getLivre();
    Integer restrictionAge = livre.getRestrictionAge();
    if (restrictionAge != null) {
        int age = Period.between(adherent.getDateNaissance(), LocalDate.now()).getYears();
        if (age < restrictionAge) {
            throw new RuntimeException("L'adhérent doit avoir au moins " + restrictionAge + " ans pour emprunter ce livre.");
        }
    }

    if ("sur_place".equalsIgnoreCase(typePret)) {
        if (quota.getQuotaSurPlace() >= profil.getQuotaMaxSurPlace()) {
            throw new RuntimeException("Le quota de prêts sur place est atteint.");
        }
        quota.setQuotaSurPlace(quota.getQuotaSurPlace() + 1);
    } else {
        if (quota.getQuotaEmprunter() >= profil.getQuotaMaxEmprunter()) {
            throw new RuntimeException("Le quota de prêts à domicile est atteint.");
        }
        quota.setQuotaEmprunter(quota.getQuotaEmprunter() + 1);
    }

    // Calcul des dates
    LocalDate today = date ;

    if (!abonnementRepository.isAbonneAlaDate(adherent, today)) {
    throw new RuntimeException("L'adhérent doit avoir un abonnement valide à la date du prêt.");
}
    LocalDate dateRenduPrevue = "sur_place".equalsIgnoreCase(typePret)
            ? today
            : today.plusDays(joursPret);

    Pret pret = new Pret();
    pret.setTypePret(typePret);
    pret.setDateEmprunt(today);
    pret.setDateRenduPrevue(dateRenduPrevue);
    pret.setAdherent(adherent);
    pret.setDateEmprunt(date);
    pret.setExemplaireLivre(exemplaire);

    
    exemplaire.setStatus(0); 
    exemplaireLivreRepository.save(exemplaire);

    adherentQuotaRepository.save(quota); 

    return pretRepository.save(pret);
}



    public List<Pret> listerTous() {
        return pretRepository.findAllWithDetails();
    }


    public Pret getById(Long id) {
        return pretRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Prêt introuvable"));
    }


    public void supprimer(Long id) {
        Pret pret = getById(id);
        pretRepository.delete(pret);
    }

@Transactional
public void rendre(Long idPret, LocalDate dateRendu) {
    Pret pret = getById(idPret);
    pret.setDateRendu(dateRendu);
    pretRepository.save(pret);

    ExemplaireLivre exemplaire = pret.getExemplaireLivre();
    exemplaire.setStatus(1); 
    exemplaireLivreRepository.save(exemplaire);

    Adherent adherent = pret.getAdherent();

    AdherentQuota quota = adherentQuotaRepository.findById(adherent.getIdAdherent())
        .orElseThrow(() -> new RuntimeException("Quota adhérent introuvable"));

    
    if ("sur_place".equalsIgnoreCase(pret.getTypePret())) {
        quota.setQuotaSurPlace(quota.getQuotaSurPlace() - 1);
    } else {
        quota.setQuotaEmprunter(quota.getQuotaEmprunter() - 1);
    }
    adherentQuotaRepository.save(quota);

    
    if (dateRendu.isAfter(pret.getDateRenduPrevue())) {
        Profil profil = adherent.getProfil(); 
        int dureePenalite = profil.getDureePenalite() != null ? profil.getDureePenalite() : 0;

        Penalite penalite = new Penalite();
        penalite.setAdherent(adherent);
        penalite.setPret(pret);
        penalite.setDateDebutPenalite(dateRendu);
        penalite.setDatelevePenalite(dateRendu.plusDays(dureePenalite));

        penaliteRepository.save(penalite);
    }
}



    public Pret modifierPret(Pret pret) {
        return pretRepository.save(pret);
    }

        public List<Pret> getPretsParAdherent(Long idAdherent) {
        return pretRepository.findByAdherentIdAdherent(idAdherent);
    }
}

