
	// 취소
	function goBack() {
	    window.location.href = "/blb/findPwdForm.me";
	}


// 이메일 인증메일보내기 요청 ajax
    function cert(){
		
		let email = "${ckPwdMember.getEmail()}";
		  console.log(email);
	    $.ajax({
			url : "cert.do",
			type : "post",
			data : {
			
				email : email
			},
			
			success : function(result) {
				
				alert(result);
				
				$("#certBtn").attr("disabled", true);
				
			},
			
			error : function() {
				console.log("인증번호 발급용 ajax 통신 실패!");
				alert("인증번호 발송에 실패했습니다. 다시 시도해주세요.");
			}
		});
	}
	
	
	
	 // 이메일 인증번호 대조 ajax
    function validateEmail(){
    
		let certKey = $("#certKey").val();
		
		$.ajax({
			url : "validatePwd.me",
			type : "post",
			data : {
				certKey : certKey,
			},
			
			success : function(result) {
				
				if(result === "인증성공!"){
					alert(result);
					
					$('#check-page').hide();
		            $('#result-page').show();
				
				}else{
				
					alert(result);
					
					$("#certKey").val("");
					$("#certKey").css("border","1px solid orangered"); 
					$("#certbtn").attr("disabled", false);
					$("#validatePwd button[type=submit]").attr("disabled",true);
				}
				
			},
			error : function() {
				console.log("인증번호 발급용 ajax 통신 실패!");
			}
		});
	}
	
	/* 인증시간 표시 - jQuery 로직*/	
	$(document).ready(function() {
	    
	    let seconds; // 남은 시간 변수
	    let countdown; // 카운트다운을 관리하는 변수
	    const $timeSpan = $('.time'); 
	    const $btnSend = $('#certbtn'); 

   		 const updateCountdown = function() {
   		 
	        if (seconds >= 0) {
	        
	            const minutes = Math.floor(seconds / 60);
	            const remainingSeconds = seconds % 60;
	            $timeSpan.text(`${minutes.toString().padStart(2, '0')}:${remainingSeconds.toString().padStart(2, '0')}`);
	            seconds--;
	        
	        } else {
	            
	            clearInterval(countdown);
	            alert('인증번호 유효시간이 만료되었습니다.');
	       
                $("#certKey").val("");
                $("#certbtn").attr("disabled", false);
                $("#validatePwd button[type=submit]").attr("disabled",true);
	        }
    	};
    
	    $btnSend.on('click', function(e) {
	       
	        e.preventDefault();
	        alert('인증번호 발송 요청이 접수되었습니다. 잠시만 기다려주세요.');
	        
	        clearInterval(countdown);
	        seconds = 100;
	
	        updateCountdown();
	        
	        countdown = setInterval(updateCountdown, 1000); 
	    });
    
   });
   
   
    /* 비번 조건체크*/ 
	 $(function(){
	      const $pwdInput = $("#newPwdForm input[name=newPwd]");
	 	
	      $pwdInput.blur(function(){
	        
	        let newPwd=$(this).val();
	        let validate = /^(?=(.*[A-Za-z].*[0-9]))(?=(.*[0-9].*[!@#$%^&*-_]))(?=(.*[A-Za-z].*[!@#$%^&*-_])).{8,16}$/
	        
		if(newPwd.length >= 8){		
	     
	        if(validate.test(newPwd)){
	         
	         $("#validatePwd").show()
	         				  .css({
							    "color": "#71C9CE",
							    "font-size": "12px",
							    "font-weight": "600"
								}).text("사용가능한 비밀번호입니다!");
								
			$("#newPwd").css("border","2px solid #71C9CE");  
			$("#newPwdForm button[type=submit]").attr("disabled", false);					
	          
	        }else{

	        	$("#validatePwd").show()
	        					.css({
					                "color": "orangered", // 색상 수정
					                "font-size": "12px",
					                "font-weight": "600"
					            }).text("8~16자의 영문 대/소문자, 숫자, 특수문자 중 2가지 이상 조합해서 사용해 주세요.");    
				$("#newPwd").css("border","1px solid orangered");  
				$("#newPwdForm button[type=submit]").attr("disabled", true);  
				$("#noticePwd").show();       	   				
	        }
	        
	   }else{
	   		  $("#newPwd").css("border", "1px solid #ccc"); // 기본 테두리 색상으로 초기화
	          $("#newPwdForm button[type=submit]").attr("disabled",true);
	          $("#validatePwd").hide();  
	          $("#noticePwd").show();               	   				
	   	
	   }     
	        
	  	 }); 
	});
	 	
	 	/* 비밀번호 확인 체크 */
	 	
	 	 $(function() {
	 	 
		    const $ckPwdInput = $("#newPwdForm input[name=checkPwd]");
		    const $pwdInput = $("#newPwdForm input[name=newPwd]");
	    
		    $ckPwdInput.change(function() {
		        let checkPwd = $(this).val();
	        
	      		if(checkPwd.length >= 8){
	      		  
		        // 비밀번호 확인
		        if (checkPwd === $pwdInput.val()) {
		         		                            
		           $("#ckPwd").css("border","2px solid #71C9CE");   
		           $("#newPwdForm button[type=submit]").attr("disabled", false);
		           $("#checkPwd").hide();  
		           
		        } else {
		           
		            $("#checkPwd").show()
		                .css({
		                    "color": "orangered", 
		                    "font-size": "12px",
		                    "font-weight": "600"
		                }).text("비밀번호가 다릅니다");
		        
		        	$("#ckPwd").css("border","1px solid orangered");
		        	$("#newPwdForm button[type=submit]").attr("disabled", true);
		        	
		        }
		
	      }else{
		
		      	$("#ckPwd").css("border", "1px solid #ccc"); // 기본 테두리 색상으로 초기화
		        $("#newPwdForm button[type=submit]").attr("disabled",true);
		        
	      }   
	       
	    });
	});


	