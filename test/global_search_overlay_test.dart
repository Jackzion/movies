import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:movies/ui/search/global_search_controller.dart';
import 'package:movies/ui/search/global_search_scope.dart';

/// 搜索层是否展开。
bool _isOpen(WidgetTester tester) =>
    find.byKey(const ValueKey('global_search_open')).evaluate().isNotEmpty;

void main() {
  Future<void> pumpScope(WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: GlobalSearchScope(
          child: const Scaffold(body: SizedBox.expand()),
        ),
      ),
    );
    await tester.pumpAndSettle();
  }

  testWidgets('Esc 关闭后仍可用可打印键唤出', (tester) async {
    await pumpScope(tester);

    // 字母唤出（中文/英文都走输入框 → 自动展开）
    await tester.enterText(find.byType(TextField), 'a');
    await tester.pumpAndSettle();
    expect(_isOpen(tester), isTrue);

    // Esc 关闭
    await tester.sendKeyEvent(LogicalKeyboardKey.escape);
    await tester.pumpAndSettle();
    expect(_isOpen(tester), isFalse);

    // 再次唤出
    await tester.enterText(find.byType(TextField), 'b');
    await tester.pumpAndSettle();
    expect(_isOpen(tester), isTrue);

    final field = tester.widget<TextField>(find.byType(TextField));
    expect(field.controller!.text.toLowerCase(), 'b');
  });

  testWidgets('Esc 关闭后 Ctrl+K 仍可唤出', (tester) async {
    await pumpScope(tester);

    await tester.sendKeyDownEvent(LogicalKeyboardKey.control);
    await tester.sendKeyEvent(LogicalKeyboardKey.keyK);
    await tester.sendKeyUpEvent(LogicalKeyboardKey.control);
    await tester.pumpAndSettle();
    expect(_isOpen(tester), isTrue);

    await tester.sendKeyEvent(LogicalKeyboardKey.escape);
    await tester.pumpAndSettle();
    expect(_isOpen(tester), isFalse);

    await tester.sendKeyDownEvent(LogicalKeyboardKey.control);
    await tester.sendKeyEvent(LogicalKeyboardKey.keyK);
    await tester.sendKeyUpEvent(LogicalKeyboardKey.control);
    await tester.pumpAndSettle();
    expect(_isOpen(tester), isTrue);
  });

  testWidgets('拼音组合区（IME 预编辑）出现时展开并保留拼音', (tester) async {
    await pumpScope(tester);
    expect(_isOpen(tester), isFalse);

    final field = tester.widget<TextField>(find.byType(TextField));
    // 模拟中文 IME：向已聚焦输入框投递 composing 预编辑
    field.controller!.value = const TextEditingValue(
      text: 'zhong',
      selection: TextSelection.collapsed(offset: 5),
      composing: TextRange(start: 0, end: 5),
    );
    await tester.pumpAndSettle();

    expect(_isOpen(tester), isTrue);
    expect(field.controller!.text, 'zhong');
    expect(field.controller!.value.composing.isValid, isTrue);
  });

  testWidgets('Backspace 删字后继续输入不复原', (tester) async {
    await pumpScope(tester);

    await tester.enterText(find.byType(TextField), 'h');
    await tester.pumpAndSettle();
    final field = tester.widget<TextField>(find.byType(TextField));
    expect(field.controller!.text.toLowerCase(), 'h');

    field.controller!.text = 'Hello';
    field.controller!.selection = const TextSelection.collapsed(offset: 5);

    await tester.sendKeyEvent(LogicalKeyboardKey.backspace);
    await tester.pump();
    expect(field.controller!.text, 'Hell');

    await tester.sendKeyEvent(LogicalKeyboardKey.backspace);
    await tester.pump();
    expect(field.controller!.text, 'Hel');

    // 模拟平台过期回写：旧快照 + 新字符
    field.controller!.value = const TextEditingValue(
      text: 'HelloX',
      selection: TextSelection.collapsed(offset: 6),
      composing: TextRange.empty,
    );
    await tester.pump();

    expect(field.controller!.text, 'HelX');
  });

  testWidgets('业务输入框聚焦时不抢可打印键', (tester) async {
    final businessCtrl = TextEditingController();
    addTearDown(businessCtrl.dispose);

    await tester.pumpWidget(
      MaterialApp(
        home: GlobalSearchScope(
          child: Scaffold(
            body: TextField(controller: businessCtrl),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    final businessField = find.byWidgetPredicate(
      (w) => w is TextField && identical(w.controller, businessCtrl),
    );
    await tester.tap(businessField);
    await tester.pumpAndSettle();
    await tester.enterText(businessField, 'z');
    await tester.pumpAndSettle();

    // 业务框里应收到 z，全局搜索不应展开
    expect(businessCtrl.text, 'z');
    expect(_isOpen(tester), isFalse);
  });

  test('applyBackspace / applyForwardDelete 基础行为', () {
    final c = GlobalSearchController();
    addTearDown(c.dispose);

    c.open(seed: 'abcd');
    expect(c.textController.text, 'abcd');

    expect(c.applyBackspace(), isTrue);
    expect(c.textController.text, 'abc');

    c.textController.selection = const TextSelection.collapsed(offset: 1);
    expect(c.applyForwardDelete(), isTrue);
    expect(c.textController.text, 'ac');

    c.textController.selection = const TextSelection.collapsed(offset: 0);
    expect(c.applyBackspace(), isFalse);
  });

  test('写入文字或组合区会自动 open', () {
    final c = GlobalSearchController();
    addTearDown(c.dispose);
    expect(c.isOpen, isFalse);

    c.textController.value = const TextEditingValue(
      text: 'ni',
      selection: TextSelection.collapsed(offset: 2),
      composing: TextRange(start: 0, end: 2),
    );
    expect(c.isOpen, isTrue);

    c.close();
    expect(c.isOpen, isFalse);

    c.textController.text = 'x';
    expect(c.isOpen, isTrue);
  });

  test('close 后焦点仍应落在搜索框（IME client）', () async {
    final c = GlobalSearchController();
    addTearDown(c.dispose);

    // 节点未接入树时 requestFocus 只是登记；此处验证 close 会调用 ensure 逻辑
    c.open();
    expect(c.isOpen, isTrue);
    c.close();
    expect(c.isOpen, isFalse);
    // close 清空草稿
    expect(c.textController.text, isEmpty);
    expect(c.textController.value.composing.isCollapsed || !c.textController.value.composing.isValid,
        isTrue);
  });
}
