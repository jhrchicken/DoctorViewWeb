package com.edu.springboot.api;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.edu.springboot.board.BoardDTO;
import com.edu.springboot.board.IBoardService;
import com.edu.springboot.member.IMemberService;
import com.edu.springboot.member.MemberDTO;

@RestController
@RequestMapping("api")
public class ApiController {
	
	@Autowired
	private IMemberService memberDAO;
	
	@Autowired
	IBoardService boardDAO;
	
	// 회원 목록
//	@GetMapping("/member")
//	public ResponseEntity<List<MemberDTO>> member() {
//		ArrayList<MemberDTO> memberLists = memberDAO.getAllMember();
//		return ResponseEntity.ok(memberLists);
//	}
	
	// 게시판 목록
//	@GetMapping("/board")
//	public ResponseEntity<List<BoardDTO>> board() {
//		ArrayList<BoardDTO> boardLists = boardDAO.
//	}
	
	
}
