import 'package:riverpod/riverpod.dart';

class UserRepository {
  UserRepository(this.ref);

  final Ref ref;
  Future<List<String>> findAll({required List<int> todoIds}) async {
    // １００ミリ秒の遅延
    await Future<void>.delayed(const Duration(milliseconds: 100));
    // IDに対応するユーザー名を返す
    final users = todoIds.map(_getUser).toList();

    return users;
  }

  String _getUser(int id) {
    switch (id) {
      case 0:
        return 'Alice';
      case 1:
        return 'Bob';
      default:
        return 'Unknown';
    }
  }
}
