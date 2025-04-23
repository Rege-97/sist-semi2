package com.plick.test;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;

@WebFilter("/*") // 전체 요청에 적용
public class ExecutionTimeFilter implements Filter {

	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {

		String uri = ((HttpServletRequest) request).getRequestURI();
		if (uri.startsWith("/semi2/resources/") || uri.endsWith(".css") || uri.endsWith(".js")) {
			chain.doFilter(request, response);
			return;
		}
		long start = System.currentTimeMillis();

		chain.doFilter(request, response);

		long end = System.currentTimeMillis();
		long duration = end - start;

		String queryString = ((HttpServletRequest) request).getQueryString();
		System.out.println("[" + ((HttpServletRequest) request).getRequestURI()
				+ ((queryString == null) ? "" : "?" + java.net.URLDecoder.decode(queryString, "UTF-8")) + "] 처리 시간: "
				+ duration + "ms");
	}
}
