package com.mig.blb.member.controller;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.IOException;
import java.net.URISyntaxException;
import java.util.ArrayList;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.ClassPathResource;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.mig.blb.member.model.service.MemberService;
import com.mig.blb.member.model.vo.CertEmail;

@Controller
public class EmailController {
	
	private ArrayList<CertEmail> certNoList = new ArrayList<>();
	
	//private static final long VALID_MINUTES = 5; // 인증 유효 시간 (5분)
	
	@Autowired
	private JavaMailSender mailSender;
	
	@Autowired
	private MemberService memberService;
	
	
	// 인증코드 뽑기 
	public static String randomKey() {
		StringBuilder randomKey = new StringBuilder();
		String random = "abcdefghijklmnopqrstuvwxyz0123456789"; 
		
		for(int i = 0; i <6; i++) {
			int randomIndex = (int)(Math.random() * random.length());
			randomKey.append(random .charAt(randomIndex));
		}
		
		return randomKey.toString();
	}
	
	// 인증코드랑 같이 메일 보내기
	@ResponseBody
	@PostMapping(value="cert.do",produces="text/html; charset=UTF-8")
	public String sendCertNo(String email) throws MessagingException, IOException, URISyntaxException {
		
		String certKey = randomKey();
		
		CertEmail certEmail = new CertEmail();
		
		certEmail.setCertKey(certKey);
	    certEmail.setCertEmail(email);
		 
		int result = memberService.insertCertEmail(certEmail);
		
		if (result > 0) {
			
			File file = new File(getClass().getClassLoader().getResource("certEmail.txt").toURI());
			
			String htmlContent = readEmailTemplateFromFile(file);
			
			htmlContent = htmlContent.replace("${certKey}", certKey);
			
			MimeMessage message = mailSender.createMimeMessage();
			
			MimeMessageHelper mimeMessageHelper
					= new MimeMessageHelper(message, true, "UTF-8");
		
			mimeMessageHelper.setSubject("[뷰라밸] 인증코드 안내 메일입니다."); // 제목
			
			String to = email; 
			
			mimeMessageHelper.setTo(to);
			
			mimeMessageHelper.setText(htmlContent,true);
			
			mailSender.send(message);
			
			return "인증코드 메일 발송!";
		 
		 }else {
	        
			 return "인증 메일 발송 실패";
	    }
	}
	
	// HTML 파일을 읽어오는 메소드
    private String readEmailTemplateFromFile(File file) throws IOException {
        StringBuilder content = new StringBuilder();

        BufferedReader br = new BufferedReader(new FileReader(file));
            String line;
            while ((line = br.readLine()) != null) {
                content.append(line).append("\n");
            }
        
        return content.toString();
    }
	
		
		// 인증번호 대조 요청
		@ResponseBody
		@PostMapping(value="validateEmail.do", produces="text/html; charset=UTF-8")
		public String validate(String email, String certKey) {
			
			CertEmail validate = new CertEmail();
			validate.setCertEmail(email);
			validate.setCertKey(certKey);
			
			int result = memberService.selectCertEmail(validate);	

			String resultMsg = "";
			
			if(result > 0 ) {
			
				resultMsg = "인증성공!";
			
			} else {
				
				resultMsg = "인증 실패";
			}
			
			// 인증정보 삭제
			int deleteresult = memberService.deleteCertEmail(validate);
			
			
			return resultMsg;
		}
	
}
