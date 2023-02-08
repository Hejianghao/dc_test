import 'package:dc_test/model/search_data.dart';
import 'package:dc_test/networking/repository/search_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'search_screen_state.dart';

class SearchScreenCubit extends Cubit<SearchScreenState> {
  SearchScreenCubit() : super(SearchScreenInitial());

  Future<void> searchText(String text) async {
    emit(FetchingDataList(text));
    final result = await SearchRepository().getSearchResult(
      text,
      noThrottle: text != 'Test',
    );
    if (result.isRight) {
      emit(DataListFetched(List.from(result.right)));
    } else {
      emit(DataListFetchFailed());
    }
  }
}
