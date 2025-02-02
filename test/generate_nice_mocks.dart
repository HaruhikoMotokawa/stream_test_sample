import 'package:mockito/annotations.dart';
import 'package:stream_test_sample/data/repositories/todo/repository.dart';
import 'package:stream_test_sample/data/repositories/user/repository.dart';

@GenerateNiceMocks([
  MockSpec<TodoRepository>(),
  MockSpec<UserRepository>(),
])
void main() {}
