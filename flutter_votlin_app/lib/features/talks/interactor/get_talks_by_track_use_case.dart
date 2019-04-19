import 'package:flutter_votlin_app/core/threading/future_interactor_with_params.dart';
import 'package:flutter_votlin_app/features/talks/models.dart';
import 'package:flutter_votlin_app/features/talks/repositories.dart';

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
