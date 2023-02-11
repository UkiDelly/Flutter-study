import 'package:flutter_riverpod/flutter_riverpod.dart';

class Account {}

// StateNotifier를 참조하는 Provider
final accountNotifierProvider = StateNotifierProvider<AccountNotifier, Account>((ref) {
  return AccountNotifier();
});

// StateNotifier, ChangeNotifier과 같은 기능, Account을 반환
class AccountNotifier extends StateNotifier<Account> {
  // 현재 state는 Account 인트턴스
  AccountNotifier() : super(Account());

  void updateAccount(Account account) {
    // state을 새로운 account 인스턴스로 업데이트
    state = account;
  }
}

// StateProvider, 리턴값 원하는 타입으로설정 가능
final anotherProvider = StateProvider<dynamic>((ref) {

  // accountNotifierProvider를 참조
  final account = ref.watch(accountNotifierProvider.notifier);

  // updateAccouunt 함수 호출
  account.updateAccount(Account());
});
