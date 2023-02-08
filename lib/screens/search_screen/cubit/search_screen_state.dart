part of 'search_screen_cubit.dart';

abstract class SearchScreenState extends Equatable {
  const SearchScreenState();

  @override
  List<Object> get props => [];
}

class SearchScreenInitial extends SearchScreenState {}

class DataListFetched extends SearchScreenState {
  final List<SearchData> list;

  const DataListFetched(this.list);

  @override
  List<Object> get props => [list];
}

class FetchingDataList extends SearchScreenState {
  final String text;
  const FetchingDataList(this.text);

  @override
  List<Object> get props => [text];
}

class DataListFetchFailed extends SearchScreenState {}
