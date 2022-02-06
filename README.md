# :pushpin: Bundduek
>누구나 크리에이터가 되어 본인의 아이디어를 세상에 내놓을 수 있는 크라우드펀딩 플랫폼  
>http://3.37.218.252:8080/  

</br>

## 1. 제작 기간 & 참여 인원
- 2021년 11월 15일 ~ 12월 15일
- 팀 프로젝트 (5명)

</br>

## 2. 사용 기술
#### `Back-end`
  - Java 8
  - Spring Boot 2.5
  - Maven 3.8
  - MyBatis 2.2
  - MySQL 8
#### `Front-end`
  - HTML5
  - JavaScript
  - JQuery 2.2
  - CSS
  - BootStrap 4.1
  
</br>

## 3. ERD 설계
<img src="https://user-images.githubusercontent.com/84839167/148019551-4897a90d-bf4e-4895-8ba2-1fadd0ef65be.png" width="550px" height="400px" title="erd" alt="ERD"></img>

<br/>

## 4. 기능 구현
이 서비스에서 제가 구현한 기능은 등록된 펀딩 프로젝트의 `상세페이지`와 프로젝트 `결제(후원)` 기능입니다.  
사용자는 원하는 프로젝트의 상세 내용을 볼 수 있으며, 선물(제품)을 선택한 후 결제(후원)를 완료합니다.
<details>
<summary><b>핵심 기능 설명 펼치기</b></summary>
<div markdown="1">
  
### 4.1. 전체 흐름
![flow](https://user-images.githubusercontent.com/84839167/148017767-2b4df319-6119-40c5-af8a-99bd185a4ad6.jpg)
  
### 4.2. Controller
![controller](https://user-images.githubusercontent.com/84839167/148033035-514d2a0d-8125-4e1b-8422-8b3f2e1e3645.jpg)
- **요청 처리** :pushpin: [코드 확인](https://github.com/jeejee1106/FinalProject_Bunddeuk/blob/93d3e30a44ad5838b36332b8ae8f968419dc9fb7/src/main/java/data/project/DetailController.java#L22)
  - Controller에서는 화면단에서 넘어온 요청을 받고, Service, Mapper Interface를 통해 사용자가 요청한 정보를 불러옵니다.
- **결과 응답** :pushpin: [코드 확인](https://github.com/jeejee1106/FinalProject_Bunddeuk/blob/93d3e30a44ad5838b36332b8ae8f968419dc9fb7/src/main/webapp/WEB-INF/project_detail/projectDetail.jsp#L189)
  - Service 계층에서 넘어온 로직 처리 결과를 화면단에 응답해줍니다.
  - 사용자가 리스트에서 선택한 프로젝트의 정보가 상세페이지가 나타나게 됩니다.

### 4.3. Service
![service](https://user-images.githubusercontent.com/84839167/148083716-4f125f91-9c93-4c39-a0f5-f9af19e5a3e5.png)
- **상세 페이지 Mapper Method 호출** :pushpin: [코드 확인](https://github.com/jeejee1106/FinalProject_Bunddeuk/blob/93d3e30a44ad5838b36332b8ae8f968419dc9fb7/src/main/java/data/project/DetailService.java#L12)
  - Service는 프로젝트의 상세페이지와 사용자의 정보를 받을 Method를 호출합니다.
  - 이때 호출된 Method는 MyBatis와 연결 되며, db에서 사용자의 정보나 프로젝트의 정보 등을 가져오며,
  - 사용자가 해당 프로젝트를 찜 했는지, 또는 이미 후원을 했는지, 기본 정보가 입력이 되어  등을 체크합니다.
  - key값을 넣어 value값을 받아야 한다면 HashMap에 넣어 보내줍니다.
  - (parameter의 데이터 타입이 int, String으로 다른 타입이기 때문에 Value값은 Object로 받았습니다.)

### 4.4. Mapper
![mapper](https://user-images.githubusercontent.com/84839167/148793806-73537088-8063-4089-955a-766a9747fc0a.png)
- **컨텐츠 저장** :pushpin: [코드 확인](https://github.com/jeejee1106/FinalProject_Bunddeuk/blob/93d3e30a44ad5838b36332b8ae8f968419dc9fb7/src/main/resources/mappers/supportSQL.xml#L3)
  - 결제(후원)를 완료하면 Mapper.xml 파일에서 SQL문을 실행하며, 실행 결과를 다시 반환 합니다.
  - 결제(후원)을 완료한 사용자와 프로젝트 정보는 DB에 저장됩니다.
  - 저장된 컨텐츠는 다시 Mapper - Service - Controller를 거쳐 화면단에 출력됩니다.
</div>
</details>

</br>

## 5. 핵심 트러블 슈팅

### 5.1. 정기결제 시스템
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
- 아래 **개선된 코드**와 같이 아임포트의 설정을 변경하고 customer_uid로 빌링키를 발급받아  
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
  <summary><b>주소 출력시 도로명 주소와 상세주소의 위치가 바뀌어서 출력됨</b></summary>
  <div markdown="1">
  
```xml
<!-- 주소데이터가 없는 멤버의 주소를 x로 출력 -->
<select id="getAddr" parameterType="String" resultType="ddto">
  select ifnull(max(addr),'x')as addr, ifnull(max(addr2),'x') as addr2 from delivery where id=#{id} and pin=1
</select>
```
  
  - addr과 addr2의 위치를 바꿔썼었음. 올바른 위치로 바꿔주니 정상적으로 출력
</div>
</details>
    
<details>
  <summary><b>텀플벅 프로젝트 데이터의 저작권 문제</b></summary>
  <img src="https://user-images.githubusercontent.com/84839167/149295215-f4ee4f1e-ed38-4a9e-9e1c-cd5e361431a6.png" width="250px" height="300px" title="erd" alt="message"></img>
  
  - 텀블벅 사이트의 창작자님들 한 분 한 분께 메세지를 보낸 후 허락해주신 창작자님의 프로젝트만 데이터로 사용하여 문제 해결
</details>
</br>

## 7. 회고 / 느낀점  
> <b>프로젝트 개발 회고 글 :</b> [Final Project를 마치고. (tistory blog)](https://jee2memory.tistory.com/entry/2021%ED%9A%8C%EA%B3%A0-Final-Project%EB%A5%BC-%EB%A7%88%EC%B9%98%EA%B3%A0)    

<br/>

> <b>블로그에 작성한 글을 일부 발췌한 내용입니다.</b>
>  
> <b>6-2. 잘한 점, 아쉬운 점</b>  
> <b>6-2-1. 잘한 점</b>
> <details>
>  <summary>팀 노션을 통해 진행상황 등 기록하고 공유하기</summary>
>  
>  > 조장을 맡기 전부터 협업을 효율적으로 할 수 있는 방법이 뭐가 있을까 자주 고민했다. 효율적인 협업을 위해선 소통이 잘 되어야 한다고 생각했다.  
>  > 나는 소통의 창구로 '노션'을 선택했는데, 팀원들은 노션을 사용해보지 않았지만 사용법이 간단해 금방 적응해서 사용할 수 있고, 필요한 페이지를 무제한으로 만들수 있기 때문에 소통을  위한 최적의 도구라고 판단했다.  
  >  노션엔 팀규칙과 코딩규칙을 기록해 놓았고, 각자의 진행상황, 참고할만한 사이트, 회의 내용 등을 기록했다. 덕분에 따로 연락하지 않고도 진행상황을 한 눈에 알 수 있었고, 효율적으로 소통을 할 수 있었다.
> </details>
> 
> <details>
>  <summary>결제 시스템 구현</summary>
>  
>  > 아마 대부분의 프로젝트엔 결제기능이 필요할 것이라고 생각한다. 프로젝트 시작 전부터 결제 기능을 구현하는 것이 어렵다는 말을 많이 들었다. 그래서 우리는 '되면 좋고 안되면 말고'라는 마음으로 프로젝트를 시작했다.  
  > 그러나 나는 다들 어렵다는 그 결제를 구현해보고 싶었다. 그렇게 며칠간 구글링과 삽질을 반복한 끝에 결제 기능을 구현할 수 있었다. 결제를 구현한 팀은 우리 팀밖에 없었고, 다른 팀들과는 확실이 구분되는 고급(?)기능이었다.
> </details>
>
> <details>
>  <summary>텀플벅에 저작권 동의 받기</summary>
>  
>  > 프로젝트 마감 5일전, 한 팀원이 말했다. "텀블벅에 있는 펀딩프로젝트 우리가 막 끌어와서 써도돼? 유튜브에도 올라갈 건데 저작권 걸리는거 아니야?" 아뿔싸. 저작권 생각을 못했다.  
  > 그렇다고 우리가 프로젝트 데이터를 하나하나 생각해서 넣기엔 시간도, 아이디어도 당연히 부족했다. 나는 바로 텀블벅에 문의를 하여 프로젝트를 사용해도 되냐는 문의를 남겼고, 텀블벅 측에선 창작자분들이 허락하면 사용해도 괜찮다는 답을 받았다.  
  > 그렇게 텀블벅의 창작자님들 한 분 한 분께 메세지를 남겼고(총 50분께 허락을 구했다.) 사용을 허락해주신 창작자님들의 펀딩프로젝트를 우리의 서비스에 등록할 수 있었다. 저작권 문제나 디자인 유출 문제로 허락해주지 않으신 창작자분들도 계셨기 때문에 저작권 동의를 받은건 정말 잘한 일이라고 생각한다.
> </details>
>
> <details>
>  <summary>마감 일주일 전까지 진행률 90%를 목표로 잡고 미리 테스트 했던 점</summary>
>  
>  > 우리는 프로젝트 마감일에 딱 맞춰 완성을 하기 보단, 기능 구현을 빠르게 마무리 지은 후 남은 일주일 동안 버그를 잡거나, 세세한 부분 수정하면서 여유로운 마감을 하기로 정했다.  
  > 모든 팀원들이 일정에 맞춰 기능 구현을 완료해 주었고, 남은 기간 버그를 잡으면서 우리의 바램대로 여유로운 마감을 할 수 있었다.  
  > 덕분에 위 저작권 관련 문제도 스무스하게 해결할 수 있었다. 기능구현도 못한 상태에서 저 상황을 맞이했더라면...어휴..끔찍하다.
> </details>
>
> <b>6-2-2. 아쉬운 점</b>  
> <details>
>  <summary>깃 브랜치를 제대로 활용하지 못함</summary>
>  
>  > 학원에 다니기 전부터 예습을 통해 깃을 사용해본 덕분에, 남들보다 깃 사용에 익숙했다.  
  > 그러나 겉핥기 식으로 공부했고, 깃 명령어를 쓰기 보다는 이클립스의 기능으로 깃헙에 소스를 올렸기 때문에 협업을 위한 깃 지식은 많이 부족했다.  
  > 가령 새로운 아이디어로 뭔가를 시도해보고 싶을 때 새로운 브랜치를 만들어 거기서 작업하면 되는데, 우리는 모두 프로젝트를 복사한 후 복사한 프로젝트에서 기능을 구현해보고, 그 파일을 다시 원래의 프로젝트에 복사 붙여넣기를 하는 효율성 제로의 작업을 했다.  
  > '잠깐, 브랜치를 만들면 되지 않나?? 우리 왜 다 복붙하고 있었지??' 라는 생각이 들었던 건 마감 하루 전날이었다...ㅎㅎ
> </details>
>
> <details>
>  <summary>아작스에 대한 이해가 부족함</summary>
> 
>  > 프로젝트 시작 전부터 나는 아작스에 많이 약했다. 그래서 아작스를 더 자세히 알고 싶었는데, 이번 프로젝트에서도 강사님과 배운 코드를 그대로 사용하거나, 구글링을 통해 아작스를 사용했다.  
  > 프로젝트를 진행하면서 이해를 했으면 좋았을텐데, 제대로 이해하지도 못한 채로 사용했던 것이 아직도 많이 아쉽다.
> </details>
>
> <details>
>  <summary>기능 구현 전 지레 겁을 먹음</summary>
>  
>  > 나는 결제 기능과 찜 기능을 구현했다. 시작 전 부터 두 기능 모두 구현하기 어렵고 복잡하다는 말을 많이 들었다. 그래서 나는 해보지도 않고 어떻게해ㅜㅜ 어떻게 하지??ㅜㅜ 라는 생각으로 시도조차 안하며 구글링만 몇시간을 했었다. 찜 기능 같은 경우는 구글링을 해도 감이 오지 않아서 냅다 코드를 짜봤다. 근데 웬걸? 두 시간만에 찜 기능을 모두 완성할 수 있었다. 기능구현보다 어려웠던건 오히려 하트 색을 바뀌게 하는 css였다....  
  > 그런데 다른 팀들은 적게는 3일, 많게는 일주일이 걸렸다는 말을 듣고 어..? 나 뭐 잘못했나..? 내 기능에 하자가 있나..? 하는 생각이 자꾸 든다. 기능은 잘 되고 있는데.....  
  > 뭐든지 걱정부터 하지 말고 일단 해보는 것이 나에게 잘 맞는 방법이라는 걸 다시 한 번 깨달았다.
> </details>
>
> <details>
>  <summary>DB설계를 제대로 하지 않고 프로젝트를 진행한 점</summary>
>  
>  > 나는 프로젝트를 본격적으로 시작하기 전에 주제를 정하고, 요구사항을 정의하고, 파트를 나누는 것으로 회의를 마쳤다.  
  > 물론 테이블에 대한 얘기도 나왔지만 member, project 테이블을 메인 테이블로 잡고 나머지는 기능 구현하면서 추가하는 걸로 결론을 내렸다. 이게 가장 큰 실수였다.  
  > 프로젝트 시작 전 DB설계를 먼저 해야한다는 사실을 며칠전에 알았다... 그러나 아직도 DB설계를 어느정도까지 한 후 프로젝트를 시작해야 하는지 잘 모르겠다. 어차피 프로젝트가 진행되면 미리 짜놓은 구조에 변경이 생길거고, 수정해야할텐데... 이 부분은 더 공부해봐야지.  
  > 어쨋든 우리는 너무 대략적으로만 짜놓았기 때문에 프로젝트를 진행하면서 테이블 구조를 짜는데 꽤나 골머리를 썩혔었다. 다음부터는 아주 세세하게는 아니더라도 틀을 튼튼하게 만들고 시작해야지.
> </details>
