
	// 버튼 관련
	function goBack() {
	     window.location.href = "/blb";
	}

	// 저장된 회원 번호 다시 나누기 

	$(document).ready(function() {
	  
        $('#phone1').val(phone.slice(0, 3));
        $('#phone2').val(phone.slice(3, 7));
        $('#phone3').val(phone.slice(7));
   
  });
	
	
	/* 입력받은 폰번호 하나로 합치기*/
   document.getElementById('updateForm').addEventListener('submit', function(event) {
       
        var phone1 = document.getElementById('phone1').value;
        var phone2 = document.getElementById('phone2').value;
        var phone3 = document.getElementById('phone3').value;

       
        var fullPhoneNumber = phone1  + phone2  + phone3;
		
        document.getElementById('phone').value = fullPhoneNumber;
        

    });
    
    
	// 비밀번호 변경 안할 때 로직
	$(document).ready(function() {
	
		if(!$('#newPwd').val()){
			$('#newPwd').removeAttr('required');
			$('#ckPwd').removeAttr('required');
		}
	});

	// 비밀번호 변경 버튼 toggle 적용 
	$(document).ready(function() {
	 
	 	$('#changePwd').on('click', function(){
	 		
	 		  $('#memberPwd, #newPwd, #ckPwd, #noticePwd, #validatePwd, #checkPwd, .input-label').each(function () {
		 		
		 		 if ($(this).hasClass('hidden')) {
	                    $(this).removeClass('hidden');
	                    $('#newPwd').attr('required','required');
						$('#ckPwd').attr('required', 'required');
	                    
	                } else {
	                    $(this).addClass('hidden');
	                    $('#newPwd').removeAttr('required');
						$('#ckPwd').removeAttr('required');
						$('input[name="newPwd"], input[name="ckPwd"]').val('');
	                }
	 			});
	 	});
	 });
	
	
	// 비밀번호 검증
	 $(function(){
	      const $pwdInput = $("#updateForm input[name=newPwd]");
	 	
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
			$("#updateForm button[type=submit]").attr("disabled", false);					
	          
	        }else{

	        	$("#validatePwd").show()
	        					.css({
					                "color": "orangered", // 색상 수정
					                "font-size": "12px",
					                "font-weight": "600"
					            }).text("8~16자의 영문 대/소문자, 숫자, 특수문자 중 2가지 이상 조합해서 사용해 주세요.");    
				$("#newPwd").css("border","1px solid orangered");  
				$("#updateForm button[type=submit]").attr("disabled", true);  
				$("#noticePwd").show();       	   				
	        }
	        
	   }else{
	   		  $("#newPwd").css("border", "1px solid #ccc"); // 기본 테두리 색상으로 초기화
	          $("#updateForm button[type=submit]").attr("disabled",true);
	          $("#validatePwd").hide();  
	          $("#noticePwd").show();               	   				
	   	
	   }     
	        
	  	 }); 
	 	});  
	 	
	 	/* 비밀번호 확인 체크 */
	 	
	 	 $(function() {
	 	 
		    const $ckPwdInput = $("#updateForm input[name=ckPwd]");
		    const $pwdInput = $("#updateForm input[name=newPwd]");
	    
		    $ckPwdInput.change(function() {
		        let ckPwd = $(this).val();
	        
	      		if(ckPwd.length >= 1){
	      		  
		        // 비밀번호 확인
		        if (ckPwd === $pwdInput.val()) {
		         		                            
		           $("#ckPwd").css("border","2px solid #71C9CE");   
		           $("#updateForm button[type=submit]").attr("disabled", false);
		           $("#checkPwd").hide();
		        } else {
		           
		            $("#checkPwd").show()
		                .css({
		                    "color": "orangered", 
		                    "font-size": "12px",
		                    "font-weight": "600"
		                }).text("비밀번호가 다릅니다");
		        
		        	$("#ckPwd").css("border","1px solid orangered");
		        	$("#updateForm button[type=submit]").attr("disabled", true);
		        }
		
	      }else{
		
		      	$("#ckPwd").css("border", "1px solid #ccc"); // 기본 테두리 색상으로 초기화
		        $("#updateForm button[type=submit]").attr("disabled",true);
	      }   
	       
	    });
	});

// 이메일 변경 버튼 클릭시 	
	$("#changebtn").on('click',function(){
		$("#changebtn").hide();
		$("#certbtn").show();
		$("#email").select();
	
	});
	
	// 이메일 수정시 인증절차 
	// 이메일 인증메일보내기 요청 ajax
    function cert(){
		
		let email = $("#email").val();
		
		if (email === "") {
	        alert("이메일을 입력해주세요.");
	        $("#email").css("border","1px solid orangered"); 
	        $("#updateForm button[type=submit]").attr("disabled",true);
	        
	        return;
	        
		  }
		  
	    $.ajax({
			url : "cert.do",
			type : "post",
			data : {
			
				email : email
			},
			
			success : function(result) {
				
				alert(result);
				
				 $("#changebtn").hide();
				 $("#certbtn").show();
				 
				$("#cert-email").show();
				$("#certKey").attr("disabled", false);
				$("#vali_email").attr("disabled",false);
				
				$("#email").attr("readonly", true);
				$("#certbtn").attr("disabled", true);
				
			},
			
			error : function() {
				console.log("인증번호 발급용 ajax 통신 실패!");
				alert("인증번호 발송에 실패했습니다. 다시 시도해주세요.");
			}
		});
	}
	
	
	
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
					 $("#updateForm button[type=submit]").attr("disabled",false);
				
				}else{
				
					alert(result);
					
					$("#cert-email").hide();
					
					$("#email").val("");
					$("#certKey").val("");
					$("#email").css("border","1px solid orangered"); 
					$("#certbtn").attr("disabled", false);
					$("#email").attr("readonly", false);
					$("#updateForm button[type=submit]").attr("disabled",true);
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
	       
                $("#cert-email").hide();
                $("#email").val("");
                $("#certKey").val("");
                $("#email").css("border", "1px solid orangered");
                $("#certbtn").attr("disabled", false);
                $("#email").attr("readonly", false);
                $("#updateForm button[type=submit]").attr("disabled",true);
	        }
    	};
    
	    $btnSend.on('click', function(e) {
	       
	       let email = $("#email").val();
		
			if (email === "") {
		        $("#email").css("border","1px solid orangered"); 
	        	$("#updateForm button[type=submit]").attr("disabled",true);
	        return;
	        
		  }
	        e.preventDefault();
	        alert('인증번호 발송 요청이 접수되었습니다. 잠시만 기다려주세요.');
	        
	        clearInterval(countdown);
	        seconds = 100;
	
	        updateCountdown();
	        
	        countdown = setInterval(updateCountdown, 1000); 
	    });
    
   });
   
   
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
                 $(".address-field").attr("disabled", false);
                 $("#sample4_detailAddress").val("");
            }
        }).open();
    }
        	