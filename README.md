# [팀프로젝트] Bundduek - 번뜩💡

### 🌏[Bundduek 바로가기](http://3.37.218.252:8080/)  
- <b>`번뜩은 본인만의 멋진 아이디어를 세상에 내놓을 수 있는 크라우드펀딩 플랫폼입니다.`</b>
- 팀프로젝트로 일반적인 쇼핑몰 보다 색다른 사이트를 만들고 싶었습니다.
- 그 결과 쇼핑몰과 비슷한 성격이지만, 여러 기능이 더해진 <b>펀딩사이트</b>를 제작하게 되었습니다.   
- 대표적인 크라우드펀딩 사이트인 <b>텀블벅</b>을 벤치마킹하여 개발하였습니다.
- 현재 리팩토링을 진행하고 있는 프로젝트 입니다.

<br>

## 1. 제작 기간 & 참여 인원
- 2021년 11월 15일 ~ 12월 15일
- 팀 프로젝트 (5명)

<br>

## 2. 사용 기술
### `Back-end`
  - Java 8
  - Spring Boot 2.5
  - Maven 3.8
  - MyBatis 2.2
  - MySQL 8
### `Front-end`
  - HTML5
  - JavaScript
  - JQuery 2.2
  - CSS
  - BootStrap 4.1
  
<br>

## 3. ERD 설계
<img src="https://user-images.githubusercontent.com/84839167/148019551-4897a90d-bf4e-4895-8ba2-1fadd0ef65be.png" width="550px" height="400px" title="erd" alt="ERD"></img>

<br>

## 4. 기능 구현
  - #### `정기결제`
    - Open API(아임포트)를 활용한 카카오 정기결제 기능 구현

  - #### `쪽지 보내기`
    - 사용자 간 쪽지를 주고 받을 수 있도록 쪽지 전송 기능 구현

  - #### `Front-end`
    - Javascript, J-Query를 사용해 메인페이지 & 상세페이지 제작

<br>

## 5. 핵심 기능 설명 & 트러블 슈팅
#### 1. Open API를 활용한 카카오 정기결제
<details>
  <summary>📌핵심 기능 설명</summary>

#### 1. 전체 흐름
![flow](https://user-images.githubusercontent.com/84839167/148017767-2b4df319-6119-40c5-af8a-99bd185a4ad6.jpg)
  
#### 2. Controller
![controller](https://user-images.githubusercontent.com/84839167/148033035-514d2a0d-8125-4e1b-8422-8b3f2e1e3645.jpg)
- **요청 처리** :pushpin: [코드 확인](https://github.com/jeejee1106/FinalProject_Bunddeuk/blob/93d3e30a44ad5838b36332b8ae8f968419dc9fb7/src/main/java/data/project/DetailController.java#L22)
  - Controller에서는 화면단에서 넘어온 요청을 받고, Service, Mapper Interface를 통해 사용자가 요청한 정보를 불러옵니다.
- **결과 응답** :pushpin: [코드 확인](https://github.com/jeejee1106/FinalProject_Bunddeuk/blob/93d3e30a44ad5838b36332b8ae8f968419dc9fb7/src/main/webapp/WEB-INF/project_detail/projectDetail.jsp#L189)
  - Service 계층에서 넘어온 로직 처리 결과를 화면단에 응답해줍니다.
  - 사용자가 리스트에서 선택한 프로젝트의 정보가 상세페이지가 나타나게 됩니다.

#### 3. Service
![service](https://user-images.githubusercontent.com/84839167/148083716-4f125f91-9c93-4c39-a0f5-f9af19e5a3e5.png)
- **상세 페이지 Mapper Method 호출** :pushpin: [코드 확인](https://github.com/jeejee1106/FinalProject_Bunddeuk/blob/93d3e30a44ad5838b36332b8ae8f968419dc9fb7/src/main/java/data/project/DetailService.java#L12)
  - Service는 프로젝트의 상세페이지와 사용자의 정보를 받을 Method를 호출합니다.
  - 이때 호출된 Method는 MyBatis와 연결 되며, db에서 사용자의 정보나 프로젝트의 정보 등을 가져오며,
  - 사용자가 해당 프로젝트를 찜 했는지, 또는 이미 후원을 했는지, 기본 정보가 입력이 되어  등을 체크합니다.
  - key값을 넣어 value값을 받아야 한다면 HashMap에 넣어 보내줍니다.
  - (parameter의 데이터 타입이 int, String으로 다른 타입이기 때문에 Value값은 Object로 받았습니다.)

#### 4. Mapper
![mapper](https://user-images.githubusercontent.com/84839167/148793806-73537088-8063-4089-955a-766a9747fc0a.png)
- **컨텐츠 저장** :pushpin: [코드 확인](https://github.com/jeejee1106/FinalProject_Bunddeuk/blob/93d3e30a44ad5838b36332b8ae8f968419dc9fb7/src/main/resources/mappers/supportSQL.xml#L3)
  - 결제(후원)를 완료하면 Mapper.xml 파일에서 SQL문을 실행하며, 실행 결과를 다시 반환 합니다.
  - 결제(후원)을 완료한 사용자와 프로젝트 정보는 DB에 저장됩니다.
  - 저장된 컨텐츠는 다시 Mapper - Service - Controller를 거쳐 화면단에 출력됩니다.
</details>
<details>
  <summary>⚽트러블 슈팅</summary>
  
  #### `정기결제가 아닌 일반 결제로 동작함`
- 저는 이 서비스에서 결제 시스템을 꼭 구현하고자 했습니다.  
- 처음엔 결제 API를 끌어다 쓴 후 기능 구현이 끝났다고 생각했습니다.
- 그러나 아래의 **일반 결제 코드 및 설정** 으로 기능을 구현하니 후원 후 바로 결제가 되는 문제가 발생했습니다.
<details>
<summary><b>일반 결제 코드 및 설정</b></summary>
<div markdown="1">
  
```javascript
//카카오 결제 API
var IMP = window.IMP; // 생략가능
IMP.init('impxxxxxxxx');  // 가맹점 식별코드
// IMP.request_pay(param, callback) 결제창 호출
IMP.request_pay({ // param
    pg : 'kakaopay', //pg사 선택 (kakao, kakaopay 둘다 가능)
    pay_method: 'card',
    merchant_uid : 'merchant_' + new Date().getTime(), //주문번호
    name : 'Bunddeuk', // 상품명
    amount : amount,
    buyer_email : email,
    buyer_name : buyer_name,
    buyer_tel : hp,
    buyer_addr : addr,
}, function (rsp) { //callback
    if (rsp.success) {
      // 결제 성공 시 로직
      alert("결제가 완료되었습니다");
    } else {
      // 결제 실패 시 로직
      var msg = '결제에 실패하였습니다.\n';
      msg += rsp.error_msg;
      alert(msg);
      return false;
    }
  $("#final-support-submit").submit();
});
```
  
</div>

  <img src="https://user-images.githubusercontent.com/84839167/149270444-d36a4324-6d5a-41ab-981f-c642bed8c941.png" width="850px" height="200px" title="erd" alt="basic2"></img>
  <img src="https://user-images.githubusercontent.com/84839167/149270436-97ff98ef-865b-4404-bcc5-611361157543.png" width="250px" height="300px" title="erd" alt="basic1"></img>
  
</details>

- 일반결제는 즉시 결제가 완료되었다는 메세지가 오며, 아임포트의 결제 내역에도 결제금액이 바로 출력됩니다.
- 저희 서비스는 펀딩 프로젝트 선택 후 바로 결제하는 시스템이 아닌, 지정된 날짜에 맞춰서 결제가 진행되는  
`정기 결제 시스템`이 필요했기 때문에  
- 아래 **개선된 코드**와 같이 아임포트의 설정을 변경하고 customer_uid로 빌링키를 등록해  
정기결제 시스템을 구현할 수 있었습니다.
<details>
<summary><b>개선된 코드</b></summary>
  
<div markdown="1">
  
```javascript
//카카오 결제 API
var IMP = window.IMP; // 생략가능
IMP.init('impxxxxxxxx');  // 가맹점 식별코드
// IMP.request_pay(param, callback) 결제창 호출
IMP.request_pay({
    pg : 'kakaopay', //pg사 선택 (kakao, kakaopay 둘다 가능)
    pay_method: 'card',
    merchant_uid : 'merchant_' + new Date().getTime(), //주문번호
    name : 'Bunddeuk', // 상품명
    amount : amount,
    //customer_uid 파라메터가 있어야 빌링키 발급을 시도함
    customer_uid : buyer_name + new Date().getTime(),
    buyer_email : email,
    buyer_name : buyer_name,
    buyer_tel : hp,
    buyer_addr : addr,
}, function(rsp) { //callback
    if ( rsp.success ) {
      console.log('빌링키 발급 성공', rsp)
      //빌링키 발급이 완료되었으므로, 서버에 결제 요청
      alert('예약 결제가 완료되었습니다!');
    } else {
      var msg = '결제에 실패하였습니다.\n';
      msg += rsp.error_msg;
      alert(msg);
      return false;
    }
    $("#final-support-submit").submit();
});
```
  
</div>
  
  <img src="https://user-images.githubusercontent.com/84839167/149270453-e7a18a12-ec8f-4128-a221-2d0a54ef8fe0.png" width="850px" height="200px" title="erd" alt="reservation2"></img>
  <img src="https://user-images.githubusercontent.com/84839167/149270446-a5947e6d-1fae-4d13-9bc6-dd097c3eac98.png" width="250px" height="300px" title="erd" alt="reservation1"></img>
  
</details>

- 코드를 개선한 후 정기결제가 완료되었다는 메세지로 바뀌었고, 아임포트의 결제 내역에도 0원이 출력된 것을 확인할 수 있습니다.
</details>

<br>

## 6. 그 외 트러블 슈팅

<details>
<summary><b>MySQL사용 시 한글 데이터는 insert안되는 문제</b></summary>
<div markdown="1">
  
```sql
CREATE TABLE  noticeboard1 (
  name varchar(30)
) DEFAULT CHARSET=utf8;
```
  
  - 처음 테이블을 생성할 때 **DEFAULT CHARSET=utf8;** 를 써줘서 해결
  - ALTER DATABASE database_name DEFAULT CHARACTER SET utf8; 명령어로 CHARACTER SET을 변경해주는 방법도 있다.
  
</div>
</details>

<details>
  <summary><b>테이블 구조를 충분히 생각하지 않은 채 프로젝트 진행</b></summary>
  <img src="https://user-images.githubusercontent.com/84839167/149280500-69e0ee59-98c7-4588-8c95-d9ec43f5890c.jpg" width="400px" height="250px" title="erd" alt="table"></img>
  
  - 프로젝트 시작 후 혼자 짰던 테이블 구조.
  - 나중에야 DB설계를 먼저 해야한다는 것을 깨달았다. 앞으로는 DB설계에 조금 더 많은 시간을 투자한 후 프로젝트를 시작해야겠다.
</details>

<details>
  <summary><b>선물 정보를 GET으로 보냈을 때 주소창에 특수문자 꺽쇠< > 가 들어가면 에러남</b></summary>
    
  - 특수문자를 인코딩 해주는 방법과 Mapping을 GET에서 POST로 바꿔주는 방법이 있는데,  
  Mapping을 바꿔주는 방법으로 문제 해결
</details>
    
<details>
  <summary><b>텀플벅 프로젝트 데이터의 저작권 문제</b></summary>
  <img src="https://user-images.githubusercontent.com/84839167/149295215-f4ee4f1e-ed38-4a9e-9e1c-cd5e361431a6.png" width="250px" height="300px" title="erd" alt="message"></img>
  
  - 텀블벅 사이트의 창작자님들 한 분 한 분께 메세지를 보낸 후 허락해주신 창작자님의 프로젝트만 데이터로 사용하여 문제 해결
</details>
</br>

## 7. 회고 / 느낀점  
- <b>프로젝트 개발 회고 글 :</b> [Final Project를 마치고. (tistory blog)](https://jee2memory.tistory.com/entry/2021%ED%9A%8C%EA%B3%A0-Final-Project%EB%A5%BC-%EB%A7%88%EC%B9%98%EA%B3%A0)    

<br/>

`블로그에 작성한 글의 일부 입니다.`
  
 <b>6-2-1. 잘한 점</b>
  * 팀 노션을 통해 진행상황 등 기록하고 공유하기
  * 결제 시스템 구현
  * 텀플벅에 저작권 동의 받기
  * 마감 일주일 전까지 진행률 90%를 목표로 잡고 미리 테스트 했던 점


<br>

 <b>6-2-2. 아쉬운 점</b>  
  * 깃 브랜치를 제대로 활용하지 못함
  * 아작스에 대한 이해가 부족함
  * 기능 구현 전 지레 겁을 먹음
  * DB설계를 제대로 하지 않고 프로젝트를 진행한 점
 
