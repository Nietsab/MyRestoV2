package en.ensiteck.myresto.dto;

import com.fasterxml.jackson.annotation.JsonView;

import java.util.List;

public record Card (
        @JsonView(Card.class)
        List<ProductReturn> entry,
        @JsonView(Card.class)
        List<ProductReturn> main,
        @JsonView(Card.class)
        List<ProductReturn> dessert,
        @JsonView(Card.class)
        List<ProductReturn> drink){}
