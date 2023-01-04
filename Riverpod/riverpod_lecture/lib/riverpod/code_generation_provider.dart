// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'code_generation_provider.g.dart';

//? 1) 어떤 Provider를 사용할지 고민할 필요가 없도록 해준다. (12월 31일 기준 아직 StreamProvider는 아직 지원 X)

// --------------------------------------------------------------------------------------------------------
// code generation test
// 이전에 사용하던 provider 생성방법
final _testProvider = Provider<String>((ref) {
  return 'Hello Code Generation';
});

// annotation을 이용하여 String타입의 state을 반환하는 함수를 만든다.
// 이때 param에 ref를 넣어주는데, 함수와 같은 이름으로 넣어주어야 한다.(첫글자는 대문자로)
// 함수 형태로 만들어져서 훨씬 직관적으로 변함
// 이때 watch하는 방법은 이 함수가 아닌, 이 함수에 Provider가 붙은 getStateProvider를 사용하여 값을 참조
// 이때 생성된 provider는 autoDisposeProvider로 생성된다.
//* 일반적인 provider
@riverpod
String getState(GetStateRef ref) {
  return 'hello code generation';
}
// --------------------------------------------------------------------------------------------------------

// future provider
// --------------------------------------------------------------------------------------------------------
// 원래 Future provider는 cache 되지만 지금 생성한 provider는 기본적으로 autoDisposeProvider이라 cache되지 않는다.
//* Future provider 하지만 autoDispose
@riverpod
Future<int> getStateFuture(GetStateFutureRef ref) async {
  return await Future.delayed(const Duration(seconds: 3), () => 10);
}

// 대문자 Riverpod을 쓸때는 무조건 param을 받기 때문에 무조건 ()를 넣어야한다.
//* Future provider 하지만 keep alive
@Riverpod(
  // 살려둘지 말지 결정 true = 계속 살려두고, false = 살려두지 않음
  keepAlive: true,
)
Future<int> getStateFuture2(GetStateFuture2Ref ref) async {
  return await Future.delayed(const Duration(seconds: 3), () => 10);
}
// --------------------------------------------------------------------------------------------------------

//? 2) Parameter(.family)를 일반 함수처럼 사용할수 있게 해준다.
// family
// --------------------------------------------------------------------------------------------------------
// 기존 .family
class Parameter {
  final int number1;
  final int number2;

  const Parameter({
    required this.number1,
    required this.number2,
  });
}

// param으로 받을수 있는 갯수가 하나뿐이기 때문에 여러 개를 받을때는 class를 만들어서 받아야한다.
final _testFamilyProvider = Provider.family<int, Parameter>((ref, param) {
  return param.number1 * param.number2;
});

// class를 만들 필요없이 함수의 파라미터로 받을 수 있다.
@riverpod
int getStateMultiply(
  GetStateMultiplyRef ref, {
  required int number1,
  required int number2,
}) {
  return number1 * number2;
}
// --------------------------------------------------------------------------------------------------------


//? StateNotifierProvider, StateNotifier
// --------------------------------------------------------------------------------------------------------
@riverpod
class GetStateNotifier extends _$GetStateNotifier {
  // 초기 상태를 지정해주는 함수를 오버라이드
  @override
  int build() {
    return 0;
  }

  // 상태를 변경하는 함수
  void increment() {
    state++;
  }

  // 상태를 변경하는 함수
  void decrement() {
    state--;
  }


}
