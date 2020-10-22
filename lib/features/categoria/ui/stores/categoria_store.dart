import 'package:kommando/core/api/message.dart';
import 'package:kommando/core/categoria/data/models/categoria.dart';
import 'package:kommando/features/categoria/data/services/categoria_services.dart';
import 'package:kommando/features/categoria/ui/states/categoria_states.dart';
import 'package:mobx/mobx.dart';

part 'categoria_store.g.dart';

class CategoriaStore = _CategoriaStore with _$CategoriaStore;

abstract class _CategoriaStore with Store {
  final CategoriaServices _categoriaServices = CategoriaServices();

  @observable
  CategoriaState state = CategoriaIdleState();

  @action
  CategoriaState setState(CategoriaState value) => this.state = value;

  Future<void> getCategorias() async {
    setState(CategoriaLoadingState());
    await _categoriaServices.fetchCategorias().then((value) {
      if (value is List<Categoria>) {
        setState(CategoriaDoneState(value));
      }
      if (value is Message) {
        setState(CategoriaErrorState(value.message));
      }
    });
  }
}
