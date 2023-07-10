package en.ensiteck.myresto.dto;

import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotNull;

public record ProductPost(
                          @NotNull
                          Long id,
                          @Min(0)
                          @NotNull
                          Long quantity) {
}
