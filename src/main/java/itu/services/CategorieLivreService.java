package itu.services;

import itu.models.CategorieLivre;
import itu.repositories.CategorieLivreRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class CategorieLivreService {

    @Autowired
    private CategorieLivreRepository categorieLivreRepository;

    public List<CategorieLivre> findAll() {
        return categorieLivreRepository.findAll();
    }

    public CategorieLivre getById(Long id) {
        return categorieLivreRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Catégorie introuvable avec l'id : " + id));
    }
}
