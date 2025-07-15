package itu.services;

import itu.models.Pret;
import itu.models.PretProlongement;
import itu.models.AdherentQuota;
import itu.models.Adherent;
import itu.models.Profil;
import itu.models.Adherent;
import itu.models.ExemplaireLivre;
import itu.models.Pret;
import itu.models.Penalite;
import itu.models.Livre;
import itu.repositories.AdherentRepository;
import itu.repositories.AbonnementRepository;
import itu.repositories.ExemplaireLivreRepository;
import itu.repositories.PenaliteRepository;
import itu.repositories.PretRepository;
import itu.repositories.AdherentQuotaRepository;
import itu.repositories.PretProlongementRepository;

import jakarta.transaction.Transactional;
import org.springframework.stereotype.Service;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.List;
import java.time.LocalDate;

@Service
public class PretProlongementService {


      @Autowired
    private  PretProlongementRepository prolongementRepository;


      @Autowired
    private AdherentQuotaRepository adherentQuotaRepository;


      @Autowired
    private PretRepository pretRepository;

     @Autowired
    private PenaliteRepository penaliteRepository;


   @Transactional
public PretProlongement demanderProlongement(Pret pret, int jours) {
    if (jours < 1 || jours > 15) {
        throw new IllegalArgumentException("Le nombre de jours doit être entre 1 et 15");
    }

    Adherent adherent = pret.getAdherent();
    Profil profil = adherent.getProfil();

      AdherentQuota quota = adherentQuotaRepository.findById(adherent.getIdAdherent())
            .orElseThrow(() -> new RuntimeException("Quota de l'adhérent introuvable."));

   if (quota.getQuotaEmprunter() >= profil.getQuotaMaxEmprunter()) {
            throw new RuntimeException("Le quota de prêts à domicile est atteint.");
        }

     if(penaliteRepository.existsByAdherent_IdAdherentAndLeveFalse(adherent.getIdAdherent())){
    throw new RuntimeException("vous etes  pénalisé.");
    }

    PretProlongement prolongement = new PretProlongement(pret, jours);
    return prolongementRepository.save(prolongement);
}

@Transactional
public void validerProlongement(Long idProlongement) {
    PretProlongement prolongement = prolongementRepository.findById(idProlongement)
        .orElseThrow(() -> new RuntimeException("Prolongement introuvable"));

    if (prolongement.getEstValide() != null && prolongement.getEstValide()) {
        throw new RuntimeException("Cette demande de prolongement est déjà validée");
    }

    Pret ancienPret = prolongement.getPret();
    ExemplaireLivre exemplaire = ancienPret.getExemplaireLivre();
    Adherent adherent = ancienPret.getAdherent();
    String typePret = ancienPret.getTypePret();

    // 🔧 Marquer le prêt comme prolongé
    ancienPret.setIsProlonged(true);
    pretRepository.save(ancienPret); // ✅ Nécessaire pour enregistrer la modification

    // 🔧 Mise à jour du quota
    AdherentQuota quota = adherentQuotaRepository.findById(adherent.getIdAdherent())
        .orElseThrow(() -> new RuntimeException("Quota de l'adhérent introuvable."));
    quota.setQuotaEmprunter(quota.getQuotaEmprunter() + 1);
     adherentQuotaRepository.save(quota);

    // 🔧 Validation du prolongement
    prolongement.setEstValide(true);
    prolongementRepository.save(prolongement);

    // 🔧 Création du nouveau prêt
    Pret nouveauPret = new Pret();
    nouveauPret.setAdherent(adherent);
    nouveauPret.setExemplaireLivre(exemplaire);
    nouveauPret.setDateEmprunt(ancienPret.getDateRenduPrevue());
    nouveauPret.setDateRenduPrevue(ancienPret.getDateRenduPrevue().plusDays(prolongement.getJourProlongement()));
    nouveauPret.setTypePret(typePret);

    pretRepository.save(nouveauPret);
}


    public List<PretProlongement> getDemandesNonValidees(){
    return prolongementRepository.findByEstValideFalse();
    }

    // Mettre à jour le prolongement




}
