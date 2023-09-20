class ImcModel{
double _peso = 0;
double _altura = 0;
double _imc = 0;
String _classificacao = "";
int _id = 0;

ImcModel(this._id, this._peso, this._altura, this._imc, this._classificacao);

int get id => _id;

  set id(int value) {
    _id = value;
  }

  double get imc => _imc;

  set imc(double value) {
    _imc = value;
  }

  double get peso => _peso;

  set peso(double value) {
    _peso = value;
  }

double get altura => _altura;

  set altura(double value) {
    _altura = value;
  }

String get classificacao => _classificacao;

  set classificacao(String value) {
    _classificacao = value;
  }
}