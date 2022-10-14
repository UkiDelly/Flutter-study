import 'package:flutter_riverpod/flutter_riverpod.dart';

// family를 쓰면 parameter이 하나 더 생긴다. 이 파라미터는 들어오는 데이터를 의미한다.
// 제너릭에 리턴값과 받을 데이터의 타입을 함께 받게 된다.
final familyModifierProvider = FutureProvider.family<List<int>, int>((ref, data) {
  return List.generate(5, (index) => index * data);
});

// family modifier provider를 생성했을때, 생성한 순간에 어떤 변수를 넣어서, 
// 넣어준 변수로 provider 안의 로직을 변경할때 familiy provider를 사용한다.