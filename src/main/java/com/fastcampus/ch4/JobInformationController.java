//package com.fastcampus.ch4;
//
//import org.springframework.stereotype.Controller;
//import org.springframework.ui.Model;
//import org.springframework.web.bind.annotation.GetMapping;
//import org.springframework.web.client.RestTemplate;
//
//import java.io.IOException;
//
//
//@Controller
//public class JobInformationController {
//
//
//    @GetMapping("/")
//    public String getJobInformation(Model model) throws IOException {
//        RestTemplate restTemplate = new RestTemplate();
//        String apiUrl = "API 호출 주소";
//        JobInformation jobInformation = restTemplate.getForObject(apiUrl, JobInformation.class);
//
//        String clientId = "네이버 API Client ID";
//        String clientSecret = "네이버 API Client Secret";
//        PapagoRestClient papagoRestClient = new PapagoRestClient(clientId, clientSecret);
//        TranslationResult translationResult = papagoRestClient.translate(jobInformation.getJobDescription(), "번역할 언어 코드");
//        String translatedText = translationResult.getTranslatedText();
//
//        model.addAttribute("jobInformation", jobInformation);
//        model.addAttribute("translatedText", translatedText);
//        return "jobInformation";
//    }
//
//
//}
