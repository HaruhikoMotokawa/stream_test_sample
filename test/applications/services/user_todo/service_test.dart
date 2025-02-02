import 'dart:async';

import 'package:async/async.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mockito/mockito.dart';
import 'package:stream_test_sample/applications/services/user_todo/provider.dart';
import 'package:stream_test_sample/data/repositories/todo/provider.dart';
import 'package:stream_test_sample/data/repositories/user/provider.dart';

import '../../../generate_nice_mocks.mocks.dart';

void main() {
  late ProviderContainer container;
  final userRepository = MockUserRepository();
  final todoRepository = MockTodoRepository();

  setUp(() {
    reset(userRepository);
    reset(todoRepository);

    container = ProviderContainer(
      overrides: [
        userRepositoryProvider.overrideWithValue(userRepository),
        todoRepositoryProvider.overrideWithValue(todoRepository),
      ],
    );
  });

  tearDown(() {
    container.dispose();
  });

  group('watch', () {
    test('Todo情報を作ったUserの最新情報を取得できる', () async {
      final todoController = StreamController<List<int>>();

      when(todoRepository.watch()).thenAnswer((_) => todoController.stream);
      when(userRepository.findAll(todoIds: anyNamed('todoIds')))
          .thenAnswer((invocation) async {
        final todoIds =
            invocation.namedArguments[const Symbol('todoIds')] as List<int>;
        final users = todoIds.map((id) {
          switch (id) {
            case 0:
              return 'Alice';
            case 1:
              return 'Bob';
            default:
              return 'Unknown';
          }
        }).toList();
        return users;
      });

      final service = container.read(userTodoServiceProvider);

      final streamQueue = StreamQueue(service.watch());

      todoController.add([0]);

      final result = await streamQueue.next;

      expect(result, ['Alice']);

      todoController.add([0, 1]);

      final result2 = await streamQueue.next;

      expect(result2, ['Alice', 'Bob']);

      await streamQueue.cancel();
      await todoController.close();

      verify(todoRepository.watch()).called(1);
      verify(userRepository.findAll(todoIds: [0])).called(1);
      verify(userRepository.findAll(todoIds: [0, 1])).called(1);
    });
  });
}
