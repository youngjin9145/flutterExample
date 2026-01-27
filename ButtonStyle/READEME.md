# ButtonStyle은 왜 WidgetStateProperty를 사용할까?

나는 너무 궁금했다. 텍스트의 스타일을 꾸밀 때는 `TextStyle`로 바로 쓰면서 버튼의 스타일을 꾸밀 때는 `ElevatedButton.styleFrom`이렇게 쓰는지 그 이유를 오늘 알아보겠다!

## 결론부터: TextStyle vs ButtonStyle의 차이

|  | TextStyle | ButtonStyle |
|---|---|---|
| **상태** | 없음 (정적) | 있음 (pressed, hovered 등) |
| **속성 타입** | 단순 값 (`Color`, `double`) | `WidgetStateProperty<T>` |
| **편의 메서드** | 불필요 | `styleFrom()` 제공 |

텍스트는 누르거나 호버하는 **상태가 없다**. 그냥 보여주기만 하면 된다. 하지만 버튼은 누르면 색이 바뀌고, 마우스를 올리면 또 바뀌고, 비활성화되면 또 바뀐다. 이런 **상태별 스타일 변화**가 필요하기 때문에 `WidgetStateProperty<T>`라는 래퍼가 필요한 것이다.

`ElevatedButton.styleFrom()`은 단순 값들을 받아서 내부적으로 `WidgetStateProperty.all()`로 감싸주는 **편의 메서드**다:

```dart
// styleFrom 사용 (간편)
ElevatedButton.styleFrom(
  backgroundColor: Colors.blue,
)

// 위 코드가 내부적으로 하는 일
ButtonStyle(
  backgroundColor: WidgetStateProperty.all(Colors.blue),
)
```

---

## ButtonStyle 직접 지정해보기

오늘은 ElevatedButton의 Style을 `styleFrom`이 아닌 `ButtonStyle`로 직접 지정해보겠다.

```dart
ElevatedButton(
  onPressed: () {},
  child: Text(
    'Sign In',
    style: TextStyle(
      fontSize: 15,
      color: AppColors.secondary,
      fontWeight: FontWeight.bold,
    ),
  ),
  style: ButtonStyle(
    overlayColor: WidgetStateProperty.resolveWith((state) {
      if (state.contains(WidgetState.pressed)) {
        return AppColors.primaryLight.withValues(alpha: 0.2);
      }
      return null; // null을 반환하면 기본 테마 값이 적용된다
    }),
    backgroundColor: WidgetStateProperty.resolveWith((state) {
      if (state.contains(WidgetState.pressed)) {
        return AppColors.secondary;
      }
      return AppColors.primaryLight;
    }),
    shape: WidgetStateProperty.all(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      )
    )
  ),
),
```

---

## 왜 WidgetStateProperty<T>를 사용하는가?

`ButtonStyle`의 모든 파라미터는 `WidgetStateProperty<T>`를 원한다. (`T`는 각 파라미터마다 다르다)

이유는 간단하다. **위젯의 상태에 따라 속성값이 변경될 수 있어야 하기 때문이다.**

### 버튼의 상태 (자주 쓰는 것)

- `pressed` - 버튼 눌렀을 때 색 바꾸기
- `hovered` - 마우스 올렸을 때 효과
- `disabled` - 비활성화 스타일
- `focused` - 키보드 접근성 (Tab으로 접근)

### 버튼의 속성

- `backgroundColor` - 배경색
- `foregroundColor` - 전경색 (텍스트, 아이콘)
- `overlayColor` - 덮어씌우는 컬러 (pressed 시 ripple 효과 등)
- `shape` - 버튼 모양

풀어서 쓰면: 버튼이 눌렸을 때(`pressed 상태`) 버튼의 배경색(`backgroundColor 속성`)이 변경되어야 한다.

---

## WidgetStateProperty의 주요 메서드

### 1. WidgetStateProperty.all

모든 상태에서 동일한 값을 적용한다.

```dart
backgroundColor: WidgetStateProperty.all(Colors.blue)
// 어떤 상태(hover, pressed, disabled 등)에서도 항상 파란색
```

### 2. WidgetStateProperty.resolveWith

상태에 따라 다른 값을 반환한다. 콜백 함수를 받아서 state에 따라 다른 값을 return한다.

```dart
backgroundColor: WidgetStateProperty.resolveWith((state) {
  if (state.contains(WidgetState.pressed)) {
    return Colors.red;    // 눌렀을 때 빨간색
  }
  if (state.contains(WidgetState.hovered)) {
    return Colors.blue;   // 호버할 때 파란색
  }
  return Colors.grey;     // 기본 상태는 회색
})
```

> **참고**: `null`을 반환하면 Flutter의 기본 테마 값이 적용된다.

---

## 소스코드로 살펴보기

### WidgetStateProperty 추상 클래스

```dart
abstract class WidgetStateProperty<T> {
  // 모든 상태에서 같은 값
  static WidgetStateProperty<T> all<T>(T value) => WidgetStatePropertyAll<T>(value);

  // 상태에 따라 다른 값
  static WidgetStateProperty<T> resolveWith<T>(WidgetPropertyResolver<T> callback) =>
      _WidgetStatePropertyWith<T>(callback);

  // 실제로 값을 계산하는 메서드
  T resolve(Set<WidgetState> states);
}
```

### all의 구현: WidgetStatePropertyAll

```dart
class WidgetStatePropertyAll<T> implements WidgetStateProperty<T> {
  const WidgetStatePropertyAll(this.value);

  final T value;

  @override
  T resolve(Set<WidgetState> states) => value;  // 상태와 무관하게 항상 같은 값!
}
```

### resolveWith의 구현: _WidgetStatePropertyWith

```dart
class _WidgetStatePropertyWith<T> implements WidgetStateProperty<T> {
  _WidgetStatePropertyWith(this._resolve);

  final WidgetPropertyResolver<T> _resolve;

  @override
  T resolve(Set<WidgetState> states) => _resolve(states);  // 우리가 작성한 콜백 실행!
}
```

`resolve()` 메서드가 호출될 때 실제 Color 값이 반환된다. `ButtonStyle`은 `WidgetStateProperty<T>`를 받지만, 실제 렌더링 시점에는 `resolve()`를 통해 단순 값(Color 등)을 얻어 사용한다.

---

## OOP 4대 특성과 연결짓기

이 코드에서 객체지향의 4가지 특성이 모두 활용되었다.

### 1. 캡슐화 (Encapsulation)

값을 외부에서 직접 접근하지 못하게 하고, 메서드를 통해서만 접근하게 하는 것.

```dart
class _WidgetStatePropertyWith<T> {
  final WidgetPropertyResolver<T> _resolve;  // _로 시작 = private
  // 외부에서 _resolve에 직접 접근 불가, resolve() 메서드로만 사용
}
```

### 2. 상속 (Inheritance)

코드를 재사용할 수 있게 하는 것. `extends`와 `implements`가 있다.

- `extends`: 부모의 모든 메서드와 필드를 상속받음
- `implements`: 모든 인스턴스 멤버(메서드, getter/setter, 필드)를 직접 구현해야 함

```dart
// implements 예시 - 필드도 다시 선언해야 함!
abstract class A {
  int value = 0;
  void foo();
}

class B implements A {
  @override
  int value = 0;  // 필드도 재선언 필요 (암묵적 getter/setter로 취급)
  
  @override
  void foo() {}
}
```

> **참고**: `static` 멤버는 클래스에 속하지 객체에 속하지 않으므로 implements 대상이 아니다.

### 3. 다형성 (Polymorphism)

부모 타입 변수에 자식 타입 객체를 할당할 수 있는 것.

```dart
WidgetStateProperty<Color> prop = WidgetStatePropertyAll(Colors.blue);  // 가능!
WidgetStateProperty<Color> prop2 = _WidgetStatePropertyWith((s) => Colors.red);  // 이것도 가능!
```

### 4. 추상화 (Abstraction)

`abstract class`는 직접 인스턴스화할 수 없다. 반드시 이를 extends하거나 implements한 **구체 클래스(concrete class)**를 통해서만 객체를 생성할 수 있다.

비유하자면: 동물원에 사자, 호랑이, 코끼리는 있지만 "동물"이라는 동물은 없다. `WidgetStateProperty`도 마찬가지로 그 자체로는 객체가 될 수 없고, `WidgetStatePropertyAll`이나 `_WidgetStatePropertyWith` 같은 구체 클래스로만 존재할 수 있다.

---

## 참고: MaterialStateProperty → WidgetStateProperty

Flutter 3.19부터 `MaterialStateProperty`가 `WidgetStateProperty`로 이름이 변경되었다. 검색할 때 옛날 자료에서는 `MaterialState`, `MaterialStateProperty`로 되어 있을 수 있으니 참고하자.

---

## 정리

1. **TextStyle**은 상태가 없어서 값을 직접 넣으면 된다.
2. **ButtonStyle**은 상태(pressed, hovered 등)에 따라 값이 바뀌어야 해서 `WidgetStateProperty<T>`로 감싸야 한다.
3. **styleFrom**은 편의 메서드로, 단순 값을 `WidgetStateProperty.all()`로 자동 래핑해준다.
4. 상태별로 다른 스타일을 주고 싶으면 `WidgetStateProperty.resolveWith()`를 사용한다.