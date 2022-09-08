import 'dart:io';

final loginApi = Platform.isIOS
    ? "http://localhost:3000/auth"
    : "http://10.0.2.2: 3000/auth";
