import 'package:async/async.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:stream_test_sample/data/repositories/todo/provider.dart';

void main() {
  late ProviderContainer container;

  setUp(() {
    container = ProviderContainer();
  });

  tearDown(() {
    container.dispose();
  });

  group('watch', () {
    test('【失敗するテスト】作成されたtodoを受け取ることができる', () {
      final repository = container.read(todoRepositoryProvider);

      final stream = repository.watch();

      repository.create(createId: 0, currentTodoIds: []);

      expect(stream, emits([0]));

      repository.streamClose();

      // Expected: should emit an event that [0]
      // Actual: <Instance of '_BroadcastStream<List<int>>'>
      // Which: emitted x Stream closed.
    });

    test('【成功するテスト expectLater】作成されたtodoを受け取ることができる', () {
      final repository = container.read(todoRepositoryProvider);

      final stream = repository.watch();

      expectLater(
        stream,
        emitsInOrder([
          [0],
          [0, 1],
        ]),
      );

      repository
        ..create(createId: 0, currentTodoIds: [])
        ..create(createId: 1, currentTodoIds: [0])
        ..streamClose();
    });

    test('【成功するテスト StreamQueue】作成されたtodoを受け取ることができる', () async {
      final repository = container.read(todoRepositoryProvider);

      final streamQueue = StreamQueue(repository.watch());

      var currentTodoIds = <int>[];

      repository.create(createId: 0, currentTodoIds: currentTodoIds);
      currentTodoIds = [0];

      final result = await streamQueue.next;

      expect(result, currentTodoIds);

      repository.create(createId: 1, currentTodoIds: currentTodoIds);
      currentTodoIds = [0, 1];

      final result2 = await streamQueue.next;

      expect(result2, currentTodoIds);

      repository.streamClose();
      await streamQueue.cancel();
    });
  });
}
