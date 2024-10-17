package com.edu.springboot.doctor;

import java.io.File;
import java.net.http.HttpResponse;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import javax.xml.crypto.dsig.keyinfo.RetrievalMethod;

import org.springframework.aop.IntroductionAdvisor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.ResourceUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.edu.springboot.board.BoardDTO;
import com.edu.springboot.board.ParameterDTO;
import com.edu.springboot.hospital.HashtagDTO;
import com.edu.springboot.member.MemberDTO;

import jakarta.mail.Session;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import utils.FileUtil;
import utils.JSFunction;
import utils.PagingUtil;

@Controller
public class DoctorController {
   
   @Autowired
   IDoctorService doctorDAO;
   
   // 페이지당 출력할 게시물 수
   @Value("#{doctorprops['doctor.postsPerPage']}")
   private int postsPerPage;
   // 한 블록당 출력할 페이지 번호 수
   @Value("#{doctorprops['doctor.pagesPerBlock']}")
   private int pagesPerBlock;
   
   
   // == 의사 목록 ==
   @GetMapping("/doctor.do")
   public String doctor(Model model, HttpServletRequest req, ParameterDTO parameterDTO) {
      
      // 의사의 개수를 통해 페이징 기능 구현
      int total = doctorDAO.countDoctor(parameterDTO);
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
      String pagingImg = PagingUtil.pagingImg(total, postsPerPage, pagesPerBlock, pageNum, req.getContextPath()+"/doctor.do?");
      model.addAttribute("pagingImg", pagingImg);
      
      // 의사의 목록
      ArrayList<DoctorDTO> doctorsList = doctorDAO.listDoctor(parameterDTO);
      for (DoctorDTO doctor : doctorsList) {
         String hospname = doctorDAO.selectHospName(doctor);
         int doclikecount = doctorDAO.countDocLike(Integer.toString(doctor.getDoc_idx()));
         int reviewcount = doctorDAO.countReview(Integer.toString(doctor.getDoc_idx()));
         int scoresum = doctorDAO.sumScore(Integer.toString(doctor.getDoc_idx()));
         doctor.setHospname(hospname);
         doctor.setLikecount(doclikecount);
         doctor.setReviewcount(reviewcount);
         if (reviewcount != 0) {
            doctor.setScore(scoresum / reviewcount);
         }
         else {
            doctor.setScore(0);
         }
      }
      model.addAttribute("doctorsList", doctorsList);
      
      return "doctor/list";
   }
   
   
   // == 의사 상세보기 ==
   @RequestMapping("/doctor/viewDoctor.do")
   public String viewDoctorReq(Model model, HttpServletResponse response, DoctorDTO doctorDTO, HttpSession session) {
      
      // 로그인 여부 검증
      MemberDTO loginMember = (MemberDTO) session.getAttribute("loginMember");
      if (loginMember == null) {
         JSFunction.alertLocation(response, "로그인 후 이용해 주세요", "../member/login.do");
         return null;
      }
      String id = loginMember.getId();
      
      // 의사
      doctorDTO = doctorDAO.viewDoctor(doctorDTO);
      String hospname = doctorDAO.selectHospName(doctorDTO);
      doctorDTO.setHospname(hospname);
      model.addAttribute("doctorDTO", doctorDTO);
      
      // 리뷰 목록
      ArrayList<DreviewDTO> reviewsList = doctorDAO.listReview(doctorDTO);
      for (DreviewDTO review : reviewsList) {
         // 리뷰 작성자 닉네임
         String nickname = doctorDAO.selectReviewNickname(review);
         review.setNickname(nickname);
         // 리뷰 좋아요 수
         int likecount = doctorDAO.countReviewLike(Integer.toString(review.getReview_idx()));
         review.setLikecount(likecount);
         // 리뷰 좋아요 클릭 여부
         int reviewlikecheck = doctorDAO.checkReviewLike(id, Integer.toString(review.getReview_idx()));
         model.addAttribute("reviewlikecheck", reviewlikecheck);
      }
      model.addAttribute("reviewsList", reviewsList);
      
      // 좋아요수
      int likecount = doctorDAO.countDocLike(Integer.toString(doctorDTO.getDoc_idx()));
      doctorDTO.setLikecount(likecount);
      
      // 좋아요 클릭 여부
      int doclikecheck = doctorDAO.checkDocLike(id, Integer.toString(doctorDTO.getDoc_idx()));
      model.addAttribute("doclikecheck", doclikecheck);
      
      // 해시태그
      ArrayList<HashtagDTO> hashtagList = doctorDAO.listHashtag();
      model.addAttribute("hashtagList", hashtagList);
      
      return "doctor/view";
   }
   
   
   // == 의사 등록 ==
   @GetMapping("/doctor/writeDoctor.do")
   public String writeDoctorGet(Model model, HttpSession session, HttpServletResponse response) {
      
      // 로그인 여부 검증
      MemberDTO loginMember = (MemberDTO) session.getAttribute("loginMember");
      if (loginMember == null) {
         JSFunction.alertLocation(response, "로그인 후 이용해 주세요", "../member/login.do");
         return null;
      }
      
      return "doctor/write";
   }
   
   @PostMapping("/doctor/writeDoctor.do")
   public String writeDoctorPost(HttpSession session, HttpServletRequest req, DoctorDTO doctorDTO) {
      
      // 파일 업로드
      String photo = null;
      try {
         String uploadDir = ResourceUtils.getFile("classpath:static/uploads/").toPath().toString();
         Part part = req.getPart("file");
         String partHeader = part.getHeader("content-disposition");
         String[] phArr = partHeader.split("filename=");
         String filename = phArr[1].trim().replace("\"", "");
         if (!filename.isEmpty()) {
            part.write(uploadDir + File.separator + filename);
            photo = FileUtil.renameFile(uploadDir, filename);
         }
      }
      catch (Exception e) {
         e.printStackTrace();
      }
      doctorDTO.setPhoto(photo);
      
      // 의사 등록
      String id = ((MemberDTO) session.getAttribute("loginMember")).getId();
      doctorDTO.setHosp_ref(id);
      doctorDAO.writeDoctor(doctorDTO);
      
      return "redirect:../doctor.do";
   }
   
   
   // == 의사 수정 ==
   @GetMapping("/doctor/editDoctor.do")
   public String editDoctorGet(Model model, HttpSession session, HttpServletResponse response, DoctorDTO doctorDTO) {
      
      // 로그인 여부 검증
      MemberDTO loginMember = (MemberDTO) session.getAttribute("loginMember");
      if (loginMember == null) {
         JSFunction.alertLocation(response, "로그인 후 이용해 주세요", "../member/login.do");
         return null;
      }
      
      // 의사 조회
      doctorDTO = doctorDAO.viewDoctor(doctorDTO);
      model.addAttribute("doctorDTO", doctorDTO);
      
      return "doctor/edit";
   }
   
   @PostMapping("/doctor/editDoctor.do")
   public String editDoctorPost(HttpServletRequest req, DoctorDTO doctorDTO) {
      
      // 파일업로드
      try {
         String uploadDir = ResourceUtils.getFile("classpath:static/uploads/").toPath().toString();
         Part part = req.getPart("file");
         String partHeader = part.getHeader("content-disposition");
         String[] phArr = partHeader.split("filename=");
         String filename = phArr[1].trim().replace("\"", "");
         if (!filename.isEmpty()) {
            part.write(uploadDir + File.separator + filename);
            String photo = FileUtil.renameFile(uploadDir, filename);
            doctorDTO.setPhoto(photo);
         }
      }
      catch (Exception e) {
         e.printStackTrace();
      }
      
      // 의사 수정
      doctorDAO.editDoctor(doctorDTO);
      
      return "redirect:../doctor/viewDoctor.do?doc_idx=" + doctorDTO.getDoc_idx();
   }
   
   
   // == 의사 삭제
   @PostMapping("/doctor/deleteDoctor.do")
   public String deleteDoctorPost(HttpSession session, HttpServletRequest req, HttpServletResponse response) {
      
      // 로그인 여부 검증
      MemberDTO loginMember = (MemberDTO) session.getAttribute("loginMember");
      if (loginMember == null) {
         JSFunction.alertLocation(response, "로그인 후 이용해 주세요", "../member/login.do");
         return null;
      }
      
      // 의사 삭제 및 의사 좋아요 리뷰 삭제
      int doc_idx = Integer.parseInt(req.getParameter("doc_idx"));
      doctorDAO.deleteDoctor(doc_idx);
      doctorDAO.deleteAllDocLike(doc_idx);
      doctorDAO.deleteAllDocReviewLike(doc_idx);
      
      return "redirect:/member/doctorInfo.do";
   }
   
   
   
   // ================================================================
   @PostMapping("/doctor/writeReview.do")
   public String writeReviewPost(HttpServletRequest req, HttpSession session) {
      // 폼값
      int doc_idx = Integer.parseInt(req.getParameter("doc_idx"));
      int score = Integer.parseInt(req.getParameter("score")) ;
      String content = req.getParameter("content");
      // 세션에 저장된 로그인 아이디
      String loginId = (String) session.getAttribute("userId");
      // 리뷰 작성
      Map<String, Object> params = new HashMap<>();
      params.put("score", score);
       params.put("content", content);
       params.put("loginId", loginId);
       params.put("doc_idx", doc_idx);
       doctorDAO.writeReview(params);
       // 생성된 review_idx
       int review_idx = (int) params.get("review_idx");
       // 해시태그 처리
       String hashtags = req.getParameter("hashtags");
       System.err.println(review_idx);
       if (hashtags != null && !hashtags.isEmpty()) {
          String[] hashtagArray = hashtags != null ? hashtags.split(",") : new String[0];
          for (String hashtag : hashtagArray) {
             doctorDAO.writeReviewHashtag(review_idx, hashtag.trim());
          }
       }
       return "redirect:../doctor/viewDoctor.do?doc_idx=" + doc_idx;
   }
   
   @PostMapping("/doctor/editReview.do")
   public String editReviewPost(HttpServletRequest req) {
      System.err.println("진입");
      // 폼값
      int doc_ref = Integer.parseInt(req.getParameter("doc_ref"));
      int review_idx = Integer.parseInt(req.getParameter("review_idx"));
      int score = Integer.parseInt(req.getParameter("score"));
      String content = req.getParameter("content");
      // 댓글 수정
      Map<String, Object> params = new HashMap<>();
      params.put("score", score);
      params.put("content", content);
      params.put("review_idx", review_idx);
      doctorDAO.editReview(params);
      // 해시태그 처리
       String hashtags = req.getParameter("hashtags");
       if (hashtags != null && !hashtags.isEmpty()) {
          String[] hashtagArray = hashtags != null ? hashtags.split(",") : new String[0];
          doctorDAO.deleteAllReviewHashtag(review_idx);
          for (String hashtag : hashtagArray) {
             doctorDAO.writeReviewHashtag(review_idx, hashtag.trim());
          }
       }
      return "redirect:../doctor/viewDoctor.do?doc_idx=" + doc_ref;
   }
   
   @PostMapping("/doctor/deleteReview.do")
   public String deleteReviewGet(HttpServletRequest req) {
      int review_idx = Integer.parseInt(req.getParameter("review_idx"));
      doctorDAO.deleteReview(review_idx);
      doctorDAO.deleteAllReply(review_idx);
      doctorDAO.deleteAllReviewLike(review_idx);
      return "redirect:../doctor/viewDoctor.do?doc_idx=" + req.getParameter("doc_ref");
   }
   

   
   @PostMapping("/doctor/writeReply.do")
   public String writeReplyPost(HttpServletRequest req, HttpSession session) {
      // 폼값
      int doc_ref = Integer.parseInt(req.getParameter("doc_ref"));
      int review_idx = Integer.parseInt(req.getParameter("review_idx"));
      String content = req.getParameter("content");
      // 세션에 저장된 로그인 아이디
      String id = (String) session.getAttribute("userId");
      // 답변 작성
      doctorDAO.writeReply(review_idx, content, id, doc_ref);
      return "redirect:../doctor/viewDoctor.do?doc_idx=" + doc_ref;
   }
   
   @PostMapping("/doctor/editReply.do")
   public String editReplyPost(HttpServletRequest req) {
      // 폼값
      int doc_ref = Integer.parseInt(req.getParameter("doc_ref"));
      int review_idx = Integer.parseInt(req.getParameter("review_idx"));
      String content = req.getParameter("content");
      // 답변 수정
      doctorDAO.editReply(review_idx, content);
      return "redirect:../doctor/viewDoctor.do?doc_idx=" + doc_ref;
   }
   
   @PostMapping("/doctor/deleteReply.do")
   public String deleteReplyGet(HttpServletRequest req) {
      doctorDAO.deleteReply(Integer.parseInt(req.getParameter("review_idx")));
      return "redirect:../doctor/viewDoctor.do?doc_idx=" + req.getParameter("doc_ref");
   }

   
   
   
   @GetMapping("/doctor/clickDocLike.do")
   public String clickLikeGet(HttpServletRequest req, HttpSession session) {
      // 좋아요 여부 확인
      String id = (String) session.getAttribute("userId");
      String doc_idx = req.getParameter("doc_idx");
      int likecheck = doctorDAO.checkDocLike(id, doc_idx);
      if (likecheck == 0) {
         // 좋아요 증가
         doctorDAO.plusDocLike(id, doc_idx);
      }
      else {
         // 좋아요 취소
         doctorDAO.minusDocLike(id, doc_idx);
      }
      return "redirect:../doctor/viewDoctor.do?doc_idx=" + doc_idx;
   }
   
   @GetMapping("/doctor/clickReviewLike.do")
   public String clickReviewGet(HttpServletRequest req, HttpSession session) {
      // 좋아요 여부 확인
      String id = (String) session.getAttribute("userId");
      String doc_ref = req.getParameter("doc_ref");
      String review_idx = req.getParameter("review_idx");
      int likecheck = doctorDAO.checkReviewLike(id, review_idx);
      if (likecheck == 0) {
         // 좋아요 증가
         doctorDAO.plusReviewLike(id, review_idx);
      }
      else {
         // 좋아요 취소
         doctorDAO.minusReviewLike(id, review_idx);
      }
      return "redirect:../doctor/viewDoctor.do?doc_idx=" + doc_ref;
   }
}
