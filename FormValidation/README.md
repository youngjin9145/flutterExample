# Day 14 - FormValidation

## 핵심 개념

### Form + GlobalKey + validator

Day 13에서는 `TextField` + `setState`로 직접 검증했지만,
`Form` 위젯을 사용하면 여러 필드를 **한번에 검증/저장/초기화**할 수 있다.

```dart
final _formKey = GlobalKey<FormState>();

Form(
  key: _formKey,
  child: Column(children: [
    TextFormField(validator: (value) { ... }),
    TextFormField(validator: (value) { ... }),
  ]),
)

// 한 줄로 모든 필드 검증
_formKey.currentState!.validate();
```

---

## 주요 API 정리

| 메서드 | 역할 |
|--------|------|
| `validate()` | 모든 필드의 `validator` 콜백 실행. 하나라도 실패하면 `false` |
| `save()` | 모든 필드의 `onSaved` 콜백 실행. 컨트롤러 쓰면 불필요 |
| `reset()` | 폼 상태 초기화 (에러 메시지 제거). **텍스트는 안 지워짐** |

### save()는 뭘 하는가?

`save()`를 호출하면 모든 `TextFormField`의 `onSaved` 콜백이 실행된다.
컨트롤러 없이 폼 값을 수집할 때 사용한다.

```dart
String? _savedName;

TextFormField(
  // controller 없이도 값을 가져올 수 있음
  onSaved: (value) {
    _savedName = value;  // ← save() 호출 시 실행됨
  },
)

// validate 통과 후 save
if (_formKey.currentState!.validate()) {
  _formKey.currentState!.save();  // 모든 onSaved 실행
  print(_savedName);              // 검증된 값 사용
}
```

**컨트롤러를 이미 쓰고 있다면 `save()`는 불필요하다.**
`controller.text`로 바로 값을 가져올 수 있기 때문이다.

| 방식 | 값 접근 | dispose 관리 |
|------|---------|:-----------:|
| `onSaved` + `save()` | `save()` 호출 후 변수에 저장 | 불필요 |
| `TextEditingController` | `controller.text`로 바로 접근 | 필요 |

### validator 콜백 규칙

```dart
validator: (value) {
  if (value == null || value.isEmpty) {
    return '에러 메시지';  // String 반환 → 에러 표시
  }
  return null;             // null 반환 → 검증 통과
}
```

---

## reset() vs clear() - 왜 둘 다 필요한가?

```dart
void _resetForm() {
  _formKey.currentState!.reset();       // 폼 상태 초기화
  _nameController.clear();              // 텍스트 삭제
  _emailController.clear();
  _passwordController.clear();
  _confirmPasswordController.clear();
}
```

| 호출 | 에러 메시지 | 입력 텍스트 |
|------|:---------:|:---------:|
| `reset()`만 | 사라짐 | **그대로** |
| `clear()`만 | **남을 수 있음** | 사라짐 |
| 둘 다 | 사라짐 | 사라짐 |

`reset()`은 **Form 위젯**의 상태(에러, 검증 결과)를 지우고,
`clear()`는 **TextEditingController**의 텍스트를 지운다.
담당하는 영역이 다르기 때문에 둘 다 호출해야 깔끔하게 초기화된다.

---

## AutovalidateMode - 왜 전환하는가?

```dart
AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;
```

### 문제: 처음부터 자동 검증하면?

폼을 열자마자 아무것도 안 입력했는데 빨간 에러가 뜬다 → UX가 나쁨

### 해결: 제출 후에만 자동 검증 활성화

```dart
void _submitForm() {
  if (_formKey.currentState!.validate()) {
    // 성공
  } else {
    // 실패 시 → 자동 검증 모드 ON
    setState(() {
      _autovalidateMode = AutovalidateMode.onUserInteraction;
    });
  }
}
```

| 시점 | 모드 | 동작 |
|------|------|------|
| 처음 진입 | `disabled` | 에러 안 보임 |
| 제출 실패 후 | `onUserInteraction` | 입력할 때마다 실시간 검증 |
| 초기화 후 | `disabled` | 다시 에러 안 보임 |

이렇게 하면 "처음에는 조용하고, 틀린 후에는 바로 알려주는" 자연스러운 폼이 된다.

---

## ThemeData 관련 메모

### ColorScheme.fromSeed()

시드 색상 하나로 Material3 컬러 팔레트(30개+)를 자동 생성한다.

```dart
ColorScheme.fromSeed(seedColor: Colors.indigo)  // 남색 계열 전체 팔레트
```

### textTheme의 nullable 타입

`titleMedium`, `bodyMedium` 등은 타입이 `TextStyle?`이라 `?.`을 써야 한다.
`ThemeData()` 사용 시 기본값이 자동 채워지므로 실제로 null인 경우는 거의 없다.

```dart
// ?. 필수 (타입이 TextStyle?이라서)
Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)
```
