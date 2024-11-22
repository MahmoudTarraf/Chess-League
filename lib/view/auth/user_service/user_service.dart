import 'package:chess_league/model/user_model.dart';
import 'package:get/get.dart';

class UserService extends GetxService {
  Rx<UserModel?> userModel = Rx<UserModel?>(
    UserModel(
      accessToken: '',
      user: User(
        id: 0,
        username: '',
        email: '',
        image: '',
        rating: 0,
      ),
    ),
  );

  void setUser(UserModel user) {
    userModel.value = user;
  }

  UserModel? get currentUser => userModel.value;
}
