package itu.services;

import itu.models.Profil;
import itu.repositories.ProfilRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;
@Service
public class ProfilService {

    @Autowired
    private ProfilRepository profilRepository;

    @Transactional
    public Profil enregistrerProfil(String nomProfil, int quotaMaxSurPlace, 
                            Integer quotaMaxEmprunter, int dureePret) {
        
        if (profilRepository.existsByNomProfil(nomProfil)) {
            throw new RuntimeException("Un profil avec ce nom existe déjà");
        }

        Profil profil = new Profil();
        profil.setNomProfil(nomProfil);
        profil.setQuotaMaxSurPlace(quotaMaxSurPlace);
        profil.setQuotaMaxEmprunter(quotaMaxEmprunter);
        profil.setDureePret(dureePret);

        return profilRepository.save(profil);
    }
    public Profil enregistrerProfil(Profil profil) {
    return profilRepository.save(profil);
}

    @Transactional(readOnly = true)
    public List<Profil> listerTous() {
        return profilRepository.findByOrderByNomProfilAsc();
    }

    @Transactional(readOnly = true)
    public Profil trouverParId(Long id) {
        return profilRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Profil non trouvé"));
    }

  
public void supprimerProfil(Long id) {
    Profil profil = profilRepository.findByIdWithAdherents(id)
        .orElseThrow(() -> new RuntimeException("Profil introuvable"));

    if (!profil.getAdherents().isEmpty()) {
        throw new RuntimeException("Impossible de supprimer : des adhérents sont encore liés à ce profil");
    }

    profilRepository.delete(profil);
}
}