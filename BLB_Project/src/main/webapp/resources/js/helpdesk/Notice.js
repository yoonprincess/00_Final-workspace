$(function() {
	
	$("#noticeList>tbody>tr").click(function() {
		
		let nno = $(this).children(".nno").text();
		location.href = "notice/" + nno;
		
		console.log("click");
	});
});

function postFormSubmit(num) {
	if(num == 1) { // 수정하기를 클릭했을 경우
		
		$("#postForm").attr("action", "../updateForm.no").submit();
		
	} else { // 삭제하기를 클릭했을 경우
		
		$("#postForm").attr("action", "../delete.no").submit();
	}
	
}