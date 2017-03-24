package com.moviego.mail;

import java.util.Date;
import java.util.Properties;

import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import org.springframework.stereotype.Service;

@Service("mail.myMailSender")
public class MailSender {
	private String mailType; // 메일 타입
	private String encType;
	private String username;
	private String password;
	
	public MailSender() {
		this.encType = "euc-kr";
		this.mailType = "text/html; charset="+encType;
		this.username = "1000cws@naver.com";
		this.password = "java$!";
	}
	
	private class SMTPAuthenticator extends javax.mail.Authenticator {
			  @Override
		      public PasswordAuthentication getPasswordAuthentication() {
		          return new PasswordAuthentication(username, password);  
		       }  
	}
	
	public boolean mailSend(Mail vo) {
		boolean b=false;
		
		vo.setSenderEmail(username);
		vo.setSenderName("MOVIE GO");
		System.out.println(vo.toString());
		
		
		Properties p = new Properties();   
  
		p.put("mail.smtp.user", "아이디");   
		p.put("mail.smtp.host", "smtp.naver.com");
		p.put("mail.smtp.port", "465");   
		p.put("mail.smtp.starttls.enable", "true");   
		p.put("mail.smtp.auth", "true");   
		p.put("mail.smtp.debug", "true");   
		p.put("mail.smtp.socketFactory.port", "465");   
		p.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");   
		p.put("mail.smtp.socketFactory.fallback", "false");  
		
		try {
			Authenticator auth = new SMTPAuthenticator();  
			Session session = Session.getDefaultInstance(p, auth);
			session.setDebug(true);
			
			Message msg = new MimeMessage(session);
			
			if(vo.getSenderName() == null || vo.getSenderName().equals(""))
				msg.setFrom(new InternetAddress(vo.getSenderEmail()));
			else
				msg.setFrom(new InternetAddress(vo.getSenderEmail(), vo.getSenderName(), encType));
			
			// 받는 사람
			msg.setRecipients(Message.RecipientType.TO, InternetAddress.parse(vo.getReceiverEmail()));
			
			// 제목
			msg.setSubject(vo.getSubject());
			
			// HTML 형식인 경우 \r\n을  <br>로 변환
			if(mailType.indexOf("text/html") != -1) {
				vo.setContent(vo.getContent().replaceAll("\n", "<br>"));
			}
			makeMessage(msg, vo);
			msg.setHeader("X-Mailer", vo.getSenderName());
			
			// 메일 보낸 날짜
			msg.setSentDate(new Date());
			
			// 메일 전송
			Transport.send(msg);
			
			b=true;
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		
		return b;
	}
	
	// 첨부 파일이 있는 경우 MIME을 MultiMime로 파일을 전송 한다.
	private void makeMessage(Message msg, Mail vo) throws MessagingException {
			// 파일을 첨부하지 않은 경우
			msg.setText(vo.getContent());
			msg.setHeader("Content-Type", mailType);
	
	}
}
