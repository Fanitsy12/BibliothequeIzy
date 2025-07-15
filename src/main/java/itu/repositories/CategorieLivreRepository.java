package itu.repositories;

import itu.models.CategorieLivre;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

public interface CategorieLivreRepository extends JpaRepository<CategorieLivre, Long> {}
