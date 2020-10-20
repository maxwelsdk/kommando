import 'package:kommando/core/categoria/data/models/categoria.dart';

abstract class CategoriaState {}
class CategoriaIdleState implements CategoriaState {}
class CategoriaLoadingState implements CategoriaState {}
class CategoriaErrorState implements CategoriaState {
  final String message;

  CategoriaErrorState(this.message);
}
class CategoriaDoneState implements CategoriaState {
  final List<Categoria> categorias;

  CategoriaDoneState(this.categorias);
}