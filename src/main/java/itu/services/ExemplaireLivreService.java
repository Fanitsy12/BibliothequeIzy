package itu.services;

import itu.models.ExemplaireLivre;
import itu.repositories.ExemplaireLivreRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ExemplaireLivreService {

    @Autowired
    private ExemplaireLivreRepository exemplaireLivreRepository;

    // Lister tous les exemplaires disponibles d’un livre
    public List<ExemplaireLivre> getExemplairesParLivre(Long idLivre) {
        return exemplaireLivreRepository.findByLivreIdLivre(idLivre);
    }

    // Ajouter des méthodes supplémentaires au besoin
    public List<ExemplaireLivre> listerTous() {
        return exemplaireLivreRepository.findAll();
    }

    public ExemplaireLivre getById(Long id) {
        return exemplaireLivreRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Exemplaire introuvable"));
    }

    public ExemplaireLivre enregistrer(ExemplaireLivre exemplaire) {
        return exemplaireLivreRepository.save(exemplaire);
    }
}
