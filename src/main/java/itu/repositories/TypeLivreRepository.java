package itu.repositories;

import itu.models.TypeLivre;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

public interface TypeLivreRepository extends JpaRepository<TypeLivre, Long> {}
