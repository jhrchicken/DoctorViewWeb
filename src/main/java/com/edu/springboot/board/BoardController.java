package com.edu.springboot.board;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import utils.PagingUtil;

@Controller
public class BoardController {
	
	@Autowired
	IBoardService  boardDAO;
	
	// 페이지당 출력할 게시물 수
	@Value("#{boardprops['board.postsPerPage']}")
	private int postsPerPage;
	// 한 블록당 출력할 페이지 번호 수
	@Value("#{boardprops['board.pagesPerBlock']}")
	private int pagesPerBlock;
	
	@GetMapping("/board/bestPost.do")
	public String bestPostGet(Model model, HttpServletRequest req, HttpSession session, ParameterDTO parameterDTO) {
		String id = (String) session.getAttribute("userId");
		// 게시글의 개수
		int total = boardDAO.countBestPost();
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
		ArrayList<BoardDTO> postList = boardDAO.listBestPost(parameterDTO);
		for (BoardDTO post : postList) {
			String nickname = boardDAO.selectBoardNickname(post);
			int likecount = boardDAO.countLike(Integer.toString(post.getBoard_idx()));
			int commentcount = boardDAO.countComment(post);
			post.setNickname(nickname);
			post.setLikecount(likecount);
			post.setCommentcount(commentcount);
		}
		model.addAttribute("postList", postList);
		// 게시판 하단에 출력할 페이지 번호를 String으로 저장한 후 Model에 저장
		String pagingImg = PagingUtil.pagingImg(total, postsPerPage, pagesPerBlock, pageNum, req.getContextPath()+"/board/myPost.do?");
		model.addAttribute("pagingImg", pagingImg);
		return "board/bestPost";
 	}
	
	@GetMapping("/board/myPost.do")
	public String myPostGet(Model model, HttpServletRequest req, HttpSession session) {
		String id = (String) session.getAttribute("userId");
		// 게시글의 개수
		int total = boardDAO.countMyPost(id);
		// 현재 페이지
		int pageNum = (req.getParameter("pageNum") == null || req.getParameter("pageNum").equals(""))
				? 1 : Integer.parseInt(req.getParameter("pageNum"));
		// 현재 페이지에 출력할 게시글의 구간 계산 및 저장
		int start = (pageNum - 1) * postsPerPage + 1;
		int end = pageNum * postsPerPage;
		// 뷰에서 게시글의 가상번호 계산을 위한 값 저장
		Map<String, Object> maps = new HashMap<String, Object>();
		maps.put("total", total);
		maps.put("postsPerPage", postsPerPage);
		maps.put("pageNum", pageNum);
		model.addAttribute("maps", maps);
		// 게시글의 목록 저장
		ArrayList<BoardDTO> postList = boardDAO.listMyPost(id, start, end);
		for (BoardDTO post : postList) {
			String nickname = boardDAO.selectBoardNickname(post);
			int likecount = boardDAO.countLike(Integer.toString(post.getBoard_idx()));
			int commentcount = boardDAO.countComment(post);
			post.setNickname(nickname);
			post.setLikecount(likecount);
			post.setCommentcount(commentcount);
		}
		model.addAttribute("postList", postList);
		// 게시판 하단에 출력할 페이지 번호를 String으로 저장한 후 Model에 저장
		String pagingImg = PagingUtil.pagingImg(total, postsPerPage, pagesPerBlock, pageNum, req.getContextPath()+"/board/myPost.do?");
		model.addAttribute("pagingImg", pagingImg);
		return "board/myPost";
	}
	
	@GetMapping("/board/myComment.do")
	public String myCommentGet(Model model, HttpServletRequest req, HttpSession session) {
		String id = (String) session.getAttribute("userId");
		// 게시글의 개수
		int total = boardDAO.countMyComment(id);
		// 현재 페이지
		int pageNum = (req.getParameter("pageNum") == null || req.getParameter("pageNum").equals(""))
				? 1 : Integer.parseInt(req.getParameter("pageNum"));
		// 현재 페이지에 출력할 게시글의 구간 계산 및 저장
		int start = (pageNum - 1) * postsPerPage + 1;
		int end = pageNum * postsPerPage;
		// 뷰에서 게시글의 가상번호 계산을 위한 값 저장
		Map<String, Object> maps = new HashMap<String, Object>();
		maps.put("total", total);
		maps.put("postsPerPage", postsPerPage);
		maps.put("pageNum", pageNum);
		model.addAttribute("maps", maps);
		// 게시글의 목록 저장
		ArrayList<BoardDTO> postList = boardDAO.listMyComment(id, start, end);
		for (BoardDTO post : postList) {
			String nickname = boardDAO.selectBoardNickname(post);
			int likecount = boardDAO.countLike(Integer.toString(post.getBoard_idx()));
			int commentcount = boardDAO.countComment(post);
			post.setNickname(nickname);
			post.setLikecount(likecount);
			post.setCommentcount(commentcount);
		}
		model.addAttribute("postList", postList);
		// 게시판 하단에 출력할 페이지 번호를 String으로 저장한 후 Model에 저장
		String pagingImg = PagingUtil.pagingImg(total, postsPerPage, pagesPerBlock, pageNum, req.getContextPath()+"/board/myComment.do?");
		model.addAttribute("pagingImg", pagingImg);
		return "board/myComment";
	}
	
	@GetMapping("/board/waitComment.do")
	public String WaitCommentGet(Model model, HttpServletRequest req, HttpSession session, ParameterDTO parameterDTO) {
		String id = (String) session.getAttribute("userId");
		// 게시글의 개수
		int total = boardDAO.countNoComment();
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
		ArrayList<BoardDTO> postList = boardDAO.listNoComment(parameterDTO);
		for (BoardDTO post : postList) {
			String nickname = boardDAO.selectBoardNickname(post);
			int likecount = boardDAO.countLike(Integer.toString(post.getBoard_idx()));
			int commentcount = boardDAO.countComment(post);
			post.setNickname(nickname);
			post.setLikecount(likecount);
			post.setCommentcount(commentcount);
		}
		model.addAttribute("postList", postList);
		// 게시판 하단에 출력할 페이지 번호를 String으로 저장한 후 Model에 저장
		String pagingImg = PagingUtil.pagingImg(total, postsPerPage, pagesPerBlock, pageNum, req.getContextPath()+"/board/waitComment.do?");
		model.addAttribute("pagingImg", pagingImg);
		return "board/waitComment";
 	}

}
