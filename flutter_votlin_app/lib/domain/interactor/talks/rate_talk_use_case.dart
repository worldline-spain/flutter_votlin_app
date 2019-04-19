import 'package:flutter_votlin_app/domain/interactor/future_interactor_with_params.dart';
import 'package:flutter_votlin_app/domain/model/models.dart';
import 'package:flutter_votlin_app/domain/repository/talks_repository.dart';

class RateTalkUseCase extends FutureInteractorWithParams<bool, TalkRating> {
  final TalksRepository talksRepository;

  RateTalkUseCase(this.talksRepository);

  @override
  Future<bool> run(TalkRating talkRating) {
    return talksRepository.rateTalk(talkRating);
  }
}
