import 'package:equatable/equatable.dart';
import 'package:bloc/bloc.dart';
import '../repositories/images_repository.dart';

class ImagesEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchImages extends ImagesEvent {
  final _searchValue;
  FetchImages(this._searchValue);

  @override
  List<Object?> get props => [_searchValue];
}

class ResetImages extends ImagesEvent {}

class ImagesState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ImagesAreNotSearched extends ImagesState {}

class ImagesAreLoading extends ImagesState {}

class ImagesAreLoaded extends ImagesState {
  final _images;
  ImagesAreLoaded(this._images);

  List<dynamic> get getData => _images;

  @override
  List<Object?> get props => [_images];
}

class ImagesAreNotLoaded extends ImagesState {}

class ImagesBloc extends Bloc<ImagesEvent, ImagesState> {
  ImagesRepository imagesRepository;
  ImagesBloc(this.imagesRepository) : super(ImagesAreNotSearched());

  @override
  Stream<ImagesState> mapEventToState(ImagesEvent event) async* {
    if (event is FetchImages) {
      yield ImagesAreLoading();
      try {
        final images = await imagesRepository.getImages(event._searchValue);
        yield ImagesAreLoaded(images);
      } catch (_) {
        yield ImagesAreNotLoaded();
      }
    } else if (event is ResetImages) {
      yield ImagesAreNotSearched();
    }
  }
}
