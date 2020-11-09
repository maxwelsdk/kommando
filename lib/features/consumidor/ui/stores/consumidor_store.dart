import 'package:kommando/core/api/message.dart';
import 'package:kommando/core/consumidor/data/models/consumidor.dart';
import 'package:kommando/features/consumidor/data/services/consumidor_services.dart';
import 'package:kommando/features/consumidor/ui/states/consumidor_states.dart';
import 'package:mobx/mobx.dart';

part 'consumidor_store.g.dart';

class ConsumidorStore = _ConsumidorStore with _$ConsumidorStore;

abstract class _ConsumidorStore with Store {
  final ConsumidorServices _consumidorServices = ConsumidorServices();

  @observable
  ConsumidorState state = ConsumidorIdleState();

  @action
  ConsumidorState setState(ConsumidorState value) => this.state = value;


  Future<void> pushConsumidor({Consumidor consumidor}) async {
    final _responseConsumidor = await _consumidorServices.pushConsumidor(
        consumidor: consumidor);
    if (_responseConsumidor is Message) {
      setState(ConsumidorErrorState(_responseConsumidor.message));
    }
    if (_responseConsumidor is Consumidor) {
      setState(ConsumidorCreatedState(_responseConsumidor));
    }
  }
}
