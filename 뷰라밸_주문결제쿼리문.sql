INSERT INTO TB_ORDER
RCVR_NAME
     , RCVR_ADDRESS
     , RCVR_PHONE
     , DLVR_REQ_MESSAGE
     
-- 주문 입력
INSERT INTO TB_ORDER(ORDER_NO
		                   , RCVR_NAME
		                   , RCVR_PHONE
		                   , RCVR_ADDRESS
		                   , DLVR_STATUS
		                   , DLVR_FEE
		                   , DLVR_COMPANY
		                   , ORDER_TOTAL_AMT
                           , PAYMENT_CODE
		                   , PAYMENT_METHOD
		                   , ORDER_DATE
		                   , MEMBER_ID)
		              VALUES(SEQ_ORDER_NO.NEXTVAL
		                   , #{rcvrName}
		                   , #{rcvrPhone}
		                   , #{rcvrAddress}
		                   , '배송대기'
		                   , #{dlvrFee}
		                   , '대한통운'
		                   , #{orderTotalAmt}
                           , 
		                   , #{paymentMethod}
		                   , SYSDATE
		                   , #{memberId})
     
-- 주문 번호 조회
SELECT SEQ_ORDER_NO.CURRVAL
  FROM DUAL


-- 장바구니 번호를 상품/주문 테이블로 넘기기
INSERT INTO TB_PRODUCT_ORDER(SERIAL_NO
                           , ORDER_QTY
                           , TOTAL_AMT
                           , ORDER_NO
                           , OPT_NO)
                      VALUES(TO_NUMBER(TO_CHAR(SYSDATE, 'YYYYMMDD') || LPAD(SEQ_SERIAL_NO.NEXTVAL, 4, '0'))
                           , #{orderQty}
                           , #{totalAmt}
                           , #{orderNo}
                           , #{optNo})

SELECT 
                           
INSERT INTO TB_PRODUCT_ORDER (SERIAL_NO
                            , ORDER_QTY
                            , TOTAL_AMT
                            , ORDER_NO
                            , OPT_NO)
                      VALUES (SEQ_SERIAL_NO.NEXTVAL
                            , #{orderQty}
                            , #{totalAmt}
                            , #{orderNo}
                            , #{optNo})




-- 장바구니에서 넘어온 주문 상품 조회
SELECT PO.*
     , P.PROD_NAME
     , O.OPT_NAME
     , O.OPT_VALUE
     , O.OPT_ADD_PRICE
     , O.REMAIN_QTY
     , C.CART_QTY
     , P.PROD_PRICE
     , PA.THUMB_PATH || PA.SAVE_FILE_NAME AS "THUMB_IMG"
  FROM TB_PRODUCT_ORDER PO
  LEFT JOIN TB_OPTION O ON (PO.OPT_NO = O.OPT_NO)
  LEFT JOIN TB_PRODUCT P ON (O.PROD_NO = P.PROD_NO)
  LEFT JOIN TB_CART C ON (C.PROD_NO = P.PROD_NO
                     AND C.OPT_NO = O.OPT_NO)
                     AND C.CART_NO IN (50, 49, 48, 47, 46, 45, 44, 43)
  LEFT JOIN (
     SELECT PROD_NO, THUMB_PATH, SAVE_FILE_NAME
       FROM TB_PRODUCT_ATTACHMENT
       WHERE (PROD_NO, PROD_ATT_NO) IN (
        SELECT PROD_NO, MIN(PROD_ATT_NO)
          FROM TB_PRODUCT_ATTACHMENT
         WHERE PROD_ATT_STATUS = 'Y'
           AND THUMB_PATH IS NOT NULL
         GROUP BY PROD_NO
         )
     ) PA ON P.PROD_NO = PA.PROD_NO
 WHERE C.CART_NO IN (50, 49, 48, 47, 46, 45, 44, 43)
 ORDER BY C.CART_NO DESC;
 
-- 주문 정보 조회
SELECT *
  FROM TB_ORDER
 WHERE ORDER_NO = CAST(#{orderNo} AS VARCHAR2(30))
 
-- 바로 구매 (옵션 번호들에 따른 상품 조회)
SELECT P.PROD_NO
     , P.PROD_NAME
     , O.OPT_NO
     , O.OPT_NAME
     , O.OPT_ADD_PRICE
     , O.REMAIN_QTY
     , P.PROD_PRICE
     , PA.THUMB_PATH || PA.SAVE_FILE_NAME AS "THUMB_IMG"
  FROM PRODUCT P
LEFT JOIN OPTION O ON P.PROD_NO = O.PROD_NO
LEFT JOIN (
            SELECT PROD_NO, THUMB_PATH, SAVE_FILE_NAME
              FROM TB_PRODUCT_ATTACHMENT
             WHERE (PROD_NO, PROD_ATT_NO) IN (
		           SELECT PROD_NO, MIN(PROD_ATT_NO)
		             FROM TB_PRODUCT_ATTACHMENT
		            WHERE PROD_ATT_STATUS = 'Y'
		              AND THUMB_PATH IS NOT NULL
		            GROUP BY PROD_NO
		       )
		  ) PA
		    ON P.PROD_NO = PA.PROD_NO
WHERE O.OPT_NO IN
<foreach item="optNo" collection="optNos" open="(" separator="," close=")">
    #{optNo}
</foreach>

-- 주문번호로 옵션번호 가져오기
SELECT PO.SERIAL_NO,
	           PO.ORDER_QTY,
	           PO.TOTAL_AMT,
	           PO.ORDER_NO,
	           PO.OPT_NO,
	           P.PROD_NO,
	           P.PROD_NAME,
	           O.OPT_NAME,
	           O.OPT_VALUE,
	           O.OPT_ADD_PRICE,
	           PA.THUMB_PATH || PA.SAVE_FILE_NAME AS THUMB_IMG,
	           P.PROD_PRICE
	      FROM TB_PRODUCT_ORDER PO
	      LEFT JOIN TB_OPTION O ON PO.OPT_NO = O.OPT_NO
	      LEFT JOIN TB_PRODUCT P ON O.PROD_NO = P.PROD_NO
	      LEFT JOIN (
		      SELECT PROD_NO, THUMB_PATH, SAVE_FILE_NAME
		        FROM TB_PRODUCT_ATTACHMENT
		       WHERE (PROD_NO, PROD_ATT_NO) IN (
		           SELECT PROD_NO, MIN(PROD_ATT_NO)
		             FROM TB_PRODUCT_ATTACHMENT
		            WHERE PROD_ATT_STATUS = 'Y'
		              AND THUMB_PATH IS NOT NULL
		            GROUP BY PROD_NO
		       )
		  ) PA
		    ON P.PROD_NO = PA.PROD_NO
	     WHERE PO.ORDER_NO = 321
	     ORDER BY PO.SERIAL_NO ASC


commit;
