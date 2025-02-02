import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:stream_test_sample/data/repositories/todo/repository.dart';

part 'provider.g.dart';

@riverpod
TodoRepository todoRepository(Ref ref) => TodoRepository(ref);
