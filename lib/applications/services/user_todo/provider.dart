import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:stream_test_sample/applications/services/user_todo/service.dart';

part 'provider.g.dart';

@riverpod
UserTodoService userTodoService(Ref ref) => UserTodoService(ref);
