package itu.services;

import itu.models.TypeLivre;
import itu.repositories.TypeLivreRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class TypeLivreService {

    @Autowired
    private TypeLivreRepository typeLivreRepository;

    public List<TypeLivre> findAll() {
        return typeLivreRepository.findAll();
    }

    public TypeLivre getById(Long id) {
        return typeLivreRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Type de livre introuvable avec l'id : " + id));
    }
}
