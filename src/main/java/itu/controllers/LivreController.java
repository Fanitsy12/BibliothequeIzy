package itu.controllers;

import itu.models.CategorieLivre;
import itu.models.Livre;
import itu.models.TypeLivre;
import itu.services.CategorieLivreService;
import itu.services.LivreService;
import itu.services.TypeLivreService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
@RequestMapping("/livres")
@RestController  // au niveau de la classe controller
public class LivreController {

    @Autowired
    private LivreService livreService;

    @Autowired
    private TypeLivreService typeLivreService;

    @Autowired
    private CategorieLivreService categorieLivreService;

@GetMapping
public String listeLivres(Model model,
                         @RequestParam(required = false) String titre,
                         @RequestParam(required = false) String auteur,
                         @RequestParam(required = false) Integer annee,
                         @RequestParam(required = false) Long typeId) {

    List<Livre> livres = livreService.rechercherLivres(titre, auteur, annee, typeId);
    List<TypeLivre> types = typeLivreService.findAll();
    List<CategorieLivre> categories = categorieLivreService.findAll();

    model.addAttribute("livres", livres);
    model.addAttribute("types", types);
    model.addAttribute("categories", categories);

    // garder les valeurs saisies pour affichage dans formulaire
    model.addAttribute("titre", titre);
    model.addAttribute("auteur", auteur);
    model.addAttribute("annee", annee);
    model.addAttribute("typeId", typeId);

    return "Livre/liste"; // jsp
}

    @GetMapping("/filtrer-categories")
    public String filtrerParCategories(@RequestParam(required = false) List<Long> categoriesSelectionnees, Model model) {
        List<Livre> livres;
        if (categoriesSelectionnees == null || categoriesSelectionnees.isEmpty()) {
            livres = livreService.rechercherLivres(null, null, null, null);
        } else {
            livres = livreService.rechercherLivresParCategories(categoriesSelectionnees);
        }

        List<TypeLivre> types = typeLivreService.findAll();
        List<CategorieLivre> allCategories = categorieLivreService.findAll();

        model.addAttribute("livres", livres);
        model.addAttribute("types", types);
        model.addAttribute("categories", allCategories);

        model.addAttribute("categoriesSelectionnees", categoriesSelectionnees);

        return "Livre/liste"; // jsp
    }
}
