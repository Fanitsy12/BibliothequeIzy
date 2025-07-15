package itu.services;

import itu.models.Livre;
import itu.repositories.LivreRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import java.util.List;
import java.util.Collections;
import java.util.Optional;
@Service
@Transactional
public class LivreService {
    
    @Autowired
    private LivreRepository livreRepository;

  public List<Livre> listerTous() {
        return livreRepository.findAll();
    }

    public List<Livre> listerTousAvecExemplaires() {
    return livreRepository.findAllWithExemplaires();
}
    public List<Livre> rechercherLivres(String titre, String auteur, Integer annee, Long typeId) {
        return livreRepository.rechercherLivres(
                (titre == null || titre.isBlank()) ? null : titre,
                (auteur == null || auteur.isBlank()) ? null : auteur,
                annee,
                typeId
        );
    }

    // Méthode 2: recherche par catégories multiples
    public List<Livre> rechercherLivresParCategories(List<Long> categories) {
        if (categories == null || categories.isEmpty()) {
            return Collections.emptyList(); // Ou livreRepository.findAll() si vous préférez retourner tout
        }
        return livreRepository.rechercherLivresParCategories(categories);
    }


    public Optional<Livre> findByIdWithExemplaires(Long id) {
        return livreRepository.findByIdWithExemplaires(id);
    }

}