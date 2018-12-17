import 'package:domain/interactor/future_interactor_with_params.dart';
import 'package:domain/model/models.dart';
import 'package:domain/repository/talks_repository.dart';

class RateTalkUseCase extends FutureInteractorWithParams<bool, TalkRating> {
  final TalksRepository talksRepository;

  RateTalkUseCase(this.talksRepository);

  @override
  Future<bool> run(TalkRating talkRating) {
    return talksRepository.rateTalk(talkRating);
  }
}
