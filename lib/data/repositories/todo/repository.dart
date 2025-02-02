import 'dart:async';

import 'package:riverpod/riverpod.dart';

class TodoRepository {
  TodoRepository(this.ref);

  final Ref ref;

  final _controller = StreamController<List<int>>.broadcast();

  void streamClose() => _controller.close();

  /// todoを監視して、作成されたtodoのIDを返す
  Stream<List<int>> watch() => _controller.stream;

  /// todoを作成する
  ///
  /// テスト用として、作成したTODOのIDと作成済みのIDは引数で入れる
  void create({required int createId, required List<int> currentTodoIds}) {
    // TODOを作成して保存し、IDを生成
    final createTodoId = createId;

    // 全体のリストと仮定
    final currentTodos = currentTodoIds;

    // 作成した全体のtodo
    final updateTodos = [...currentTodos, createTodoId];
    // 作成したtodoを流す
    _controller.add(updateTodos);
  }
}
