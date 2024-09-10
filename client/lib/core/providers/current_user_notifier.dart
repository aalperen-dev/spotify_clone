import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:spotify/core/models/user_model.dart';

part 'current_user_notifier.g.dart';

@Riverpod(keepAlive: true)
class CurrentUserNotifier extends _$CurrentUserNotifier {
  @override
  UserModel? build() {
    return null;
  }

  void addUser(UserModel userModel) {
    state = userModel;
  }
}
