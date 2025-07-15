package itu.repositories;

import itu.models.ExemplaireLivre;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ExemplaireLivreRepository extends JpaRepository<ExemplaireLivre, Long> {
   List<ExemplaireLivre> findByLivreIdLivre(Long idLivre);

}
