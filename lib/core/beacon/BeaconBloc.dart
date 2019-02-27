import 'package:bloc/bloc.dart';
import 'package:city_tips/core/beacon/BeaconEvent.dart';
import 'package:city_tips/core/beacon/BeaconState.dart';
import 'package:city_tips/core/model/Beacon.dart';
import 'package:city_tips/core/model/User.dart';
import 'package:city_tips/core/repositories/UserRepository.dart';
import 'package:meta/meta.dart';


class BeaconBloc extends Bloc<BeaconEvent, BeaconState>{
  final UserRepository userRepository;

  BeaconBloc({@required this.userRepository}): assert(userRepository != null);

  @override
  BeaconState get initialState => BeaconUninitialized();

  @override
  Stream<BeaconState> mapEventToState(
    BeaconState currentState, 
    BeaconEvent event
    )async * {
      if(event is AppStarted){
        yield BeaconSuccess();
        try{
          final User user = await userRepository.getUser(); 
          final List<Beacon> beacons = user.beacons; 

        } catch(error){
          print(error);
        }
      }
   
  }
}