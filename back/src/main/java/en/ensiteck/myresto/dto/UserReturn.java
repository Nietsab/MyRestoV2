package en.ensiteck.myresto.dto;

import com.fasterxml.jackson.annotation.JsonView;
import jakarta.validation.constraints.NotEmpty;

public record UserReturn(
        @JsonView(Command.class)
        String login,
        @JsonView(Command.class)
        String firstname,
        @JsonView(Command.class)
        String lastname) {
}
