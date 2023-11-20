import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/core/bloc/base_event.dart';
import 'package:news_app/core/bloc/base_state.dart';

class BaseBloc<Event extends BlocEvent, State extends BlocState>
    extends Bloc<Event, State> {
  BaseBloc(super.initialState);
}
