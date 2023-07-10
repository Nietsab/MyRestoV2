package en.ensiteck.myresto.service;

import en.ensiteck.myresto.dto.ProductReturn;
import jakarta.transaction.Transactional;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import static org.assertj.core.api.Assertions.*;

@SpringBootTest
@Transactional
class CardServiceTest {

    @Autowired
    CardService cardService;

    @Test
    void getAllProduct(){
        var card = cardService.getCard();
        assertThat(card.entry()).contains(new ProductReturn(4L,"salade",1.99, null),new ProductReturn(5L,"paté",2, null));
        assertThat(card.main()).contains(new ProductReturn(3L,"frite",2.50, null),new ProductReturn(2L,"cote de port",4.99, null));
        assertThat(card.dessert()).contains(new ProductReturn(1L,"glace chocolat",2, null));
        assertThat(card.drink()).contains(new ProductReturn(6L,"coca cola",3.99, null));
    }
}