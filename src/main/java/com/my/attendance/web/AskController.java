package com.my.attendance.web;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.my.attendance.domain.Ask;
import com.my.attendance.service.AskService;

import jakarta.servlet.http.HttpSession;

@Controller("askController")
public class AskController {
	@Autowired private AskService askService;
	
	@GetMapping
	@RequestMapping("admin/ask/asklist")
	public ModelAndView asklist(ModelAndView mv) {
		mv.setViewName("admin/ask/asklist");
		return mv;
	}
	
	@GetMapping
	@RequestMapping("admin/ask/addask")
	public ModelAndView addask(ModelAndView mv) {
		mv.setViewName("admin/ask/addask");
		return mv;
	}
	
	@GetMapping
	@RequestMapping("admin/ask/getask")
	public ModelAndView getask(ModelAndView mv) {
		mv.setViewName("admin/ask/getask");
		return mv;
	}
	
	@GetMapping
	@RequestMapping("admin/ask/admasklist")
	@AdminCheck
	public ModelAndView admasklist(ModelAndView mv, HttpSession session) {
		mv.setViewName("admin/ask/admasklist");
		return mv;
	}
	
	@GetMapping
	@RequestMapping("admin/ask/admgetask")
	@AdminCheck
	public ModelAndView admgetask(ModelAndView mv, HttpSession session) {
		mv.setViewName("admin/ask/admgetask");
		return mv;
	}
	
	@GetMapping
	@RequestMapping("ask/asklist")
	public ModelAndView userasklist(ModelAndView mv) {
		mv.setViewName("ask/asklist");
		return mv;
	}
	
	@GetMapping
	@RequestMapping("ask/addask")
	public ModelAndView useraddask(ModelAndView mv) {
		mv.setViewName("ask/addask");
		return mv;
	}
	
	@GetMapping
	@RequestMapping("ask/getask")
	public ModelAndView usergetask(ModelAndView mv) {
		mv.setViewName("ask/getask");
		return mv;
	}

	@GetMapping("admin/ask/asklist/get")
	@ResponseBody
	public List<Ask> getAsks() {
	    return askService.getAsks();
	}

	@GetMapping("admin/ask/asklist/getAsk")
	@ResponseBody
	public List<Ask> getAsk(int askNo) {
		return askService.getAsk(askNo);
	}
	
	@PostMapping("admin/ask/addask/add")
	public ResponseEntity<String> addAsk(String askTitle, String askName, String askContent) {
	    askService.addAsk(askTitle, askName, askContent);
	    return new ResponseEntity<>(HttpStatus.CREATED);
	}
	
	@PutMapping("admin/ask/admgetask/add")
	public ResponseEntity<String> addAnswer(@RequestBody Ask ask) {
	    askService.addAnswer(ask);
	    return new ResponseEntity<>(HttpStatus.OK);
	}
	
	@DeleteMapping("admin/ask/admgetask/del/{askNo}")
	public ResponseEntity<String> delAnswer(@PathVariable int askNo) {
	    askService.delAsk(askNo);
	    return new ResponseEntity<>(HttpStatus.OK);
	}

}
