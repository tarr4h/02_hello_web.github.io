package com.kh.web.member.model.service;

import static com.kh.web.common.JdbcTemplate.*;
import java.sql.Connection;

import com.kh.web.common.JdbcTemplate;
import com.kh.web.member.model.dao.MemberDao;
import com.kh.web.member.model.vo.Member;

/**
 * 
 * Dao요청
 * - Connection객체 생성
 *
 */
public class MemberService {
	
	private MemberDao memberDao = new MemberDao();

	/**
	 * DML
	 * 1. Connection생성
	 * 2. Dao 메소드호출(Connection 전달)
	 * 3. trasaction처리 (commit / rollback)
	 * 4. Connection 자원반납
	 * 
	 * @param member
	 * @return
	 */
	public int insertMember(Member member) {
		Connection conn = null;
		int result = 0;
		
		// 완성형 transaction 처리
		// exception이 발생하는 경우에만 rollbakc 되도록 try/catch절 처리
		// 예외는 Servlet(controller)까지 던져서, Tomcat이 처리하도록 함.
		try {
			conn = getConnection();
			result = memberDao.insertMember(conn, member);
			commit(conn);
		} catch(Exception e) {
			rollback(conn);
			throw e;
		}
		close(conn);
		return result;
	}

}
