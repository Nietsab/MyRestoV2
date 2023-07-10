package en.ensiteck.myresto.controller;

import jakarta.transaction.Transactional;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.http.MediaType;
import org.springframework.test.annotation.DirtiesContext;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.ResultActions;

import static org.springframework.security.test.web.servlet.request.SecurityMockMvcRequestPostProcessors.httpBasic;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.*;
import static org.springframework.test.web.servlet.result.MockMvcResultHandlers.print;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.content;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

@SpringBootTest
@AutoConfigureMockMvc
@DirtiesContext(classMode = DirtiesContext.ClassMode.BEFORE_EACH_TEST_METHOD)
class CommandControllerTest {

    @Autowired
    private MockMvc mockMvc;

    @Test
    void createCommand() throws Exception {
        createCommandRequest()
                .andExpect(status().isOk());
    }

    @Test
    void createCommandBadCommand() throws Exception {
        this.mockMvc.perform(post("/command").content("""
                        [
                        	{
                        	    "id":10,
                        	    "quantity": 1
                        	},
                        	{
                        	    "id":2,
                        	    "quantity": 1
                        	},
                        	{
                        	    "id":3,
                        	    "quantity": 1
                        	}
                        ]
                        """).contentType(MediaType.APPLICATION_JSON)
                        .with(httpBasic("test","test"))
                )
                .andExpect(status().isBadRequest())
                .andExpect(content().json("""
                {
                    "10":"bad id"
                }
                """));
    }

    @Test
    @Transactional
    void getCommand() throws Exception {
        createCommandRequest();

        this.mockMvc.perform(get("/command")
                        .with(httpBasic("test","test"))
                )
                .andExpect(status().isOk())
                .andExpect(content().json("""
[{"id":1,"product":[{"id":1,"name":"glace chocolat","price":2.0,"quantity":1},{"id":2,"name":"cote de port","price":4.99,"quantity":1},{"id":3,"name":"frite","price":2.5,"quantity":1}],"user":{"login":"test","firstname":"test","lastname":"test"},"status":"PREPARE"}]                
                """));
    }

    @Test
    void deleteCommand() throws Exception {
        createCommandRequest();
        this.mockMvc.perform(delete("/command/1").with(httpBasic("test","test"))
                )
                .andExpect(status().isOk());
    }

    @Test
    void sendCommand() throws Exception {
        createCommandRequest();
        this.mockMvc.perform(post("/command/1/send").with(httpBasic("admin","admin"))
                )
                .andExpect(status().isOk());
    }

    @Test
    void sendCommandNotAdmin() throws Exception {
        createCommandRequest();
        this.mockMvc.perform(post("/command/1/send").with(httpBasic("test","test"))
                )
                .andExpect(status().isForbidden());
    }


    ResultActions createCommandRequest() throws Exception {
        return this.mockMvc.perform(post("/command").content("""
                        [
                        	{
                        	    "id":1,
                        	    "quantity": 1
                        	},
                        	{
                        	    "id":2,
                        	    "quantity": 1
                        	},
                        	{
                        	    "id":3,
                        	    "quantity": 1
                        	}
                        ]
                        """).contentType(MediaType.APPLICATION_JSON)
                .with(httpBasic("test","test"))
        );
    }
}