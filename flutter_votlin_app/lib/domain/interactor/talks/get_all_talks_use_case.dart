import 'package:flutter_votlin_app/domain/interactor/future_interactor_no_params.dart';
import 'package:flutter_votlin_app/domain/model/models.dart';
import 'package:flutter_votlin_app/domain/repository/talks_repository.dart';

class GetAllTalksUseCase extends FutureInteractorNoParams<GetAllTalksResponse> {
  final TalksRepository talksRepository;

  GetAllTalksUseCase(this.talksRepository);

  @override
  Future<GetAllTalksResponse> run() async {
    List<Talk> allTalks = await talksRepository.getTalks();
    List<Talk> businessTalks =
        await talksRepository.getTalksByTrack(Track.BUSINESS);
    List<Talk> developmentTalks =
        await talksRepository.getTalksByTrack(Track.DEVELOPMENT);
    List<Talk> makerTalks = await talksRepository.getTalksByTrack(Track.MAKER);

    return GetAllTalksResponse()
      ..allTalks = allTalks
      ..businessTalks = businessTalks
      ..developmentTalks = developmentTalks
      ..makerTalks = makerTalks;
  }
}

class GetAllTalksResponse {
  List<Talk> allTalks;
  List<Talk> businessTalks;
  List<Talk> developmentTalks;
  List<Talk> makerTalks;
}
