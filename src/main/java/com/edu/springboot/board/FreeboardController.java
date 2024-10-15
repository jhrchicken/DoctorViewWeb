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

import jakarta.mail.Session;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import utils.JSFunction;
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
		for (BoardDTO post : postsList) {
			String nickname = boardDAO.selectBoardNickname(post);
			int likecount = boardDAO.countLike(Integer.toString(post.getBoard_idx()));
			int commentcount = boardDAO.countComment(post);
			post.setNickname(nickname);
			post.setLikecount(likecount);
			post.setCommentcount(commentcount);
		}
		model.addAttribute("postsList", postsList);
		// 게시판 하단에 출력할 페이지 번호를 String으로 저장한 후 Model에 저장
		String pagingImg = PagingUtil.pagingImg(total, postsPerPage, pagesPerBlock, pageNum, req.getContextPath()+"/freeboard.do?");
		model.addAttribute("pagingImg", pagingImg);
		return "freeboard/list";
	}
	
	@RequestMapping("/freeboard/viewPost.do")
	public String viewPostReq(Model model, BoardDTO boardDTO, HttpSession session, HttpServletResponse response) {
		String loginId = (String) session.getAttribute("userId");
	    // 로그인하지 않은 경우
	    if (loginId == null) {
	        JSFunction.alertLocation(response, "로그인 후 이용해 주세요.", "../member/login.do");
	        return null;
	    }
		// 자유게시판의 게시글 조회
		boardDTO = boardDAO.viewPost(boardDTO);
		// 조회수 증가
		boardDAO.plusVisitcount(boardDTO);
		// 줄바꿈 처리 및 저장
		boardDTO.setContent(boardDTO.getContent().replace("\r\n", "<br/>"));
		// 닉네임
		String nickname = boardDAO.selectBoardNickname(boardDTO);
		boardDTO.setNickname(nickname);
		model.addAttribute("boardDTO", boardDTO);
		// 댓글 처리
		ArrayList<CommentsDTO> commentsList = boardDAO.listComments(boardDTO);
		for (CommentsDTO comment : commentsList) {
			nickname = boardDAO.selectCommNickname(comment);
			comment.setNickname(nickname);
		}
		model.addAttribute("commentsList", commentsList);
		// 좋아요수 신고수 댓글수
		int likecount = boardDAO.countLike(Integer.toString(boardDTO.getBoard_idx()));
		int reportcount = boardDAO.countReport(boardDTO.getBoard_idx());
		int commentcount = boardDAO.countComment(boardDTO);
		model.addAttribute("likecount", likecount);
		model.addAttribute("reportcount", reportcount);
		model.addAttribute("commentcount", commentcount);
		// 좋아요 신고 클릭 여부
		String id = (String) session.getAttribute("userId");
		int likecheck = boardDAO.checkLike(id, Integer.toString(boardDTO.getBoard_idx()));
		int reportcheck = boardDAO.checkReport(id, Integer.toString(boardDTO.getBoard_idx()));
		model.addAttribute("likecheck", likecheck);
		model.addAttribute("reportcheck", reportcheck);
		return "freeboard/view";
	}
	
	@GetMapping("/freeboard/writePost.do")
	public String writePostGet(Model model, HttpSession session, HttpServletResponse response) {
		String loginId = (String) session.getAttribute("userId");
	    // 로그인하지 않은 경우
	    if (loginId == null) {
	        JSFunction.alertLocation(response, "로그인 후 이용해 주세요.", "../member/login.do");
	        return null;
	    }
		return "freeboard/write";
	}
	@PostMapping("/freeboard/writePost.do")
	public String writePostPost(Model model, HttpServletRequest req, HttpServletResponse response, HttpSession session) {
		String loginId = (String) session.getAttribute("userId");
	    // 로그인하지 않은 경우
	    if (loginId == null) {
	        JSFunction.alertLocation(response, "로그인 후 이용해 주세요.", "../member/login.do");
	        return null;
	    }
		// 폼값
		String title = req.getParameter("title");
		String content = req.getParameter("content");
		boardDAO.writePost(title, content, loginId);
		return "redirect:../freeboard.do";
	}
	
	@GetMapping("/freeboard/editPost.do")
	public String editPostGet(Model model, HttpSession session, HttpServletResponse response, BoardDTO boardDTO) {
		String loginId = (String) session.getAttribute("userId");
	    // 로그인하지 않은 경우
	    if (loginId == null) {
	        JSFunction.alertLocation(response, "로그인 후 이용해 주세요.", "../member/login.do");
	        return null;
	    }
		boardDTO = boardDAO.viewPost(boardDTO);
		// 닉네임
		String nickname = boardDAO.selectBoardNickname(boardDTO);
		boardDTO.setNickname(nickname);
		model.addAttribute("boardDTO", boardDTO);
		return "freeboard/edit";
	}
	@PostMapping("/freeboard/editPost.do")
	public String editPostPost(BoardDTO boardDTO) {
		boardDAO.editPost(boardDTO);
		return "redirect:../freeboard/viewPost.do?board_idx=" + boardDTO.getBoard_idx();
	}
	
	@PostMapping("/freeboard/deletePost.do")
	public String deletePostPost(HttpSession session, HttpServletRequest req, HttpServletResponse response) {
		String loginId = (String) session.getAttribute("userId");
	    // 로그인하지 않은 경우
	    if (loginId == null) {
	        JSFunction.alertLocation(response, "로그인 후 이용해 주세요.", "../member/login.do");
	        return null;
	    }
		String board_idx = req.getParameter("board_idx");
		boardDAO.deletePost(board_idx);
		// 게시글 삭제에 의한 좋아요 및 신고 삭제
		boardDAO.deleteAllLike(board_idx);
		boardDAO.deleteAllReport(board_idx);
		return "redirect:../freeboard.do";
	}
	
	@GetMapping("/freeboard/clickLike.do")
	public String clickLikeGet(HttpSession session, HttpServletRequest req, HttpServletResponse response) {
		String loginId = (String) session.getAttribute("userId");
	    // 로그인하지 않은 경우
	    if (loginId == null) {
	        JSFunction.alertBack(response, "로그인 후 이용해주세요");
	        return null;
	    }
		// 좋아요 여부 확인
		String id = (String) session.getAttribute("userId");
		String board_idx = req.getParameter("board_idx");
		int likecheck = boardDAO.checkLike(id, board_idx);
		if (likecheck == 0) {
			// 좋아요 증가
			boardDAO.plusLike(id, board_idx);
		}
		else {
			// 좋아요 취소
			boardDAO.minusLike(id, board_idx);
		}
		return "redirect:../freeboard/viewPost.do?board_idx=" + board_idx;
	}
	
	@GetMapping("/freeboard/clickReport.do")
	public String clickReportGet(HttpSession session, HttpServletRequest req, HttpServletResponse response) {
		String loginId = (String) session.getAttribute("userId");
	    // 로그인하지 않은 경우
	    if (loginId == null) {
	        JSFunction.alertBack(response, "로그인 후 이용해주세요");
	        return null;
	    }
		// 신고 여부 확인
		String id = (String) session.getAttribute("userId");
		String board_idx = req.getParameter("board_idx");
		int reportcheck = boardDAO.checkReport(id, board_idx);
		if (reportcheck == 0) {
			// 신고 수 증가
			boardDAO.plusReport(id, board_idx);
		}
		else {
			// 신고 수 감소
			boardDAO.minusReport(id, board_idx);
		}
		return "redirect:../freeboard/viewPost.do?board_idx=" + board_idx;
	}
	
	@PostMapping("/freeboard/writeComment.do")
	public String writeCommentPost(HttpSession session, HttpServletRequest req, HttpServletResponse response) {
		String loginId = (String) session.getAttribute("userId");
	    // 로그인하지 않은 경우
	    if (loginId == null) {
	        JSFunction.alertBack(response, "로그인 후 이용해주세요");
	        return null;
	    }
		// 폼값
		int board_idx = Integer.parseInt(req.getParameter("board_idx"));
		String content = req.getParameter("content");
		// 세션에 저장된 로그인 아이디
		String id = (String) session.getAttribute("userId");
		// 댓글 작성
		boardDAO.writeComment(id, board_idx, content);
		return "redirect:../freeboard/viewPost.do?board_idx=" + board_idx;
	}
	
	@PostMapping("/freeboard/editComment.do")
	public String editCommentPost(HttpSession session, HttpServletRequest req, HttpServletResponse response) {
		String loginId = (String) session.getAttribute("userId");
	    // 로그인하지 않은 경우
	    if (loginId == null) {
	        JSFunction.alertBack(response, "로그인 후 이용해주세요");
	        return null;
	    }
		// 폼값
		int board_ref = Integer.parseInt(req.getParameter("board_ref"));
		String content = req.getParameter("content");
		int comm_idx = Integer.parseInt(req.getParameter("comm_idx"));
		// 댓글 수정
		boardDAO.editComment(comm_idx, content);
		return "redirect:../freeboard/viewPost.do?board_idx=" + board_ref;
	}

	@PostMapping("/freeboard/deleteComment.do")
	public String deleteCommentGet(HttpSession session, HttpServletRequest req, HttpServletResponse response) {
		String loginId = (String) session.getAttribute("userId");
	    // 로그인하지 않은 경우
	    if (loginId == null) {
	        JSFunction.alertBack(response, "로그인 후 이용해주세요");
	        return null;
	    }
		boardDAO.deleteComment(req.getParameter("comm_idx"));
		return "redirect:../freeboard/viewPost.do?board_idx=" + req.getParameter("board_ref");
	}
	
}