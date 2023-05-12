package com.my.attendance.web;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.my.attendance.domain.CompanyNotice;
import com.my.attendance.domain.PublicNotice;
import com.my.attendance.service.NoticeService;

import jakarta.servlet.http.HttpSession;

@RestController("NoticeController")
public class NoticeController {
@Autowired private NoticeService noticeService;
	
	//admin 전체 공지사항 목록
	@GetMapping
	@RequestMapping("admin/notice/admntclist")
	@AdminCheck
	public ModelAndView getadmntclist(ModelAndView mv, HttpSession session) {
		mv.setViewName("admin/notice/admntclist");
		return mv;
	}
	
	@GetMapping("admin/notice/ntclist/get")
	@ResponseBody
	public List<PublicNotice> getPublicNoticeLists() {
		return noticeService.getPublicNoticeLists();
	}
	
	//admin 전체 공지사항 추가
	@GetMapping
	@RequestMapping("admin/notice/addntc")
	@AdminCheck
	public ModelAndView addPublicNotice(ModelAndView mv, HttpSession session) {
		mv.setViewName("admin/notice/addntc");
		return mv;
	}
	
	@PostMapping("admin/notice/addntc/add")
	public void addPublicNotice(String publicNoticeTitle, String publicNoticeContent) {
		noticeService.addPublicNotice(publicNoticeTitle, publicNoticeContent);
	}
	
	//admin 전체 공지사항 상세 조회
	@GetMapping
	@RequestMapping("admin/notice/admgetntc")
	@AdminCheck
	public ModelAndView getadmgetntc(ModelAndView mv, HttpSession session) {
		mv.setViewName("admin/notice/admgetntc");
		return mv;
	}
	
	@GetMapping("admin/notice/getntc/get")
	@ResponseBody
	public List<PublicNotice> getPublicNotice(int publicNoticeNo) {
		return noticeService.getPublicNotice(publicNoticeNo);
	}
	
	//admin 전체 공지사항 수정
	@GetMapping
	@RequestMapping("admin/notice/fixntc")
	@AdminCheck
	public ModelAndView fixPublicNotice(ModelAndView mv, HttpSession session) {
		mv.setViewName("admin/notice/fixntc");
		return mv;
	}
	
	@PutMapping("admin/notice/fixntc/fix")
	@ResponseBody
	public void fixPublicNotice(@RequestBody PublicNotice publicNotice) {
		noticeService.fixPublicNotice(publicNotice);
	}
	
	//admin 전체 공지사항 삭제
	@DeleteMapping("admin/notice/getntc/del/{publicNoticeNo}")
	public void delPublicNotice(@PathVariable int publicNoticeNo) {
		noticeService.delPublicNotice(publicNoticeNo);
	}
	
	//company 전체 공지사항 목록
	@GetMapping
	@RequestMapping("admin/notice/ntclist")
	public ModelAndView getntclist(ModelAndView mv, HttpSession session) {
		mv.setViewName("admin/notice/ntclist");
		return mv;
	}

	//company 전체 공지사항 상세 조회
	@GetMapping
	@RequestMapping("admin/notice/getntc")
	public ModelAndView getntc(ModelAndView mv) {
		mv.setViewName("admin/notice/getntc");
		return mv;
	}
	
	//user 전체 공지사항 목록
	@GetMapping
	@RequestMapping("notice/ntclist")
	public ModelAndView usergetntclist(ModelAndView mv) {
		mv.setViewName("notice/ntclist");
		return mv;
	}
	
	//user 전체 공지사항 상세 조회
	@GetMapping
	@RequestMapping("notice/getntc")
	public ModelAndView usergetntc(ModelAndView mv) {
		mv.setViewName("notice/getntc");
		return mv;
	}
	
	//CompanyNotice
	
	//Company 사내 공지사항 목록
	@GetMapping
	@RequestMapping("admin/notice/comntclist")
	@CompanyCheck
	public ModelAndView getcomntclist(ModelAndView mv, HttpSession session) {
		mv.setViewName("admin/notice/comntclist");
		return mv;
	}
	
	@GetMapping("admin/notice/comntclist/get")
	@ResponseBody
	public List<CompanyNotice> getCompanyNoticeList(String companyId) {
		return noticeService.getCompanyNoticeList(companyId);
	}
	
	//Company 사내 공지사항 추가
	@GetMapping
	@RequestMapping("admin/notice/addcomntc")
	@CompanyCheck
	public ModelAndView addCompanyNotice(ModelAndView mv, HttpSession session) {
		mv.setViewName("admin/notice/addcomntc");
		return mv;
	}
	
	@PostMapping("admin/notice/addcomntc/add")
	public void addCompanyNotice(String companyNoticeTitle, String companyNoticeContent, String companyId) {
		noticeService.addCompanyNotice(companyNoticeTitle, companyNoticeContent, companyId);
	}
	
	//Company 사내 공지사항 상세 조회
	@GetMapping
	@RequestMapping("admin/notice/getcomntc")
	@CompanyCheck
	public ModelAndView getCompanyNotice(ModelAndView mv, HttpSession session) {
		mv.setViewName("admin/notice/getcomntc");
		return mv;
	}
	
	@GetMapping("admin/notice/getcomntc/get")
	@ResponseBody
	public List<CompanyNotice> getCompanyNotice(int companyNoticeNo) {
		return noticeService.getCompanyNotice(companyNoticeNo);
	}
	
	//company 사내 공지사항 수정
	@GetMapping
	@RequestMapping("admin/notice/fixcomntc")
	@CompanyCheck
	public ModelAndView fixCompanyNotice(ModelAndView mv, HttpSession session) {
		mv.setViewName("admin/notice/fixcomntc");
		return mv;
	}
	
	@PutMapping("admin/notice/fixcomntc/fix")
	@ResponseBody
	public void fixCompanyNotice(@RequestBody CompanyNotice companyNotice) {
		noticeService.fixCompanyNotice(companyNotice);
	}
	
	//company 사내 공지사항 삭제
	@DeleteMapping("admin/notice/getcomntc/del/{companyNoticeNo}")
	public void delCompanyNotice(@PathVariable int companyNoticeNo) {
		noticeService.delCompanyNotice(companyNoticeNo);
	}
	
	//user 사내 공지사항 목록
	@GetMapping
	@RequestMapping("notice/comntclist")
	@EmployeeCheck
	public ModelAndView usergetcomntclist(ModelAndView mv, HttpSession session) {
		mv.setViewName("notice/comntclist");
		return mv;
	}
	
	//user 사내 공지사항 상세 조회
	@GetMapping
	@RequestMapping("notice/getcomntc")
	@EmployeeCheck
	public ModelAndView usergetcomntc(ModelAndView mv, HttpSession session) {
		mv.setViewName("notice/getcomntc");
		return mv;
	}
}
