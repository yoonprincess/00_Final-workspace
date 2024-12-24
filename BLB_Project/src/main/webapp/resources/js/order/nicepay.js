// NicePay Server Auth Payment
function serverAuth() {

    AUTHNICE.requestPay({
        
      clientId: 'S2_af4543a0be4d49a98122e01ec2059a56',
      method: 'card',
      orderId: '634d6c22-9aff-43cb-b9b0-d56ce72484be',
      amount: 1004,
      goodsName: '나이스페이-상품',
      returnUrl: 'http://localhost:3000/serverAuth', // API를 호출할 Endpoint 입력
      fnError: function (result) {
        alert('개발자확인용 : ' + result.errorMsg);
      }
    });
  }
  