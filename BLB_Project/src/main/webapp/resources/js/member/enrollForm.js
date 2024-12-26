/**
 * 회원가입폼 과 관련된 자바스크립트
 */
 
  /* 입력받은 폰번호 하나로 합치기*/
   document.getElementById('enrollForm').addEventListener('submit', function(event) {
       
        var phone1 = document.getElementById('phone1').value;
        var phone2 = document.getElementById('phone2').value;
        var phone3 = document.getElementById('phone3').value;

       
        var fullPhoneNumber = phone1  + phone2  + phone3;
		
        document.getElementById('phone').value = fullPhoneNumber;
        

    });
    
    /* 아이디 중복체크 및 아이디 조건체크*/ 

    $(function(){
      const $idInput = $("#enrollForm input[name=memberId]");
 	  const $checkId = $("#checkId");
 	  
      $idInput.blur(function(){
        let checkId=$(this).val();
        
    	let validate = /^(?![0-9])(?![0-9]+$)[a-z0-9]{5,20}$/;
    	 
        if(checkId.length >= 5){
        
	        if(!validate.test(checkId)){
		
		         $("#checkId").show()
		        					.css({
						                "color": "orangered", // 색상 수정
						                "font-size": "12px",
						                "font-weight": "600"
						            }).text("5~20자의 영문 소문자,숫자만 사용 가능하며, 숫자로 시작 또는 숫자로만 이루어진 아이디는 사용할 없습니다."); 
		         
		          $("#memeberId").css("border","1px solid #orangered");
		          $("#enrollForm button[type=submit]").attr("disabled",true);
			      $("#noticeId").show();    
			     
			     return; 
			 }
			 
          $.ajax({
            url: "idCheck.me",
            type : "GET",
            data :{
              checkId : checkId
            },
            success : function(result){
	              if(result === "NNN"){
	              
	                	  $("#noticeId").show(); 
	                      $("#checkId").show()
	                              .css("color","orangered")
	                              .text("해당 아이디는 이미 등록된 아이디입니다. 다른 아이디를 입력해주세요.")
	                              .css("font-size","12px")
	                              .css("font-weight","600");
	                      
	                      $("#enrollForm button[type=submit]").attr("disabled",true);
	                      $("#memeberId").css("border","1px solid #orangered");    
	              
	              }else{
	              
	             
	                      $("#checkId").show()
	                              .css("color","#71C9CE")
	                              .text("사용가능한 아이디입니다!")
	                              .css("font-size","12px")
	                              .css("font-weight","600");
	                      
	                      $("#enrollForm button[type=submit]").attr("disabled", false);
	                      $("#memberId").css("border","2px solid #71C9CE");  
	                     
	              }
               
            },
            error : function(result){
             
                console.log("ajax 통신 실패!")
             
            }
          });
       
        }else{
         
          $("#memberId").css("border", "1px solid #ccc"); // 기본 테두리 색상으로 초기화
          $("#enrollForm button[type=submit]").attr("disabled",true);
          $("#checkId").hide(); 
          $("#noticeId").show();     	   				
        }
      });
    });
    
     /* 비번 조건체크*/ 
	    $(function(){
	      const $pwdInput = $("#enrollForm input[name=memberPwd]");
	 	
	      $pwdInput.blur(function(){
	        
	        let memberPwd=$(this).val();
	        let validate = /^(?=(.*[A-Za-z].*[0-9]))(?=(.*[0-9].*[!@#$%^&*-_]))(?=(.*[A-Za-z].*[!@#$%^&*-_])).{8,16}$/
	        
		if(memberPwd.length >=1){		
	     
	        if(validate.test(memberPwd)){
	         
	         $("#validatePwd").show()
	         				  .css({
							    "color": "#71C9CE",
							    "font-size": "12px",
							    "font-weight": "600"
								}).text("사용가능한 비밀번호입니다!");
								
			$("#memberPwd").css("border","2px solid #71C9CE");   
			$("#enrollForm button[type=submit]").attr("disabled", false);					
	          
	        }else{

	        	$("#validatePwd").show()
	        					.css({
					                "color": "orangered", // 색상 수정
					                "font-size": "12px",
					                "font-weight": "600"
					            }).text("8~16자의 영문 대/소문자, 숫자, 특수문자 중 2가지 이상 조합해서 사용해 주세요.");    
				$("#memberPwd").css("border","1px solid orangered");  
				$("#enrollForm button[type=submit]").attr("disabled", true);  
				$("#noticePwd").show();       	   				
	        }
	        
	   }else{
	   		  $("#memberPwd").css("border", "1px solid #ccc"); // 기본 테두리 색상으로 초기화
	          $("#enrollForm button[type=submit]").attr("disabled",true);
	          $("#validatePwd").hide();  
	          $("#noticePwd").show();               	   				
	   	
	   }     
	        
	  	 }); 
	 	});  
	 	
	 	/* 비밀번호 확인 체크 */
	 	
	 	 $(function() {
	 	 
		    const $ckPwdInput = $("#enrollForm input[name=checkPwd]");
		    const $pwdInput = $("#enrollForm input[name=memberPwd]");
	    
		    $ckPwdInput.change(function() {
		        let checkPwd = $(this).val();
	        
	      		  
		        // 비밀번호 확인
		        if (checkPwd === $pwdInput.val()) {
		         		                            
		           $("#ckPwd").css("border","2px solid #71C9CE");   
		           $("#enrollForm button[type=submit]").attr("disabled", false);
		           $("#checkPwd").hide();  
		           
		        } else {
		           
		            $("#checkPwd").show()
		                .css({
		                    "color": "orangered", 
		                    "font-size": "12px",
		                    "font-weight": "600"
		                }).text("비밀번호가 다릅니다");
		        
		        	$("#ckPwd").css("border","1px solid orangered");
		        	$("#enrollForm button[type=submit]").attr("disabled", true);
		        	
		        }
	       
	    });
	});
	
	
	 let isCerted = false;
    
	// 폼 제출 이벤트
     $(document).ready(function () {
        $("#enrollForm").on("submit", function (event) {
          console.log("보여?"); 
            if (!isCerted) { // 인증이 완료되지 않았다면
                event.preventDefault();
                alert('이메일 인증을 완료해주세요.');
            }else{
            	console.log("인증완 제출허용");
            }
        });
    });
    
    // 이메일 인증메일보내기 요청 ajax
    function cert(){

		let email = $("#email").val();
		
		
		$.ajax({
			url : "cert.do",
			type : "post",
			data : {
			
				email : email
			},
			
			success : function(result) {
				
				alert(result);
				
				$("#cert-email").show();
				$("#certKey").attr("disabled", false);
				$("#vali_email").attr("disabled",false);
				$("#email").attr("disabled", true);
				$("#certbtn").attr("disabled", true);
				isCerted = true;
			},
			
			error : function() {
				console.log("인증번호 발급용 ajax 통신 실패!");
				alert("인증번호 발송에 실패했습니다. 다시 시도해주세요.");
			}
		});
	}
	
	
	$(document).ready(function() {
	    
	    let seconds; // 남은 시간 변수
	    let countdown; // 카운트다운을 관리하는 변수
	    let isCerted = false;
	    
	    const $timeSpan = $('.time'); 
	    const $btnSend = $('#certbtn');
	    const $submitBtn = $('#submitBtn') 
		
		//인증시간표시	
   		 const updateCountdown = function() {
   		 
	        if (seconds >= 0) {
	        
	            const minutes = Math.floor(seconds / 60);
	            const remainingSeconds = seconds % 60;
	            $timeSpan.text(`${minutes.toString().padStart(2, '0')}:${remainingSeconds.toString().padStart(2, '0')}`);
	            seconds--;
	        
	        } else {
	            
	            clearInterval(countdown);
	            alert('인증번호 유효시간이 만료되었습니다.');
	       
                $("#cert-email").hide();
                $("#email").val("");
                $("#certKey").val("");
                $("#email").css("border", "1px solid orangered");
                $("#email").attr("disabled", false);
                $("#certbtn").attr("disabled", false);
                $submitBtn.attr("disabled", true);
	    		isCerted = false;
	        }
    	};
    	
    	// 인증메일요청 함수 호출
	    $btnSend.on('click', function(e) {
	        e.preventDefault();
	        
	        alert('인증번호 발송 요청이 접수되었습니다. 잠시만 기다려주세요.');
	        cert();
	        
	        clearInterval(countdown);
	        seconds = 300;
	        updateCountdown();
	        countdown = setInterval(updateCountdown, 1000); 
	    });
    	
   });
	
	 // 이메일 인증번호 대조 ajax
    function validateEmail(){
    
		let email = $("#email").val();
		let certKey = $("#certKey").val();
		
		$.ajax({
			url : "validateEmail.do",
			type : "post",
			data : {
				certKey : certKey,
				email : email
			},
			success : function(result) {
				
				if(result === "인증성공!"){
					alert(result);
				
					$("#cert-email").hide();
					$("#email").css("border","2px solid #71C9CE"); 
					$("#hiddenEmail").val(email);
					$("#enrollForm button[type=submit]").attr("disabled",false);
	    			isCerted = true;
				
				}else{
				
					alert(result);
					
					$("#cert-email").hide();
					
					$("#email").val("");
					$("#certKey").val("");
					$("#email").css("border","1px solid orangered"); 
					$("#email").attr("disabled", false);
					$("#certbtn").attr("disabled", false);
					$("#enrollForm button[type=submit]").attr("disabled",true);
					isCerted = false;
				}
				 console.log("isCerted 상태:", isCerted);
			},
			error : function() {
				console.log("인증번호 발급용 ajax 통신 실패!");
			}
		});
	}
	
		
	 /* DAUM 지도검색 API */
	 
	 function sample4_execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {

                // 도로명 주소의 노출 규칙에 따라 주소를 표시한다.
                var roadAddr = data.roadAddress; // 도로명 주소 변수
                var extraRoadAddr = ''; // 참고 항목 변수

                // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                    extraRoadAddr += data.bname;
                }
                // 건물명이 있고, 공동주택일 경우 추가한다.
                if(data.buildingName !== '' && data.apartment === 'Y'){
                   extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                }
                // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                if(extraRoadAddr !== ''){
                    extraRoadAddr = ' (' + extraRoadAddr + ')';
                }
				
				var fullAddress = '도로명 : ' + roadAddr + extraRoadAddr+ '\n'+ '지번 : '+ data.jibunAddress ;
				
                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('sample4_postcode').value = data.zonecode;
               
                document.getElementById("sample4_roadAddress").value = fullAddress;
                
                if(data.autoRoadAddress) {
                    var expRoadAddr = data.autoRoadAddress + extraRoadAddr;
                  
                } else if(data.autoJibunAddress) {
                    var expJibunAddr = data.autoJibunAddress;
                    document.getElementById("sample4_roadAddress").value = '도로명 : ' + roadAddr + extraRoadAddr + '\n' + '지번 : ' + expJibunAddr;
                    
                } 
                
                document.getElementById("sample4_detailAddress").focus();
            }
        }).open();
    }
        