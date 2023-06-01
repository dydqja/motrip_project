package com.bit.motrip.config;

import com.bit.motrip.common.ImageSaveService;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;
import org.springframework.web.servlet.view.tiles3.TilesConfigurer;
import org.springframework.web.servlet.view.tiles3.TilesViewResolver;

@Configuration
public class WebConfig implements WebMvcConfigurer {
//
//    private String connectPath = "/imagePath/**";
//    private String resourcePath = "file:///home/uploadedImage";
    private String connectPath = "/imagePath/**";
    private String resourcePath = "file:////Users/sean/Desktop/moimages/";

   // private String resourcePath = "file:///C:\\motripimage/";
//    addResourceHandler : 리소스와 연결될 URL path를 지정합니다. (클라이언트가 파일에 접근하기 위해 요청하는 url)
//    localhost:8080/imagePath*//**

// addResourceLocations: 실제 리소스가 존재하는 외부 경로를 지정합니다.
// 경로의 마지막은 반드시 " / "로 끝나야 하고, 로컬 디스크 경로일 경우 file:/// 접두어를 꼭 붙여야 합니다.

// 이렇게 설정하면 클라이언트로부터 http://호스트 주소:포트/imagePath/testImage.jpg 와 같은 요청이 들어 왔을 때
// /home/uploadedImage/testImage.jpg 파일로 연결됩니다.

// 실제 개발에서는 .properties 또는 .yml을 통해 개발 환경에 따른 경로를 작성하고 주입받아서 사용하는 것이 좋습니다.

    //추가 공부 리소스 https://blog.jiniworld.me/28

    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {
        registry.addResourceHandler(connectPath)
                .addResourceLocations(resourcePath);
    }
    @Bean
    public TilesConfigurer tilesConfigurer() {
        TilesConfigurer tilesConfigurer = new TilesConfigurer();
        tilesConfigurer.setDefinitions(
                new String[] {"/WEB-INF/tiles/tiles.xml"}
        );
        tilesConfigurer.setCheckRefresh(true);
        return tilesConfigurer;
    }
    @Bean
    public TilesViewResolver tilesViewResolver() {
        TilesViewResolver tilesViewResolver = new TilesViewResolver();
        tilesViewResolver.setOrder(1);
        return tilesViewResolver;
    }
    @Bean
    public ImageSaveService imageSaveService() {
        return new ImageSaveService(resourcePath);
    }



}
