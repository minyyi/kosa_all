/* 
1. `var`와 `let` 변수를 각각 사용하여, for문 안과 밖에서 값을 출력했을 때 차이를 확인하는 코드를 작성하세요.  
2. for문에서 `var` 키워드를 사용했을 때와, `let` 키워드를 사용했을 때의 결과를 콘솔에 각각 출력해보세요.

### 요구사항
- 새 파일(예: `scopeTest.js`)을 만들고 아래와 같은 흐름으로 작성해보세요:
  1. `var`로 선언된 변수가 for문 내부/외부에서 어떻게 동작하는지 출력
  2. `let`으로 선언된 변수가 for문 내부/외부에서 어떻게 동작하는지 출력
- 결과를 보고 간단히 주석으로 차이점을 설명해봅니다.
*/

// var i = 100;
// for (var i = 0; i < 10; i++) {
//   console.log(i);
// }

// console.log(i); //10

// let i = 100;
// for (let i = 0; i < 10; i++) {
//   console.log(i);
// }

// console.log(i); //100
// ## 2. (중) 코드 작성 문제

// ### 문제
// 클로저(Closure)를 이용해 **카운터** 함수를 작성하고, 콘솔에서 증가 동작을 확인해보세요.

// 1. `makeCounter`라는 함수를 만드세요.
//    - 내부에 `count` 변수를 `0`으로 초기화합니다.
//    - 내부 함수를 반환(return)하여, 이 내부 함수가 호출될 때마다 `count`가 1씩 증가한 값을 콘솔에 출력하도록 만드세요.
// 2. `makeCounter` 함수를 이용해 `counter1`, `counter2`를 각각 생성하여, 두 카운터가 서로 독립적으로 증가하는지 확인해보세요.

const makeCounter = () => {
  let counter = 0;
  let innerFunc = function () {
    console.log(counter++);
  };
  return innerFunc;
};
const counter1 = makeCounter();
const counter2 = makeCounter();
counter1();
counter1();
counter2();
counter1();
counter2();
// ## 3. (상) 코드 작성 문제

// ### 문제
// **프로토타입**을 활용하여, **도형(Shape) 및 삼각형(Triangle)** 객체를 생성하는 코드를 작성하세요.

// 1. `Shape`라는 생성자 함수를 만듭니다.
//    - 인자로 `name`을 받아서 프로퍼티로 저장하세요.
//    - 프로토타입에 `getName()` 메서드를 정의하여, `this.name`을 반환하도록 합니다.
// 2. `Triangle`이라는 생성자 함수를 만듭니다.
//    - 인자로 `base`, `height`를 받아서 프로퍼티로 저장하세요.
//    - `Triangle`의 프로토타입을 `Shape`의 프로토타입과 연결 지어서, `Triangle` 인스턴스가 `Shape`의 메서드를 물려받게 해보세요.
// 3. `Triangle` 프로토타입 또는 생성자 내부에 `getArea()` 메서드를 정의하여, 삼각형 넓이( `(base * height) / 2` )를 반환하도록 합니다.
// 4. 실제로 `Triangle` 객체를 생성해, `getName()`과 `getArea()`를 콘솔에 출력해보세요.

// ### 예시 코드 흐름
// ```js
// function Shape(name) { ... }
// Shape.prototype.getName = function() { ... }

// function Triangle(name, base, height) { ... }
// // Prototype 상속 연결
// Triangle.prototype = ...

// Triangle.prototype.getArea = function() { ... }

// const tri = new Triangle("삼각형", 5, 10);
// console.log(tri.getName()); // "삼각형"
// console.log(tri.getArea()); // 25
// ```
