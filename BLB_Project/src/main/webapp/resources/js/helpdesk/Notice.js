$(function() {
	
	$("#noticeList>tbody>tr").click(function() {
		
		let nno = $(this).children(".nno").text();
		location.href = "notice/" + nno;
	});
});

// 관리자 확인 및 버튼 표시 로직
        const isAdmin = localStorage.getItem('userId') === 'admin';
        const adminControls = document.getElementById('adminControls');
        if (isAdmin) {
            adminControls.style.display = 'flex';
        }
        
        function goList(){
            location.href="../list.no";
        }
        
        
        function goBack(){
            location.href="../list.no";
        }


