package com.bit;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.scheduling.annotation.EnableScheduling;

@EnableScheduling // 스케줄러 사용
@SpringBootApplication
public class MotripApplication {

	public static void main(String[] args) {
		SpringApplication.run(MotripApplication.class, args);
	}

}
