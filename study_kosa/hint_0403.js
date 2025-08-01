// ## 2. 힌트

// ### 문제 1 힌트
// - 버튼이 클릭되면 `input.value`를 가져와 `div.innerHTML`에 대입 후, `input.value = ""`로 리셋한다.
// - DOM 선택은 `document.getElementById("result")` 같은 방법을 사용.

// ### 문제 2 힌트
// - 순서:
//   1) `shift()`로 맨 앞 요소 제거
//   2) `push()`로 뒤에 2개 추가
//   3) `concat()`으로 기존 배열 + `"체리"` => 새 배열 생성
// - 각 단계 마다 `console.log()`로 결과 확인

// ### 문제 3 힌트
// - 0~255 사이 정수: `Math.floor(Math.random() * 256)`
// - `setInterval`로 1초마다 함수 실행, 5번 실행 후 `clearInterval`로 종료
// - DOM 요소 배경색 설정: `div.style.backgroundColor = "rgb(r, g, b)"`

// ### 문제 4 힌트
// 1. **부모창**
//    - `nameRegex = /^[A-Za-z가-힣]+$/` 로 정규표현식 구성
//    - 배열에 이름 `push` 후, 참가자가 3명 이상이면 “추첨 시작” 버튼을 활성화
//    - `window.open("popup.html", ...)` 으로 팝업 창 생성
//    - `window.participants = 배열` 로 전역에 노출
// 2. **팝업창**
//    - `const parentWindow = window.opener;` → `parentWindow.participants` 접근
//    - `Math.floor(Math.random() * 배열.length)`로 랜덤 인덱스 추출
//    - 5번 돌린 후 `clearInterval` → 최종 당첨자 표시, “닫기” 버튼으로 창 닫기
