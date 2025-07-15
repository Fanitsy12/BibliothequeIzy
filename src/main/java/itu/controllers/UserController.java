package itu.controllers;

import itu.models.User;
import itu.services.UserService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping("/users")
public class UserController {

    @Autowired
    private UserService userService;

    @GetMapping("/login")
    public String showLoginForm() {
        return "User/login"; // userLogin.jsp
    }

    @PostMapping("/login")
    public String processLogin(@RequestParam String email,
                               @RequestParam String mdp,
                               HttpSession session,
                               Model model) {
        return userService.login(email, mdp)
                .map(user -> {
                    session.setAttribute("userConnecte", user);
                    return "redirect:/dashboard";
                })
                .orElseGet(() -> {
                    model.addAttribute("erreur", "Email ou mot de passe incorrect");
                    return "User/login";
                });
    }

    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/login";
    }
}
