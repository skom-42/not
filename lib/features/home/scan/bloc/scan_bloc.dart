import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navigation/navigation.dart';

part 'scan_event.dart';

part 'scan_state.dart';

class ScanBloc extends Bloc<ScanEvent, ScanState> {
  final AppRouterDelegate _appRouter;

  ScanBloc({
    required AppRouterDelegate appRouter,
  })  : _appRouter = appRouter,
        super(ContentState()) {
    on<HandleQrCode>(_onHandleQrCode);
  }

  Future<void> _onHandleQrCode(HandleQrCode event, Emitter<ScanState> emit) async {}
}
