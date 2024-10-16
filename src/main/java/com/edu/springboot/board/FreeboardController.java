package com.edu.springboot.board;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.edu.springboot.member.MemberDTO;

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
	
	
	// == 자유게시판 목록 ==
	@GetMapping("/freeboard.do")
	public String freeboard(Model model, HttpServletRequest req, ParameterDTO parameterDTO) {
		
		// 게시글의 개수를 통해 페이징 기능 구현
		int total = boardDAO.countPost(parameterDTO);
		int pageNum = (req.getParameter("pageNum") == null || req.getParameter("pageNum").equals(""))
				? 1 : Integer.parseInt(req.getParameter("pageNum"));
		int start = (pageNum - 1) * postsPerPage + 1;
		int end = pageNum * postsPerPage;
		parameterDTO.setStart(start);
		parameterDTO.setEnd(end);
		Map<String, Object> maps = new HashMap<String, Object>();
		maps.put("total", total);
		maps.put("postsPerPage", postsPerPage);
		maps.put("pageNum", pageNum);
		model.addAttribute("maps", maps);
		String pagingImg = PagingUtil.pagingImg(total, postsPerPage, pagesPerBlock, pageNum, req.getContextPath()+"/freeboard.do?");
		model.addAttribute("pagingImg", pagingImg);
		
		// 게시물의 목록
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
		
		return "freeboard/list";
	}
	
	
	// == 자유게시판 상세보기 ==
	@GetMapping("/freeboard/viewPost.do")
	public String viewPost(Model model, HttpSession session, HttpServletResponse response,  BoardDTO boardDTO) {

		// 로그인 여부 검증
		MemberDTO loginMember = (MemberDTO) session.getAttribute("loginMember");
		if (loginMember == null) {
			JSFunction.alertLocation(response, "로그인 후 이용해 주세요", "../member/login.do");
			return null;
		}
		String id = loginMember.getId();
		
		// 게시글
		boardDTO = boardDAO.viewPost(boardDTO);
		boardDAO.plusVisitcount(boardDTO);
		boardDTO.setContent(boardDTO.getContent().replace("\r\n", "<br/>"));
		String nickname = boardDAO.selectBoardNickname(boardDTO);
		String emoji = boardDAO.selectBoardEmoji(boardDTO);
		if (emoji != null) boardDTO.setNickname(nickname + " " + emoji);
		else boardDTO.setNickname(nickname);
		model.addAttribute("boardDTO", boardDTO);
		
		// 댓글 목록
		ArrayList<CommentsDTO> commentsList = boardDAO.listComments(boardDTO);
		for (CommentsDTO comment : commentsList) {
			nickname = boardDAO.selectCommNickname(comment);
			emoji = boardDAO.selectCommEmoji(comment);
			if (emoji != null) comment.setNickname(nickname + " " + emoji);
			else comment.setNickname(nickname);
		}
		model.addAttribute("commentsList", commentsList);
		
		// 좋아요수 신고수 댓글수
		int likecount = boardDAO.countLike(Integer.toString(boardDTO.getBoard_idx()));
		int reportcount = boardDAO.countReport(boardDTO.getBoard_idx());
		int commentcount = boardDAO.countComment(boardDTO);
		boardDTO.setLikecount(likecount);
		boardDTO.setReportcount(reportcount);
		boardDTO.setCommentcount(commentcount);
		
		// 좋아요 신고 클릭 여부
		int likecheck = boardDAO.checkLike(id, Integer.toString(boardDTO.getBoard_idx()));
		int reportcheck = boardDAO.checkReport(id, Integer.toString(boardDTO.getBoard_idx()));
		model.addAttribute("likecheck", likecheck);
		model.addAttribute("reportcheck", reportcheck);
		return "freeboard/view";
	}
	
	
	// == 게시글 작성 ==
	@GetMapping("/freeboard/writePost.do")
	public String writePostGet(Model model, HttpSession session, HttpServletResponse response) {
		
		// 로그인 여부 검증
		MemberDTO loginMember = (MemberDTO) session.getAttribute("loginMember");
		if (loginMember == null) {
			JSFunction.alertLocation(response, "로그인 후 이용해 주세요", "../member/login.do");
			return null;
		}
	    
		return "freeboard/write";
	}
	
	@PostMapping("/freeboard/writePost.do")
	public String writePostPost(Model model, HttpServletRequest req, HttpServletResponse response, HttpSession session, BoardDTO boardDTO) {
		
		// 게시글 작성
		String id = ((MemberDTO) session.getAttribute("loginMember")).getId();
		boardDTO.setWriter_ref(id);
		boardDAO.writePost(boardDTO);
		
		return "redirect:../freeboard.do";
	}
	
	
	// == 게시글 수정 ==
	@GetMapping("/freeboard/editPost.do")
	public String editPostGet(Model model, HttpSession session, HttpServletResponse response, BoardDTO boardDTO) {
		
		// 로그인 여부 검증
		MemberDTO loginMember = (MemberDTO) session.getAttribute("loginMember");
		if (loginMember == null) {
			JSFunction.alertLocation(response, "로그인 후 이용해 주세요", "../member/login.do");
			return null;
		}
		
		// 게시글 수정
		boardDTO = boardDAO.viewPost(boardDTO);
		String nickname = boardDAO.selectBoardNickname(boardDTO);
		String emoji = boardDAO.selectBoardEmoji(boardDTO);
		if (emoji != null) boardDTO.setNickname(nickname + " " + emoji);
		else boardDTO.setNickname(nickname);
		model.addAttribute("boardDTO", boardDTO);
		
		return "freeboard/edit";
	}
	
	@PostMapping("/freeboard/editPost.do")
	public String editPostPost(BoardDTO boardDTO) {
		boardDAO.editPost(boardDTO);
		return "redirect:../freeboard/viewPost.do?board_idx=" + boardDTO.getBoard_idx();
	}
	
	
	// == 게시글 삭제 ==
	@PostMapping("/freeboard/deletePost.do")
	public String deletePostPost(HttpSession session, HttpServletRequest req, HttpServletResponse response) {
		
		// 로그인 여부 검증
		MemberDTO loginMember = (MemberDTO) session.getAttribute("loginMember");
		if (loginMember == null) {
			JSFunction.alertLocation(response, "로그인 후 이용해 주세요", "../member/login.do");
			return null;
		}
		
		// 게시글 삭제 및 게시글의 좋아요 신고 삭제
		String board_idx = req.getParameter("board_idx");
		boardDAO.deletePost(board_idx);
		boardDAO.deleteAllLike(board_idx);
		boardDAO.deleteAllReport(board_idx);
		
		return "redirect:../freeboard.do";
	}

	
	// == 댓글 작성 (Ajax) ==
	@PostMapping("/freeboard/writeComment.do")
	@ResponseBody
	public Map<String, Object> writeCommentPost(HttpSession session, CommentsDTO commentsDTO) {
	    Map<String, Object> resultMap = new HashMap<>();

	    // 로그인 여부 검증
	    MemberDTO loginMember = (MemberDTO) session.getAttribute("loginMember");
	    if (loginMember == null) {
	        resultMap.put("result", "error");
	        resultMap.put("message", "로그인 후 이용해 주세요.");
	        return resultMap;
	    }

	    // 댓글 작성
	    String id = loginMember.getId();
	    commentsDTO.setWriter_ref(id);
	    try {
	        boardDAO.writeComment(commentsDTO);
	        resultMap.put("result", "success");
	        resultMap.put("message", "댓글이 성공적으로 작성되었습니다.");

	        commentsDTO = boardDAO.selectComments(commentsDTO);
	        commentsDTO.setNickname(loginMember.getNickname());
	        String nickname = boardDAO.selectCommNickname(commentsDTO);
			String emoji = boardDAO.selectCommEmoji(commentsDTO);
			if (emoji != null) commentsDTO.setNickname(nickname + " " + emoji);
			else commentsDTO.setNickname(nickname);
			
	        // 댓글 정보 추가
	        resultMap.put("comment", Map.of(
	            "comm_idx", commentsDTO.getComm_idx(),
	            "nickname", commentsDTO.getNickname(),
	            "content", commentsDTO.getContent(),
	            "postdate", commentsDTO.getPostdate()
	        ));
	        
	    } catch (Exception e) {
	    	e.printStackTrace();
	        resultMap.put("result", "error");
	        resultMap.put("message", "댓글 작성에 실패했습니다.");
	    }

	    return resultMap;
	}


	
	// == 댓글 수정 ==
	@PostMapping("/freeboard/editComment.do")
	@ResponseBody
	public Map<String, Object> editCommentPost(HttpSession session, HttpServletRequest req, HttpServletResponse response, CommentsDTO commentsDTO) {
	    
		Map<String, Object> resultMap = new HashMap<>();
	    
	    // 로그인 여부 검증
	    MemberDTO loginMember = (MemberDTO) session.getAttribute("loginMember");
	    if (loginMember == null) {
	    	resultMap.put("result", "error");
	        return resultMap;
	    }
	    
	    // 댓글 수정
	    try {
	        boardDAO.editComment(commentsDTO);
	        resultMap.put("result", "success");
	        resultMap.put("comment", commentsDTO);
	    }
	    catch (Exception e) {
	    	resultMap.put("result", "error");
	    }
	    
	    return resultMap;
	}
	
	
	// == 댓글 삭제 (AJAX) ==
	@PostMapping("/freeboard/deleteComment.do")
	@ResponseBody
	public Map<String, String> deleteComment(HttpSession session, HttpServletRequest req, HttpServletResponse response, CommentsDTO commentsDTO) {
	    
	    Map<String, String> resultMap = new HashMap<>();
	    
	    // 로그인 여부 검증
	    MemberDTO loginMember = (MemberDTO) session.getAttribute("loginMember");
	    if (loginMember == null) {
	        resultMap.put("result", "error");
	        resultMap.put("message", "로그인 후 이용해 주세요.");
	        return resultMap; // 로그인 실패 응답
	    }
	    
	    // 본인 확인
	    if (!loginMember.getId().equals(commentsDTO.getWriter_ref())) {
	        resultMap.put("result", "error");
	        resultMap.put("message", "본인이 작성한 댓글만 삭제할 수 있습니다.");
	        return resultMap;
	    }
	    
	    // 댓글 삭제
	    try {
	        boardDAO.deleteComment(Integer.toString(commentsDTO.getComm_idx()));
	        resultMap.put("result", "success");
	        resultMap.put("message", "댓글이 성공적으로 삭제되었습니다.");
	    }
	    catch (Exception e) {
	        resultMap.put("result", "error");
	        resultMap.put("message", "댓글 삭제에 실패했습니다.");
	    }
	    
	    return resultMap;
	}

	
	// == 좋아요 기능 ==
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
	
	
	// == 싫어요 기능 ==
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
	
	
}