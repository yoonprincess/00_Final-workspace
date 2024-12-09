--회원등급 (TB_GRADE) 데이터값 --
INSERT INTO TB_GRADE(GRADE_NAME
                                        ,MIN_POINT
                                        ,MAX_POINT)
                            VALUES('BABY'
                                        , 0
                                        ,3000);
                        
INSERT INTO TB_GRADE(GRADE_NAME
                                        ,MIN_POINT
                                        ,MAX_POINT)
                            VALUES('MINT'
                                        , 3000
                                        ,5000);
                                        
INSERT INTO TB_GRADE(GRADE_NAME
                                        ,MIN_POINT
                                        ,MAX_POINT)
                            VALUES('GOLD'
                                        , 5000
                                        ,10000);
                                        
INSERT INTO TB_GRADE(GRADE_NAME
                                        ,MIN_POINT
                                        ,MAX_POINT)
                            VALUES('VIP'
                                        , 10000
                                        ,99999999);

-- 관리자 계정--
 INSERT INTO TB_MEMBER ( MEMBER_ID,
                                                MEMBER_NAME,
                                                MEMBER_PWD,
                                                PHONE,
                                                EMAIL,
                                                BIRTHDATE,
                                                CREATE_DATE,
                                                DELETE_DATE,
                                                STATUS,
                                                TOTAL_POINTS,
                                                CURRENT_POINTS,
                                                GRADE_NAME
                                            ) 
                              VALUES ( 'admin',
                                                '관리자',
                                                '$2a$10$C80V3tc1Sy0rEjBf/izb9OPjvV5sKzbp0AqAzR6nd395KWgHcUg8S', -- 'admin01!'
                                                '01011112222',
                                                'admin@mig.com',
                                                TO_DATE('2000-01-01', 'YYYY-MM-DD'),
                                                DEFAULT,
                                                NULL,
                                                'Y',
                                                DEFAULT,
                                                DEFAULT,
                                                'VIP'
                                            );
-- 기본배송지 샘플계정--
INSERT INTO TB_DELIVERY (DELI_CODE,
                                              DELI_NAME,
                                              DELI_PHONE,
                                              POSTCODE,
                                              DELI_ADDRESS,
                                                DETAIL_ADDRESS,
                                              DELI_COMMENT,
                                               DELI_DEFAULT,
                                              MEMBER_ID) 
                              VALUES ( SEQ_DELI_CODE.NEXTVAL,
                                                '관리자',
                                                '01011112222',
                                                '07212',
                                               ' 서울 영등포구 선유동2로 57 (양평동4가)',
                                                '이레빌딩 19층',
                                                NULL,
                                                DEFAULT,
                                                'admin' );

--회원샘플계정--
INSERT INTO TB_MEMBER (
                                            MEMBER_ID,
                                            MEMBER_NAME,
                                            MEMBER_PWD,
                                            PHONE,
                                            EMAIL,
                                            BIRTHDATE,
                                            CREATE_DATE,
                                            DELETE_DATE,
                                            STATUS,
                                            TOTAL_POINTS,
                                            CURRENT_POINTS,
                                            GRADE_NAME
                                        ) 
                                        VALUES (
                                            'user01',
                                            '홍길동',
                                            '$2a$10$10sE..DFkXAKR0br6NBeAu1i3bNswzZq2sA34zdq9244HK1cai2b2', -- 'password01!'
                                            '01088889999',
                                            'user01@gmail.com',
                                            TO_DATE('2000-01-11', 'YYYY-MM-DD'), 
                                            DEFAULT,
                                            NULL,
                                            'Y',
                                            DEFAULT,
                                            DEFAULT,
                                            'BABY'
                                        );

-- 상품샘플 데이터--
INSERT INTO TB_PRODUCT (PROD_NO
                      , CATEGORY_NAME
                      , PROD_NAME
                      , PROD_CONTENT
                      , PROD_PRICE
                      , PROD_ORIGIN
                      , PROD_CAUTION
                      , PROD_COUNT
                      , PROD_ENROLL_DATE
                      , PROD_STATUS
                      , SUBCATEGORY_NAME
                        )
                VALUES (SEQ_PROD_NO.NEXTVAL
                      , '스킨케어'
                      , '뷰라밸 모이스처 에센스'
                      , '알콜프리 무향의 저자극성 제품'
                      , 17900
                      , '사철쑥추출물(96.0%),부틸렌글라이콜,1,2.-헥산다이올'
                      , '가. 화장품 사용 시 또는 사용 후 직사광선에 의하여 사용부위가 붉은 반점, 부어오름 또는 가려움증 등의 이상 증상이나 부작용이 있는 경우에는 전문의 등과 상담할 것. 나. 상처가 있는 부위 등에는 사용을 자제할 것. 다. 보관 및 취급 시 주의사항 1) 어린이의 손이 닿지 않는 곳에 보관할 것. 2) 직사광선을 피해서 보관할 것.'
                      , DEFAULT
                      , DEFAULT
                      , DEFAULT
                      , '스킨/에센스'
                        );

INSERT INTO TB_PRODUCT (PROD_NO, CATEGORY_NAME, PROD_NAME, PROD_CONTENT, PROD_PRICE, PROD_ORIGIN, PROD_CAUTION, PROD_COUNT, PROD_ENROLL_DATE, PROD_STATUS, SUBCATEGORY_NAME)
VALUES (SEQ_PROD_NO.NEXTVAL, '스킨케어', '뷰라밸 클렌징 워터', '저자극의 민감성 피부용 클렌징', 12900, '녹차추출물(70%), 글리세린, 카프릴릴글라이콜', '가. 눈에 들어가지 않도록 주의할 것. 나. 상처 부위 사용 금지. 다. 직사광선을 피할 것.', DEFAULT, DEFAULT, DEFAULT, '클렌징');

INSERT INTO TB_PRODUCT (PROD_NO, CATEGORY_NAME, PROD_NAME, PROD_CONTENT, PROD_PRICE, PROD_ORIGIN, PROD_CAUTION, PROD_COUNT, PROD_ENROLL_DATE, PROD_STATUS, SUBCATEGORY_NAME)
VALUES (SEQ_PROD_NO.NEXTVAL, '메이크업', '뷰라밸 매트 립스틱', '고발색의 매트 립스틱', 9900, '쉐어버터, 비즈왁스, 토코페롤', '가. 눈 주위 사용 금지. 나. 화장 후 직사광선 피할 것.', DEFAULT, DEFAULT, DEFAULT, '립');

INSERT INTO TB_PRODUCT (PROD_NO, CATEGORY_NAME, PROD_NAME, PROD_CONTENT, PROD_PRICE, PROD_ORIGIN, PROD_CAUTION, PROD_COUNT, PROD_ENROLL_DATE, PROD_STATUS, SUBCATEGORY_NAME)
VALUES (SEQ_PROD_NO.NEXTVAL, '스킨케어', '뷰라밸 데일리 선크림', 'SPF50+/PA+++의 무기자차', 14900, '징크옥사이드, 티타늄디옥사이드, 알로에베라잎추출물', '가. 눈 주위 사용 금지. 나. 햇빛 노출 전 30분 전에 사용할 것.', DEFAULT, DEFAULT, DEFAULT, '선케어');

INSERT INTO TB_PRODUCT (PROD_NO, CATEGORY_NAME, PROD_NAME, PROD_CONTENT, PROD_PRICE, PROD_ORIGIN, PROD_CAUTION, PROD_COUNT, PROD_ENROLL_DATE, PROD_STATUS, SUBCATEGORY_NAME)
VALUES (SEQ_PROD_NO.NEXTVAL, '맨즈', '뷰라밸 맨즈 헤어왁스', '강력한 고정력을 제공하는 왁스', 13900, '세테아릴알코올, 디메치콘, 향료', '가. 눈에 닿지 않도록 할 것. 나. 상처 부위 사용 금지.', DEFAULT, DEFAULT, DEFAULT, '헤어');

INSERT INTO TB_PRODUCT (PROD_NO, CATEGORY_NAME, PROD_NAME, PROD_CONTENT, PROD_PRICE, PROD_ORIGIN, PROD_CAUTION, PROD_COUNT, PROD_ENROLL_DATE, PROD_STATUS, SUBCATEGORY_NAME)
VALUES (SEQ_PROD_NO.NEXTVAL, '헤어/바디', '뷰라밸 린스', '모발을 부드럽게 만드는 린스', 8900, '판테놀, 하이드롤라이즈드실크, 코코넛오일', '가. 두피에 장기간 방치하지 말 것. 나. 눈에 들어가지 않게 할 것.', DEFAULT, DEFAULT, DEFAULT, '린스');

INSERT INTO TB_PRODUCT (PROD_NO, CATEGORY_NAME, PROD_NAME, PROD_CONTENT, PROD_PRICE, PROD_ORIGIN, PROD_CAUTION, PROD_COUNT, PROD_ENROLL_DATE, PROD_STATUS, SUBCATEGORY_NAME)
VALUES (SEQ_PROD_NO.NEXTVAL, '메이크업', '뷰라밸 아이섀도우 팔레트', '8가지 컬러의 아이섀도우', 20900, '탈크, 마이카, 디메치콘', '가. 눈에 들어가지 않게 주의. 나. 가루날림 주의.', DEFAULT, DEFAULT, DEFAULT, '아이');

INSERT INTO TB_PRODUCT (PROD_NO, CATEGORY_NAME, PROD_NAME, PROD_CONTENT, PROD_PRICE, PROD_ORIGIN, PROD_CAUTION, PROD_COUNT, PROD_ENROLL_DATE, PROD_STATUS, SUBCATEGORY_NAME)
VALUES (SEQ_PROD_NO.NEXTVAL, '스킨케어', '뷰라밸 수분 크림', '보습에 탁월한 고농축 크림', 19900, '히알루론산, 글리세린, 알로에베라잎추출물', '가. 눈 주위 사용 금지. 나. 보관 시 직사광선 피할 것.', DEFAULT, DEFAULT, DEFAULT, '크림/로션');

INSERT INTO TB_PRODUCT (PROD_NO, CATEGORY_NAME, PROD_NAME, PROD_CONTENT, PROD_PRICE, PROD_ORIGIN, PROD_CAUTION, PROD_COUNT, PROD_ENROLL_DATE, PROD_STATUS, SUBCATEGORY_NAME)
VALUES (SEQ_PROD_NO.NEXTVAL, '헤어/바디', '뷰라밸 모이스처 바디로션', '촉촉한 보습을 위한 바디로션', 15900, '쉐어버터, 코코넛오일, 알로에베라잎추출물', '가. 상처 부위 사용 금지. 나. 어린이 손이 닿지 않는 곳에 보관.', DEFAULT, DEFAULT, DEFAULT, '바디로션');

INSERT INTO TB_PRODUCT (PROD_NO, CATEGORY_NAME, PROD_NAME, PROD_CONTENT, PROD_PRICE, PROD_ORIGIN, PROD_CAUTION, PROD_COUNT, PROD_ENROLL_DATE, PROD_STATUS, SUBCATEGORY_NAME)
VALUES (SEQ_PROD_NO.NEXTVAL, '맨즈', '뷰라밸 맨즈 올인원 스킨', '스킨과 로션이 합쳐진 제품', 22900, '알로에베라잎추출물, 글리세린, 부틸렌글라이콜', '가. 피부에 발진 시 즉시 사용 중단. 나. 직사광선 피할 것.', DEFAULT, DEFAULT, DEFAULT, '스킨');

INSERT INTO TB_PRODUCT (PROD_NO, CATEGORY_NAME, PROD_NAME, PROD_CONTENT, PROD_PRICE, PROD_ORIGIN, PROD_CAUTION, PROD_COUNT, PROD_ENROLL_DATE, PROD_STATUS, SUBCATEGORY_NAME)
VALUES (SEQ_PROD_NO.NEXTVAL, '헤어/바디', '뷰라밸 샴푸', '모발과 두피를 깨끗하게 하는 샴푸', 9900, '멘톨, 판테놀, 코코넛오일', '가. 눈에 들어가지 않게 할 것. 나. 상처 부위 사용 금지.', DEFAULT, DEFAULT, DEFAULT, '샴푸');


INSERT INTO TB_PRODUCT (PROD_NO, CATEGORY_NAME, PROD_NAME, PROD_CONTENT, PROD_PRICE, PROD_ORIGIN, PROD_CAUTION, PROD_COUNT, PROD_ENROLL_DATE, PROD_STATUS, SUBCATEGORY_NAME)
VALUES (SEQ_PROD_NO.NEXTVAL, '스킨케어', '뷰라밸 하이드레이팅 에센스', '피부에 깊은 수분감을 주는 에센스', 24900, '글리세린, 부틸렌글라이콜, 녹차추출물', '가. 피부 자극 시 사용 중지. 나. 직사광선 피할 것.', DEFAULT, DEFAULT, DEFAULT, '스킨/에센스');

INSERT INTO TB_PRODUCT (PROD_NO, CATEGORY_NAME, PROD_NAME, PROD_CONTENT, PROD_PRICE, PROD_ORIGIN, PROD_CAUTION, PROD_COUNT, PROD_ENROLL_DATE, PROD_STATUS, SUBCATEGORY_NAME)
VALUES (SEQ_PROD_NO.NEXTVAL, '메이크업', '뷰라밸 틴트 립밤', '촉촉한 보습과 자연스러운 색상 제공', 12900, '쉐어버터, 마카다미아씨오일, 비타민E', '가. 입술 외 사용 금지. 나. 직사광선 피할 것.', DEFAULT, DEFAULT, DEFAULT, '립');

INSERT INTO TB_PRODUCT (PROD_NO, CATEGORY_NAME, PROD_NAME, PROD_CONTENT, PROD_PRICE, PROD_ORIGIN, PROD_CAUTION, PROD_COUNT, PROD_ENROLL_DATE, PROD_STATUS, SUBCATEGORY_NAME)
VALUES (SEQ_PROD_NO.NEXTVAL, '맨즈', '뷰라밸 맨즈 클렌징 젤', '지복합성 피부를 위한 클렌징 젤', 17900, '글리세린, 살리실산, 티트리오일', '가. 눈에 들어가지 않게 주의. 나. 보관 시 직사광선 피할 것.', DEFAULT, DEFAULT, DEFAULT, '스킨');

INSERT INTO TB_PRODUCT (PROD_NO, CATEGORY_NAME, PROD_NAME, PROD_CONTENT, PROD_PRICE, PROD_ORIGIN, PROD_CAUTION, PROD_COUNT, PROD_ENROLL_DATE, PROD_STATUS, SUBCATEGORY_NAME)
VALUES (SEQ_PROD_NO.NEXTVAL, '헤어/바디', '뷰라밸 헤어 세럼', '모발에 윤기와 건강을 부여하는 세럼', 18900, '아르간오일, 판테놀, 하이드롤라이즈드케라틴', '가. 두피에 사용하지 말 것. 나. 어린이 손에 닿지 않게 보관.', DEFAULT, DEFAULT, DEFAULT, '헤어');

INSERT INTO TB_PRODUCT (PROD_NO, CATEGORY_NAME, PROD_NAME, PROD_CONTENT, PROD_PRICE, PROD_ORIGIN, PROD_CAUTION, PROD_COUNT, PROD_ENROLL_DATE, PROD_STATUS, SUBCATEGORY_NAME)
VALUES (SEQ_PROD_NO.NEXTVAL, '스킨케어', '뷰라밸 카밍 토너', '민감성 피부를 위한 진정 토너', 15900, '카모마일추출물, 알란토인, 글리세린', '가. 사용 후 밀폐 보관. 나. 피부 이상 발생 시 즉시 중단.', DEFAULT, DEFAULT, DEFAULT, '스킨/에센스');

INSERT INTO TB_PRODUCT (PROD_NO, CATEGORY_NAME, PROD_NAME, PROD_CONTENT, PROD_PRICE, PROD_ORIGIN, PROD_CAUTION, PROD_COUNT, PROD_ENROLL_DATE, PROD_STATUS, SUBCATEGORY_NAME)
VALUES (SEQ_PROD_NO.NEXTVAL, '메이크업', '뷰라밸 글로우 파운데이션', '자연스러운 광채를 부여하는 베이스', 29900, '미네랄파우더, 실리카, 토코페롤', '가. 눈에 들어가지 않도록 주의. 나. 장기간 방치 금지.', DEFAULT, DEFAULT, DEFAULT, '베이스');

INSERT INTO TB_PRODUCT (PROD_NO, CATEGORY_NAME, PROD_NAME, PROD_CONTENT, PROD_PRICE, PROD_ORIGIN, PROD_CAUTION, PROD_COUNT, PROD_ENROLL_DATE, PROD_STATUS, SUBCATEGORY_NAME)
VALUES (SEQ_PROD_NO.NEXTVAL, '맨즈', '뷰라밸 맨즈 쉐이빙 젤', '부드러운 면도를 위한 젤', 13900, '알로에베라잎추출물, 글리세린, 티트리오일', '가. 상처 부위 사용 금지. 나. 직사광선 피할 것.', DEFAULT, DEFAULT, DEFAULT, '스킨');

INSERT INTO TB_PRODUCT (PROD_NO, CATEGORY_NAME, PROD_NAME, PROD_CONTENT, PROD_PRICE, PROD_ORIGIN, PROD_CAUTION, PROD_COUNT, PROD_ENROLL_DATE, PROD_STATUS, SUBCATEGORY_NAME)
VALUES (SEQ_PROD_NO.NEXTVAL, '헤어/바디', '뷰라밸 프레쉬 바디워시', '상쾌한 사용감을 주는 바디워시', 11900, '멘톨, 코코넛오일, 비타민E', '가. 눈에 들어가지 않게 주의. 나. 상처 부위 사용 금지.', DEFAULT, DEFAULT, DEFAULT, '바디로션');

INSERT INTO TB_PRODUCT (PROD_NO, CATEGORY_NAME, PROD_NAME, PROD_CONTENT, PROD_PRICE, PROD_ORIGIN, PROD_CAUTION, PROD_COUNT, PROD_ENROLL_DATE, PROD_STATUS, SUBCATEGORY_NAME)
VALUES (SEQ_PROD_NO.NEXTVAL, '스킨케어', '뷰라밸 브라이트닝 세럼', '피부 톤 개선을 위한 고농축 세럼', 21900, '나이아신아마이드, 아르부틴, 글리세린', '가. 피부 이상 발생 시 사용 중단. 나. 어린이 손이 닿지 않는 곳에 보관.', DEFAULT, DEFAULT, DEFAULT, '스킨/에센스');

INSERT INTO TB_PRODUCT (PROD_NO, CATEGORY_NAME, PROD_NAME, PROD_CONTENT, PROD_PRICE, PROD_ORIGIN, PROD_CAUTION, PROD_COUNT, PROD_ENROLL_DATE, PROD_STATUS, SUBCATEGORY_NAME)
VALUES (SEQ_PROD_NO.NEXTVAL, '메이크업', '뷰라밸 워터프루프 아이라이너', '번짐 없이 지속되는 아이라이너', 16900, '비즈왁스, 카본블랙, 폴리머', '가. 눈에 들어가지 않게 주의. 나. 사용 후 마개를 닫아 보관.', DEFAULT, DEFAULT, DEFAULT, '아이');

INSERT INTO TB_PRODUCT (PROD_NO, CATEGORY_NAME, PROD_NAME, PROD_CONTENT, PROD_PRICE, PROD_ORIGIN, PROD_CAUTION, PROD_COUNT, PROD_ENROLL_DATE, PROD_STATUS, SUBCATEGORY_NAME)
VALUES (SEQ_PROD_NO.NEXTVAL, '헤어/바디', '뷰라밸 딥 컨디셔너', '건조한 모발을 위한 집중 케어 린스', 17900, '쉐어버터, 하이드롤라이즈드케라틴, 판테놀', '가. 두피에 장시간 방치 금지. 나. 눈에 들어가지 않게 주의.', DEFAULT, DEFAULT, DEFAULT, '린스');

INSERT INTO TB_PRODUCT (PROD_NO, CATEGORY_NAME, PROD_NAME, PROD_CONTENT, PROD_PRICE, PROD_ORIGIN, PROD_CAUTION, PROD_COUNT, PROD_ENROLL_DATE, PROD_STATUS, SUBCATEGORY_NAME)
VALUES (SEQ_PROD_NO.NEXTVAL, '맨즈', '뷰라밸 맨즈 페이스크림', '남성 피부를 위한 고보습 크림', 15900, '히알루론산, 글리세린, 쉐어버터', '가. 상처 부위 사용 금지. 나. 사용 후 밀폐 보관.', DEFAULT, DEFAULT, DEFAULT, '스킨');

INSERT INTO TB_PRODUCT (PROD_NO, CATEGORY_NAME, PROD_NAME, PROD_CONTENT, PROD_PRICE, PROD_ORIGIN, PROD_CAUTION, PROD_COUNT, PROD_ENROLL_DATE, PROD_STATUS, SUBCATEGORY_NAME)
VALUES (SEQ_PROD_NO.NEXTVAL, '메이크업', '뷰라밸 크리미 블러셔', '부드럽고 자연스러운 컬러감 제공', 19900, '미네랄파우더, 쉐어버터, 토코페롤', '가. 눈 주위 사용 금지. 나. 사용 후 직사광선 피할 것.', DEFAULT, DEFAULT, DEFAULT, '베이스');

INSERT INTO TB_PRODUCT (PROD_NO, CATEGORY_NAME, PROD_NAME, PROD_CONTENT, PROD_PRICE, PROD_ORIGIN, PROD_CAUTION, PROD_COUNT, PROD_ENROLL_DATE, PROD_STATUS, SUBCATEGORY_NAME)
VALUES (SEQ_PROD_NO.NEXTVAL, '헤어/바디', '뷰라밸 리페어 헤어마스크', '손상 모발에 영양을 공급하는 마스크', 25900, '판테놀, 쉐어버터, 하이드롤라이즈드케라틴', '가. 두피에 직접 사용하지 말 것. 나. 어린이 손 닿지 않는 곳에 보관.', DEFAULT, DEFAULT, DEFAULT, '헤어');

INSERT INTO TB_PRODUCT (PROD_NO, CATEGORY_NAME, PROD_NAME, PROD_CONTENT, PROD_PRICE, PROD_ORIGIN, PROD_CAUTION, PROD_COUNT, PROD_ENROLL_DATE, PROD_STATUS, SUBCATEGORY_NAME)
VALUES (SEQ_PROD_NO.NEXTVAL, '스킨케어', '뷰라밸 수딩 젤', '피부 자극을 완화하는 젤', 14900, '알로에베라잎추출물, 글리세린, 판테놀', '가. 상처 부위 사용 금지. 나. 보관 시 직사광선 피할 것.', DEFAULT, DEFAULT, DEFAULT, '크림/로션');


INSERT INTO TB_PRODUCT (PROD_NO, CATEGORY_NAME, PROD_NAME, PROD_CONTENT, PROD_PRICE, PROD_ORIGIN, PROD_CAUTION, PROD_COUNT, PROD_ENROLL_DATE, PROD_STATUS, SUBCATEGORY_NAME)
VALUES (SEQ_PROD_NO.NEXTVAL, '스킨케어', '뷰라밸 모이스처라이징 크림', '건조한 피부에 보습을 제공하는 크림', 23900, '쉐어버터, 글리세린, 판테놀', '가. 눈에 들어가지 않게 주의. 나. 직사광선을 피해서 보관.', DEFAULT, DEFAULT, DEFAULT, '크림/로션');

INSERT INTO TB_PRODUCT (PROD_NO, CATEGORY_NAME, PROD_NAME, PROD_CONTENT, PROD_PRICE, PROD_ORIGIN, PROD_CAUTION, PROD_COUNT, PROD_ENROLL_DATE, PROD_STATUS, SUBCATEGORY_NAME)
VALUES (SEQ_PROD_NO.NEXTVAL, '메이크업', '뷰라밸 매트 립스틱', '선명한 컬러와 매트한 마무리감 제공', 15900, '카올린, 쉐어버터, 비타민E', '가. 입술 외의 사용 금지. 나. 사용 후 마개를 닫아 보관.', DEFAULT, DEFAULT, DEFAULT, '립');

INSERT INTO TB_PRODUCT (PROD_NO, CATEGORY_NAME, PROD_NAME, PROD_CONTENT, PROD_PRICE, PROD_ORIGIN, PROD_CAUTION, PROD_COUNT, PROD_ENROLL_DATE, PROD_STATUS, SUBCATEGORY_NAME)
VALUES (SEQ_PROD_NO.NEXTVAL, '맨즈', '뷰라밸 맨즈 선크림', 'UV 차단과 함께 피부 보호', 18900, '티타늄디옥사이드, 글리세린, 판테놀', '가. 눈 주위 사용 금지. 나. 어린이 손 닿지 않는 곳에 보관.', DEFAULT, DEFAULT, DEFAULT, '스킨');

INSERT INTO TB_PRODUCT (PROD_NO, CATEGORY_NAME, PROD_NAME, PROD_CONTENT, PROD_PRICE, PROD_ORIGIN, PROD_CAUTION, PROD_COUNT, PROD_ENROLL_DATE, PROD_STATUS, SUBCATEGORY_NAME)
VALUES (SEQ_PROD_NO.NEXTVAL, '헤어/바디', '뷰라밸 퓨어 샴푸', '두피와 모발을 건강하게 관리하는 샴푸', 12900, '코코넛오일, 알로에베라추출물, 글리세린', '가. 눈에 들어가지 않게 주의. 나. 어린이 손 닿지 않는 곳에 보관.', DEFAULT, DEFAULT, DEFAULT, '샴푸');

INSERT INTO TB_PRODUCT (PROD_NO, CATEGORY_NAME, PROD_NAME, PROD_CONTENT, PROD_PRICE, PROD_ORIGIN, PROD_CAUTION, PROD_COUNT, PROD_ENROLL_DATE, PROD_STATUS, SUBCATEGORY_NAME)
VALUES (SEQ_PROD_NO.NEXTVAL, '스킨케어', '뷰라밸 UV 프로텍터', '민감한 피부를 위한 저자극 선크림', 20900, '징크옥사이드, 티타늄디옥사이드, 글리세린', '가. 상처 부위 사용 금지. 나. 사용 후 직사광선 피할 것.', DEFAULT, DEFAULT, DEFAULT, '선케어');

INSERT INTO TB_PRODUCT (PROD_NO, CATEGORY_NAME, PROD_NAME, PROD_CONTENT, PROD_PRICE, PROD_ORIGIN, PROD_CAUTION, PROD_COUNT, PROD_ENROLL_DATE, PROD_STATUS, SUBCATEGORY_NAME)
VALUES (SEQ_PROD_NO.NEXTVAL, '메이크업', '뷰라밸 하이라이터', '피부에 자연스러운 광택을 부여하는 하이라이터', 17900, '미네랄파우더, 쉐어버터, 토코페롤', '가. 눈 주위 사용 금지. 나. 직사광선을 피해서 보관.', DEFAULT, DEFAULT, DEFAULT, '아이');

INSERT INTO TB_PRODUCT (PROD_NO, CATEGORY_NAME, PROD_NAME, PROD_CONTENT, PROD_PRICE, PROD_ORIGIN, PROD_CAUTION, PROD_COUNT, PROD_ENROLL_DATE, PROD_STATUS, SUBCATEGORY_NAME)
VALUES (SEQ_PROD_NO.NEXTVAL, '맨즈', '뷰라밸 맨즈 헤어왁스', '자연스러운 스타일링과 고정력 제공', 14900, '카올린, 쉐어버터, 글리세린', '가. 눈에 들어가지 않게 주의. 나. 직사광선을 피해서 보관.', DEFAULT, DEFAULT, DEFAULT, '헤어');

INSERT INTO TB_PRODUCT (PROD_NO, CATEGORY_NAME, PROD_NAME, PROD_CONTENT, PROD_PRICE, PROD_ORIGIN, PROD_CAUTION, PROD_COUNT, PROD_ENROLL_DATE, PROD_STATUS, SUBCATEGORY_NAME)
VALUES (SEQ_PROD_NO.NEXTVAL, '헤어/바디', '뷰라밸 딥 모이스처 바디로션', '건조한 피부를 위한 보습 바디로션', 19900, '쉐어버터, 글리세린, 판테놀', '가. 피부 자극 시 사용 중단. 나. 어린이 손 닿지 않는 곳에 보관.', DEFAULT, DEFAULT, DEFAULT, '바디로션');

INSERT INTO TB_PRODUCT (PROD_NO, CATEGORY_NAME, PROD_NAME, PROD_CONTENT, PROD_PRICE, PROD_ORIGIN, PROD_CAUTION, PROD_COUNT, PROD_ENROLL_DATE, PROD_STATUS, SUBCATEGORY_NAME)
VALUES (SEQ_PROD_NO.NEXTVAL, '스킨케어', '뷰라밸 클렌징 오일', '메이크업과 노폐물 제거를 위한 클렌징 오일', 18900, '코코넛오일, 포도씨오일, 비타민E', '가. 눈에 들어가지 않게 주의. 나. 직사광선을 피해서 보관.', DEFAULT, DEFAULT, DEFAULT, '클렌징');

INSERT INTO TB_PRODUCT (PROD_NO, CATEGORY_NAME, PROD_NAME, PROD_CONTENT, PROD_PRICE, PROD_ORIGIN, PROD_CAUTION, PROD_COUNT, PROD_ENROLL_DATE, PROD_STATUS, SUBCATEGORY_NAME)
VALUES (SEQ_PROD_NO.NEXTVAL, '메이크업', '뷰라밸 롱래스팅 파우더', '오랜 시간 지속되는 피부 표현을 위한 파우더', 13900, '미네랄파우더, 실리카, 쉐어버터', '가. 사용 후 밀폐 보관. 나. 직사광선 피할 것.', DEFAULT, DEFAULT, DEFAULT, '베이스');


COMMIT;