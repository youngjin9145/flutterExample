# Navigator 을 여러개 생성해서 사용해보자!

# Flutter Navigator 완전 정리 📚

---

## 1. 기본 구조

MaterialApp으로 프로젝트를 감싸면 Navigator가 자동 생성됨. 이 Navigator를 통해 현재 Route(화면)를 변경한다.

```dart
MaterialApp(          // ← Navigator 자동 생성!
  home: HomePage(),
)
```

---

## 2. Navigator와 Route의 관계

```
Navigator = 화면들을 관리하는 "관리자" 👨‍🍳
Route = 화면 하나 (접시 🍽️)

Navigator가 Route들을 Stack 방식으로 쌓고 치움
```

```
      [프로필 화면]  ← 맨 위 (지금 보이는 화면)
      [상품 상세]
      [홈 화면]      ← 맨 아래
    ━━━━━━━━━━━━━
       Navigator
```

| 메서드 | 설명 | 비유 |
| --- | --- | --- |
| `push()` | 새 화면 열기 | 접시 쌓기 |
| `pop()` | 이전 화면으로 | 접시 치우기 |
| `popUntil()` | 특정 화면까지 | 접시 여러 개 치우기 |

---

## 3. 단일 Navigator의 문제점

모든 화면이 **하나의 Stack에 쌓임**.

```
예시: 홈 → 게시물1 → 게시물2 → 검색 → 검색결과1 → 검색결과2

Stack 상태:
[검색결과2]  ← 현재 위치
[검색결과1]
[검색]
[게시물2]
[게시물1]
[홈]
━━━━━━━━━━
Navigator
```

문제 1: 검색결과2에서 홈으로 가려면?

→ 5번 pop 해야 함! 😱

문제 2: 다시 검색으로 가면?

→ 검색 화면이 "새로 생성"됨 (이전 상태 사라짐!)

---

## 4. 해결책: 탭별 독립 Navigator

각 탭마다 **자신만의 Navigator**를 가지게 함.

```
┌─────────────────────────────────────────────┐
│                                             │
│        지금 보이는 화면 (맨 위 접시)           │
│                                             │
├─────────┬─────────┬─────────┬─────────┬─────┤
│   🏠    │   🔍    │   ➕    │   🎬    │ 👤  │
│   홈    │  검색   │  만들기  │  릴스   │ 프로필│
└─────────┴─────────┴─────────┴─────────┴─────┘
     ↓         ↓         ↓         ↓        ↓
  Navigator Navigator Navigator Navigator Navigator
  (홈 전용) (검색 전용)   ...      ...    (프로필 전용)
```

장점:

홈 탭에서 게시물1 → 게시물2 → 게시물3 이동 후

검색 탭으로 전환했다가

다시 홈 탭으로 돌아오면

→ 게시물3 상태가 그대로 유지! 🎉

---

## 5. 새로운 문제: Navigator 재생성

탭을 전환할 때마다 Navigator를 새로 호출하면?

```dart
// ❌ 문제가 되는 코드
body: _barSelected == 0
    ? Navigator(...)  // 탭 바꿀 때마다 새로 생성!
    : Navigator(...), // 탭 바꿀 때마다 새로 생성!
```

```
발생하는 일:
1. Navigator가 새로 생성됨
2. 기존 Navigator가 위젯 트리에서 제거됨
3. 기존 Navigator 안의 Route 스택도 함께 삭제!
4. 상태가 초기화됨!

결과: 탭을 왔다 갔다 할 때마다 처음 화면으로 리셋 😱
```

---

## 6. 최종 해결책: IndexedStack

한 번만 생성하고, 그 다음에는 보이기/숨기기만 함.

```dart
IndexedStack(
  index: _barSelected,  // 보여줄 자식의 번호
  children: [
    Navigator(...),  // index 0 - 홈
    Navigator(...),  // index 1 - 검색
    Navigator(...),  // index 2 - 프로필
  ],
)
```

### IndexedStack 동작 원리

```
앱 시작 시 (한 번만!):
├── Navigator(0) 생성 ✅
├── Navigator(1) 생성 ✅
└── Navigator(2) 생성 ✅

탭 전환 시:
├── index = 0 → Navigator(0) 보임, 나머지 숨김
├── index = 1 → Navigator(1) 보임, 나머지 숨김
└── index = 2 → Navigator(2) 보임, 나머지 숨김

새로 생성? ❌ NO!
보이기/숨기기만! ✅ YES!
```

핵심 특징

- 모든 자식이 위젯 트리에 유지됨
- 제거되지 않으므로 상태가 보존됨
- 스크롤 위치, 폼 입력, 타이머 등 모든 상태 유지!

---

## 7. 전체 구현 코드

```dart
class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _currentIndex = 0;

  // 각 탭의 Navigator를 제어하기 위한 키
  final List<GlobalKey<NavigatorState>> _navigatorKeys = [
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
  ];

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) return;

        // 현재 탭의 Navigator에서 뒤로가기 시도
        final navigator = _navigatorKeys[_currentIndex].currentState;
        if (navigator != null) {
          await navigator.maybePop();
        }
      },
      child: Scaffold(
        body: IndexedStack(
          index: _currentIndex,
          children: [
            _buildNavigator(0, const HomeTab()),
            _buildNavigator(1, const SearchTab()),
          ],
        ),
        bottomNavigationBar: NavigationBar(
          selectedIndex: _currentIndex,
          onDestinationSelected: (index) {
            setState(() => _currentIndex = index);
          },
          destinations: const [
            NavigationDestination(icon: Icon(Icons.home), label: '홈'),
            NavigationDestination(icon: Icon(Icons.search), label: '검색'),
          ],
        ),
      ),
    );
  }

  Widget _buildNavigator(int index, Widget child) {
    return Navigator(
      key: _navigatorKeys[index],
      onGenerateRoute: (settings) {
        return MaterialPageRoute(builder: (_) => child);
      },
    );
  }
}
```

---

## 8. 주의사항

### IndexedStack의 단점

| 장점 | 단점 |
| --- | --- |
| 상태 보존 | 모든 자식이 처음에 동시 생성 |
| 빠른 탭 전환 | 메모리에 계속 유지됨 |
| 구현이 간단함 | 자식이 무거우면 메모리 사용량 증가 |

### 해결 방안

```dart
// 자식이 많거나 무거운 경우:
// 1. lazy_indexed_stack 패키지 사용
// 2. AutomaticKeepAliveClientMixin + PageView 사용
```

---

## 9. 핵심 요약

```
1. MaterialApp = Navigator 자동 생성

2. 단일 Navigator 문제
   → 모든 화면이 하나의 Stack에 쌓임
   → 탭 전환 시 상태 유지 불가

3. 해결책: 탭별 독립 Navigator
   → 각 탭이 자신만의 화면 스택 보유
   → 탭 전환해도 상태 유지

4. Navigator 재생성 문제
   → 탭 전환 시 Navigator가 새로 생성되면 상태 리셋

5. 최종 해결책: IndexedStack
   → 한 번만 생성, 보이기/숨기기로 전환
   → 위젯 트리에서 제거되지 않아 상태 보존!
```

---

## 10. 비유로 정리

```
IndexedStack = 서랍장 🗄️

┌─────────────────────────────┐
│         서랍장               │
│  ┌─────┐ ┌─────┐ ┌─────┐   │
│  │서랍1│ │서랍2│ │서랍3│   │
│  │(홈) │ │(검색)│ │(설정)│   │
│  └─────┘ └─────┘ └─────┘   │
└─────────────────────────────┘

- 각 서랍 = 독립적인 Navigator
- 서랍 안의 물건 = Route(화면) 스택
- 서랍 열기 = index 변경 (보이기)
- 서랍 닫기 = 숨기기 (삭제 아님!)

서랍을 닫아도 안에 있는 물건은 그대로!
다시 열면 아까 상태 그대로 있음! 🎉
```

---

## 11. PopScope: 뒤로가기 버튼 제어

### 문제: 다중 Navigator에서 뒤로가기

상황: 홈 탭에서 게시물1 → 게시물2 → 게시물3까지 들어간 상태

```
┌─────────────────────────────────┐
│       [게시물3] ← 현재 화면      │
│       [게시물2]                 │
│       [게시물1]                 │
│       [홈]                      │
│       ━━━━━━━━                  │
│       홈 탭 Navigator           │
├─────────────────────────────────┤
│   🏠 홈    │    🔍 검색         │
└─────────────────────────────────┘
```

안드로이드 뒤로가기 버튼 누르면?

❌ PopScope 없으면:

→ MaterialApp의 Navigator가 반응

→ 앱 전체가 종료됨! 😱

(홈 탭 Navigator는 무시됨)

✅ PopScope 있으면:

→ 뒤로가기를 가로챔

→ 현재 탭(홈)의 Navigator에서 pop

→ 게시물3 → 게시물2로 이동! 🎉

---

### PopScope란?

"뒤로가기 버튼을 가로채서, 어떻게 처리할지 정하는 문지기" 🚪👮

```dart
PopScope(
  canPop: false,  // 기본 뒤로가기 막기
  onPopInvokedWithResult: (didPop, result) {
    // 뒤로가기 시도 시 실행할 코드
  },
  child: Scaffold(...),
)
```

### 파라미터 설명

| 파라미터 | 타입 | 설명 |
| --- | --- | --- |
| canPop | bool | true: 뒤로가기 허용 / false: 막음 |
| onPopInvokedWithResult | Function | 뒤로가기 시도 시 실행되는 콜백 |
| didPop | bool | 실제로 나갔으면 true, 막혔으면 false |
| result | dynamic | Navigator.pop(context, 값)의 값 |

---

### 다중 Navigator에서 사용법

```dart
PopScope(
  canPop: false,  // 1️⃣ 일단 기본 뒤로가기 막음
  onPopInvokedWithResult: (didPop, result) async {
    // 2️⃣ 이미 나갔으면 무시
    if (didPop) return;

    // 3️⃣ 현재 탭의 Navigator 가져오기
    final navigator = _navigatorKeys[_currentIndex].currentState;

    // 4️⃣ 현재 탭에서 뒤로가기 시도
    if (navigator != null) {
      await navigator.maybePop();
    }
  },
  child: Scaffold(...),
)
```

---

### 동작 흐름

```
[1] 사용자가 뒤로가기 버튼 누름
         ↓
[2] PopScope가 가로챔 (canPop: false)
         ↓
[3] onPopInvokedWithResult 실행
         ↓
[4] 현재 탭의 Navigator에서 maybePop() 시도
         ↓
    ┌─────────────────────────────────┐
    │  스택에 화면이 2개 이상?         │
    │                                 │
    │  YES → pop 실행 (이전 화면으로)  │
    │  NO  → 아무 일 없음 (첫 화면)    │
    └─────────────────────────────────┘
```

---

### 비유: 공항 출국 심사

```
PopScope = 출국 심사대 👮

┌─────────────────────────────────┐
│  👤 승객: "나가고 싶어요!"        │
│                                 │
│  👮 심사관 (PopScope):           │
│     "잠깐! 내가 확인할게요"       │
│                                 │
│     canPop: false               │
│     → "일단 못 나가요"           │
│                                 │
│     onPopInvokedWithResult:     │
│     → "어디서 왔어요? 확인하고    │
│        적절한 곳으로 보내줄게요"  │
└─────────────────────────────────┘
```

---

### WillPopScope vs PopScope

| 항목 | WillPopScope (구식) | PopScope (신식) |
| --- | --- | --- |
| Flutter 버전 | 3.12 이전 | 3.12 이상 |
| 상태 | Deprecated | 권장 |
| 반환값 | Future<bool> | 없음 (void) |
| 뒤로가기 막기 | return false | canPop: false |
| 직접 나가기 | 자동 | Navigator.pop() 직접 호출 |

```dart
// ❌ 옛날 방식 (WillPopScope)
WillPopScope(
  onWillPop: () async {
    return false;  // false 반환하면 막힘
  },
  child: Scaffold(...),
)

// ✅ 새로운 방식 (PopScope)
PopScope(
  canPop: false,  // 막기
  onPopInvokedWithResult: (didPop, result) {
    // 필요시 직접 Navigator.pop() 호출
  },
  child: Scaffold(...),
)
```

---

### 전체 코드에서의 위치

```dart
@override
Widget build(BuildContext context) {
  return PopScope(  // ← 최상단에 감싸기!
    canPop: false,
    onPopInvokedWithResult: (didPop, result) async {
      if (didPop) return;

      final navigator = _navigatorKeys[_currentIndex].currentState;
      if (navigator != null) {
        await navigator.maybePop();
      }
    },
    child: Scaffold(  // ← 이 안에 IndexedStack 등
      body: IndexedStack(...),
      bottomNavigationBar: NavigationBar(...),
    ),
  );
}
```

---

### 핵심 요약

```
PopScope가 필요한 이유:
1. 앱에 Navigator가 여러 개 있으면
2. 안드로이드 뒤로가기는 기본적으로 "최상위 Navigator"만 인식
3. 탭 안의 Navigator는 무시됨
4. PopScope로 뒤로가기를 가로채서
5. "현재 탭의 Navigator"에서 처리하도록 연결!

한 줄 정리:
PopScope = 뒤로가기 버튼과 올바른 Navigator를 연결해주는 다리 🌉
```