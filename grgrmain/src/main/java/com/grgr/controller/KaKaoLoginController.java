package com.grgr.controller;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.concurrent.ExecutionException;

import javax.servlet.http.HttpSession;

import org.json.simple.parser.ParseException;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.github.scribejava.core.model.OAuth2AccessToken;
import com.grgr.dto.UserVO;
import com.grgr.service.UserService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

//네이버의 로그인 OpenAPI를 사용하여 간편 로그인하는 방법
//1.네이버 개발자 센터에 OpenAPI 신청 기능을 사용하여 어플리케이션 등록
// => 어플리케이션 이름, 사용자 API, 서비스 환경(서비스 URL, 콜백 URL)등을 입력하여 등록
//2.내 어플리케이션에서 Client Id, Client Secret  확인
//3.네이버 로그인 이미지를 다운로드 받아 출력하고 서비스 URL로 링크 제공
//4.scribejava-apis 라이브러리와 json-simple 라이브러리 프로젝트에 빌드 처리
//5.로그인 관련 API를 요청하기 위한 클래스 작성 - NaverLoginApi 클래스와 NaverLoginBean 클래스
//6.요청 처리 메소드에서 로그인 관련 API를 요청하기 위한 클래스의 메소드를 호출하여 인증을 이용한 권한 처리

@Controller
@RequestMapping("/oauth")
@Slf4j
@RequiredArgsConstructor
public class KaKaoLoginController {
	private final com.grgr.auth.KakaoLoginBean kakaoLoginBean;
	private final UserService userService;

	// 네이버 로그인 페이지를 요청하기 위한 요청 처리 메소드
	@RequestMapping("/kakao")
	public String kakaoLogin(HttpSession session) throws UnsupportedEncodingException {
		String kakaoAuthUrl = kakaoLoginBean.getAuthorizationUrl(session);
		return "redirect:" + kakaoAuthUrl;
	}

	// 네이버 로그인 성공시 Callback URL 페이지를 처리하기 위한 요청 처리 메소드
	@RequestMapping("/kakao/callback")
	public String kakaoLoginCallback(@RequestParam String code, @RequestParam String state, HttpSession session)
			throws IOException, ParseException, InterruptedException, ExecutionException {

		// 1. 코드를 이용하여 엑세스 토큰 받기
		OAuth2AccessToken accessToken = kakaoLoginBean.getAccessToken(session, code, state);

		// 2. access Token 이용하여 사용자 프로필 정보 받아오기
		UserVO profile = kakaoLoginBean.getUserProfile(accessToken);

		log.info("profile : "+profile);
		//3. DB에 해당 유저가 존재하는지 check (kakaoID 컬럼 추가) & userinfoDB에 삽입 or update
		if( userService.loginNaverUser(profile) == false) {
			log.warn("카카오 로그인 및 회원가입 실패");
			return "redirect:/user/login";
		}
		
		//4.세션에 로그인 정보 저장 - 정상적으로 작동했다면 KakaoId 가 존재할 것임..
		UserVO user = userService.getNaverLoginUser(profile.getNaverId());
		session.setAttribute("loginId", user.getUserId());
		session.setAttribute("loginNickname", user.getNickName());
		session.setAttribute("loginUno", user.getUno());
		session.setAttribute("loginActive", user.getActive());
		session.setAttribute("loginUserStatus", user.getUserStatus());
		session.setAttribute("loginLastLogin", user.getLastLogin());
		
		return "redirect:/main";			
	}
}