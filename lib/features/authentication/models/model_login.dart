import 'package:equatable/equatable.dart';

class UserTokenModel extends Equatable {
  final String accessToken;
  final String refreshToken;
  final List<String>? recoveryCodes;

  const UserTokenModel({
    required this.accessToken,
    required this.refreshToken,
    this.recoveryCodes,
  });

  // Factory constructor to create a UserTokenModel from JSON data
  factory UserTokenModel.fromJson(Map<String, dynamic> json) {
    return UserTokenModel(
      accessToken: json['access_token'] as String,
      refreshToken: json['refresh_token'] as String,
      recoveryCodes: json.containsKey('recovery_codes')
          ? List<String>.from(json['recovery_codes'] as List)
          : null,
    );
  }

  @override
  List<Object?> get props => [accessToken, refreshToken, recoveryCodes];
}

class RefreshUserTokenRequestModel {
  final String refreshToken;

  const RefreshUserTokenRequestModel({required this.refreshToken});

  Map<String, dynamic> toJson() {
    return {'refresh_token': refreshToken};
  }
}

class RegisterUserRequestModel {
  final String email;
  final String password;

  const RegisterUserRequestModel({required this.email, required this.password});

  Map<String, dynamic> toJson() {
    return {'email': email, 'password': password};
  }
}

class LoginUserRequestModel {
  final String email;
  final String password;

  const LoginUserRequestModel({required this.email, required this.password});

  Map<String, dynamic> toJson() {
    return {'email': email, 'password': password};
  }
}

class UserToken {
  final String accessToken;
  final String refreshToken;
  final List<String>? recoveryCodes;

  const UserToken({
    required this.accessToken,
    required this.refreshToken,
    this.recoveryCodes,
  });
}
