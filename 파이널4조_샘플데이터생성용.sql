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
                        'user02',
                        '이유저',
                        '$2a$10$10sE..DFkXAKR0br6NBeAu1i3bNswzZq2sA34zdq9244HK1cai2b2', -- 'password01!'
                        '01022222222',
                        'user02@gmail.com',
                        TO_DATE('2000-01-11', 'YYYY-MM-DD'), 
                        DEFAULT,
                        NULL,
                        'Y',
                        DEFAULT,
                        DEFAULT,
                        'BABY'
                    );
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
                        'user03',
                        '삼유저',
                        '$2a$10$10sE..DFkXAKR0br6NBeAu1i3bNswzZq2sA34zdq9244HK1cai2b2', -- 'password01!'
                        '01022222222',
                        'user03@gmail.com',
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


-- 상품 이미지 샘플 데이터--
INSERT INTO TB_PRODUCT_ATTACHMENT VALUES(SEQ_PROD_ATT_NO.NEXTVAL
                                       , 'product1_1.jpg'
                                       , 'product1_1.jpg'
                                       , '/resources/uploadFiles/product/'
                                       , '/resources/uploadFiles/product/thumb/'
                                       , 'Y'
                                       , 36);
INSERT INTO TB_PRODUCT_ATTACHMENT VALUES(SEQ_PROD_ATT_NO.NEXTVAL
                                       , 'product1_2.jpg'
                                       , 'product1_2.jpg'
                                       , '/resources/uploadFiles/product/'
                                       , '/resources/uploadFiles/product/thumb/'
                                       , 'Y'
                                       , 36);
INSERT INTO TB_PRODUCT_ATTACHMENT VALUES(SEQ_PROD_ATT_NO.NEXTVAL
                                       , 'product1_3.jpg'
                                       , 'product1_3.jpg'
                                       , '/resources/uploadFiles/product/'
                                       , '/resources/uploadFiles/product/thumb/'
                                       , 'Y'
                                       , 36);
INSERT INTO TB_PRODUCT_ATTACHMENT VALUES(SEQ_PROD_ATT_NO.NEXTVAL
                                       , 'product_caution.jpg'
                                       , 'product_caution.jpg'
                                       , '/resources/uploadFiles/product/'
                                       , null
                                       , 'Y'
                                       , 36);
INSERT INTO TB_PRODUCT_ATTACHMENT VALUES(SEQ_PROD_ATT_NO.NEXTVAL
                                       , 'product1_detail.jpg'
                                       , 'product1_detail.jpg'
                                       , '/resources/uploadFiles/product/'
                                       , null
                                       , 'Y'
                                       , 36);

INSERT INTO TB_PRODUCT_ATTACHMENT VALUES(SEQ_PROD_ATT_NO.NEXTVAL
                                       , 'product2_1.jpg'
                                       , 'product2_1.jpg'
                                       , '/resources/uploadFiles/product/'
                                       , '/resources/uploadFiles/product/thumb/'
                                       , 'Y'
                                       , 35);
INSERT INTO TB_PRODUCT_ATTACHMENT VALUES(SEQ_PROD_ATT_NO.NEXTVAL
                                       , 'product2_2.jpg'
                                       , 'product2_2.jpg'
                                       , '/resources/uploadFiles/product/'
                                       , '/resources/uploadFiles/product/thumb/'
                                       , 'Y'
                                       , 35);
INSERT INTO TB_PRODUCT_ATTACHMENT VALUES(SEQ_PROD_ATT_NO.NEXTVAL
                                       , 'product2_3.jpg'
                                       , 'product2_3.jpg'
                                       , '/resources/uploadFiles/product/'
                                       , '/resources/uploadFiles/product/thumb/'
                                       , 'Y'
                                       , 35);
INSERT INTO TB_PRODUCT_ATTACHMENT VALUES(SEQ_PROD_ATT_NO.NEXTVAL
                                       , 'product_caution.jpg'
                                       , 'product_caution.jpg'
                                       , '/resources/uploadFiles/product/'
                                       , null
                                       , 'Y'
                                       , 35);
INSERT INTO TB_PRODUCT_ATTACHMENT VALUES(SEQ_PROD_ATT_NO.NEXTVAL
                                       , 'product2_detail.jpg'
                                       , 'product2_detail.jpg'
                                       , '/resources/uploadFiles/product/'
                                       , null
                                       , 'Y'
                                       , 35);

INSERT INTO TB_PRODUCT_ATTACHMENT VALUES(SEQ_PROD_ATT_NO.NEXTVAL
                                       , 'product3_1.jpg'
                                       , 'product3_1.jpg'
                                       , '/resources/uploadFiles/product/'
                                       , '/resources/uploadFiles/product/thumb/'
                                       , 'Y'
                                       , 34);
INSERT INTO TB_PRODUCT_ATTACHMENT VALUES(SEQ_PROD_ATT_NO.NEXTVAL
                                       , 'product3_2.jpg'
                                       , 'product3_2.jpg'
                                       , '/resources/uploadFiles/product/'
                                       , '/resources/uploadFiles/product/thumb/'
                                       , 'Y'
                                       , 34);
INSERT INTO TB_PRODUCT_ATTACHMENT VALUES(SEQ_PROD_ATT_NO.NEXTVAL
                                       , 'product3_3.jpg'
                                       , 'product3_3.jpg'
                                       , '/resources/uploadFiles/product/'
                                       , '/resources/uploadFiles/product/thumb/'
                                       , 'Y'
                                       , 34);
INSERT INTO TB_PRODUCT_ATTACHMENT VALUES(SEQ_PROD_ATT_NO.NEXTVAL
                                       , 'product_caution.jpg'
                                       , 'product_caution.jpg'
                                       , '/resources/uploadFiles/product/'
                                       , null
                                       , 'Y'
                                       , 34);
INSERT INTO TB_PRODUCT_ATTACHMENT VALUES(SEQ_PROD_ATT_NO.NEXTVAL
                                       , 'product3_detail.jpg'
                                       , 'product3_detail.jpg'
                                       , '/resources/uploadFiles/product/'
                                       , null
                                       , 'Y'
                                       , 34);
INSERT INTO TB_PRODUCT_ATTACHMENT VALUES(SEQ_PROD_ATT_NO.NEXTVAL
                                       , 'product3_detail.jpg'
                                       , 'product3_detail.jpg'
                                       , '/resources/uploadFiles/product/'
                                       , null
                                       , 'Y'
                                       , 34);

INSERT INTO TB_PRODUCT_ATTACHMENT VALUES(SEQ_PROD_ATT_NO.NEXTVAL
                                       , 'product2_1.jpg'
                                       , 'product2_1.jpg'
                                       , '/resources/uploadFiles/product/'
                                       , '/resources/uploadFiles/product/thumb/'
                                       , 'Y'
                                       , 33);
INSERT INTO TB_PRODUCT_ATTACHMENT VALUES(SEQ_PROD_ATT_NO.NEXTVAL
                                       , 'product2_detail.jpg'
                                       , 'product2_detail.jpg'
                                       , '/resources/uploadFiles/product/'
                                       , null
                                       , 'Y'
                                       , 33);
                                       
INSERT INTO TB_PRODUCT_ATTACHMENT VALUES(SEQ_PROD_ATT_NO.NEXTVAL
                                       , 'product1_1.jpg'
                                       , 'product1_1.jpg'
                                       , '/resources/uploadFiles/product/'
                                       , '/resources/uploadFiles/product/thumb/'
                                       , 'Y'
                                       , 32);
INSERT INTO TB_PRODUCT_ATTACHMENT VALUES(SEQ_PROD_ATT_NO.NEXTVAL
                                       , 'product1_detail.jpg'
                                       , 'product1_detail.jpg'
                                       , '/resources/uploadFiles/product/'
                                       , null
                                       , 'Y'
                                       , 32);

INSERT INTO TB_PRODUCT_ATTACHMENT VALUES(SEQ_PROD_ATT_NO.NEXTVAL
                                       , 'product3_1.jpg'
                                       , 'product3_1.jpg'
                                       , '/resources/uploadFiles/product/'
                                       , '/resources/uploadFiles/product/thumb/'
                                       , 'Y'
                                       , 31);
INSERT INTO TB_PRODUCT_ATTACHMENT VALUES(SEQ_PROD_ATT_NO.NEXTVAL
                                       , 'product3_detail.jpg'
                                       , 'product3_detail.jpg'
                                       , '/resources/uploadFiles/product/'
                                       , null
                                       , 'Y'
                                       , 31);

INSERT INTO TB_PRODUCT_ATTACHMENT VALUES(SEQ_PROD_ATT_NO.NEXTVAL
                                       , 'product2_1.jpg'
                                       , 'product2_1.jpg'
                                       , '/resources/uploadFiles/product/'
                                       , '/resources/uploadFiles/product/thumb/'
                                       , 'Y'
                                       , 30);
INSERT INTO TB_PRODUCT_ATTACHMENT VALUES(SEQ_PROD_ATT_NO.NEXTVAL
                                       , 'product2_detail.jpg'
                                       , 'product2_detail.jpg'
                                       , '/resources/uploadFiles/product/'
                                       , null
                                       , 'Y'
                                       , 30);

INSERT INTO TB_PRODUCT_ATTACHMENT VALUES(SEQ_PROD_ATT_NO.NEXTVAL
                                       , 'product1_1.jpg'
                                       , 'product1_1.jpg'
                                       , '/resources/uploadFiles/product/'
                                       , '/resources/uploadFiles/product/thumb/'
                                       , 'Y'
                                       , 29);
INSERT INTO TB_PRODUCT_ATTACHMENT VALUES(SEQ_PROD_ATT_NO.NEXTVAL
                                       , 'product1_detail.jpg'
                                       , 'product1_detail.jpg'
                                       , '/resources/uploadFiles/product/'
                                       , null
                                       , 'Y'
                                       , 29);

INSERT INTO TB_PRODUCT_ATTACHMENT VALUES(SEQ_PROD_ATT_NO.NEXTVAL
                                       , 'product3_1.jpg'
                                       , 'product3_1.jpg'
                                       , '/resources/uploadFiles/product/'
                                       , '/resources/uploadFiles/product/thumb/'
                                       , 'Y'
                                       , 28);
INSERT INTO TB_PRODUCT_ATTACHMENT VALUES(SEQ_PROD_ATT_NO.NEXTVAL
                                       , 'product3_detail.jpg'
                                       , 'product3_detail.jpg'
                                       , '/resources/uploadFiles/product/'
                                       , null
                                       , 'Y'
                                       , 28);

INSERT INTO TB_PRODUCT_ATTACHMENT VALUES(SEQ_PROD_ATT_NO.NEXTVAL
                                       , 'product2_1.jpg'
                                       , 'product2_1.jpg'
                                       , '/resources/uploadFiles/product/'
                                       , '/resources/uploadFiles/product/thumb/'
                                       , 'Y'
                                       , 27);
INSERT INTO TB_PRODUCT_ATTACHMENT VALUES(SEQ_PROD_ATT_NO.NEXTVAL
                                       , 'product2_detail.jpg'
                                       , 'product2_detail.jpg'
                                       , '/resources/uploadFiles/product/'
                                       , null
                                       , 'Y'
                                       , 27);

INSERT INTO TB_PRODUCT_ATTACHMENT VALUES(SEQ_PROD_ATT_NO.NEXTVAL
                                       , 'product1_1.jpg'
                                       , 'product1_1.jpg'
                                       , '/resources/uploadFiles/product/'
                                       , '/resources/uploadFiles/product/thumb/'
                                       , 'Y'
                                       , 26);
INSERT INTO TB_PRODUCT_ATTACHMENT VALUES(SEQ_PROD_ATT_NO.NEXTVAL
                                       , 'product1_detail.jpg'
                                       , 'product1_detail.jpg'
                                       , '/resources/uploadFiles/product/'
                                       , null
                                       , 'Y'
                                       , 26);

INSERT INTO TB_PRODUCT_ATTACHMENT VALUES(SEQ_PROD_ATT_NO.NEXTVAL
                                       , 'product3_1.jpg'
                                       , 'product3_1.jpg'
                                       , '/resources/uploadFiles/product/'
                                       , '/resources/uploadFiles/product/thumb/'
                                       , 'Y'
                                       , 25);
INSERT INTO TB_PRODUCT_ATTACHMENT VALUES(SEQ_PROD_ATT_NO.NEXTVAL
                                       , 'product3_detail.jpg'
                                       , 'product3_detail.jpg'
                                       , '/resources/uploadFiles/product/'
                                       , null
                                       , 'Y'
                                       , 25);

INSERT INTO TB_PRODUCT_ATTACHMENT VALUES(SEQ_PROD_ATT_NO.NEXTVAL
                                       , 'product2_1.jpg'
                                       , 'product2_1.jpg'
                                       , '/resources/uploadFiles/product/'
                                       , '/resources/uploadFiles/product/thumb/'
                                       , 'Y'
                                       , 24);
INSERT INTO TB_PRODUCT_ATTACHMENT VALUES(SEQ_PROD_ATT_NO.NEXTVAL
                                       , 'product2_detail.jpg'
                                       , 'product2_detail.jpg'
                                       , '/resources/uploadFiles/product/'
                                       , null
                                       , 'Y'
                                       , 24);

INSERT INTO TB_PRODUCT_ATTACHMENT VALUES(SEQ_PROD_ATT_NO.NEXTVAL
                                       , 'product1_1.jpg'
                                       , 'product1_1.jpg'
                                       , '/resources/uploadFiles/product/'
                                       , '/resources/uploadFiles/product/thumb/'
                                       , 'Y'
                                       , 23);
INSERT INTO TB_PRODUCT_ATTACHMENT VALUES(SEQ_PROD_ATT_NO.NEXTVAL
                                       , 'product1_detail.jpg'
                                       , 'product1_detail.jpg'
                                       , '/resources/uploadFiles/product/'
                                       , null
                                       , 'Y'
                                       , 23);

INSERT INTO TB_PRODUCT_ATTACHMENT VALUES(SEQ_PROD_ATT_NO.NEXTVAL
                                       , 'product3_1.jpg'
                                       , 'product3_1.jpg'
                                       , '/resources/uploadFiles/product/'
                                       , '/resources/uploadFiles/product/thumb/'
                                       , 'Y'
                                       , 22);
INSERT INTO TB_PRODUCT_ATTACHMENT VALUES(SEQ_PROD_ATT_NO.NEXTVAL
                                       , 'product3_detail.jpg'
                                       , 'product3_detail.jpg'
                                       , '/resources/uploadFiles/product/'
                                       , null
                                       , 'Y'
                                       , 22);

INSERT INTO TB_PRODUCT_ATTACHMENT VALUES(SEQ_PROD_ATT_NO.NEXTVAL
                                       , 'product1_1.jpg'
                                       , 'product1_1.jpg'
                                       , '/resources/uploadFiles/product/'
                                       , '/resources/uploadFiles/product/thumb/'
                                       , 'Y'
                                       , 21);
INSERT INTO TB_PRODUCT_ATTACHMENT VALUES(SEQ_PROD_ATT_NO.NEXTVAL
                                       , 'product1_detail.jpg'
                                       , 'product1_detail.jpg'
                                       , '/resources/uploadFiles/product/'
                                       , null
                                       , 'Y'
                                       , 21);

INSERT INTO TB_PRODUCT_ATTACHMENT VALUES(SEQ_PROD_ATT_NO.NEXTVAL
                                       , 'product2_1.jpg'
                                       , 'product2_1.jpg'
                                       , '/resources/uploadFiles/product/'
                                       , '/resources/uploadFiles/product/thumb/'
                                       , 'Y'
                                       , 20);
INSERT INTO TB_PRODUCT_ATTACHMENT VALUES(SEQ_PROD_ATT_NO.NEXTVAL
                                       , 'product2_detail.jpg'
                                       , 'product2_detail.jpg'
                                       , '/resources/uploadFiles/product/'
                                       , null
                                       , 'Y'
                                       , 20);

INSERT INTO TB_PRODUCT_ATTACHMENT VALUES(SEQ_PROD_ATT_NO.NEXTVAL
                                       , 'product3_1.jpg'
                                       , 'product3_1.jpg'
                                       , '/resources/uploadFiles/product/'
                                       , '/resources/uploadFiles/product/thumb/'
                                       , 'Y'
                                       , 19);
INSERT INTO TB_PRODUCT_ATTACHMENT VALUES(SEQ_PROD_ATT_NO.NEXTVAL
                                       , 'product3_detail.jpg'
                                       , 'product3_detail.jpg'
                                       , '/resources/uploadFiles/product/'
                                       , null
                                       , 'Y'
                                       , 19);

INSERT INTO TB_PRODUCT_ATTACHMENT VALUES(SEQ_PROD_ATT_NO.NEXTVAL
                                       , 'product1_1.jpg'
                                       , 'product1_1.jpg'
                                       , '/resources/uploadFiles/product/'
                                       , '/resources/uploadFiles/product/thumb/'
                                       , 'Y'
                                       , 18);
INSERT INTO TB_PRODUCT_ATTACHMENT VALUES(SEQ_PROD_ATT_NO.NEXTVAL
                                       , 'product1_detail.jpg'
                                       , 'product1_detail.jpg'
                                       , '/resources/uploadFiles/product/'
                                       , null
                                       , 'Y'
                                       , 18);

INSERT INTO TB_PRODUCT_ATTACHMENT VALUES(SEQ_PROD_ATT_NO.NEXTVAL
                                       , 'product2_1.jpg'
                                       , 'product2_1.jpg'
                                       , '/resources/uploadFiles/product/'
                                       , '/resources/uploadFiles/product/thumb/'
                                       , 'Y'
                                       , 17);
INSERT INTO TB_PRODUCT_ATTACHMENT VALUES(SEQ_PROD_ATT_NO.NEXTVAL
                                       , 'product2_detail.jpg'
                                       , 'product2_detail.jpg'
                                       , '/resources/uploadFiles/product/'
                                       , null
                                       , 'Y'
                                       , 17);

INSERT INTO TB_PRODUCT_ATTACHMENT VALUES(SEQ_PROD_ATT_NO.NEXTVAL
                                       , 'product3_1.jpg'
                                       , 'product3_1.jpg'
                                       , '/resources/uploadFiles/product/'
                                       , '/resources/uploadFiles/product/thumb/'
                                       , 'Y'
                                       , 16);
INSERT INTO TB_PRODUCT_ATTACHMENT VALUES(SEQ_PROD_ATT_NO.NEXTVAL
                                       , 'product3_detail.jpg'
                                       , 'product3_detail.jpg'
                                       , '/resources/uploadFiles/product/'
                                       , null
                                       , 'Y'
                                       , 16);

INSERT INTO TB_PRODUCT_ATTACHMENT VALUES(SEQ_PROD_ATT_NO.NEXTVAL
                                       , 'product1_1.jpg'
                                       , 'product1_1.jpg'
                                       , '/resources/uploadFiles/product/'
                                       , '/resources/uploadFiles/product/thumb/'
                                       , 'Y'
                                       , 15);
INSERT INTO TB_PRODUCT_ATTACHMENT VALUES(SEQ_PROD_ATT_NO.NEXTVAL
                                       , 'product1_detail.jpg'
                                       , 'product1_detail.jpg'
                                       , '/resources/uploadFiles/product/'
                                       , null
                                       , 'Y'
                                       , 15);

INSERT INTO TB_PRODUCT_ATTACHMENT VALUES(SEQ_PROD_ATT_NO.NEXTVAL
                                       , 'product2_1.jpg'
                                       , 'product2_1.jpg'
                                       , '/resources/uploadFiles/product/'
                                       , '/resources/uploadFiles/product/thumb/'
                                       , 'Y'
                                       , 14);
INSERT INTO TB_PRODUCT_ATTACHMENT VALUES(SEQ_PROD_ATT_NO.NEXTVAL
                                       , 'product2_detail.jpg'
                                       , 'product2_detail.jpg'
                                       , '/resources/uploadFiles/product/'
                                       , null
                                       , 'Y'
                                       , 14);

INSERT INTO TB_PRODUCT_ATTACHMENT VALUES(SEQ_PROD_ATT_NO.NEXTVAL
                                       , 'product3_1.jpg'
                                       , 'product3_1.jpg'
                                       , '/resources/uploadFiles/product/'
                                       , '/resources/uploadFiles/product/thumb/'
                                       , 'Y'
                                       , 13);
INSERT INTO TB_PRODUCT_ATTACHMENT VALUES(SEQ_PROD_ATT_NO.NEXTVAL
                                       , 'product3_detail.jpg'
                                       , 'product3_detail.jpg'
                                       , '/resources/uploadFiles/product/'
                                       , null
                                       , 'Y'
                                       , 13);

INSERT INTO TB_PRODUCT_ATTACHMENT VALUES(SEQ_PROD_ATT_NO.NEXTVAL
                                       , 'product1_1.jpg'
                                       , 'product1_1.jpg'
                                       , '/resources/uploadFiles/product/'
                                       , '/resources/uploadFiles/product/thumb/'
                                       , 'Y'
                                       , 12);
INSERT INTO TB_PRODUCT_ATTACHMENT VALUES(SEQ_PROD_ATT_NO.NEXTVAL
                                       , 'product1_detail.jpg'
                                       , 'product1_detail.jpg'
                                       , '/resources/uploadFiles/product/'
                                       , null
                                       , 'Y'
                                       , 12);

INSERT INTO TB_PRODUCT_ATTACHMENT VALUES(SEQ_PROD_ATT_NO.NEXTVAL
                                       , 'product2_1.jpg'
                                       , 'product2_1.jpg'
                                       , '/resources/uploadFiles/product/'
                                       , '/resources/uploadFiles/product/thumb/'
                                       , 'Y'
                                       , 11);
INSERT INTO TB_PRODUCT_ATTACHMENT VALUES(SEQ_PROD_ATT_NO.NEXTVAL
                                       , 'product2_detail.jpg'
                                       , 'product2_detail.jpg'
                                       , '/resources/uploadFiles/product/'
                                       , null
                                       , 'Y'
                                       , 11);

INSERT INTO TB_PRODUCT_ATTACHMENT VALUES(SEQ_PROD_ATT_NO.NEXTVAL
                                       , 'product3_1.jpg'
                                       , 'product3_1.jpg'
                                       , '/resources/uploadFiles/product/'
                                       , '/resources/uploadFiles/product/thumb/'
                                       , 'Y'
                                       , 10);
INSERT INTO TB_PRODUCT_ATTACHMENT VALUES(SEQ_PROD_ATT_NO.NEXTVAL
                                       , 'product3_detail.jpg'
                                       , 'product3_detail.jpg'
                                       , '/resources/uploadFiles/product/'
                                       , null
                                       , 'Y'
                                       , 10);

INSERT INTO TB_PRODUCT_ATTACHMENT VALUES(SEQ_PROD_ATT_NO.NEXTVAL
                                       , 'product1_1.jpg'
                                       , 'product1_1.jpg'
                                       , '/resources/uploadFiles/product/'
                                       , '/resources/uploadFiles/product/thumb/'
                                       , 'Y'
                                       , 9);
INSERT INTO TB_PRODUCT_ATTACHMENT VALUES(SEQ_PROD_ATT_NO.NEXTVAL
                                       , 'product1_detail.jpg'
                                       , 'product1_detail.jpg'
                                       , '/resources/uploadFiles/product/'
                                       , null
                                       , 'Y'
                                       , 9);

INSERT INTO TB_PRODUCT_ATTACHMENT VALUES(SEQ_PROD_ATT_NO.NEXTVAL
                                       , 'product2_1.jpg'
                                       , 'product2_1.jpg'
                                       , '/resources/uploadFiles/product/'
                                       , '/resources/uploadFiles/product/thumb/'
                                       , 'Y'
                                       , 8);
INSERT INTO TB_PRODUCT_ATTACHMENT VALUES(SEQ_PROD_ATT_NO.NEXTVAL
                                       , 'product2_detail.jpg'
                                       , 'product2_detail.jpg'
                                       , '/resources/uploadFiles/product/'
                                       , null
                                       , 'Y'
                                       , 8);

INSERT INTO TB_PRODUCT_ATTACHMENT VALUES(SEQ_PROD_ATT_NO.NEXTVAL
                                       , 'product3_1.jpg'
                                       , 'product3_1.jpg'
                                       , '/resources/uploadFiles/product/'
                                       , '/resources/uploadFiles/product/thumb/'
                                       , 'Y'
                                       , 7);
INSERT INTO TB_PRODUCT_ATTACHMENT VALUES(SEQ_PROD_ATT_NO.NEXTVAL
                                       , 'product3_detail.jpg'
                                       , 'product3_detail.jpg'
                                       , '/resources/uploadFiles/product/'
                                       , null
                                       , 'Y'
                                       , 7);

INSERT INTO TB_PRODUCT_ATTACHMENT VALUES(SEQ_PROD_ATT_NO.NEXTVAL
                                       , 'product1_1.jpg'
                                       , 'product1_1.jpg'
                                       , '/resources/uploadFiles/product/'
                                       , '/resources/uploadFiles/product/thumb/'
                                       , 'Y'
                                       , 6);
INSERT INTO TB_PRODUCT_ATTACHMENT VALUES(SEQ_PROD_ATT_NO.NEXTVAL
                                       , 'product1_detail.jpg'
                                       , 'product1_detail.jpg'
                                       , '/resources/uploadFiles/product/'
                                       , null
                                       , 'Y'
                                       , 6);

INSERT INTO TB_PRODUCT_ATTACHMENT VALUES(SEQ_PROD_ATT_NO.NEXTVAL
                                       , 'product2_1.jpg'
                                       , 'product2_1.jpg'
                                       , '/resources/uploadFiles/product/'
                                       , '/resources/uploadFiles/product/thumb/'
                                       , 'Y'
                                       , 5);
INSERT INTO TB_PRODUCT_ATTACHMENT VALUES(SEQ_PROD_ATT_NO.NEXTVAL
                                       , 'product2_detail.jpg'
                                       , 'product2_detail.jpg'
                                       , '/resources/uploadFiles/product/'
                                       , null
                                       , 'Y'
                                       , 5);

INSERT INTO TB_PRODUCT_ATTACHMENT VALUES(SEQ_PROD_ATT_NO.NEXTVAL
                                       , 'product3_1.jpg'
                                       , 'product3_1.jpg'
                                       , '/resources/uploadFiles/product/'
                                       , '/resources/uploadFiles/product/thumb/'
                                       , 'Y'
                                       , 4);
INSERT INTO TB_PRODUCT_ATTACHMENT VALUES(SEQ_PROD_ATT_NO.NEXTVAL
                                       , 'product3_detail.jpg'
                                       , 'product3_detail.jpg'
                                       , '/resources/uploadFiles/product/'
                                       , null
                                       , 'Y'
                                       , 4);

INSERT INTO TB_PRODUCT_ATTACHMENT VALUES(SEQ_PROD_ATT_NO.NEXTVAL
                                       , 'product1_1.jpg'
                                       , 'product1_1.jpg'
                                       , '/resources/uploadFiles/product/'
                                       , '/resources/uploadFiles/product/thumb/'
                                       , 'Y'
                                       , 3);
INSERT INTO TB_PRODUCT_ATTACHMENT VALUES(SEQ_PROD_ATT_NO.NEXTVAL
                                       , 'product1_detail.jpg'
                                       , 'product1_detail.jpg'
                                       , '/resources/uploadFiles/product/'
                                       , null
                                       , 'Y'
                                       , 3);

INSERT INTO TB_PRODUCT_ATTACHMENT VALUES(SEQ_PROD_ATT_NO.NEXTVAL
                                       , 'product2_1.jpg'
                                       , 'product2_1.jpg'
                                       , '/resources/uploadFiles/product/'
                                       , '/resources/uploadFiles/product/thumb/'
                                       , 'Y'
                                       , 2);
INSERT INTO TB_PRODUCT_ATTACHMENT VALUES(SEQ_PROD_ATT_NO.NEXTVAL
                                       , 'product2_detail.jpg'
                                       , 'product2_detail.jpg'
                                       , '/resources/uploadFiles/product/'
                                       , null
                                       , 'Y'
                                       , 2);

INSERT INTO TB_PRODUCT_ATTACHMENT VALUES(SEQ_PROD_ATT_NO.NEXTVAL
                                       , 'product3_1.jpg'
                                       , 'product3_1.jpg'
                                       , '/resources/uploadFiles/product/'
                                       , '/resources/uploadFiles/product/thumb/'
                                       , 'Y'
                                       , 1);
INSERT INTO TB_PRODUCT_ATTACHMENT VALUES(SEQ_PROD_ATT_NO.NEXTVAL
                                       , 'product3_detail.jpg'
                                       , 'product3_detail.jpg'
                                       , '/resources/uploadFiles/product/'
                                       , null
                                       , 'Y'
                                       , 1);

-- 상품 옵션 (기본상품) 전체 추가 --
BEGIN
    FOR i IN 1..36 LOOP
        INSERT INTO TB_OPTION VALUES(
            SEQ_OPT_NO.NEXTVAL,
            '기본 상품', -- 옵션 이름
            NULL, -- 옵션 값
            0, -- 추가금액
            300, -- 재고수량
            i -- PROD_NO
        );
    END LOOP;
    COMMIT;
END;
/
-- 상품 옵션 (추가옵션1) 전체 추가 --
BEGIN
    FOR i IN 1..36 LOOP
        INSERT INTO TB_OPTION VALUES(
            SEQ_OPT_NO.NEXTVAL,
            '추가 옵션1', -- 옵션 이름
            '50ml', -- 옵션 값
            5000, -- 추가금액
            5, -- 재고수량
            i -- PROD_NO
        );
    END LOOP;
    COMMIT;
END;
/

-- 주문 샘플 데이터 --
BEGIN
    FOR order_no IN 1..15 LOOP
        INSERT INTO TB_ORDER (
            ORDER_NO, 
            RCVR_NAME, 
            RCVR_PHONE, 
            RCVR_ADDRESS, 
            DLVR_REQ_MESSAGE, 
            DLVR_STATUS, 
            DLVR_FEE, 
            DLVR_COMPANY, 
            DISPATCH_DATE, 
            COMPLETE_DATE, 
            ORDER_TOTAL_AMT, 
            PAYMENT_CODE, 
            PAYMENT_METHOD, 
            ORDER_DATE, 
            REFUND_DATE, 
            REFUND_REASON, 
            MEMBER_ID
        ) VALUES (
            SEQ_ORDER_NO.NEXTVAL, -- ORDER_NO 시퀀스로 생성
            '수령자' || TO_CHAR(order_no, 'FM000'), -- RCVR_NAME
            '010' || LPAD(TRUNC(DBMS_RANDOM.VALUE(10000000, 99999999)), 8, '0'), -- RCVR_PHONE
            '서울특별시 강남구 역삼동 ' || TO_CHAR(order_no, 'FM000') || '번지', -- RCVR_ADDRESS
            CASE 
                WHEN MOD(order_no, 5) = 0 THEN '배송 요청 사항 없음'
                WHEN MOD(order_no, 5) = 1 THEN '부재 시 경비실에 맡겨주세요.'
                WHEN MOD(order_no, 5) = 2 THEN '배송 전 연락 부탁드립니다.'
                ELSE NULL
            END, -- DLVR_REQ_MESSAGE
            '배송대기', -- DLVR_STATUS
            2500, -- DLVR_FEE
            CASE 
                WHEN MOD(order_no, 3) = 0 THEN 'CJ대한통운'
                WHEN MOD(order_no, 3) = 1 THEN '한진택배'
                ELSE '로젠택배'
            END, -- DLVR_COMPANY
            CASE 
                WHEN MOD(order_no, 4) = 0 THEN SYSDATE + TRUNC(DBMS_RANDOM.VALUE(1, 5)) -- DISPATCH_DATE
                ELSE NULL
            END, 
            CASE 
                WHEN MOD(order_no, 4) = 0 THEN SYSDATE + TRUNC(DBMS_RANDOM.VALUE(6, 10)) -- COMPLETE_DATE
                ELSE NULL
            END, 
            TRUNC(DBMS_RANDOM.VALUE(30000, 150000)), -- ORDER_TOTAL_AMT
            CASE 
                WHEN MOD(order_no, 4) = 0 THEN 'PAYCODE' || TO_CHAR(order_no, 'FM000')
                ELSE NULL
            END, -- PAYMENT_CODE
            CASE 
                WHEN MOD(order_no, 2) = 0 THEN '카드결제'
                ELSE '계좌이체'
            END, -- PAYMENT_METHOD
            SYSDATE - TRUNC(DBMS_RANDOM.VALUE(0, 30)), -- ORDER_DATE
            CASE 
                WHEN MOD(order_no, 10) = 0 THEN SYSDATE + TRUNC(DBMS_RANDOM.VALUE(1, 5)) -- REFUND_DATE
                ELSE NULL
            END, 
            CASE 
                WHEN MOD(order_no, 10) = 0 THEN '상품 파손으로 인한 환불 요청'
                ELSE NULL
            END, -- REFUND_REASON
            CASE 
                WHEN MOD(order_no, 3) = 0 THEN 'user01'
                WHEN MOD(order_no, 3) = 1 THEN 'user02'
                ELSE 'user03'
            END -- MEMBER_ID
        );
    END LOOP;
    COMMIT;
END;
/


-- 상품별 50개의 문의글 및 답변 데이터 삽입
DECLARE
    v_inquiry_no NUMBER; -- 문의 번호 저장
    v_max_product_no NUMBER; -- 최대 상품 번호
    v_member_ids SYS.ODCIVARCHAR2LIST := SYS.ODCIVARCHAR2LIST('user01', 'user02', 'user03');
    v_inquiry_content SYS.ODCIVARCHAR2LIST := SYS.ODCIVARCHAR2LIST(
        '배송이 언제 되나요?',
        '재고가 부족한가요?',
        '상품 정보가 궁금합니다.',
        '할인 이벤트는 없나요?',
        '사용법이 복잡해요.'
    );
    v_reply_content SYS.ODCIVARCHAR2LIST := SYS.ODCIVARCHAR2LIST(
        '오늘 발송 예정입니다.',
        '현재 재고가 충분합니다.',
        '상품 설명서를 참고해 주세요.',
        '할인 이벤트는 다음 주에 시작됩니다.',
        '자세한 사용법은 설명서를 확인해 주세요.'
    );
BEGIN
    -- TB_PRODUCT의 최대 상품 번호 가져오기
    SELECT MAX(PROD_NO) INTO v_max_product_no FROM TB_PRODUCT;

    FOR p IN 1..v_max_product_no LOOP -- 모든 상품 반복
        FOR i IN 1..50 LOOP -- 한 상품당 50개의 문의글 생성
            -- 상품 문의글 삽입
            INSERT INTO TB_INQUIRY (
                INQUIRY_NO, 
                INQUIRY_CONTENT, 
                INQUIRY_TYPE, 
                INQUIRY_ANSWERED_YN, 
                INQUIRY_STATUS, 
                MEMBER_ID, 
                PROD_NO
            ) VALUES (
                SEQ_INQUIRY_NO.NEXTVAL,
                v_inquiry_content(TRUNC(DBMS_RANDOM.VALUE(1, 6))), -- 랜덤 문의 내용
                '상품', -- 문의 유형
                'Y',    -- 답변 여부 (답변 있음)
                DEFAULT, -- 상태값 (디폴트 'Y')
                v_member_ids(MOD(i, 3) + 1), -- 작성자 순환: user01, user02, user03
                p -- 상품 번호
            )
            RETURNING INQUIRY_NO INTO v_inquiry_no;

            -- 답변 삽입
            INSERT INTO TB_INQUIRY_REPLY (
                INQUIRY_REPLY_NO,
                INQUIRY_REPLY_CONTENT,
                INQUIRY_REPLY_STATUS,
                INQUIRY_NO,
                MEMBER_ID
            ) VALUES (
                SEQ_INQUIRY_REPLY_NO.NEXTVAL,
                v_reply_content(TRUNC(DBMS_RANDOM.VALUE(1, 6))), -- 랜덤 답변 내용
                DEFAULT, -- 상태값 (디폴트 'Y')
                v_inquiry_no, -- 삽입된 문의 번호
                'admin' -- 답변 작성자
            );
        END LOOP;
    END LOOP;

    COMMIT;
END;
/


-- 상품 주문 데이터 생성 (ORDER_NO 기준 1옵션당 1주문)
BEGIN
    -- ORDER_NO를 기준으로 상품 주문 데이터 삽입
    FOR order_rec IN (SELECT DISTINCT ORDER_NO FROM TB_ORDER) LOOP
        -- 상품 주문 생성: 하나의 ORDER_NO당 여러 옵션을 추가
        FOR opt_no IN 81..98 LOOP
            INSERT INTO TB_PRODUCT_ORDER VALUES(
                SEQ_SERIAL_NO.NEXTVAL, -- SERIAL_NO
                1,                     -- 주문 수량
                38000,                 -- 총 금액
                order_rec.ORDER_NO,    -- ORDER_NO
                opt_no                 -- OPT_NO
            );
        END LOOP;
    END LOOP;

    COMMIT; -- 변경 사항 저장
END;
/
                    
-- 리뷰 샘플 데이터 생성 (실제 주문당 1리뷰)
DECLARE
    v_review_content SYS.ODCIVARCHAR2LIST := SYS.ODCIVARCHAR2LIST(
        '이 제품 정말 좋아요!',
        '효과가 만족스럽습니다.',
        '배송이 빨랐어요.',
        '기대 이상입니다. 추천합니다!',
        '디자인이 마음에 들어요.'
    );
    v_index NUMBER := 0; -- 리뷰 내용 순환용 인덱스
BEGIN
    -- TB_PRODUCT_ORDER의 SERIAL_NO마다 리뷰 생성
    FOR rec IN (
        SELECT PO.SERIAL_NO, O.MEMBER_ID
        FROM TB_PRODUCT_ORDER PO
        JOIN TB_ORDER O ON PO.ORDER_NO = O.ORDER_NO
    ) LOOP
        -- 리뷰 데이터 삽입
        v_index := v_index + 1;

        INSERT INTO TB_REVIEW (
            REV_NO,
            REV_CONTENT,
            REV_RATING,
            REV_STATUS,
            SERIAL_NO,
            MEMBER_ID
        ) VALUES (
            SEQ_REV_NO.NEXTVAL, -- 리뷰 번호 시퀀스
            v_review_content(MOD(v_index, 5) + 1), -- 순환 리뷰 내용
            TRUNC(DBMS_RANDOM.VALUE(3, 6)), -- 랜덤 별점 (3~5)
            'Y', -- 리뷰 상태 활성화
            rec.SERIAL_NO, -- SERIAL_NO
            rec.MEMBER_ID -- 실제 주문한 사용자 ID
        );
    END LOOP;

    COMMIT;
END;
/
-- 리뷰 작성용 상품 주문 데이터 생성 (34, 35, 36 상품에 주문정보 추가)
BEGIN
    -- ORDER_NO를 기준으로 상품 주문 데이터 삽입
    FOR order_rec IN (SELECT DISTINCT ORDER_NO FROM TB_ORDER) LOOP
        -- 상품 주문 생성: 하나의 ORDER_NO당 여러 옵션을 추가
        FOR opt_no IN 49..50 LOOP
            INSERT INTO TB_PRODUCT_ORDER VALUES(
                SEQ_SERIAL_NO.NEXTVAL, -- SERIAL_NO
                1,                     -- 주문 수량
                38000,                 -- 총 금액
                order_rec.ORDER_NO,    -- ORDER_NO
                opt_no                 -- OPT_NO
            );
        END LOOP;
    END LOOP;

    COMMIT; -- 변경 사항 저장
END;
/


COMMIT;