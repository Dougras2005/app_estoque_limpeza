import 'package:flutter/material.dart';

class UsuariosPage extends StatefulWidget {
  const UsuariosPage({super.key});

  @override
  UsuariosPageState createState() => UsuariosPageState();
}

class UsuariosPageState extends State<UsuariosPage> {
  // Controladores para os campos de texto
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _telefoneController = TextEditingController();
  final TextEditingController _matriculaController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  // Lista de perfis disponíveis
  final List<String> _perfis = ['Administrador', 'Usuário'];
  String? _perfilSelecionado;

  // Chave global para o formulário
  final _formKey = GlobalKey<FormState>();

  // Método para cadastrar usuário
  void _cadastrarUsuario() {
    if (_formKey.currentState!.validate()) {
      print('Nome: ${_nomeController.text}');
      print('Telefone: ${_telefoneController.text}');
      print('Matrícula: ${_matriculaController.text}');
      print('Email: ${_emailController.text}');
      print('Perfil: $_perfilSelecionado');

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Usuário cadastrado com sucesso!')),
      );

      // Limpar os campos após cadastro
      _nomeController.clear();
      _telefoneController.clear();
      _matriculaController.clear();
      _emailController.clear();
      setState(() {
        _perfilSelecionado = null;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Por favor, corrija os erros no formulário!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastro de Usuário'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _nomeController,
                decoration: const InputDecoration(
                  labelText: 'Nome',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'O nome é obrigatório';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _telefoneController,
                decoration: const InputDecoration(
                  labelText: 'Telefone',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'O telefone é obrigatório';
                  }
                  if (!RegExp(r'^\d+$').hasMatch(value)) {
                    return 'Digite apenas números';
                  }
                  if (value.length < 10 || value.length > 11) {
                    return 'Informe um telefone válido com 10 ou 11 dígitos';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _matriculaController,
                decoration: const InputDecoration(
                  labelText: 'Matrícula',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'A matrícula é obrigatória';
                  }
                  if (value.length != 8) {
                    return 'A matrícula deve conter 8 caracteres';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'O email é obrigatório';
                  }
                  if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                    return 'Informe um email válido';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  labelText: 'Perfil',
                  border: OutlineInputBorder(),
                ),
                value: _perfilSelecionado,
                items: _perfis
                    .map((perfil) => DropdownMenuItem(
                          value: perfil,
                          child: Text(perfil),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _perfilSelecionado = value;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, selecione um perfil';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 32),
              Center(
                child: ElevatedButton(
                  onPressed: _cadastrarUsuario,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 32, vertical: 12),
                  ),
                  child: const Text('Cadastrar'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
