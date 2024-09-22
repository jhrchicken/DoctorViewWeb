package com.edu.springboot.board;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import jakarta.servlet.http.HttpServletRequest;
import utils.PagingUtil;

@Controller
public class FreeboardController {
	
	@Autowired
	IFreeboardService boardDAO;
	
	// 페이지당 출력할 게시물 수
	@Value("#{boardprops['board.postsPerPage']}")
	private int postsPerPage;
	// 한 블록당 출력할 페이지 번호 수
	@Value("#{boardprops['board.pagesPerBlock']}")
	private int pagesPerBlock;
	
	@GetMapping("/freeboard.do")
	public String freeboard(Model model, HttpServletRequest req, ParameterDTO parameterDTO) {
		// 게시글의 개수
		int total = boardDAO.countPost(parameterDTO);
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
		ArrayList<BoardDTO> postsList = boardDAO.listPost(parameterDTO);
		model.addAttribute("postsList", postsList);
		// 게시판 하단에 출력할 페이지번호를 String으로 저장한 후 Model에 저장 (********** 수정 필요 **********)
		String pagingImg = PagingUtil.pagingImg(total, postsPerPage, pagesPerBlock, pageNum, req.getContextPath()+"/freeboard.do?");
		model.addAttribute("pagingImg", pagingImg);
		return "freeboard/list";
	}
	
	@RequestMapping("/freeboard/viewPost.do")
	public String viewPostReq(Model model, BoardDTO boardDTO) {
		// 자유게시판의 게시글 조회
		boardDTO = boardDAO.viewPost(boardDTO);
		// 조회수 증가
		boardDAO.plusVisitcount(boardDTO);
		// 줄바꿈 처리 및 저장
		boardDTO.setContent(boardDTO.getContent().replace("\r\n", "<br/>"));
		model.addAttribute("boardDTO", boardDTO);
		return "freeboard/view";
	}
	
	@GetMapping("/freeboard/writePost.do")
	public String writePostGet(Model model) {
		return "freeboard/write";
	}
	@PostMapping("/freeboard/writePost.do")
	public String writePostPost(Model model, HttpServletRequest req) {
		// 폼값
		String title = req.getParameter("title");
		String content = req.getParameter("content");
		String writer_idx = req.getParameter("writer_idx");
		// ************** 작성자 정보 가져오기 *****************
		
		boardDAO.writePost(title, content, writer_idx);
		return "redirect:../freeboard.do";
	}
	
	@GetMapping("/freeboard/editPost.do")
	public String editPostGet(Model model, BoardDTO boardDTO) {
		boardDTO = boardDAO.viewPost(boardDTO);
		model.addAttribute("boardDTO", boardDTO);
		return "freeboard/edit";
	}
	@PostMapping("/freeboard/editPost.do")
	public String editPostPost(BoardDTO boardDTO) {
		boardDAO.editPost(boardDTO);
		return "redirect:../freeboard/viewPost.do?board_idx=" + boardDTO.getBoard_idx();
	}
	
	@PostMapping("/freeboard/deletePost.do")
	public String deletePostPost(HttpServletRequest req) {
		boardDAO.deletePost(req.getParameter("board_idx"));
		return "redirect:freeboard.do";
	}
}