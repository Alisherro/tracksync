import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyGlobalObserver extends BlocObserver {
  // @override
  // void onEvent(Bloc bloc, Object? event) {
  //   super.onEvent(bloc, event);
  //   debugPrint(
  //       '///////////////////////////////////////////////////////////\n'
  //           'EVENT ${bloc.runtimeType} $event');
  // }
  //
  // @override
  // void onChange(BlocBase bloc, Change change) {
  //   super.onChange(bloc, change);
  //   debugPrint('CHANGE ${bloc.runtimeType} $change');
  // }
  //
  // @override
  // void onTransition(Bloc bloc, Transition transition) {
  //   super.onTransition(bloc, transition);
  //   debugPrint('TRANSITION ${bloc.runtimeType} $transition');
  // }
  //
  // @override
  // void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
  //   debugPrint('ERROR ${bloc.runtimeType} $error $stackTrace');
  //   super.onError(bloc, error, stackTrace);
  // }
}
