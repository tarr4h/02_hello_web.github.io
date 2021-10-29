package com.kh.web.member.controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.kh.web.member.model.service.MemberService;
import com.kh.web.member.model.vo.Member;

/**
 * Servlet은 Controller역할을 담담한다.
 */
@WebServlet("/member/enroll.do")
public class MemberEnrollServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private MemberService memberService = new MemberService();

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			// 0. 인코딩처리
			request.setCharacterEncoding("utf-8");
			
			// 1. 요청처리 : 사용자입력값을 자바변수에 옮겨담기
			String userId = request.getParameter("userId");
			String pwd = request.getParameter("pwd");
			String userName = request.getParameter("userName");
			String ssn1 = request.getParameter("ssn1");
			String ssn2 = request.getParameter("ssn2");
			String email = request.getParameter("email");
			String tel1 = request.getParameter("tel1");
			String tel2 = request.getParameter("tel2");
			String tel3 = request.getParameter("tel3");
			String job = request.getParameter("job");
			String[] hobbies = request.getParameterValues("hobby");
			
			String ssn = ssn1 + "-" + ssn2;
			String tel = tel1 + tel2 + tel3;
			String hobby = hobbies != null ? String.join(",", hobbies) : ""; // join 메소드
					
			Member member = new Member(userId, pwd, userName, ssn, email, tel, job, hobby, null); // regDate default로 처리하기 위해 null로 넘긴다.
			
			// 2. 업무로직 : db에 insert요청
			int result = memberService.insertMember(member);			
			
			
			// 3. 응답 html 처리 : jsp에 위임
			// 결과페이지에서 보여줄 정보 처리
			// 1. 사용자정보
			request.setAttribute("userId", userId);
			request.setAttribute("userName", userName);
			request.setAttribute("ssn1", ssn1);
			request.setAttribute("email", email);
			request.setAttribute("tel", tel);
			request.setAttribute("job", job);
			request.setAttribute("hobby", hobby);
			
			// 2. 회원가입 처리 결과(1 or 0)
			request.setAttribute("result", result);
			
			RequestDispatcher requestDispatcher = request.getRequestDispatcher("/memberEnrollEnd.jsp");
			requestDispatcher.forward(request, response);
		} catch(Exception e) {
			e.printStackTrace();
			throw e;
			// 밑에서부터 던진 ErrorMessage를 Tomcat에게 던진다.
		}
	}

}
