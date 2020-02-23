import 'package:flutter_votlin_app/core/threading/future_interactor_with_params.dart';
import 'package:flutter_votlin_app/features/talks/models.dart';
import 'package:flutter_votlin_app/features/talks/repositories.dart';

class RateTalkUseCase extends FutureInteractorWithParams<bool, TalkRating> {
  final TalksRepository talksRepository;

  RateTalkUseCase(this.talksRepository);

  @override
  Future<bool> run(TalkRating talkRating) {
    return talksRepository.rateTalk(talkRating);
  }
}
