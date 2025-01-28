import 'package:flutter/material.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    const String titulo = 'Jogo da Velha';
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: titulo,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomePage(title: titulo),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
    required this.title,
  });

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> _jogo = ['', '', '', '', '', '', '', '', ''];
  String _resultado = '';
  bool _jogador1 = true;

  void _jogar(int indice) {
    setState(() {
      if (_jogo[indice] == '') {
        _jogo[indice] = _jogador1 ? 'X' : 'O';
        _jogador1 = !_jogador1;
        _verificarVencedor();
      }
    });
  }

  void _verificarVencedor() {
    List<List<int>> combinacoes = [
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8],
      [0, 3, 6],
      [1, 4, 7],
      [2, 5, 8],
      [0, 4, 8],
      [2, 4, 6],
    ];

    for (var combinacao in combinacoes) {
      if (_jogo[combinacao[0]] == _jogo[combinacao[1]] &&
          _jogo[combinacao[1]] == _jogo[combinacao[2]] &&
          _jogo[combinacao[0]] != '') {
        _resultado = _jogo[combinacao[0]] == 'X' ? 'Jogador 1 venceu!' : 'Jogador 2 venceu!';
        return;
      }
    }

    if (!_jogo.contains('')) {
      _resultado = 'Empate!';
    }
  }

  void _reiniciar() {
    setState(() {
      _jogo = ['', '', '', '', '', '', '', '', ''];
      _resultado = '';
      _jogador1 = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              child: Container(),
            ),
            Expanded(
              flex: 7,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: Container(),
                  ),
                  Expanded(
                    flex: 2,
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(5.0),
                        border: Border.all(
                          color: Colors.black,
                          width: 1,
                        ),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black45,
                            blurRadius: 10,
                            offset: Offset(5, 5),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: GridView.count(
                          shrinkWrap: true,
                          crossAxisCount: 3,
                          childAspectRatio: 1,
                          children: List.generate(9, (indice) {
                            return GestureDetector(
                              onTap: () => _jogar(indice),
                              child: Container(
                                margin: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.black,
                                    width: 1,
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    _jogo[indice],
                                    style: const TextStyle(fontSize: 30),
                                  ),
                                ),
                              ),
                            );
                          }),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                alignment: Alignment.center,
                child: Text(
                  _resultado,
                  style: const TextStyle(fontSize: 20),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                alignment: Alignment.center,
                child: ElevatedButton(
                  onPressed: _reiniciar,
                  child: const Text('Reiniciar'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}