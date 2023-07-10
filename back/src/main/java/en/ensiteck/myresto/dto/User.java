package en.ensiteck.myresto.dto;

import jakarta.validation.constraints.NotEmpty;

public record User(
        @NotEmpty
        String login,
        @NotEmpty
        String firstname,
        @NotEmpty
        String lastname,
        @NotEmpty
        String password,
        @NotEmpty
        String email,
        @NotEmpty
        String address) {
}
