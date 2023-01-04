import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'code_generation_provider.g.dart';

// 1) 어떤 Provider를 사용할지 고민할 필요가 없도록 해준다. (12월 31일 기준 아직 StreamProvider는 아직 지원 X)
// 2) Parameter(.family)를 일반 함수처럼 사용할수 있게 해준다.

// code generation test
// 이전에 사용하던 provider 생성방법
final _testProvider = Provider<String>((ref) {
  return 'Hello Code Generation';
});

// annotation을 이용하여 String타입의 state을 반환하는 함수를 만든다.
// 이때 param에 ref를 넣어주는데, 함수와 같은 이름으로 넣어주어야 한다.(첫글자는 대문자로)
// 함수 형태로 만들어져서 훨씬 직관적으로 변함
// 이때 watch하는 방법은 이 함수가 아닌, 이 함수에 Provider가 붙은 getStateProvider를 사용하여 값을 참조
@riverpod
String getState(GetStateRef ref) {
  return 'hello code generation';
}
