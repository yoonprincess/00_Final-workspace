$(function() {
	
	$("#noticeList>tbody>tr").click(function() {
		
		let nno = $(this).children(".nno").text();
		location.href = "notice/" + nno;
	});
});


