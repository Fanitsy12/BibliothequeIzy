package itu.services;

import itu.models.Adherent;
import itu.models.AdherentQuota;
import itu.repositories.AdherentQuotaRepository;
import itu.models.Profil;
import itu.repositories.AdherentRepository;
import itu.repositories.ProfilRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;


import java.util.List;
import java.util.Optional;
import java.time.LocalDate;

@Service
@Transactional
public class AdherentService {
    
    @Autowired
    private AdherentRepository adherentRepository;

    
    @Autowired
    private ProfilRepository profilRepository;

     @Autowired
    private AdherentQuotaRepository adherentQuotaRepository;

    public List<Adherent> findAll() {
        return adherentRepository.findAllWithProfil();
    }

    public Adherent findById(Long id) {
        return adherentRepository.findByIdWithDetails(id);
    }

    public List<Adherent> findAllWithCurrentPrets() {
        return adherentRepository.findAllWithCurrentPrets();
    }

    public List<Adherent> findAdherentsWithEmpruntsEnCours() {
        return adherentRepository.findAdherentsWithEmpruntsEnCours();
    }

    public List<Adherent> findAdherentsWithEmpruntsEnRetard() {
        return adherentRepository.findAdherentsWithEmpruntsEnRetard();
    }

    public List<Adherent> findByNomContaining(String nom) {
        return adherentRepository.findByNomContainingIgnoreCaseOrPrenomContainingIgnoreCase(nom, nom);
    }

    public long countTotalAdherents() {
        return adherentRepository.count();
    }

    public long countAdherentsActifs() {
        return adherentRepository.countAdherentsWithCurrentPrets();
    }

    public Adherent save(Adherent adherent) {
        return adherentRepository.save(adherent);
    }

    public void delete(Long id) {
        adherentRepository.deleteById(id);
    }

    public List<Adherent> findByProfil(Long profilId) {
        return adherentRepository.findByProfilIdProfil(profilId);
    }

  


@Transactional
public Adherent creerAdherent(String nom, String prenom, LocalDate dateNaissance,
                              String email, String motDePasse, Long idProfil) {

    if (adherentRepository.existsByEmail(email)) {
        throw new RuntimeException("Un adhérent avec cet email existe déjà");
    }

    Profil profil = profilRepository.findById(idProfil)
        .orElseThrow(() -> new RuntimeException("Profil non trouvé"));

    Adherent adherent = new Adherent();
    adherent.setNom(nom);
    adherent.setPrenom(prenom);
    adherent.setDateNaissance(dateNaissance);
    adherent.setEmail(email);
    adherent.setMotDePasse(motDePasse);
    adherent.setDateInscription(LocalDate.now());
    adherent.setProfil(profil);

 
  Adherent save= adherentRepository.save(adherent);
  return save;

    
}





    public List<Adherent> listerTous() {
        return adherentRepository.findAll();
    }
     public Optional<Adherent> authentifier(String email, String motDePasse) {
        return adherentRepository.findByEmailAndMotDePasse(email, motDePasse);
    }

}
