abstract class DbMapper<M> {
  M toModel(Map<String, dynamic> map);

  Map<String, dynamic> toMap(M model);
}
