import 'package:domain/interactor/future_interactor_with_params.dart';
import 'package:domain/model/models.dart';
import 'package:domain/repository/talks_repository.dart';

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
