import 'package:flutter/widgets.dart';
import 'package:scoped_model/scoped_model.dart';

abstract class BaseScopedModel extends Model {
  void destroy();
}

abstract class BaseScopedModelState<SW extends StatefulWidget> extends State<SW> {

  @override
  void initState() {
    super.initState();
    onInitState();
  }

  @override
  void dispose() {
    super.dispose();
    onDispose();
  }

  void onInitState();
  void onDispose();
}
