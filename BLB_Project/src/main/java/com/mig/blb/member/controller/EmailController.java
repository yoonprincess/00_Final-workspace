package com.mig.blb.member.controller;

import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.util.ArrayList;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;

import org.springframework.beans.factory.annotation.Autowired;
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
	
	@ResponseBody
	@PostMapping(value="cert.do",produces="text/html; charset=UTF-8")
	public String sendCertNo(String email) throws MessagingException, IOException {
		
		String certKey = randomKey();
		
		CertEmail certEmail = new CertEmail();
		
		certEmail.setCertKey(certKey);
	    certEmail.setCertEmail(email);
		 
		 certNoList.add(certEmail);
		 
		 int result = memberService.insertCertEmail(certNoList);
		
		 if (result > 0) {
		        
			String htmlContent = readEmailTemplateFromFile("certEmail.txt");
			
			htmlContent = htmlContent.replace("${certKey}", certKey);
			
			MimeMessage message = mailSender.createMimeMessage();
			
			MimeMessageHelper mimeMessageHelper
					= new MimeMessageHelper(message, true, "UTF-8");
		
			mimeMessageHelper.setSubject("[뷰라밸] 인증코드 안내 메일입니다."); // 제목
			
			String to = email; 
			
			mimeMessageHelper.setTo(to);
			
			mimeMessageHelper.setText(htmlContent,true);
			
			mailSender.send(message);
			
			return "result";
		 
		 }else {
	        
			 return "인증 메일 발송 실패";
	    }
	}
	
	// HTML 파일을 읽어오는 메소드
    private String readEmailTemplateFromFile(String filename) throws IOException {
        StringBuilder content = new StringBuilder();

        BufferedReader br = new BufferedReader(new FileReader("src/main/resources/"+ filename));
            String line;
            while ((line = br.readLine()) != null) {
                content.append(line).append("\n");
            }
        
        return content.toString();
    }
	// 인증번호를 만들어서 해당 이메일로 전송해주는 요청
	/*	@ResponseBody
		@PostMapping(value="cert.do", 
					 produces="text/html; charset=UTF-8")
		public String sendCert) {
			
			// 메세지 정보 담기
			message.setSubject("[KH 정보교육원] 이메일 인증 번호입니다.");
			message.setText("인증 번호 : " + random);
			message.setTo(email);
			
			// 메세지 전송하기
			mailSender.send(message);
			
			return "인증번호 발급 완료"; // 응답데이터
		}
		
		// 인증번호 대조 요청
		@ResponseBody
		@PostMapping(value="validate.do",
					 produces="text/html; charset=UTF-8")
		public String validate(String email, String checkNo) {
			
			// certNoList 로 부터
			// email 과 checkNo 이 정확하게 모두 일치하는 것을 찾아주면 됨!!
			
			String result = "";
			
			// CERT 테이블에서 SELECT
			// SELECT * FROM CERT WHERE 이메일, 인증번호 모두 일치하고 
			// 그리고 SYSDATE < CREATE_DATE + 3분
			// > 3분 이내라면 조회가 되고, 3분 이후라면 null
			if(certNoList.get(email) != null && 
					certNoList.get(email).equals(checkNo)) {
				
				result = "인증 성공";
				
			} else {
				
				result = "인증 실패";
			}
			
			// 인증번호 대조작업 완료 후 주의할점 이라고 한다면
			// 인증번호는 "1회성" 임!!
			// > 대조에 성공했든, 실패했든 간에 인증번호 발급 내역을
			//   꼭 지워줘야 한다라는 것!!
			certNoList.remove(email);
			
			// CERT 테이블 DELETE
			
			// System.out.println(certNoList);
			
			return result;
		}
	*/
}
