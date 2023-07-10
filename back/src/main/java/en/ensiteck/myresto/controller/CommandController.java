package en.ensiteck.myresto.controller;

import com.fasterxml.jackson.annotation.JsonView;
import en.ensiteck.myresto.dto.Command;
import en.ensiteck.myresto.dto.ProductPost;
import en.ensiteck.myresto.dto.ProductReturn;
import en.ensiteck.myresto.exception.BadIdException;
import en.ensiteck.myresto.service.CommandService;
import jakarta.annotation.security.RolesAllowed;
import jakarta.validation.Valid;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.*;

import java.security.Principal;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("command")
public class CommandController {

    private final CommandService commandService;

    public CommandController(CommandService commandService){
        this.commandService=commandService;
    }

    @PostMapping("")
    public void createCommand(@Valid @RequestBody List<ProductPost> command, Principal principal) throws BadIdException {
        commandService.createCommand(principal.getName(),command);
    }

    @GetMapping("")
    @JsonView(Command.class)
    public List<Command> getCommand(Principal principal) {
        return commandService.getCommand(principal.getName());
    }

    @DeleteMapping("/{id}")
    public void deleteCommand(@PathVariable("id") Long id) throws BadIdException {
        commandService.deleteCommand(id);
    }

    @PostMapping("/{id}/send")
    @RolesAllowed("ROLE_ADMIN")
    public void sendCommand(@PathVariable("id") Long id) throws BadIdException {
        commandService.sendCommand(id);
    }

    @ExceptionHandler(BadIdException.class)
    @ResponseStatus(HttpStatus.BAD_REQUEST)
    public Map<String, String> handleValidationExceptions(
            BadIdException ex) {
        Map<String, String> errors = new HashMap<>();
        ex.getIds().forEach(id-> errors.put(id,"bad id"));
        return errors;
    }

}
