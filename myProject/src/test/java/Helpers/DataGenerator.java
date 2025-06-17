package Helpers;

import com.github.javafaker.Faker;

import net.minidev.json.JSONObject;

public class DataGenerator {

    public static String getEmailId(){

    Faker fake = new Faker();
    String emailId = fake.name().firstName().toLowerCase() + fake.random().nextInt(0,200) + "@karatetest.com";
    //String userName = fake.name().firstName();
    return (emailId);    
    }

    public static String getUserName(){
    Faker fake = new Faker();
    //String emailId = fake.name().firstName() + fake.random().nextInt(0,200) + "@karatetest.com";
    String userName = fake.name().firstName();
    return (userName);
    }

    public static JSONObject getRandomArticlesData(){
        
        Faker fake = new Faker();
        String title = fake.gameOfThrones().character();
        String description = fake.gameOfThrones().city();
        String body = fake.gameOfThrones().quote();
        JSONObject json = new JSONObject();
        json.put("title",title);
        json.put("description",description);
        json.put("body",body);
        return json;
    }
    

    
}
