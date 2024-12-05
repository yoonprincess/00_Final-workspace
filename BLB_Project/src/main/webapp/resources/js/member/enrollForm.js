/**
 * 회원가입폼 과 관련된 자바스크립트
 */
   document.getElementById('enrollForm').addEventListener('submit', function(event) {
       
        var phone1 = document.getElementById('phone1').value;
        var phone2 = document.getElementById('phone2').value;
        var phone3 = document.getElementById('phone3').value;

       
        var fullPhoneNumber = phone1  + phone2  + phone3;
		
        document.getElementById('phone').value = fullPhoneNumber;
        

    });
    
   