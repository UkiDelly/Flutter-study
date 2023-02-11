import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_study/common/model/model_with_id.dart';
import 'package:flutter_study/common/provider/pagination_provider.dart';
import 'package:flutter_study/common/utils/pagination_utils.dart';

import 'model/cursor_pagination_model.dart';

typedef PaginationWidgetBuilder<T extends IModelWithId> = Widget Function(
  BuildContext context,
  int index,
  T model,
);

/// A [Screen] that handles pagination and
/// set [T] as the type of the data to be paginated
class PaginationListView<T extends IModelWithId> extends ConsumerStatefulWidget {
  const PaginationListView({Key? key, required this.provider, required this.itemBuilder})
      : super(key: key);

  /// Prodiver to use in this screen
  final StateNotifierProvider<PaginationNotifier, CursorPaginationBase> provider;

  /// Widget builder to build widget of type [T] in this screen,
  final PaginationWidgetBuilder<T> itemBuilder;

  @override
  ConsumerState createState() => _PaginationListViewState<T>();
}

class _PaginationListViewState<T extends IModelWithId> extends ConsumerState<PaginationListView> {
  final ScrollController controller = ScrollController();

  void listen() {
    PaginationUtils.paginate(controller: controller, provider: ref.read(widget.provider.notifier));
  }

  @override
  void initState() {
    super.initState();
    controller.addListener(listen);
  }

  @override
  void dispose() {
    controller
      ..removeListener(listen)
      ..dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(widget.provider);

    // 완전 처음 로딩중일때
    if (state is CursorPaginationLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );

      // 에러가 발생할때
    } else if (state is CursorPaginationError) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(state.message, textAlign: TextAlign.center),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () => ref.read(widget.provider.notifier).paginate(forceRefetch: true),
            child: const Text('다시 시'),
          ),
        ],
      );
    }

    final cp = state as CursorPagination<T>;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: ListView.separated(
        controller: controller,
        itemCount: cp.data.length + 1,
        itemBuilder: (context, index) {
          if (index == cp.data.length) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Center(
                child: cp is CursoPaginationFetchingMore
                    ? const CircularProgressIndicator()
                    : const Text(
                        '마지막 데이터입니다',
                      ),
              ),
            );
          }
          // final item = snapshot.data![index];,
          final pItem = cp.data[index];

          return widget.itemBuilder(context, index, pItem);
        },
        separatorBuilder: (context, index) => const Divider(),
      ),
    );
  }
}
