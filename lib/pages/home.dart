import 'package:flutter/material.dart';
import 'package:imc_flutter/model/imc_model.dart';
import 'package:imc_flutter/repository/imc_repository.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  double imc = 0;
  String classificacao = "";
  TextEditingController pesoController = TextEditingController();
  TextEditingController alturaController = TextEditingController();
  ImcRepository imcRepository = ImcRepository();
  var _imcs = const <ImcModel>[];

  @override
  void initState() {
    obterImcs();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Calcular IMC")),
      body:  Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),

        child: ListView.builder(
         itemCount: _imcs.length,
          itemBuilder: (BuildContext bc, int index){
           var imc = _imcs[index];
           return ListTile(
             leading: const Icon(Icons.image_search),
             title:  Text(imc.classificacao),
             subtitle: Row(
               mainAxisAlignment: MainAxisAlignment.spaceBetween,
               children:  [
                 Text('''Peso: ${imc.peso.toString()} '''),
                 Text('''Altura: ${imc.altura.toString()} '''),
                 Text('''Imc: ${imc.imc.toString()} '''),
               ],
             ),);
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          _alertImc();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
  void obterImcs() async {
    _imcs = await imcRepository.listar();
    setState(() {

    });

  }

  _alertImc(){

    showDialog(context: context, builder: (BuildContext context){
      return AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10)
        ),
        alignment: Alignment.center,
        elevation: 8,
        title: const Text("Calcular IMC"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children:  [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TextField(
                keyboardType: TextInputType.number,

                decoration: const InputDecoration(
                    hintText: "Peso"
                ),
                controller: pesoController,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TextField(
                keyboardType: TextInputType.number,

                decoration: const InputDecoration(
                    hintText: "Altura"
                ),
                 controller: alturaController,
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
              onPressed: (){
                _salvarImc(double.parse(pesoController.text), double.parse(alturaController.text));
                Navigator.of(context).pop();

              }, child: const Text("Calcular")),
          TextButton(
              onPressed: (){
                Navigator.of(context).pop();
              },
              child: const Text("Cancelar"))
        ],
      );
    });

  }
  Future<void> _salvarImc(double peso, double altura) async {


    double resultado = peso / (altura * altura);

    if (resultado < 16) {
      classificacao = "magreza grave";
    } else if (resultado >= 16 && resultado < 17) {
      classificacao = "magreza moderada";
    } if (resultado >= 17 && resultado < 18.5) {
      classificacao = "magreza leve";
    } else if (resultado >= 18.5 && resultado < 25) {
      classificacao = "saudavel";
    } if (resultado >= 25 && resultado < 30) {
      classificacao = "sobrepeso";
    } else if (resultado >= 30 && resultado < 35) {
      classificacao = "Obesidade I";
    }else if (resultado >= 35 && resultado < 40) {
      classificacao = "Obesidade II";
    }else if (resultado >= 40.0 ) {
      classificacao = "Obesidade III";
    }

    setState(() {
      imc = resultado;
      classificacao;
    });

    ImcModel model = ImcModel(0, peso, altura, imc, classificacao);

    await imcRepository.salvar(model);

    obterImcs();
    clearControllers();
    setState(() {});
  }
  void clearControllers(){
    pesoController.clear();
    alturaController.clear();
  }
}
