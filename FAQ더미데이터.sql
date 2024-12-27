INSERT INTO TB_FAQ (FAQ_NO, FAQ_TITLE, FAQ_CONTENT, FAQ_TYPE, FAQ_STATUS)
VALUES (1, '교환 및 반품도 매장에서 할 수 있나요?', 
'BLB 매장 교환은 어려우며, 온라인몰을 통한 교환 및 반품 신청이 필요합니다.\n\n마이페이지 > 주문/배송조회 > 교환/반품 신청을 통해 아래 방법으로 처리해주세요.\n교환: 회수 택배 기사님을 통해 물류센터로 교환 \n반품: 회수 택배 기사님을 통해 물류센터로 반품 / 오프라인 매장에 방문하여 직접 반품', 
'결제/환불', 'Y');

INSERT INTO TB_FAQ (FAQ_NO, FAQ_TITLE, FAQ_CONTENT, FAQ_TYPE, FAQ_STATUS)
VALUES (2, '상품 배송 기간은 얼마나 걸리나요?', 
'BLB는 주문 후 평균 2~3일 내에 상품을 배송합니다. 도서/산간 지역은 추가 시간이 소요될 수 있습니다. 상세한 배송 안내는 마이페이지 > 배송조회에서 확인하실 수 있습니다.', 
'배송', 'Y');

INSERT INTO TB_FAQ (FAQ_NO, FAQ_TITLE, FAQ_CONTENT, FAQ_TYPE, FAQ_STATUS)
VALUES (3, '쿠폰은 어떻게 사용할 수 있나요?', 
'BLB 쿠폰은 결제 페이지에서 적용 가능합니다. 쿠폰을 선택 후 할인된 금액으로 결제하시면 됩니다. 유효기간 내에 사용해주시기 바랍니다.', 
'쿠폰/할인', 'Y');

INSERT INTO TB_FAQ (FAQ_NO, FAQ_TITLE, FAQ_CONTENT, FAQ_TYPE, FAQ_STATUS)
VALUES (4, 'BLB 멤버십 포인트는 어디에서 확인하나요?', 
'BLB 멤버십 포인트는 마이페이지 > 포인트 조회에서 확인하실 수 있습니다. 포인트는 결제 시 현금처럼 사용 가능하며, 일부 상품에는 사용 제한이 있을 수 있습니다.', 
'멤버십', 'Y');

INSERT INTO TB_FAQ (FAQ_NO, FAQ_TITLE, FAQ_CONTENT, FAQ_TYPE, FAQ_STATUS)
VALUES (5, '상품이 품절된 경우 어떻게 처리되나요?', 
'BLB에서 주문한 상품이 품절된 경우, 결제 금액은 자동으로 환불 처리됩니다. 환불 완료 후 문자 메시지로 안내드리며, 카드사 사정에 따라 2~3일 소요될 수 있습니다.', 
'결제/환불', 'Y');

COMMIT;
