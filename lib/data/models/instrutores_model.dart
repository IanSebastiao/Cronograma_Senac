class Instrutores {
  final int? idInstrutores;
  final String nomeInstrutor;

  Instrutores({
    this.idInstrutores,
    required this.nomeInstrutor, required String nome,
  });

  Map<String, dynamic> toMap() {
    return {
      'idInstrutores': idInstrutores,
      'nome_instrutor': nomeInstrutor,
    };
  }
}