import 'package:flutter_votlin_app/core/threading/future_interactor_with_params.dart';
import 'package:flutter_votlin_app/features/talks/models.dart';
import 'package:flutter_votlin_app/features/talks/repositories.dart';

class GetTalkDetailUseCase
    extends FutureInteractorWithParams<GetTalkDetailResponse, Talk> {
  final TalksRepository talksRepository;

  GetTalkDetailUseCase(this.talksRepository);

  @override
  Future<GetTalkDetailResponse> run(Talk talk) async {
    Talk talkWithDetail = await talksRepository.getTalkById(talk.id);
    return GetTalkDetailResponse()..talk = talkWithDetail;
  }
}

class GetTalkDetailResponse {
  Talk talk;
}
