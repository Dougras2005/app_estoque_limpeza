class Movimentacao {
  final int? idmovimentacao;
  final String saida;
  final int idmaterial;
  final int idusuario;

  Movimentacao({
    this.idmovimentacao,
    required this.saida,
    required this.idmaterial,
    required this.idusuario,
  });

  Map<String, dynamic> toMap() {
    return {
      'idmovimentacao': idmovimentacao,
      'saida': saida,
      'idmaterial': idmaterial,
      'idusuario': idusuario,
    };
  }
}
