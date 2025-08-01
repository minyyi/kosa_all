const sum = (a, b) => {
  let result = a + b;
  return result;
};
sum(3, 5);
console.log("합: ", sum(3, 5));

let num = [1, 2, 3, 4, 5, 6];
const filterEven = (num) => {
  let evenarr = [];
  let oddarr = [];
  num.map((num) => {
    if (num % 2 == 0) {
      evenarr.push(num);
    } else {
      oddarr.push(num);
    }
  });
  return `짝수: [${evenarr}] , 홀수: [${oddarr}]`;
};
filterEven(num);
console.log(filterEven(num));

// ## TodoList 클래스 구현

// **문제 설명:**

// Todo 항목을 관리할 수 있는 `TodoList` 클래스를 작성하세요.

// - 클래스는 내부에 Todo 항목들을 저장할 배열을 가집니다.
// - 다음의 메서드를 구현합니다.
//     - `add(todo)`: 주어진 문자열 `todo`를 리스트에 추가합니다.
//     - `remove(index)`: 주어진 인덱스의 Todo 항목을 삭제합니다.
//     - `getTodos()`: 현재의 Todo 항목들을 배열 형태로 반환합니다.
// - 작성한 클래스를 사용해 몇 가지 Todo 항목을 추가하고, 삭제한 후 최종 리스트를 콘솔에 출력하는 예제 코드를 작성하세요.

class Todolist {
  todos;
  // count;
  constructor() {
    this.todos = [];
  }
  addTodo(todo) {
    this.todos.push(todo);
  }
  removeTodo(index) {
    this.todos.splice(index, 1);
  }
  getTodos() {
    console.log(this.todos);
  }
}

const my = new Todolist();
my.addTodo("되나?");
my.addTodo("과연");
my.getTodos();
my.removeTodo(1);
my.getTodos();
