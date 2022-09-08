import 'dart:io';

final loginApi = Platform.isIOS
    ? "http://localhost:3000/auth/login"
    : "http://10.0.2.2: 3000/auth/login";
