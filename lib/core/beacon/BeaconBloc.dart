import 'package:bloc/bloc.dart';
import 'package:city_tips/core/beacon/BeaconEvent.dart';
import 'package:city_tips/core/beacon/BeaconState.dart';
import 'package:city_tips/core/repositories/BeacoinRepository.dart';
import 'package:meta/meta.dart';


class BeaconBloc extends Bloc<BeaconEvent, BeaconState>{
    final BeaconRepository beaconRepository;

  BeaconBloc({@required this.beaconRepository}): assert(beaconRepository != null);

  @override
  // TODO: implement initialState
  BeaconState get initialState => BeaconUninitialized();

  @override
  Stream<BeaconState> mapEventToState(
    BeaconState currentState, 
    BeaconEvent event
    )async * {
      if(event is AppStarted){
        yield BeaconSuccess();
      }
   
  }
}