package itu.repositories;

import itu.models.Profil;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import java.util.List;
import java.util.Optional;

public interface ProfilRepository extends JpaRepository<Profil, Long> {
    boolean existsByNomProfil(String nomProfil);
    List<Profil> findByOrderByNomProfilAsc();


@Query("SELECT p FROM Profil p LEFT JOIN FETCH p.adherents WHERE p.idProfil = :id")
Optional<Profil> findByIdWithAdherents(@Param("id") Long id);
}