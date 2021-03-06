<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ include file="../main/header.jsp"%>
<!DOCTYPE html>
<html lang="kr">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
     <!-- 파비콘 -->
    <link rel="icon" type="image/ico" href="${pageContext.request.contextPath}/resources/public/favicon.ico">
	<sec:csrfMetaTags />
    <title>ontact, 서로 연결되는 온라인 공간</title>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100;300;400;500;700;900&display=swap"
        rel="stylesheet">
    <link href="${pageContext.request.contextPath}/resources/css/reset.css" rel="stylesheet" type="text/css">
    <link href="${pageContext.request.contextPath}/resources/css/lightbox.min.css" rel="stylesheet">
    <script type="text/javascript" src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
    <script src="https://kit.fontawesome.com/22634e2e1a.js" crossorigin="anonymous"></script>
    
    <style>
        *{
            margin:0;
        }
        html,body {
            width: 100%;
            height: 100%;
            position: relative;
            font-size: 14px;
            font-family: Noto Sans KR;
            line-height: 1.15;
        }
        button{
            font-family: Noto Sans KR;
            cursor:pointer;
        }
        input{
            font-family: Noto Sans KR;
        }
        a{
            cursor:pointer;
            text-decoration:none;
        }

        header {
            position: relative;
            width: 100%;
            height: 60px;
        }

        header div {
            width: 1200px;
            height: 60px;
            margin: 0 auto;
        }

        section {
            position: relative;
            width: 1200px;
            height: 100%;
            margin: 0 auto;
        }

        /*사이드메뉴*/
        aside {
            width: 210px;
            height: 100%;
            float: left;
            background-color: #f2f2f2;
        }

        #aside_back {
            margin-top: 30px;
            width: 150px;
            height: 56px;
            font-size: 17px;
            line-height: 54px;
            border: 1px solid #5A3673;
            background-color: #5A3673;
            border-radius: 3px;
            font-weight: 700;
            color: white;
            margin-bottom: 20px;
        }

        aside ul {
            display: block;
        }

        aside ul li {
            padding: 20px;
            cursor: pointer;
        }

        aside ul a li {
            font-weight: 700;
            color: black;
            text-decoration: none;
            cursor: pointer;
            font-size: 15px;
        }
        
        aside ul li:hover{
		background-color: #e7e7e7;
		}

        /* 본문 */
        article {
            position: absolute;
            width: 970px;
            height: 860px;
            left: 210px;
            padding: 40px 0 40px 40px;
            border-left: 1px solid #e7e7e7;
            box-sizing: border-box;
        }
        #info_text{
            font-size:18px;
            border-bottom:2px solid #5A3673;
            padding : 0 0 12px 0;
            margin-bottom: 15px;
        }
        #alert{
            position:absolute;
            left:40%;
            width:350px;
            height:40px;
            border:1px solid #a2a2a2;
            margin:5px auto;
            background-color:#d4cdf5;
            font-size: 14px;
            color: #505050;
            font-weight:700;
            text-align: center;
            line-height: 40px;
            z-index:99999;
            display:none;
        }
        #info_wrapper{
            position: relative;
            display: flex;
            margin:20px 0px 0px 60px;
        }
        #info_side{
            
        }
        #info_side_text{
            font-size:16px;
            color:#111;
            padding-left:2px;
            font-weight:400;
            margin-left:20px;
        }
        #line{
            margin:20px 0;
            height:1px;
            line-height:0;
            overflow:hidden;
            background-color: #e9eaed;
            width:400px;
        }
        /* 사진부분 */
        #info_photo_wrap {
            width: 250px;
            position: relative;
        }

        #userphoto {
            width: 110px;
            height: 110px;
            z-index: 30;
            position: absolute;
            top: 10px;
            left: 30px;
            right: 0;
            bottom: 0px;
            content: "";
            display: block;
            border-radius: 90px;
            /* box-shadow: inset 0 0 0 1px rgba(0, 0, 0, .05); */
            /* border:1px solid #acacac; */
        }
        #profile{
       		width: 110px;
            height: 110px;
           /*  z-index: 30; */
            position: absolute;
            top: 0px;
            left: 0px;
            right: 0;
            bottom: 0px;
            content: "";
            display: block;
            border-radius: 90px;
            box-shadow: inset 0 0 0 1px rgba(0, 0, 0, .05);
            border:1px solid #acacac;
        }
        .thumb-image{
        	width: 110px;
            height: 110px;
            z-index: 30;
            position: absolute;
            top: 15px;
            left: 30px;
            right: 0;
            bottom: 0px;
            content: "";
            display: block;
            border-radius: 90px;
            box-shadow: inset 0 0 0 1px rgba(0, 0, 0, .05);
            border:1px solid #acacac;
            background-color:red;
        }
        #userphoto_btn{
            display: block;
            position: absolute;
            width: 40px;
            height: 40px;
            bottom: -115px;
            right: 105px;
            border-radius: 90px;
            border:1px solid #acacac;
            /* background-image: url("../img/photo-camera.png"); */
            background-color: #fff;
            z-index: 30;
        }
        #userphoto_btn img{
            display: block;
            position: relative;
            width: 30px;
            padding-top:4px;
            margin:0 auto;
            /* border-radius: 90px; */
            /* border:1px solid #d2d2d2; */
        }
        #userphoto_menu{
            display:none;
            position:absolute;
            border:1px solid #d2d2d2;
            top:95px;
            right:58px;
            padding:5px 0px 5px 0px;
            font-size:12px;
            text-align: left;
            box-shadow: 3px 7px 7px 2px rgba(0,0,0,.15);
            border-radius: 3px;
            z-index: 100;
            background-color: #fff;
        }
        .file{
            display:block;
            color:#666;
            white-space:nowrap;
            padding:5px 10px 10px 10px;
            border-bottom:1px solid #d2d2d2;
            line-height: 12px;
        }
        #removephoto{
            display:block;
            color:#666;
            white-space:nowrap;
            padding:10px 10px 5px 10px;
            line-height: 12px;
        }
        #photobtn {
            width: 100px;
            height: 25px;
            background-color: #5A3673;
            border: 1px solid #5A3673;
            border-radius: 3px;
            color: #e7e7e7;
            border: none;
            font-family: Noto Sans KR;
            font-weight: 500;
            vertical-align: middle;
            font-size: 14px;
            position:absolute;
            top:140px;
            left:36px;
            display:none;
        }
        /* 내정보 부분 */
        #info_section ul li{
            padding-bottom:5px
        }
        .userinfo_editable,
        .userinfo_uneditable,
        .companyinfo_editable{
            display:flex;
            position:relative;
            min-width: 350px;
            min-height:31px;
            line-height: 31px;
            padding:3px;
        }
        .userinfo_editable:hover,
        .companyinfo_editable:hover{
            background-color:#e7e7e7;
        }
        .userinfo_editable_content{
            width:170px;
        }
        .editbtn{
            display:none;
        }
        .userinfo_editable:hover .editbtn,
        .companyinfo_editable:hover .editbtn{
            position: absolute;
            display:block;
            right:0;
            font-size:12px;
            color:#a3a3a3;
            margin-left:30px;
            margin-right:5px;
        }
        /*내 정보 편집*/
        .userinfo_edit{
            display:flex;
            position:relative;
            min-width: 350px;
            min-height:31px;
            line-height: 31px;
            padding:3px;
        }
        .input_edit{
            border-top:none;
            border-left:none;
            border-right:none;
            border-bottom:1px solid #dddee2;
            font-weight:700;
            vertical-align:middle;
            width:184px;
        }
        .info_btn_save{
            padding:0 7px 1px 7px;
            margin-left:12px;
            height:24px;
            line-height:24px;
            font-size:13px;
            font-weight:700;
            color:#505050;
            text-align:center;
            border:1px solid #b0b1b3;
            border-radius:2px;
            background-color:#fff;
        }
        .canclebtn{
            margin-left:10px;
            font-size:13px;;
            font-weight:700;
            color:#7b7c7f;
            line-height: 26px;
        }
        
    </style>
</head>

<body>
    <header>
    	<div id="alert">수정되었습니다</div>
        <div>헤더 들어갈 자리</div>
    </header>
    <section>
        <aside>
            <a href="${pageContext.request.contextPath}/project/all/list">
            <button id="aside_back"><&nbsp;&nbsp;&nbsp;&nbsp;돌아가기</button>
            </a>
            <ul>
                <a href="${pageContext.request.contextPath}/user/mypage/detail"><li style="text-decoration:underline;">계정 정보</li></a>
                <a href="${pageContext.request.contextPath}/user/mypage/updpwd"><li>비밀번호 설정</li></a>
            </ul>
        </aside>
        <article>
            <div id="info_text">계정 정보</div>
            <h5 id="info_side_text">내 프로필</h5>
            <div id="info_wrapper">
                <div id="info_side">
                    <div id="info_photo_wrap">
                    <sec:authentication property="principal.ufilepath" var="ufilepath"/>
                    <sec:authentication property="principal.ufilename" var="dbufilename"/>
                    	<c:if test="${empty ufilepath}">
                        	<div id="userphoto"><img src="${pageContext.request.contextPath}/resources/img/user-3.png" id="profile"></div>
                    	</c:if>
                    	<c:if test="${not empty ufilepath}">
                    		<div id="userphoto"><img src="${ufilepath}" id="profile"></div>
                    	</c:if>
                        <a id="userphoto_btn"><img src="${pageContext.request.contextPath}/resources/img/photo-camera.png"></a>
                        <form id="profileform" action="${pageContext.request.contextPath}/user/mypage/profile" method="post">
	                        <div id="userphoto_menu">
	                        	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
	                            <label class="file" for="uploadphoto" style="cursor:pointer;">사진 편집</label>
	                            <input type="file" id="uploadphoto" accept="image/*" name="image" style="display:none;">
	                            <a id="removephoto" onclick="deleteFileWrtPage()">사진 삭제</a>
	                            <input type="hidden" id="ufilename" name="ufilename">
	                            <input type="hidden" id="ufilepath2" name="ufilepath">
	                            <input type="hidden" id="dbufilename" value="${dbufilename}">
	                        </div>
	                        <button type="submit" id="photobtn">사진 등록하기</button>
                        </form>
                    </div>
                </div>
               
                <div id="info_section">
                    <ul class="usersinfo">
                        <li class="userinfo_line">
                            <div class="userinfo_uneditable">
                                <span class="userinfo_editable_content">아이디</span>
                                <strong class="userinfo_content"><sec:authentication property="principal.username" var="email"/>${email}</strong>
                            </div>
                        </li>
                        <li class="userinfo_line">
                            <!--마우스오버-->
                            <div class="userinfo_uneditable">
                                <span class="userinfo_editable_content">이름</span>
                                <strong class="userinfo_content"><sec:authentication property="principal.uname" var="name"/>${name}</strong>
                                <a class="editbtn">수정</a>
                            </div>
                        </li>
                        <li class="userinfo_line">
                            <div class="userinfo_uneditable">
                                <span class="userinfo_editable_content">이메일</span>
                                <strong class="userinfo_content">${email}</strong>
                            </div>
                        </li>
                        <li class="userinfo_line">
                            <!--마우스오버-->
                            <div class="userinfo_editable">
                                <span class="userinfo_editable_content">휴대폰번호</span>
	                                <sec:authentication property="principal.utell" var="tell"/>
                                <strong class="userinfo_content" id="utell_content">${tell}</strong>
                                <a class="editbtn">수정</a>
                            </div>
                            <!--편집활성-->
                            <div class="userinfo_edit" style="display: none">
                                <span class="userinfo_editable_content">휴대폰번호</span>
                                <input type="text" class="input_edit" placeholder="숫자만 입력해주세요"  maxlength="15" name="utell" value="${tell}" id="utell">
                                <button class="info_btn_save" id="utellbtn">저장</button>
                                <a class="canclebtn">취소</a>
                            </div>
                        </li>
                    </ul>
                    <div id="line"></div>
                    <ul class="companyinfo">
                        <li class="companyinfo_line">
                            <!--마우스오버, 권한설정-->
                            <sec:authorize access="hasRole('ROLE_USER')">
                            <div class="userinfo_uneditable">
                                <span class="userinfo_editable_content">회사명</span>
                                <strong class="userinfo_content">${company.cname}</strong>
                                <a class="editbtn">수정</a>
                            </div>
                            </sec:authorize>
                            
                            <sec:authorize access="hasRole('ROLE_ADMIN')">
                            <div class="companyinfo_editable">
                                <span class="userinfo_editable_content">회사명</span>
                                <strong class="userinfo_content" id="cname_content">${company.cname}</strong>
                                <a class="editbtn">수정</a>
                            </div>
                            <!--편집활성-->                            
                            <div class="userinfo_edit" style="display: none">
                                <span class="userinfo_editable_content">회사명</span>
                                <input type="text" class="input_edit" placeholder="최대 30자" maxlength="30" name="cname" value="${company.cname}" id="cname">
                                <button class="info_btn_save" id="cnamebtn">저장</button>
                                <a class="canclebtn">취소</a>
                            </div>
                            </sec:authorize>
                        </li>
                        <li class="companyinfo_line">
                            <div class="userinfo_uneditable">
                                <span class="userinfo_editable_content">부서명</span>
                                <strong class="userinfo_content">${dname}</strong>
                                <a class="editbtn">수정</a>
                            </div>
                        </li>
                        <li class="companyinfo_line">
                            <!--마우스오버-->
                            <div class="companyinfo_editable">
                                <span class="userinfo_editable_content">직책</span>
                                <strong class="userinfo_content" id="urank_content"><sec:authentication property="principal.urank" var="rank"/>${rank}</strong>
                                <a class="editbtn">수정</a>
                            </div>
                             <!--편집활성-->
                             <div class="userinfo_edit" style="display: none">
                                <span class="userinfo_editable_content">직책</span>
                                <input type="text" class="input_edit" placeholder="직책 입력 2~6자"  maxlength="6" name="urank" value="${rank}" id="urank1">
                                <button class="info_btn_save" id="urankbtn">저장</button>
                                <a class="canclebtn">취소</a>
                            </div>
                        </li>
                        <li class="companyinfo_line">
                            <!--마우스오버-->
                            <div class="companyinfo_editable">
                                <span class="userinfo_editable_content">회사연락처</span>
                                <strong class="userinfo_content" id="ctel_content">${company.ctel}</strong>
                                <a class="editbtn">수정</a>
                            </div>
                            <!--편집활성-->
                            <div class="userinfo_edit" style="display: none">
                                <span class="userinfo_editable_content">회사연락처</span>
                                <input type="text" class="input_edit" placeholder="숫자만 입력해주세요" name="ctel" maxlength="15" value="${company.ctel}" id="ctel">
                                <button class="info_btn_save" id="ctelbtn">저장</button>
                                <a class="canclebtn">취소</a>
                            </div>
                        </li>
                    </ul>
                   </div>
            </div>
        </article>
    </section>

    <script>
    
        //편집 버튼 활성화
        $('.editbtn').click(function(){
            $(this).parent('.userinfo_editable').css("display","none");
            $(this).parents('li').find('.userinfo_edit').css("display","flex");
        });
        $('.editbtn').click(function(){
            $(this).parent('.companyinfo_editable').css("display","none");
            $(this).parents('li').find('.userinfo_edit').css("display","flex");
        });
        $('.canclebtn').click(function(){
            let $t = $(this).parents('li');
            let content = $t.find('.userinfo_content').text();
            $(this).parent('.userinfo_edit').css("display","none");
            $(this).parent('.userinfo_edit').find('.input_edit').val(content);
            $t.find('.userinfo_editable').css("display","flex");
        });
        $('.canclebtn').click(function(){
            let $t = $(this).parents('li');
            let content = $t.find('.userinfo_content').text();
            $(this).parent('.userinfo_edit').css("display","none");
            $(this).parent('.userinfo_edit').find('.input_edit').val(content);
            $t.find('.companyinfo_editable').css("display","flex");
        });
        
       //정보 수정
       $('#utellbtn').click(function(){
    	   var utell = $("#utell").val();
    	   var utell_origin = $("#utell_content").text();
	        $.ajax({
				type:"GET",
				url:"${pageContext.request.contextPath}/user/mypage/updutell?utell="+utell,
				success:function(data){
					console.log(data);
					if(data=='aaa'){
						$('#alert').text('숫자만 입력해주세요.');
						$('#alert').css('background-color','#ffdcdc');
						$('#alert').fadeIn(2000, function(){
							$(this).fadeOut('slow');
						});
						$("#utell").parent('.userinfo_edit').css("display","none");
						$("#utell").parents('li').find('.userinfo_editable').css("display","flex");
						$("#utell").val(utell_origin);
					} else{
						$('#alert').text('변경되었습니다.');
						$('#alert').fadeIn(2000, function(){
							$(this).fadeOut('slow');
						});
						$("#utell").parent('.userinfo_edit').css("display","none");
						$("#utell").parents('li').find('.userinfo_editable').css("display","flex");
						$('#utell_content').text(utell);
					}
				}
			})
        });
       
       $('#cnamebtn').click(function(){
    	   var cname = $("#cname").val();
    	   var cname_origin = $("#cname_content").text();
	        $.ajax({
				type:"GET",
				url:"${pageContext.request.contextPath}/user/mypage/updcname?cname="+cname,
				success:function(data){
					console.log(data);
					if(data=='aaa'){
						$('#alert').text('이름에 특수문자를 넣을 수 없습니다.');
						$('#alert').css('background-color','#ffdcdc');
						$('#alert').fadeIn(2000, function(){
							$(this).fadeOut('slow');
						});
						$("#cname").parent('.userinfo_edit').css("display","none");
						$("#cname").parents('li').find('.companyinfo_editable').css("display","flex");
						$("#cname").val(cname_origin);
					} else{
						$('#alert').text('변경되었습니다.');
						$('#alert').fadeIn(2000, function(){
							$(this).fadeOut('slow');
						});
						$("#cname").parent('.userinfo_edit').css("display","none");
						$("#cname").parents('li').find('.companyinfo_editable').css("display","flex");
						$('#cname_content').text(cname);
					}
				}
			})
        });
       
       
       $('#urankbtn').click(function(){
    	   var urank = $("#urank1").val();
    	   console.log(urank);
    	   var urank_origin = $("#urank_content").text();
	        $.ajax({
				type:"GET",
				url:"${pageContext.request.contextPath}/user/mypage/updurank?urank="+urank,
				success:function(data){
					console.log(data);
					if(data=='aaa'){
						$('#alert').text('직책에 특수문자를 넣을 수 없습니다.');
						$('#alert').css('background-color','#ffdcdc');
						$('#alert').fadeIn(2000, function(){
							$(this).fadeOut('slow');
						});
						$("#urank1").parent('.userinfo_edit').css("display","none");
						$("#urank1").parents('li').find('.companyinfo_editable').css("display","flex");
						$("#urank1").val(urank_origin);
					} else{
						$('#alert').text('변경되었습니다.');
						$('#alert').fadeIn(2000, function(){
							$(this).fadeOut('slow');
						});
						$("#urank1").parent('.userinfo_edit').css("display","none");
						$("#urank1").parents('li').find('.companyinfo_editable').css("display","flex");
						$('#urank_content').text(urank);
					}
				}
			})
        });
       
       
       $('#ctelbtn').click(function(){
    	   var ctel = $("#ctel").val();
    	   var ctel_origin = $("#ctel_content").text();
	        $.ajax({
				type:"GET",
				url:"${pageContext.request.contextPath}/user/mypage/updctel?ctel="+ctel,
				success:function(data){
					console.log(data);
					if(data=='aaa'){
						$('#alert').text('숫자만 입력해주세요.');
						$('#alert').css('background-color','#ffdcdc');
						$('#alert').fadeIn(2000, function(){
							$(this).fadeOut('slow');
						});
						$("#ctel").parent('.userinfo_edit').css("display","none");
						$("#ctel").parents('li').find('.companyinfo_editable').css("display","flex");
						$("#ctel").val(ctel_origin);
					} else{
						$('#alert').text('변경되었습니다.');
						$('#alert').fadeIn(2000, function(){
							$(this).fadeOut('slow');
						});
						$("#ctel").parent('.userinfo_edit').css("display","none");
						$("#ctel").parents('li').find('.companyinfo_editable').css("display","flex");
						$('#ctel_content').text(ctel);
					}
				}
			})
        });
       // 회사명은 사장만 가능 / 직책, 회사연락처는 그냥.. 다 가능하게 하자..
        
       
       //사진 메뉴 토글
        $("#userphoto_btn").on("click", function (e) {
            e.preventDefault();
            $("#userphoto_menu").toggle();
        })
  
    	var header = $("meta[name='_csrf_header']").attr("content");
        var token = $("meta[name='_csrf']").attr("content");
        
        //console.log($("ufilename").val()+"맨처음 들어왔을때");
        
        //페이지 벗어나려 할 때
        var checkUnload = true;
        $(window).on("beforeunload", function(){
        	let ufilename = $("#ufilename").val();
            if(checkUnload){
            	if(ufilename===null||ufilename===""){
            		return "이 페이지를 벗어나면 작성된 내용은 저장되지 않습니다.";
            	} else{
            		deleteFile(ufilename);
            		return "이 페이지를 벗어나면 작성된 내용은 저장되지 않습니다.";
            	}
            }
        });
        
        // 서버에 파일 업로드
        $("#uploadphoto").on("change", fileChange);
        function fileChange(e){
        	e.preventDefault();
        	let ufilename = $("#ufilename").val();
            	if(ufilename!==null||ufilename!==""){
            		deleteFile(ufilename);
            	} 
        	
        	var files = e.target.files;
        	var file = files[0];
        	var formData = new FormData();
     	    formData.append("file", file);
     	    console.log(formData.get('file'));
     	    // 파일 업로드 AJAX 통신 메서드 호출
     	    uploadFile(formData);
        }
    	
    	//파일 업로드 AJAX 통신
    	function uploadFile(formData){
    		$.ajax({
    			url:"${pageContext.request.contextPath}/files/upload",
    			data:formData,
    			dataType:"text",
    			processData:false,
    			contentType:false,
    			type:"POST",
    			beforeSend: function(xhr){
    				xhr.setRequestHeader(header, token);	// 헤드의 csrf meta태그를 읽어 CSRF 토큰 함께 전송
    			},
    			success:function(data){
    				printFiles(data);
    			}
    		})
    	}
		
    	// 첨부파일 출력
    	function printFiles(data){
    		// 파일 정보 처리
    	    var fileInfo = getFileInfo(data);
    		$("#ufilename").val(fileInfo.fullName);
			
    		// 원본 파일이 들어가도록
    		let imgSrc = fileInfo.imgSrc;
            
            let s = imgSrc.indexOf("s_");
            let after = imgSrc.indexOf("-");
            if(s<after){
              let first = imgSrc.slice(0,s);
              let second = imgSrc.slice(s+2, imgSrc.length);
              imgSrc = first+second;
              console.log(imgSrc+": 원본");
            }
            
    		
    		$("#ufilepath2").val(imgSrc);
    		$("#profile").attr("src",fileInfo.imgSrc);
			$("#userphoto_menu").hide();
        	$("#photobtn").show()
    	}
    	
    	// 프로필사진 등록
   		$("#profileform").submit(function (event) {
   			let dbufilename = $("#dbufilename").val();
   			deleteFile(dbufilename);
   			checkUnload = false;
    	});
    	
    	
    	// 파일 삭제 (db삭제 or 서버에서 사진삭제)
    	function deleteFileWrtPage() {
    		let ufilename = $("#ufilename").val();
    		let dbufilename = $("#dbufilename").val();
    		let f = document.createElement("form");
    		f.setAttribute("method", "post");
    		
    		var delconfirm = confirm("정말 삭제하시겠습니까?")
    		if(delconfirm){
    			if(ufilename===null || ufilename===""){
    				if(dbufilename===null||dbufilename===""){
    					alert("삭제할 사진이 없습니다.")
    				} else{
    					checkUnload = false;
    					deleteFile(dbufilename);
		    			f.setAttribute("action","${pageContext.request.contextPath}/user/mypage/delProfile")
		    			document.body.appendChild(f);
		    			var i = document.createElement("input");
		    			i.setAttribute("type","hidden");
		    			i.setAttribute("name","${_csrf.parameterName}");
		    			i.setAttribute("value","${_csrf.token}");
		    			f.appendChild(i);
		    			f.submit();    					
    				}
	    		} else {
	    			checkUnload = false;
	    			// 사진편집이 실행 되었을 경우
	    			console.log(ufilename);
	    			console.log("사진편집");
	    			f.setAttribute("action","${pageContext.request.contextPath}/user/mypage/delPreviewProfile");
	    			document.body.appendChild(f);
	    			var i = document.createElement("input");
	    			i.setAttribute("type","hidden");
	    			i.setAttribute("name","ufilename");
	    			i.setAttribute("value",ufilename);
	    			f.appendChild(i);
	    			var csrf = document.createElement("input");
	    			csrf.setAttribute("type","hidden");
	    			csrf.setAttribute("name","${_csrf.parameterName}");
	    			csrf.setAttribute("value","${_csrf.token}");
	    			f.appendChild(csrf);
	    			f.submit();
	    		}
    		} else {
    			alert("삭제가 취소되었습니다.")
    		}
    	}
    	
    	// 서버파일 삭제 AJAX 통신
    	function deleteFile(dbufilename) {
    	    $.ajax({
    	        url: "${pageContext.request.contextPath}/files/delete",
    	        type: "post",
    	        data: {fileName: dbufilename},
    	        dataType: "text",
    	        beforeSend: function(xhr){
    				xhr.setRequestHeader(header, token);	// 헤드의 csrf meta태그를 읽어 CSRF 토큰 함께 전송
    			},
    	        success: function (result) {
    	            if (result === "DELETED") {
    	            	console.log("삭제됨");
    	            }
    	        }
    	    });
    	}
    	
    	// 파일 정보 처리
    	function getFileInfo(fullName) {

    	    var originalFileName;   // 화면에 출력할 파일명
    	    var imgSrc;             // 썸네일 or 파일아이콘 이미지 파일 출력 요청 URL
    	    var originalFileUrl;    // 원본파일 요청 URL
    	    var uuidFileName;       // 날짜경로를 제외한 나머지 파일명 (UUID_파일명.확장자)

    	    // 이미지 파일이면
    	    if (checkImageType(fullName)) {
    	        imgSrc = "${pageContext.request.contextPath}/files/display?fileName=" + fullName; // 썸네일 이미지 링크
    	        uuidFileName = fullName.substr(14);
    	        var originalImg = fullName.substr(0, 12) + fullName.substr(14);
    	        // 원본 이미지 요청 링크
    	        originalFileUrl = "${pageContext.request.contextPath}/files/display?fileName=" + originalImg;
    	    } else {
    	        alert("이미지 파일만 선택해주세요.")
    	        return false;
    	    }
    	    originalFileName = uuidFileName.substr(uuidFileName.indexOf("_") + 1);
    	    return {originalFileName: originalFileName, imgSrc: imgSrc, originalFileUrl: originalFileUrl, fullName: fullName};
    	}

    	// 이미지 파일 유무 확인
    	function checkImageType(fullName) {
    	    var pattern = /jpg$|gif$|png$|jpge$/i;
    	    return fullName.match(pattern);
    	}
    	
    </script>
</body>

</html>