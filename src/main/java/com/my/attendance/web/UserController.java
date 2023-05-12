package com.my.attendance.web;

import java.io.File;
import java.io.IOException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.my.attendance.domain.Admin;
import com.my.attendance.domain.Company;
import com.my.attendance.domain.Employee;
import com.my.attendance.service.UserService;

import jakarta.servlet.http.HttpSession;

@Controller
public class UserController {
	@GetMapping
	@RequestMapping("admin/user/comlist")
	@AdminCheck
	public ModelAndView listCompany(ModelAndView mv, HttpSession session) {
		mv.setViewName("admin/user/comlist");
		return mv;
	}
	
	@GetMapping
	@RequestMapping("admin/user/getcom")
	@AdminCheck
	public ModelAndView Companyget(ModelAndView mv, HttpSession session) {
		mv.setViewName("admin/user/getcom");
		return mv;
	}
	
	//company--------------------------------
	@RequestMapping("admin/user/login")
	public String loginCompany() {
		return "admin/user/login";
	}
	
	@RequestMapping("admin/user/findid")
	public String findidCom() {
		return "admin/user/findid";
	}
	
	@RequestMapping("admin/user/findpw")
	public String findpwCom() {
		return "admin/user/findpw";
	}
	
	@RequestMapping("admin/user/addcom")
	public String addcom() {
		return "admin/user/addcom";
	}
	
	@GetMapping
	@RequestMapping("admin/user/getinfo")
	@CompanyCheck
	public ModelAndView getCompany(ModelAndView mv, HttpSession session) {
		mv.setViewName("admin/user/getinfo");
		return mv;
	}
	
	@GetMapping
	@RequestMapping("admin/user/fixinfo")
	@CompanyCheck
	public ModelAndView fixCompany(ModelAndView mv, HttpSession session) {
		mv.setViewName("admin/user/fixinfo");
		return mv;
	}
	
	@GetMapping
	@RequestMapping("admin/user/emplist")
	@CompanyCheck
	public ModelAndView listEmployee(ModelAndView mv, HttpSession session) {
		mv.setViewName("admin/user/emplist");
		return mv;
	}
	
	@GetMapping
	@RequestMapping("admin/user/addemp")
	@CompanyCheck
	public ModelAndView addemp(ModelAndView mv, HttpSession session) {
		mv.setViewName("admin/user/addemp");
		return mv;
	}
	
	@GetMapping
	@RequestMapping("admin/user/fixemp")
	@CompanyCheck
	public ModelAndView fixEmployee(ModelAndView mv, HttpSession session) {
		mv.setViewName("admin/user/fixemp");
		return mv;
	}
	
	//employee ------------------------------
	@RequestMapping("user/login")
	public String loginEmployee() {
		return "user/login";
	}
	
	@RequestMapping("user/findid")
	public String findid() {
		return "user/findid";
	}
	
	@RequestMapping("user/findpw")
	public String findpw() {
		return "user/findpw";
	}
	
	@GetMapping
	@RequestMapping("user/fixpw")
	@EmployeeCheck
	public ModelAndView fixPw(ModelAndView mv, HttpSession session) {
		mv.setViewName("user/fixpw");
		return mv;				
	}
	
	@Autowired private UserService userService;
	
	//admin--------------------------------
	@ResponseBody
	@GetMapping("loginAdmin")
	public String getLoginAdmin(String adminId, String adminPw, HttpSession session) {
		String result = "";
		Admin adm = userService.admLoginCheck(adminId, adminPw);
		if(adm != null) {
			session.setAttribute("adminId", adm.getAdminId());
			result = "admin";
		} else {
			result = "";
		}
		
		return result;
	}
	
	@GetMapping(value = {"logoutAdmin", "*/logoutAdmin"})
	public String admLogout(HttpSession session) {
		session.setAttribute("adminId", null);
		return "redirect:/admin";
	}
	
	//company--------------------------------
	@ResponseBody
	@GetMapping("admin/user/loginCom")
	public String getLoginCompany(String companyId, String companyPw, 
			HttpSession session) {
		String result = "";
		Company com = userService.comLoginCheck(companyId, companyPw);
		if(com != null) {
			session.setAttribute("comId", com.getCompanyId());
			result = "company";
		} else {
			result = "";
		}
		return result;
	}
	
	@GetMapping(value = {"logoutCom", "*/logoutCom", "*/*/logoutCom"})
	public String comLogout(HttpSession session) {
		session.setAttribute("comId", null);
		return "redirect:/company";
	}
	
	@ResponseBody
	@GetMapping("admin/user/findIdCom")
	public String getcompanyId(String companyName, int companyRegno) {
		String id = userService.comFindId(companyName, companyRegno);
		return id;
	}
	
	@ResponseBody
	@GetMapping("admin/user/findPwCom")
	public String getcompanyPw(String companyId, String companyEmail) {
		String pw = userService.comFindPw(companyId, companyEmail);
		return pw;
	}
	
	@ResponseBody
	@GetMapping("admin/user/comlist/get")
	public List<Company> getCompanys() {
		return userService.getCompanys();
	}
	
	@PostMapping("admin/user/addcom/add")
	public ResponseEntity<String> addCompany(@RequestBody Company company) {
	    userService.addCompany(company);
	    return new ResponseEntity<>(HttpStatus.CREATED);
	}
	
	@GetMapping("admin/user/addcom/check")
	@ResponseBody
	public int checkCompany(String companyId) {
	    return userService.checkCompany(companyId);
	}

	@PutMapping("admin/user/fixinfo/fix")
	public ResponseEntity<String> fixCompany(@RequestBody Company company){
		userService.fixCompany(company);
		return new ResponseEntity<>(HttpStatus.OK);
	}
	
	@GetMapping(value = {"admin/user/fixinfo/get", "admin/user/getinfo/get"})
	@ResponseBody
	public List<Company> choiceCompany(String companyId) {
	    return userService.getCompany(companyId);
	}
	
	@DeleteMapping("admin/user/getinfo/del/{companyId}")
	public ResponseEntity<String> delCompany(@PathVariable String companyId) {
	    userService.delCompany(companyId);
	    return new ResponseEntity<>(HttpStatus.OK);
	}
	
	//employee--------------------------------
	@ResponseBody
	@GetMapping("user/loginEmp")
	public String getLoginEmployee(String employeeId, String employeePw, HttpSession session) {
		String result = "";
		Employee emp = userService.loginCheck(employeeId, employeePw);
		if(emp != null) {
			session.setAttribute("empNo", emp.getEmployeeNo());
			session.setAttribute("empName", emp.getEmpName());
			session.setAttribute("hireDate", emp.getHireDate());
			session.setAttribute("comId", emp.getCompanyId());
			result = "main";
		} else {
			result = "";
		}
		return result;
	}
	
	@GetMapping(value = {"logout", "*/logout"})
	public String logout(HttpSession session) {
		session.setAttribute("empNo", null);
		session.setAttribute("empName", null);
		session.setAttribute("hireDate", null);
		session.setAttribute("comId", null);
		return "redirect:/";
	}
	
	@ResponseBody
	@GetMapping("user/findId")
	public String getEmployeeId(String employeeName, String employeePh) {
		String id = userService.findId(employeeName, employeePh);
		return id;
	}
	
	@ResponseBody
	@GetMapping("user/findPw")
	public String getEmployeePw( String employeeId, String employeePino) {
		String pw = userService.findPw(employeeId, employeePino);
		return pw;
	}
	
	@GetMapping("user/fixpw/check")
	@ResponseBody
	public int checkEmployeePw(int employeeNo, String employeePw) {
	    return userService.checkEmployeePw(employeeNo, employeePw);
	}
	
	@PutMapping("user/fixpw/fix/{employeeNo}/{employeePw}")
	public ResponseEntity<String> fixEmployeePw(@PathVariable int employeeNo, @PathVariable String employeePw){
		userService.fixEmployeePw(employeeNo, employeePw);
		 return new ResponseEntity<>(HttpStatus.OK);
	}

	@PostMapping("admin/user/addemp/add")
	public ResponseEntity<String> addEmployee(@RequestBody Employee employee){
		userService.addEmployee(employee);
		return new ResponseEntity<>(HttpStatus.CREATED);
	}
	
	@GetMapping("admin/user/addemp/check")
	@ResponseBody
	public int checkEmployee(String empId) {
		return userService.checkEmployee(empId);
	}	
		    	    		
	@PutMapping("admin/user/fixemp/fix")
	public ResponseEntity<String> fixEmployee(@RequestBody Employee employee){
		userService.fixEmployee(employee);
		return new ResponseEntity<>(HttpStatus.OK);
	}
	
	@GetMapping("admin/user/fixemp/get")
	@ResponseBody
	public List<Employee> choiceEmployee(int employeeNo){
		return userService.getEmployee(employeeNo);
	}
	

	@ResponseBody
	@GetMapping("admin/user/emplist/get")
	public List<Employee> getEmployees(String companyId) {
		return userService.getEmployees(companyId);
	}
	
	@DeleteMapping("admin/user/emplist/del/{employeeNo}")
	public ResponseEntity<String> delEmployee(@PathVariable int employeeNo) {
	    userService.delEmployee(employeeNo);
	    return new ResponseEntity<>(HttpStatus.OK);
	}
	
	@ResponseBody
	@GetMapping("admin/user/emplist/getInfo/{employeeNo}")
	public List<Employee> getEmployeeInfo(@PathVariable int employeeNo) {
		return userService.getEmployeeInfo(employeeNo);
	}
	
	@Value("${attachPath}") private String attachPath;
	
	@PostMapping("admin/user/profil")
	public String selectProfil(@RequestParam("profil") MultipartFile file) throws IOException {
		String fileName = file.getOriginalFilename();

		if (!file.isEmpty()) {
        	file.transferTo(new File(attachPath + fileName));
		}

		return "admin/user/emplist";
	}
}
