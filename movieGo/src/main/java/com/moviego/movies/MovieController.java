package com.moviego.movies;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller("movies.movieController")
public class MovieController {
	
	@RequestMapping(value="/movies")
	public String movieForm() throws Exception {
		
		return ".mainLayout";
	}
}
