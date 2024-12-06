import 'package:cronograma/data/models/cursos_model.dart';
import 'package:cronograma/data/repositories/cursos_repository.dart';
import 'package:cronograma/presentation/viewmodels/cursos_viewmodels.dart';
import 'package:flutter/material.dart';

class CadastroUnidadesCurricularesPage extends StatefulWidget {
  const CadastroUnidadesCurricularesPage({super.key});

  @override
  State<CadastroUnidadesCurricularesPage> createState() => _CadastroUnidadesCurricularesPageState();
}

class _CadastroUnidadesCurricularesPageState extends State<CadastroUnidadesCurricularesPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _cargaHorariaController = TextEditingController();

  CursosViewModel cursosViewModel = CursosViewModel(CursosRepository());
  List<Cursos> cursos = [];
  Cursos? cursoSelecionado;

  @override
  void initState() {
    super.initState();
    _carregarCursos();
  }

  Future<void> _carregarCursos() async {
    List<Cursos> listaCursos = await cursosViewModel.getCursos();
    setState(() {
      cursos = listaCursos;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastro de Unidade Curricular'),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Preencha os dados da Unidade Curricular',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _nomeController,
                decoration: const InputDecoration(
                  labelText: 'Nome',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o nome';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _cargaHorariaController,
                decoration: const InputDecoration(
                  labelText: 'Carga Horária',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira a carga horária';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              DropdownButtonFormField<Cursos>(
                value: cursoSelecionado,
                items: cursos.map((curso) {
                  return DropdownMenuItem<Cursos>(
                    value: curso,
                    child: Text(curso.nomeCurso),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    cursoSelecionado = value;
                  });
                },
                decoration: const InputDecoration(
                  labelText: 'Curso',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null) {
                    return 'Por favor, selecione um curso';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Cadastro realizado com sucesso!')),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 40),
                  textStyle: const TextStyle(fontSize: 18),
                ),
                child: const Text('Cadastrar Unidade Curricular'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
