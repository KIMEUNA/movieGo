package com.moviego.member;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.encoding.ShaPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.moviego.mail.Mail;
import com.moviego.mail.MailSender;

@Controller("member.memberController")
public class MemberController {
	@Autowired
	private MemberService service;
	@Autowired
	private MailSender mailSender;

	// 접근 오서라이제이션(Authorization:권한)이 없는 경우
	@RequestMapping(value="/member/noAuthorized")
	public String noAuthorized() {
		return ".member.noAuthorized";
	}
	
	@RequestMapping(value = "/member/member", method = RequestMethod.GET)
	public String createdForm(Model model, HttpSession session) throws Exception {
		SessionInfo info = (SessionInfo) session.getAttribute("member");
		if (info != null) 
			return "redirect:/member/noAuthorized";
		
		model.addAttribute("title", "회원 가입");
		model.addAttribute("mode", "created");
		return ".member.member";
	}

	@RequestMapping(value = "/member/member", method = RequestMethod.POST)
	public String createdSubmit(Member member, Model model) throws Exception {
		// 패스워드 암호화
		ShaPasswordEncoder passwordEncoder = new ShaPasswordEncoder(256);
		String hashed = passwordEncoder.encodePassword(member.getPass(), null);
		member.setPass(hashed);
		
		int result = service.insertMember(member);
		
		if (result == 0) {
			model.addAttribute("message", "회원가입이 실패했습니다. 다른 아이디로 다시 가입하시기 바랍니다.");
			model.addAttribute("mode", "created");
			model.addAttribute("title", "회원 가입");
			return ".member.member";
		}

		StringBuffer sb = new StringBuffer();
		sb.append(member.getName() + "님의 회원 가입이 정상적으로 처리되었습니다.<br>");
		sb.append("메인화면으로 이동하여 로그인 하시기 바랍니다.<br>");

		model.addAttribute("title", "회원 가입");
		model.addAttribute("message", sb.toString());

		return ".member.complete";
	}
	
	@RequestMapping(value="/member/login")
	public String login(String login_error, Model model, HttpSession session) {
		boolean loginError = login_error != null;
		String msg = "";
		if (loginError) {
			msg = "아이디 또는 패스워드를 잘못 입력 하셨습니다.";
			model.addAttribute("message", msg);		
		}
		model.addAttribute("title", "로그인");
		
		return ".member.login";
	}
	
	@RequestMapping(value = "/member/idCheck")
	@ResponseBody
	public Map<String, Object> idCheck(
					@RequestParam String id
			) throws Exception {

		Member member = service.readMember2(id);

		String passed = "true";
		if (member != null)
			passed = "false";

		Map<String, Object> map = new HashMap<>();
		map.put("passed", passed);
		return map;
	}
	
	@RequestMapping(value = "/member/telCheck")
	@ResponseBody
	public Map<String, Object> telCheck(
					@RequestParam String tel
			) throws Exception {

		int res = service.telCheck(tel);

		String passed = "false";
		if (res == 0)
			passed = "true";

		Map<String, Object> map = new HashMap<>();
		map.put("passed", passed);
		return map;
	}
	
	@RequestMapping(value = "/member/emailCheck")
	@ResponseBody
	public Map<String, Object> emailCheck(@RequestParam String email) throws Exception {

		int res = service.emailCheck(email);

		String passed = "false";
		if (res == 0)
			passed = "true";

		Map<String, Object> map = new HashMap<>();
		map.put("passed", passed);
		return map;
	}
	
	@RequestMapping(value="/member/findInfo", method=RequestMethod.GET)
	public String findPwdForm() {
		return ".member.findInfo";
	}
	
	@RequestMapping(value="/member/findId", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> findId(Member dto) throws Exception{
		// 회원이 이메일, 폰번을 입력해서 아이디를 찾는다.
		// 폰번과 이멜이 일치하는 회원정보가 있으면 true 없으면 false
		// true이면 아이디를 출력해준다.
		
		Map<String, Object> model = new HashMap<>();
		String state="false";
		
		String id=service.getFindId(dto);
		
		if(id != null) {
			state="true";
			model.put("id", id);
		}
		
		model.put("state", state);
		
		return model;
	}
	
	@RequestMapping(value="/member/findPwd", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> findPwd(Member dto) throws Exception{
		
		// 비찾에서 회원이 입력한 정보를 가지고 db와 비교.
		// 맞으면 임시비밀번호를 생성해 db에서 update 한 뒤 임시비밀번호를 메일로 전송한다.
		// state 변수에 맞으면 true를, 틀리면 false를 던진다.
		Map<String, Object> model = new HashMap<>();
		String state="false";
		
		dto = service.getFindPwd(dto);
		if(dto != null) {
			char pwdChar[] = new char[] { 
										'1', '2', '3', '4', '5', '6', '7', '8', '9', '0', 'A', 'B', 'C', 'D',
										'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X',
										'Y', 'Z', 'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r',
										's', 't', 'u', 'v', 'w', 'x', 'y', 'z', '!', '@', '#', '$', '%', '^', '&', '*', '(', ')' 
										};	// 임시 비밀번호에 들어갈 문자 배열

			String randPwd = "";

			for (int i = 0; i < 10; i++) {
				int rand = (int) (Math.random() * (pwdChar.length));
				randPwd += pwdChar[rand];	// 임시비밀번호 생성
			}
			
			ShaPasswordEncoder passwordEncoder = new ShaPasswordEncoder(256);
			String hashed = passwordEncoder.encodePassword(randPwd, null);
			dto.setPass(hashed);
			dto.setEnabled(1);
			// 여기서 메일 전송을 한다.
			Mail mail = new Mail();
			mail.setSubject("[MOVIE GO] "+dto.getId() +"님 임시비밀번호 발급 안내 메일입니다.");
			mail.setContent("신청자 : "+dto.getName()
									+"\n신청일자 : "+dto.getM_regdate()
									+"\n임시비밀번호 : "+randPwd
									+"\n로그인 후 사용하고자 하시는 비밀번호로 수정해주세요.");
			mail.setReceiverEmail(dto.getEmail());
			state="error";
			if(mailSender.mailSend(mail)) { // 메일 전송을 성공하면 임시비밀번호를 update 한다.
				service.updateMember2(dto);
				model.put("name", dto.getName());
				model.put("email", dto.getEmail());
				state="true";
			} 
		}
		
		
		model.put("state", state);
		
		return model;
	}

	@RequestMapping(value = "/member/pwdCheck", method = RequestMethod.GET)
	public String pwdCheckForm(String dropout, Model model, HttpSession session) {

		SessionInfo info = (SessionInfo) session.getAttribute("member");
		if (info == null) {
			return "redirect:/member/login";
		}

		if (dropout == null) {
			model.addAttribute("title", "정보수정");
			model.addAttribute("mode", "update");
		} else {
			model.addAttribute("title", "회원탈퇴");
			model.addAttribute("mode", "dropout");
		}
		return ".member.pwdCheck";
	}
	
	@RequestMapping(value="/member/pwdCheck", method=RequestMethod.POST)
	public String pwdCheckSubmit(
			@RequestParam(value = "txtPassword") String pass, 
			@RequestParam(value = "mode") String mode,
			Model model, HttpSession session) throws Exception {
		
		SessionInfo info = (SessionInfo) session.getAttribute("member");
		
		if (info == null) {
			return "redirect:/member/login";
		}

		Member dto = service.readMember2(info.getId());
		if (dto == null) {
			session.invalidate();
			return "redirect:/member/member";
		}

		ShaPasswordEncoder passwordEncoder = new ShaPasswordEncoder(256);
		String hashed = passwordEncoder.encodePassword(pass, null);

		if (dto.getPass().equals(hashed)) {
			if (mode.equals("update")) {
				model.addAttribute("dto", dto);
				model.addAttribute("mode", "update");
				model.addAttribute("title", "회원 정보 수정");
				
				return ".member.member";
				
			} else if (mode.equals("dropout")) {
				Map<String, Object> map=new HashMap<>();
				map.put("mIdx", dto.getMemberIdx());
				map.put("id", dto.getId());
			
				service.deleteMember2(map);
				
				session.removeAttribute("member");
				session.invalidate();

				model.addAttribute("title", "회원 탈퇴");

				StringBuffer sb = new StringBuffer();
				sb.append(dto.getName() + "님의 회원 탈퇴 처리가 정상적으로 처리되었습니다.<br>");
				sb.append("메인화면으로 이동 하시기 바랍니다.<br>");
				model.addAttribute("message", sb.toString());

				return ".member.complete";
			}
		}

		model.addAttribute("message", "패스워드가 일치하지 않습니다.");
		if (mode.equals("update")) {
			model.addAttribute("title", "정보 수정");
			model.addAttribute("mode", "update");
		} else {
			model.addAttribute("title", "회원 탈퇴");
			model.addAttribute("mode", "dropout");
		}
		return ".member.pwdCheck";
	}

	// 수정완료
	@RequestMapping(value = "/member/update", method = RequestMethod.POST)
	public String updateSubmit(Member member, Model model, HttpSession session) throws Exception {
		SessionInfo info = (SessionInfo) session.getAttribute("member");
		if (info == null) {
			return "redirect:/member/login";
		}

		// 패스워드 암호화
		ShaPasswordEncoder passwordEncoder = new ShaPasswordEncoder(256);
		String hashed = passwordEncoder.encodePassword(member.getPass(), null);
		member.setPass(hashed);

		member.setEnabled(1);
		service.updateMember2(member);

		StringBuffer sb = new StringBuffer();
		sb.append(member.getName() + "님의 회원정보가 정상적으로 변경되었습니다.<br>");
		sb.append("메인화면으로 이동 하시기 바랍니다.<br>");

		model.addAttribute("title", "회원 정보 수정");
		model.addAttribute("message", sb.toString());

		return ".member.complete";
	}

}
