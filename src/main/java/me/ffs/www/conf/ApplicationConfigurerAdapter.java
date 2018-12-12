package me.ffs.www.conf;


import org.springframework.boot.web.server.ErrorPage;
import org.springframework.boot.web.server.WebServerFactoryCustomizer;
import org.springframework.boot.web.servlet.server.ConfigurableServletWebServerFactory;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.HttpStatus;
import org.springframework.validation.beanvalidation.LocalValidatorFactoryBean;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;

import me.ffs.www.control.interceptor.AccessInterceptor;
import me.ffs.www.control.interceptor.LoginInterceptor;

import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

/**
 * @author: 456
 * @date: 2018/3/7
 */
@Configuration
public class ApplicationConfigurerAdapter  implements WebMvcConfigurer {


    /*************************************404  500  页面****************************************/
    @Bean
    public WebServerFactoryCustomizer containerCustomizer(){
        return new MyCustomizer();
    }
    private static class MyCustomizer implements WebServerFactoryCustomizer<ConfigurableServletWebServerFactory>  {
        @Override
        public void customize(ConfigurableServletWebServerFactory container) {
            container.addErrorPages(new ErrorPage(HttpStatus.NOT_FOUND , "/404"));
            container.addErrorPages(new ErrorPage(HttpStatus.INTERNAL_SERVER_ERROR,"/500"));
        }
    }

    @Bean
    public javax.validation.Validator localValidatorFactoryBean() {
        return new LocalValidatorFactoryBean();
    }

    /**
     * 配置拦截器
     * @author 456
     * @param registry
     */
    @Override
    public void addInterceptors(InterceptorRegistry registry) {
//        registry.addInterceptor(new UserSecurityInterceptor()).addPathPatterns("/**","/pay/**","/ql/**");
        registry.addInterceptor(new LoginInterceptor()).addPathPatterns("/**").excludePathPatterns("/global/**","/front/anony/**","/back/anony/**","/resources/**","/images/**","/403/**","/404/**","/500/**","/audio/**","/share_img/**");
        registry.addInterceptor(new AccessInterceptor()).addPathPatterns("/front/anony/signup");
    }

}