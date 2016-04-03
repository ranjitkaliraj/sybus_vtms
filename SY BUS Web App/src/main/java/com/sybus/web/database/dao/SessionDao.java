package com.sybus.web.database.dao;

import org.springframework.jdbc.core.JdbcTemplate;

public class SessionDao {
	private JdbcTemplate jdbcTemplate;

	public void setJdbcTemplate(JdbcTemplate jdbcTemplate) {
		this.jdbcTemplate = jdbcTemplate;
	}

}
