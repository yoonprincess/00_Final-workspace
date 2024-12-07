$(document).ready(function () {
    // 초기화 버튼 클릭
    $('#resetFilters').click(function () {
        $('input[name="filter"]').prop('checked', false);
    });

    // 필터 적용 버튼 클릭
    $('#applyFilters').click(function () {
        let selectedFilters = [];
        $('input[name="filter"]:checked').each(function () {
            selectedFilters.push($(this).val());
        });
        alert('적용된 필터: ' + selectedFilters.join(', '));
    });

    // 정렬 및 보기 설정
    $('#sortBy, #itemsPerPage').change(function () {
        const sortBy = $('#sortBy').val();
        const itemsPerPage = $('#itemsPerPage').val();
        alert(`정렬: ${sortBy}, 보기: ${itemsPerPage}개`);
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
