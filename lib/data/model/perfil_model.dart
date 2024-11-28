class Perfil {
  final int? idperfil;
  final String perfil;

  Perfil({this.idperfil, required this.perfil});

  Map<String, dynamic> toMap() {
    return {
      'idperfil': idperfil,
      'perfil': perfil,
    };
  }
}
