import 'package:flutter_test/flutter_test.dart';
import 'package:kommando/core/api/api.dart';
import 'package:kommando/core/categoria/data/models/categoria.dart';
import 'package:kommando/features/categoria/data/services/categoria_services.dart';

void main() {
  final CategoriaServices _categoriaServices = CategoriaServices();

  Api.url = "http://localhost:8080";

  test("Deve criar uma categoria", () async {
    final categoria = await _categoriaServices
        .pushCategoria(categoria: Categoria(nome: "Categoria Teste 44444"))
        .then((value) {
      expect(value.id, isNotEmpty);
      return value;
    });

    if (categoria is Categoria) {
      await _categoriaServices
          .deleteCategoria(id: categoria.id)
          .then((value) => expect(value.message, categoria.id));
    }
  });

  test("Busca lista", () async {
    final list =
        List.generate(3, (index) => Categoria(nome: "Categoria $index"));

    for (var categoria in list) {
      await _categoriaServices
          .pushCategoria(categoria: categoria)
          .then((value) => expect(value.id, isNotEmpty));
    }

    final currentList = await _categoriaServices.fetchCategorias();

    if (currentList is List<Categoria>) {
      for (var categoria in currentList) {
        if (categoria.id != "5f8de73f3eafda2d7f8c2c64")
          _categoriaServices
              .deleteCategoria(id: categoria.id)
              .then((value) => expect(value.message, categoria.id));
      }
    }
  });
}
