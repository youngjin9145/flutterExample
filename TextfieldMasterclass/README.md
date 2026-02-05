# TextField & TextEditingController 정리

---

## 1. TextField와 controller의 관계

사용자가 키보드로 치는 건 TextField가 받아. 근데 받은 값을 어디에 저장하냐가 포인트야.

```
사용자가 "안녕" 입력
  → TextField가 받음
  → controller.text에 "안녕" 저장
```

**TextField는 입력을 받는 창문이고, controller는 그 값을 저장하는 그릇이야.**

---

## 2. controller 안 넘기면

```dart
TextField(
  decoration: InputDecoration(labelText: '입력'),
)
```

TextField가 내부에서 그릇(controller)을 만들어서 써. 사용자 입력, 화면 갱신 다 잘 돼. 리스너 등록, dispose까지 알아서 해줘.

근데 그릇이 TextField 안에 있으니까 밖에서 꺼내볼 수가 없어.

```dart
// 이런 게 불가능
print(???.text);
???.clear();
```

---

## 3. controller를 넘기면

```dart
class _MyPageState extends State<MyPage> {
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return TextField(controller: controller);
  }
}
```

니가 만든 그릇을 TextField한테 넘긴 거야. 그러면 TextField가 입력받은 값을 니 그릇에 담아줘. 니 그릇이니까 밖에서 자유롭게 쓸 수 있어.

```dart
print(controller.text);        // 텍스트 읽기
controller.text = "강제 입력";  // 텍스트 쓰기
controller.clear();            // 텍스트 지우기
```

---

## 4. 왜 dispose가 필요하냐

controller를 넘기는 순간, TextField 내부에서 이런 일이 일어나:

```dart
// TextField 내부 코드
controller.addListener(_handleTextChanged);

void _handleTextChanged() {
  setState(() {});  // 화면 다시 그려!
}
```

TextField가 controller한테 **"값 바뀌면 나한테 알려줘"**라고 자기 콜백을 등록해. 값이 바뀔 때마다 controller가 이 콜백을 호출해서 화면을 다시 그려.

```
controller._listeners = [_handleTextChanged]
                               │
                               ▼
                      TextField의 State 참조
```

화면이 사라지면 TextField는 죽어. 근데 controller는 build() 바깥에 있으니까 안 죽어. 리스너 목록에 죽은 State의 콜백이 남아있게 되고, 이러면 메모리 누수나 에러가 생겨.

---

## 5. dispose를 하면

```dart
@override
void dispose() {
  controller.dispose();  // 리스너 목록 전부 비움
  super.dispose();
}
```

controller 안의 리스너 목록이 비워져서 참조가 끊기고, GC가 전부 회수해감. 깔끔.

---

> **TextField는 입력을 받는 창문이고, controller는 값을 저장하는 그릇이다. 밖에서 그릇을 쓰려면 직접 만들어서 넘겨야 하고, 직접 만들었으면 직접 dispose 해야 한다. TextField가 addListener로 연결해놓은 걸 끊어주는 게 dispose다.**
