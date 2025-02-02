import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:stream_test_sample/data/repositories/user/repository.dart';

part 'provider.g.dart';

@riverpod
UserRepository userRepository(Ref ref) => UserRepository(ref);
