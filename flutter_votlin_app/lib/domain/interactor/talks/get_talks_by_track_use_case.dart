import 'package:flutter_votlin_app/domain/interactor/future_interactor_with_params.dart';
import 'package:flutter_votlin_app/domain/model/models.dart';
import 'package:flutter_votlin_app/domain/repository/talks_repository.dart';

class GetTalksByTrackUseCase
    extends FutureInteractorWithParams<GetTalksByTrackResponse, Track> {
  final TalksRepository talksRepository;

  GetTalksByTrackUseCase(this.talksRepository);

  @override
  Future<GetTalksByTrackResponse> run(Track track) async {
    List<Talk> talkList;
    if (track == Track.ALL) {
      talkList = await talksRepository.getTalks();
    } else {
      talkList = await talksRepository.getTalksByTrack(track);
    }
    return GetTalksByTrackResponse()..talkList = talkList;
  }
}

class GetTalksByTrackResponse {
  List<Talk> talkList;
}
