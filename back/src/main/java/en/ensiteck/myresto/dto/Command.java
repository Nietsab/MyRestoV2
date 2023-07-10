package en.ensiteck.myresto.dto;

import com.fasterxml.jackson.annotation.JsonView;
import en.ensiteck.myresto.entity.CommandStatus;

import java.util.Date;
import java.util.List;

public record Command(
        @JsonView(Command.class)
        Long id,
        @JsonView(Command.class)
        List<ProductReturn> product,
        @JsonView(Command.class)
        UserReturn user,
        @JsonView(Command.class)
        CommandStatus status,
        @JsonView(Command.class)
        Date date) {
}
