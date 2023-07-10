package en.ensiteck.myresto.controller;

import en.ensiteck.myresto.dto.User;
import en.ensiteck.myresto.exception.BadIdException;
import en.ensiteck.myresto.exception.UserExisteException;
import en.ensiteck.myresto.repository.UserRepository;
import en.ensiteck.myresto.service.UserService;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpStatus;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.Map;

@RestController
@RequestMapping("user")
public class UserController {

    public UserService userService;

    public UserController(UserService userService){
        this.userService=userService;
    }

    @PostMapping("")
    public void createUser(@Valid @RequestBody User user) throws UserExisteException {
        userService.createUser(user);
    }

    @PostMapping("/login")
    public Map<String,Object> login(Authentication authentication) {
        var ret = new HashMap<String,Object>();
        ret.put("admin",authentication.getAuthorities().contains(new SimpleGrantedAuthority("ROLE_ADMIN")));
        return ret;
    }

    @ExceptionHandler(UserExisteException.class)
    @ResponseStatus(HttpStatus.BAD_REQUEST)
    public Map<String,String> handleValidationExceptions(
            UserExisteException ex) {
        Map<String,String> error = new HashMap<>();
        error.put("reason","utilisateur deja existant");
        return error;
    }

}
