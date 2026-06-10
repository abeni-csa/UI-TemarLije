/// Request model for user login
class LoginRequest {
  final String email;
  final String password;

  LoginRequest({required this.email, required this.password});

  /// Converts request object to JSON for API payload
  Map<String, dynamic> toJson() => {'email': email, 'password': password};
}

/// Request model for user registration
class SignupRequest {
  final String email;
  final String password;

  SignupRequest({required this.email, required this.password});

  /// Converts request object to JSON for API payload
  Map<String, dynamic> toJson() => {'email': email, 'password': password};
}

/// Response model for authentication operations (login/signup)
class AuthResponse {
  final String accessToken;
  final String refreshToken;
  final List<String>? recoveryCodes;
  final bool requiresTwoFactor;
  final String? userId;

  AuthResponse({
    required this.accessToken,
    required this.refreshToken,
    this.recoveryCodes,
    this.requiresTwoFactor = false,
    this.userId,
  });

  /// Factory constructor to create AuthResponse from API JSON response
  factory AuthResponse.fromJson(Map<String, dynamic> json) {
    return AuthResponse(
      accessToken: json['access_token'] ?? '',
      refreshToken: json['refresh_token'] ?? '',
      recoveryCodes: json['recovery_codes'] != null
          ? List<String>.from(json['recovery_codes'])
          : null,
      requiresTwoFactor: json['requires_two_factor'] ?? false,
      userId: json['user_id'],
    );
  }
}

/// Configuration model for Two-Factor Authentication setup
class TwoFactorConfig {
  final String otpBase32;
  final String otpAuthUrl;

  TwoFactorConfig({required this.otpBase32, required this.otpAuthUrl});

  /// Factory constructor to create TwoFactorConfig from API JSON response
  factory TwoFactorConfig.fromJson(Map<String, dynamic> json) {
    return TwoFactorConfig(
      otpBase32: json['otp_base32'] ?? '',
      otpAuthUrl: json['otp_auth_url'] ?? '',
    );
  }
}

/// Request model for verifying two-factor authentication code
class VerifyTwoFactorRequest {
  final String code;
  final String? userId;

  VerifyTwoFactorRequest({required this.code, this.userId});

  /// Converts request object to JSON for API payload
  Map<String, dynamic> toJson() => {
    'code': code,
    if (userId != null) 'user_id': userId,
  };
}
