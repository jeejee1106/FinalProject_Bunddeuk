package com.team.project;

import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.Test;

import data.paging.PagingHandler;

public class PagingTest {

	@Test
	public void test() {
		PagingHandler pagingHandler = new PagingHandler(84, 16);
		System.out.println(pagingHandler.getBeginPage());
		System.out.println(pagingHandler.getEndPage());
		
		Assertions.assertTrue(pagingHandler.getBeginPage() == 1);
		Assertions.assertTrue(pagingHandler.getEndPage() == 5);
	}
}
