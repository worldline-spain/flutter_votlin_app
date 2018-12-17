import 'package:domain/interactor/future_interactor_with_params.dart';
import 'package:domain/model/models.dart';
import 'package:domain/repository/talks_repository.dart';

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
