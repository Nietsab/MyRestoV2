package en.ensiteck.myresto.controller;

import jakarta.transaction.Transactional;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.boot.test.autoconfigure.web.servlet.WebMvcTest;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.result.MockMvcResultHandlers;

import static org.junit.jupiter.api.Assertions.*;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.content;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;


@SpringBootTest
@AutoConfigureMockMvc
@Transactional
class CardControllerTest {

    @Autowired
    private MockMvc mockMvc;


    @Test
    void getCard() throws Exception {
        this.mockMvc.perform(get("/card"))
                .andExpect(status().isOk())
                .andExpect(content().json("""
                        {
                        \t"entry": [
                        \t\t{
                        \t\t\t"id": 4,
                        \t\t\t"name": "salade",
                        \t\t\t"price": 1.99
                        \t\t},
                        \t\t{
                        \t\t\t"id": 5,
                        \t\t\t"name": "paté",
                        \t\t\t"price": 2.0
                        \t\t}
                        \t],
                        \t"main": [
                        \t\t{
                        \t\t\t"id": 2,
                        \t\t\t"name": "cote de port",
                        \t\t\t"price": 4.99
                        \t\t},
                        \t\t{
                        \t\t\t"id": 3,
                        \t\t\t"name": "frite",
                        \t\t\t"price": 2.5
                        \t\t}
                        \t],
                        \t"dessert": [
                        \t\t{
                        \t\t\t"id": 1,
                        \t\t\t"name": "glace chocolat",
                        \t\t\t"price": 2.0
                        \t\t}
                        \t],
                        \t"drink": [
                        \t\t{
                        \t\t\t"id": 6,
                        \t\t\t"name": "coca cola",
                        \t\t\t"price": 3.99
                        \t\t}
                        \t]
                        }"""));
    }

}