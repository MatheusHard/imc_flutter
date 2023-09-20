import 'package:imc_flutter/db/database_sqflitte.dart';
import 'package:imc_flutter/model/imc_model.dart';

class ImcRepository{

  Future<List<ImcModel>> listar () async {

    List<ImcModel> imcs = [];
    var db = await DataBaseSqFlitte().obterDatabase();
    var result = await db.rawQuery("SELECT id, peso, altura, imc, classificacao FROM tabela_imc");
    for(var item in result){
      imcs.add(ImcModel(int.parse(item["id"].toString()),
                        double.parse(item["peso"].toString()),
                        double.parse(item["altura"].toString()),
                        double.parse(item["imc"].toString()),
                        item["classificacao"].toString()));
    }
    return imcs;
  }
  Future<void> salvar(ImcModel model) async{
    var db = await DataBaseSqFlitte().obterDatabase();
    await db.rawInsert("INSERT INTO tabela_imc (peso, altura, imc, classificacao) values (?,?, ?, ?)",
        [model.peso, model.altura, model.imc, model.classificacao]);

  }
}