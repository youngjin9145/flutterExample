# Flutter Decoration

# Flutter Decoration 시스템 분리 이유

## 핵심 설계 철학

Flutter가 `BoxDecoration`과 `ShapeDecoration`을 분리한 건

**“최적화 vs 유연성” 트레이드오프** 때문입니다.

---

## BoxDecoration + BoxBorder

```dart
Container(
  decoration: BoxDecoration(
    border: Border(
      top: BorderSide(color: Colors.red, width: 3),
      bottom: BorderSide(color: Colors.blue, width: 1),
      left: BorderSide(color: Colors.green, width: 2),
      right: BorderSide.none,
    ),
  ),
)
```

### 특징

- 직사각형(또는 `borderRadius`로 둥근 사각형)에 최적화
- 각 변(top/right/bottom/left)을 개별적으로 제어 가능
- 성능이 좋음 (단순한 기하학 계산)

---

## ShapeDecoration + ShapeBorder

```dart
Container(
  decoration: ShapeDecoration(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
      side: BorderSide(color: Colors.red, width: 2), // 전체 균일
    ),
  ),
)
```

### 특징

- 원, 별, 다각형 등 임의의 Shape 표현 가능
- 테두리는 전체가 균일해야 함 (각 변 개별 제어 불가)
- Path 기반이라 복잡한 모양 가능하지만, 세밀한 변 제어는 포기

---

## 왜 이렇게 나눴나?

| 관점 | BoxDecoration | ShapeDecoration |
| --- | --- | --- |
| Shape | 사각형 only | 원, 별, 다각형 등 자유 |
| Border 제어 | 각 변 개별 스타일링 ✅ | 전체 균일만 가능 ❌ |
| 성능 | 빠름 | 상대적으로 느림 (Path 계산) |
| 사용 Border | BoxBorder (Border) | ShapeBorder (OutlinedBorder 계열) |

### 수학적 이유

임의의 Shape에서 `"top"`, `"bottom"` 개념이 모호합니다.

원에서 top은 어디인가요? 별 모양에서는요?

그래서 `ShapeBorder`는 전체를 하나로 취급할 수밖에 없습니다.

---

## InputDecoration은 완전히 다른 것

```dart
TextField(
  decoration: InputDecoration(
    labelText: 'Email',
    border: OutlineInputBorder(), // InputBorder 타입
  ),
)
```

`InputDecoration`은 `Decoration`을 **상속하지 않습니다**.

완전 별개의 클래스입니다.

| Decoration | InputDecoration |
| --- | --- |
| Container 등의 시각적 장식 | TextField 전용 |
| BoxBorder, ShapeBorder 사용 | InputBorder 사용 |
| 단순 시각적 요소 | label, hint, error, icon 등 입력 UX 요소 포함 |

---

## 정리

```
Decoration (abstract)
├── BoxDecoration ─── BoxBorder (Border) ─── 각 변 개별 제어 ✅, 사각형만
└── ShapeDecoration ─ ShapeBorder ────────── 자유로운 Shape ✅, 균일한border만

InputDecoration (별개) ─── InputBorder ─── TextField 전용 UX 요소
```

결국 Flutter 팀이

**“모든 걸 하나로 합치면 API가 복잡해지고 성능도 떨어진다”**

고 판단해서 용도별로 분리한 겁니다.

**InputBorder를 TextField에서 쓰는 이유는
label이 생기면 테두리가 자동으로 ‘비켜줘야(notch)’ 하는 상황이 생기기 때문**

이다.

---

## Outline vs Outlined 네이밍 차이

### 먼저 정정

- **ShapeDecoration에서 쓰는 건 `OutlinedBorder`**
- **`OutlineInputBorder`는 ShapeDecoration이 아니라 InputDecoration에서 사용**

```dart
// ShapeDecoration → ShapeBorder → OutlinedBorder (추상) → 구현체들
ShapeDecoration(
  shape: RoundedRectangleBorder(...), // OutlinedBorder의 하위 클래스
)

// InputDecoration → InputBorder → OutlineInputBorder
InputDecoration(
  border: OutlineInputBorder(...),
)
```

---

## 왜 이름이 다른가?

| 클래스 네이밍 | 도입 시기 |
| --- | --- |
| OutlineInputBorder | Outline (명사) / Flutter 초기 |
| OutlinedBorder | Outlined (과거분사/형용사) / Material Design 2+ |
| OutlinedButton | Outlined / Material Design 2 |

Flutter 초기에는 `OutlineInputBorder`, `OutlineButton`처럼 **명사형**을 사용했습니다.

Material Design이 발전하면서 `"Outlined"`, `"Filled"`, `"Elevated"` 같은

**형용사형 네이밍으로 통일**하는 방향으로 바뀌었습니다.

```dart
// 옛날 (deprecated)
OutlineButton()

// 지금
OutlinedButton()
```

---

## 왜 OutlineInputBorder는 안 바뀌었나?

`OutlineInputBorder`는 너무 많이 사용되고 있어서 deprecated 시키지 못했습니다.

바꾸면 기존 코드가 너무 많이 깨지기 때문에 그냥 둔 거예요.

---

## 결론

API 설계 시점의 차이 + 하위 호환성 유지 때문에 생긴 **네이밍 불일치**입니다.

논리적 이유는 없고, **역사적 이유**입니다.