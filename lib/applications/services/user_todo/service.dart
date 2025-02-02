import 'package:riverpod/riverpod.dart';
import 'package:stream_test_sample/data/repositories/todo/provider.dart';
import 'package:stream_test_sample/data/repositories/todo/repository.dart';
import 'package:stream_test_sample/data/repositories/user/provider.dart';
import 'package:stream_test_sample/data/repositories/user/repository.dart';

class UserTodoService {
  UserTodoService(this.ref);

  final Ref ref;

  UserRepository get userRepository => ref.read(userRepositoryProvider);

  TodoRepository get todoRepository => ref.read(todoRepositoryProvider);

  Stream<List<String>> watch() async* {
    final todoStream = todoRepository.watch();

    await for (final todoIds in todoStream) {
      final users = await userRepository.findAll(todoIds: todoIds);
      yield users;
    }
  }
}
