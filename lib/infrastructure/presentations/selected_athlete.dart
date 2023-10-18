import 'package:flutter/material.dart';

class SelAthlete extends StatelessWidget {
  const SelAthlete({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text("Seleção de Atleta"),
        centerTitle: true,
      ),
      body: ListView(
        children: const [
          SizedBox(height: 30,),
          ListTile(
            title: Text("João"),
            trailing: Icon(Icons.arrow_forward_outlined),
          ),
          ListTile(
            title: Text("João"),
            trailing: Icon(Icons.arrow_forward_outlined),
          ),
          ListTile(
            title: Text("João"),
            trailing: Icon(Icons.arrow_forward_outlined),
          ),
          ListTile(
            title: Text("João"),
            trailing: Icon(Icons.arrow_forward_outlined),
          ),
          ListTile(
            title: Text("João"),
            trailing: Icon(Icons.arrow_forward_outlined),
          ),ListTile(
            title: Text("João"),
            trailing: Icon(Icons.arrow_forward_outlined),
          )
        ],
      ),
    );
  }
}
