  /* 입력받은 폰번호 하나로 합치기*/
   document.getElementById('enrollDeliForm').addEventListener('submit', function(event) {
       
        var phone1 = document.getElementById('phone1').value;
        var phone2 = document.getElementById('phone2').value;
        var phone3 = document.getElementById('phone3').value;

       
        var fullPhoneNumber = phone1  + phone2  + phone3;
		
        document.getElementById('deliPhone').value = fullPhoneNumber;
        

    });

/* 배송지 추가요청사항 placeholder */	
$(document).ready(function() {
  $('input[name="entry"]').on('change', function() {
    var selectedValue = $(this).val();
	 
    switch (selectedValue) {
      case '비밀번호':
        placeholderText = "공동현관 비밀번호를 입력하세요";
        break;
      case '경비실호출':
        placeholderText = "경비실 호출 방법을 입력하세요";
        break;
      case '자유출입가능':
       placeholderText = "추가 요청사항을 입력하세요";
        break;
      case '기타사항':
        placeholderText = "기타 상세 내용을 입력하세요";
        break;
    }

    $('#additionalInfo').attr('placeholder', placeholderText);
  });
});

 /* 입력받은 배송 요청사항들 하나로 합치기*/
 
    document.getElementById('enrollDeliForm').addEventListener('submit', function(event) {
       
        var entryInfo1 =$('input[name="entry"]:checked').val();
        var entryInfo2 = document.getElementById('additionalInfo').value;
       
        var fullComment = entryInfo1  +'/'+ entryInfo2;
		
        document.getElementById('deliComment').value = fullComment;
        
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
            }
        }).open();
    }

// 약관동의 체크박스 관련    
     $(document).ready(function() {  
   $('#confirmBtn').on('click', function(e){
		   if(!$('#agree').prop('checked')){
		   	e.preventDefault();
		   	alert('약관에 동의해주세요');
		   }
   		});
   });
        