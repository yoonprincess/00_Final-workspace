$(document).ready(function () {
    // 정렬 및 보기 설정
	$('#sortBy, #boardLimit').change(function () {
	    const sortBy = $('#sortBy').val();
	    const boardLimit = $('#boardLimit').val();
	
	    // 현재 URL을 기반으로 파라미터 추가
	    const currentUrl = new URL(window.location.href);
	    currentUrl.searchParams.set('sortBy', sortBy);
	    currentUrl.searchParams.set('boardLimit', boardLimit);
	    
	    // 페이지 초기화
	    currentUrl.searchParams.set('ppage', 1);
	
	    // 새 URL로 이동
	    window.location.href = currentUrl.toString();
	});

    // 장바구니 추가 버튼
    $('.add-cart').click(function (e) {
        e.stopPropagation();
        const productId = $(this).data('id');
        alert(`장바구니에 상품 ${productId} 추가!`);
    });

    // 찜하기 버튼
    $('.add-wishlist').click(function (e) {
        e.stopPropagation();
        const productId = $(this).data('id');
        alert(`찜 목록에 상품 ${productId} 추가!`);
    });
});
