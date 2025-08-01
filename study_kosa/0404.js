// [문제]

// (1번 문제: 난이도 쉬움)
// 아래 코드가 실행되었을 때 콘솔에 출력되는 값을 구하는 문제입니다.

// ```js
// var data = 10;

// function func() {
//   this.data = 20;
//   data = 30;

//   console.log("1. data: " + data); //30
//   console.log("2. this.data: " + this.data); //20
//   console.log("3. window.data: " + window.data); //30
// }

// func();
// ```
// 위 코드가 실행되었을 때, 각 console.log가 출력하는 내용을 작성하세요.

// ---

// (2번 문제: 난이도 중간)
// 다음 코드를 수정하여, “Hello”를 출력한 직후 1초 뒤에 “World”를 출력하도록 콜백 함수를 사용해 완성하세요.

// ```js
function printHello() {
  console.log("Hello");
}

function printWorld() {
  setTimeout(() => console.log("World"), 1000);
}
printHello();
printWorld();
// // 콜백 함수를 이용해서, "Hello"를 출력하고 1초 뒤에 "World"가 출력되도록 작성해보세요.
// ```

// ---

// (3번 문제: 난이도 어려움)
// Promise를 활용해 다음 요구사항을 충족하는 코드를 작성하세요.

// 1. getDelayPromise 함수는 인자로 받은 초(second) 뒤에 "완료"라는 문자열을 resolve하는 Promise를 반환해야 합니다.
// 2. 이 함수를 활용하여, 2초 뒤에 "첫 번째 완료", 이어서 1초 뒤에 "두 번째 완료"를 차례대로 콘솔에 출력하세요.
// 3. 첫 번째 완료 직후 "첫 번째 종료"라는 문구를 한 번 더 콘솔에 출력한 뒤, “두 번째 완료”가 나오도록 then 체인을 구성하세요.

// (출력 예시)
// ```
// 2초 후에 첫 번째 완료
// 첫 번째 종료
// 1초 후에 두 번째 완료
// ```

// ---

// (4번 문제: 난이도 매우 어려움)
// 아래 조건에 따라 지하철 요금을 계산하는 함수를 작성하고, 이를 async/await와 결합하여 시뮬레이션하는 코드를 완성하세요.

// 1. calcFare(distance, ageType) 라는 함수를 만드세요.
//    - distance (km 단위 정수): 이동 거리
//    - ageType: 'ADULT', 'YOUNG', 'CHILD' 세 가지 중 하나
//    - 요금 계산 규칙
//      - 10km 이하: 기본요금
//        (성인: 1250, 청소년: 720, 어린이: 450)
//      - 10~50km: 10km를 제외한 나머지 거리에 대하여 5km마다 100원 추가
//      - 50km 초과: 앞선 계산(10~50km)까지 더한 후, 50km 초과 구간은 8km마다 100원 추가
// 2. 위 calcFare 함수를 Promise 형태로 감싸서, 2초 후에 결과를 resolve하도록 구현하세요.
// 3. async/await를 활용해 다음 순서대로 계산 과정을 시뮬레이션하세요.
//    - distance = 8, ageType = 'ADULT' → 결과 출력
//    - distance = 37, ageType = 'YOUNG' → 결과 출력
//    - distance = 52, ageType = 'CHILD' → 결과 출력
//    - 각 단계 사이마다 2초씩 지연을 두어, 마치 데이터를 서버에서 받아오는 것처럼 동작하게 하세요.

// (출력 예시)
// ```
// 성인(8km) 요금: 1250원
// 청소년(37km) 요금: XXX원
// 어린이(52km) 요금: XXX원
// ```
// (XXX 자리에 실제 계산값이 들어가도록 작성하세요.)

// ---
