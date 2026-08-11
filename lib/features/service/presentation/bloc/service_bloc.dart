import 'package:bloc/bloc.dart';

part 'service_event.dart';
part 'service_state.dart';

class ServiceBloc extends Bloc<ServiceEvent, ServiceState> {
  ServiceBloc() : super(ServiceInitial()) {
    on<ServiceEvent>((event, emit) {});
  }
}
