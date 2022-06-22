package com.uni.spring.manager.model.dto;


import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
public class Search {
	String find;
	String keyword;
	@Override
	public String toString() {
		return "Search [find=" + find + ", keyword=" + keyword + "]";
	}
}
