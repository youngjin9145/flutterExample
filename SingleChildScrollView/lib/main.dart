import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: SingleChildScrollViewPage5());
  }
}

class SingleChildScrollViewPage1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print('bottom: ${MediaQuery.of(context).padding.bottom}');
    print('viewPadding: ${MediaQuery.of(context).viewPadding.bottom}');

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'SingleChildScrollViewPractice',
          style: TextStyle(fontSize: 12),
        ),
      ),
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight:
                MediaQuery.of(context).size.height -
                MediaQuery.of(context).padding.top -
                kToolbarHeight -
                MediaQuery.of(context).padding.bottom,
            // padding.bottom 은 선택 사항이라고 한다.
            // 내가 지금 작업하고 있는 Pixel 5 에서는 padding.bottom 이 0이다.
            // 그래서 상관이 없는데 padding 도 사실 body 에서 쓸 수 있는 영역이라고 한다;;
          ),
          child: Container(
            width: double.infinity,
            height: 100,
            color: Colors.red,
            alignment: Alignment.bottomCenter,
            // 자식 크기를 존중 및 정렬
            child: Container(height: 10, width: 10, color: Colors.green),
          ),
        ),
      ),
    );
  }
}

class SingleChildScrollViewPage2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'SingleChildScrollViewPractice',
          style: TextStyle(fontSize: 12),
        ),
      ),
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight:
                MediaQuery.of(context).size.height -
                MediaQuery.of(context).padding.top -
                kToolbarHeight -
                MediaQuery.of(context).padding.bottom,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Form(
                child: Column(
                  children: [
                    TextFormField(
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.red,
                        hintText: 'Input Test!',
                        hintStyle: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: 400,
                width: double.infinity,
                color: Colors.green,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SingleChildScrollViewPage3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'SingleChildScrollViewPractice',
          style: TextStyle(fontSize: 12),
        ),
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Form(
              child: TextFormField(
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.red,
                  hintText: 'Input Test!',
                  hintStyle: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          SliverFillRemaining(
            hasScrollBody: false, // 내부 scroll 활성화 여부
            child: Container( // Align 이 더 낫긴함.
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 100,
                color: Colors.yellow,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SingleChildScrollViewPage4 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Column + Expanded 방식',
          style: TextStyle(fontSize: 12),
        ),
      ),
      body: Column(
        children: [
          // 🔼 스크롤 가능한 영역
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Form(
                    child: TextFormField(
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.red,
                        hintText: 'Input Test!',
                        hintStyle: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  // 테스트용 큰 컨텐츠
                  Container(
                    height: 200,
                    width: double.infinity,
                    color: Colors.blue.shade100,
                    child: Center(child: Text('스크롤 콘텐츠')),
                  ),
                  Container(
                    height: 200,
                    width: double.infinity,
                    color: Colors.blue.shade200,
                    child: Center(child: Text('스크롤 콘텐츠 2')),
                  ),
                ],
              ),
            ),
          ),

          // 🔽 하단 고정 영역
          Container(
            height: 100,
            width: double.infinity,
            color: Colors.yellow,
            child: Center(
              child: Text('하단 고정 버튼 영역', style: TextStyle(fontSize: 16)),
            ),
          ),
        ],
      ),
    );
  }
}

class SingleChildScrollViewPage5 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Column + Expanded 방식',
          style: TextStyle(fontSize: 12),
        ),
      ),
      body: Column(
        children: [
          // 🔼 스크롤 가능한 영역
          Expanded(
            child: ListView.separated(
              itemCount: 10,
              separatorBuilder: (context, index) {
                return Text('----------');
              },
              itemBuilder: (context, index) {
                return Text('kk $index');
              },
              )
          ),

          // 🔽 하단 고정 영역
          Container(
            height: 100,
            width: double.infinity,
            color: Colors.yellow,
            child: Center(
              child: Text('하단 고정 버튼 영역', style: TextStyle(fontSize: 16)),
            ),
          ),
        ],
      ),
    );
  }
}

class SingleChildScrollViewPage6 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('hasScrollBody: true 예제')),
      body: CustomScrollView(
        slivers: [
          // 상단 고정 영역
          SliverToBoxAdapter(
            child: Container(
              height: 100,
              color: Colors.blue,
              child: Center(child: Text('상단 영역', style: TextStyle(color: Colors.white))),
            ),
          ),

          // 남은 공간에 ListView (따로 스크롤됨!)
          SliverFillRemaining(
            hasScrollBody: true,  // ← 내부 스크롤 활성화
            child: ListView.builder(
              itemCount: 50,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text('아이템 $index'),
                  tileColor: index.isEven ? Colors.grey[200] : Colors.white,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}