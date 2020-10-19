import 'package:kommando/core/categoria/data/models/categoria.dart';

abstract class ICategoria {
  Future pushCategoria({Categoria categoria});
  Future fetchCategorias();
  Future fetchCategoriaById({String id});
  Future updateCategoria({Categoria categoria});
  Future deleteCategoria({String id});
}