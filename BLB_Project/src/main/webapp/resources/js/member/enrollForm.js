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
    	let validate = /^[a-z0-9-_]{5,20}$/;
    	 
        if(checkId.length >= 5){
        
	        if(!validate.test(checkId)){
		
		         $("#noticeId").css("display","none");
		         $("#checkId").show()
		        					.css({
						                "color": "orangered", // 색상 수정
						                "font-size": "12px",
						                "font-weight": "600"
						            }).text("5~20자의 영문 소문자, 숫자와 특수기호(_),(-)만 사용 가능합니다."); 
		         
		          $("#memeberId").css("border","1px solid #orangered");
		         $("#enrollForm button[type=submit]").attr("disabled",true);
			         
			     return 
			 }
          $.ajax({
            url: "idCheck.me",
            type : "GET",
            data :{
              checkId : checkId
            },
            success : function(result){
              if(result === "NNN"){
                
                $("#noticeId").css("display","none");
                
                      $("#checkId").show()
                              .css("color","orangered")
                              .text("사용할수 없는 아이디입니다. 다른 아이디를 입력해주세요.")
                              .css("font-size","12px")
                              .css("font-weight","600");
                      
                      $("#enrollForm button[type=submit]").attr("disabled",true);
                      
                      $("#memeberId").css("border","1px solid #orangered");    
              
              }else{
                $("#noticeId").hide();
                      $("#checkId").show()
                              .css("color","#71C9CE")
                              .text("사용가능한 아이디입니다!")
                              .css("font-size","12px")
                              .css("font-weight","600");
                      
                      $("#enrollForm button[type=submit]").attr("disabled", false);
                     
                      $("#memberId").css("border","1px solid #71C9CE");  
                     
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
        let validate = /^[A-Za-z0-9!@#$%^&*-_]{8,16}$/;
        
        
        
	if(memberPwd.length >= 8){		
        if(validate.test(memberPwd)){
        
         $("#noticePwd").css("display","none");
         
         $("#validatePwd").show()
         				  .css({
						    "color": "#71C9CE",
						    "font-size": "12px",
						    "font-weight": "600"
							}).text("사용가능한 비밀번호입니다!");
		$("#memberPwd").css("border","1px solid #71C9CE");   					
          
        }else{
       		$("#noticePwd").css("display","none");
        	$("#validatePwd").show()
        					.css({
				                "color": "orangered", // 색상 수정
				                "font-size": "12px",
				                "font-weight": "600"
				            }).text("8~16자의 영문 대/소문자, 숫자, 특수문자를 사용해 주세요.");    
			$("#memberPwd").css("border","1px solid orangered");     	   				
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
        
      if(checkPwd.length >= 8){
      		  
        // 비밀번호 확인
        if (checkPwd === $pwdInput.val()) {
         
            $("#checkPwd").show()
                .css({
                    "color": "#71C9CE",
                    "font-size": "12px",
                    "font-weight": "600"
                }).text("비밀번호 확인!");
                            
           $("#ckPwd").css("border","1px solid #71C9CE");   
        } else {
           
            $("#checkPwd").show()
                .css({
                    "color": "orangered", 
                    "font-size": "12px",
                    "font-weight": "600"
                }).text("비밀번호가 다릅니다");
        
        	$("#ckPwd").css("border","1px solid orangered");
        	
        }

      }else{

      	$("#ckPwd").css("border", "1px solid #ccc"); // 기본 테두리 색상으로 초기화
        $("#enrollForm button[type=submit]").attr("disabled",true);
        $("#checkPwd").hide();  
      
      }   
       
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
				
				var fullAddress = '도로명 : ' + roadAddr + extraRoadAddr+ '\n '+ '지번 : '+ data.jibunAddress ;
				
                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('sample4_postcode').value = data.zonecode;
               
                document.getElementById("sample4_roadAddress").value = fullAddress;

                var guideTextBox = document.getElementById("guide");
                // 사용자가 '선택 안함'을 클릭한 경우, 예상 주소라는 표시를 해준다.
                
                if(data.autoRoadAddress) {
                    var expRoadAddr = data.autoRoadAddress + extraRoadAddr;
                    guideTextBox.innerHTML = '(예상 도로명 주소 : ' + expRoadAddr + ')';
                    guideTextBox.style.display = 'block';

                } else if(data.autoJibunAddress) {
                    var expJibunAddr = data.autoJibunAddress;
                    document.getElementById("sample4_roadAddress").value = '도로명 : ' + roadAddr + extraRoadAddr + '\n' + '지번 : ' + expJibunAddr;
                    guideTextBox.style.display = 'block';
                } else {
                    guideTextBox.innerHTML = '';
                    guideTextBox.style.display = 'none';
                }
                
                window.close(); 
            }
        }).open();
    }
    
    
        