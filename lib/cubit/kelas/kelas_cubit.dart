import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'kelas_state.dart';

class KelasCubit extends Cubit<KelasState> {
  KelasCubit() : super(KelasInitial());
}
