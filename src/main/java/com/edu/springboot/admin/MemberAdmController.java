package com.edu.springboot.admin;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import com.edu.springboot.board.BoardDTO;
import com.edu.springboot.board.ParameterDTO;
import com.edu.springboot.member.IMemberService;
import com.edu.springboot.member.MemberDTO;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import utils.JSFunction;
import utils.PagingUtil;

@Controller
public class MemberAdmController {
	
	@Autowired
	IMemberService memberDAO;
	
	// 페이지당 출력할 게시물 수
	@Value("#{boardprops['board.postsPerPage']}")
	private int postsPerPage;
	// 한 블록당 출력할 페이지 번호 수
	@Value("#{boardprops['board.pagesPerBlock']}")
	private int pagesPerBlock;

	@GetMapping("/admin/member_list.do")
	public String member_list(Model model, ParameterDTO parameterDTO, HttpServletRequest req) {
		// 게시글의 개수
		int total = memberDAO.countAllMembers(parameterDTO);
		// 현재 페이지
		int pageNum = (req.getParameter("pageNum") == null || req.getParameter("pageNum").equals(""))
				? 1 : Integer.parseInt(req.getParameter("pageNum"));
		// 현재 페이지에 출력할 게시글의 구간 계산 및 저장
		int start = (pageNum - 1) * postsPerPage + 1;
		int end = pageNum * postsPerPage;
		parameterDTO.setStart(start);
		parameterDTO.setEnd(end);
		
		// 뷰에서 게시글의 가상번호 계산을 위한 값 저장
		Map<String, Object> maps = new HashMap<String, Object>();
		maps.put("total", total);
		maps.put("postsPerPage", postsPerPage);
		maps.put("pageNum", pageNum);
		model.addAttribute("maps", maps);
		
		// 게시물의 목록 저장
		List<MemberDTO> memberList = memberDAO.pageAllMembers(parameterDTO);
		model.addAttribute("memberList", memberList);
		
		// 페이지번호
		String pagingImg = PagingUtil.pagingImg(total, postsPerPage, pagesPerBlock, pageNum, req.getContextPath()+"/admin/member_list.do?");
		model.addAttribute("pagingImg", pagingImg);
		
		return "admin-front/member_list";
	}
	
	
	@GetMapping("/admin/member_edit.do")
	public String member_edit(Model model, MemberDTO memberDTO, HttpServletRequest req) {
		
		memberDTO = memberDAO.getMember(req.getParameter("id"));	
		model.addAttribute("memberDTO", memberDTO);
		
		String[] tel =  memberDTO.getTel().split("-");
		String[] email =  memberDTO.getEmail().split("@");
		String[] rrn =  memberDTO.getRrn().split("-");
		
		model.addAttribute("tel", tel);
		model.addAttribute("email", email);
		model.addAttribute("rrn1", rrn[0]);
		model.addAttribute("rrn2", rrn[1].substring(0,1));
		
		return "admin-front/member_edit";
	}
	
	@PostMapping("/admin/member_edit.do")
	public String member_edit(MemberDTO memberDTO, HttpServletRequest req) {
	
		// member
		String tel = req.getParameter("tel1") + "-" + req.getParameter("tel2") + "-" + req.getParameter("tel3");
		String email = req.getParameter("email1") + "@" + req.getParameter("email2");
		String rrn = req.getParameter("rrn1") + "-" + req.getParameter("rrn2");
		memberDTO.setTel(tel);
		memberDTO.setEmail(email);
		memberDTO.setRrn(rrn);
		
		memberDAO.editUser(memberDTO);
		return "redirect:member_list.do";
	}
		
	@GetMapping("/admin/member_delete.do")
	public String member_delete(HttpServletResponse resp, MemberDTO memberDTO, HttpServletRequest req) {
		memberDAO.deleteUser(memberDTO.getId());
		JSFunction.alertLocation(resp, "삭제 되었습니다.", "member_list.do");
		return null;
	}	
}
