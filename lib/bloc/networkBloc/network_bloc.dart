import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'network_events.dart';
import 'network_states.dart';


class NetworkBloc extends Bloc<NetworkEvent, NetworkState> {


  StreamSubscription _subscription;

  NetworkBloc() : super(ConnectionInitial());



  @override
  Stream<NetworkState> mapEventToState(NetworkEvent event) async* {
    if (event is ListenConnection) {
      _subscription = DataConnectionChecker().onStatusChange.listen((status) {
        add(ConnectionChanged(status == DataConnectionStatus.disconnected
            ? ConnectionFailure()
            : ConnectionSuccess()));
      });
    }
    if (event is ConnectionChanged) yield event.connection;
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }



}

