
	// 버튼 관련
	function goBack() {
	    history.back();
	}

	// 저장된 회원 번호 다시 나누기 

	$(document).ready(function() {
	  
	  $('#phone1').val(phone.slice(0, 3));
	  $('#phone2').val(phone.slice(3, 7));
	  $('#phone3').val(phone.slice(7));
	});


	// 이메일변경버튼 
	function changeEmail(){
		$("#email").val("");
		  $("#email").attr("disabled", false); 
		$("#changebtn").hide();
		$("#certbtn").show();
	}

	// 이메일 수정시 인증절차 
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
				
			},
			
			error : function() {
				console.log("인증번호 발급용 ajax 통신 실패!");
				
				alert("인증번호 발송에 실패했습니다. 다시 시도해주세요.");
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
                $("#email").attr("disabled", false);
                $("#certbtn").attr("disabled", false);
	        }
    	};
    
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
				
				}else{
				
					alert(result);
					
					$("#cert-email").hide();
					
					$("#email").val("");
					$("#certKey").val("");
					$("#email").css("border","1px solid orangered"); 
					$("#email").attr("disabled", false);
					$("#certbtn").attr("disabled", false);
				}
				
			},
			error : function() {
				console.log("인증번호 발급용 ajax 통신 실패!");
			}
		});
	}
	