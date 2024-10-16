package com.edu.springboot.hospital;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.edu.springboot.doctor.DoctorDTO;

@Mapper
public interface IHospitalService {
	
	// 병원 목록
	public List<HospitalDTO> getAllHospitals();
	// 병원 상세정보 목록
	public List<DetailDTO> getAllHDetails();
	// 병원 리뷰 목록
	public List<HreviewDTO> getAllHReviews();
	// 병원 리뷰의 답변 목록
	public List<HreviewDTO> getAllHReplies();
	// 전체 해시태그 목록
	public List<HashtagDTO> getAllHashtags();
	
	
	
	// 병원 API 목록: 병원 API의 레코드 개수를 카운트
	public int countHospApi(ParameterDTO parameterDTO);
	// 병원 API 목록: 병원 API의 레코드에서 한 페이지에 출력할 레코드를 인출
	public ArrayList<HospitalDTO> listHospApi(ParameterDTO parameterDTO);
	// 병원 API 조회
	public HospitalDTO viewHospApi(HospitalDTO hospitalDTO);
	
	// 병원 입점 여부 확인: 병원이름으로 입점 여부를 확인하여 아이디 추출
	public String selectHospId(String name);
	// 병원 조회
	public BasicDTO viewHosp(String id);
	
	// 병원 검색: 검색된 병원의 개수를 카운트
	public int countSearchHosp(ParameterDTO parameterDTO);
	// 병원 검색
	public List<HospitalDTO> listSearchHosp(String searchSido, String searchGugun, String searchDong, String searchField, String searchWord, List<String> filterList, int start, int end);
	
	
	// 병원 상세정보 조회
	public DetailDTO selectDetail(String id);
	
	// 의사 조회
	public ArrayList<DoctorDTO> listDoctor(HospitalDTO hospitalDTO);
	
	// 리뷰 조회
	public ArrayList<HreviewDTO> listReview(HospitalDTO hospitalDTO);
	// 리뷰 작성
    public int writeReview(Map<String, Object> params);
	// 리뷰 수정
	public int editReview(Map<String, Object> params);
	// 리뷰 삭제
	public int deleteReview(int review_idx);
	
	// 답변 작성
	public int writeReply(int review_idx, String content, String loginId, int api_ref);
	// 답변 수정
	public int editReply(int review_idx, String content);
	// 답변 삭제
	public int deleteReply(int review_idx);
	// 리뷰 삭제에 따른 답변 일괄 삭제
	public int deleteAllReply(int original_idx);

	// 닉네임 인출: 리뷰 작성자 닉네임 인출
	public String selectReviewNickname(HreviewDTO hreviewDTO);
	
	// 병원 좋아요: 병원 좋아요 수 조회
	public int countHospLike(int recodenum);
	// 병원 좋아요: 병원 좋아요 레코드 존재 여부 확인
	public int checkHospLike(String userId, int api_idx);
	// 병원 좋아요: 병원 좋아요 수 증가
	public int plusHospLike(String userId, int api_idx);
	// 병원 좋아요: 병원 좋아요 수 감소
	public int minusHospLike(String userId, int api_idx);
	
	// 리뷰 좋아요: 리뷰 좋아요 수 조회
	public int countReviewLike(String recodenum);
	// 리뷰 좋아요: 리뷰 좋아요 레코드 존재 여부 확인
	public int checkReviewLike(String id, String review_idx);
	// 리뷰 좋아요: 리뷰 좋아요 수 증가
	public int plusReviewLike(String id, String review_idx);
	// 리뷰 좋아요: 리뷰 좋아요 수 감소
	public int minusReviewLike(String id, String review_idx);
	// 리뷰 좋아요: 리뷰 삭제에 의한 리뷰 좋아요 일괄 삭제
	public int deleteAllLike(int review_idx);
	
	// 리뷰 수 조회
	public int countReview(int api_idx);
	// 별점 합계 조회
	public int sumScore(int api_idx);
	
	// 해시태그 목록
	public ArrayList<HashtagDTO> listHashtag();
	// 병원 해시태그 목록 조회
	public ArrayList<HashtagDTO> selectHospHashtag(String id);
	// 리뷰 해시태그 작성
	public int writeReviewHashtag(int review_idx, String tag);
	// 리뷰의 모든 해시태그 삭제
	public int deleteAllReviewHashtag(int review_idx);
	
	// 주소 동적 셀렉트: 시도를 인출
	public List<AddressDTO> selectSido();
	// 주소 동적 셀렉트: 시도에 해당하는 시구군을 인출
	public List<AddressDTO> selectGugun(AddressDTO addressDTO);
	// 주소 동적 셀렉트: 시구군에 해당하는 읍면동을 인출
	public List<AddressDTO> selectDong(AddressDTO addressDTO);
	
	// 지도에 표시할 병원 목록
	public ArrayList<HospitalDTO> listHospMark(ParameterDTO parameterDTO);
	
}
