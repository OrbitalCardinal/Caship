import 'package:flutter/material.dart';
import '../widgets/square_avatar.dart';

class RequestScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            decoration: InputDecoration(
              labelText: "Buscar",
              border: OutlineInputBorder(),
              suffixIcon: Icon(Icons.search)
            ),
          ),
          SizedBox(height: 20),
          Text("Contactos usando caship:",
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
          Divider(
            color: Colors.grey,
            thickness: 1,
          ),
          Column(
            children: [],
          ),
          Expanded(
            child: ListView.separated(
              itemBuilder: (ctx, items) {
                return ListTile(
                  onTap: () {

                  },
                  leading: SquareAvatar("https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixid=MXwxMjA3fDB8MHxzZWFyY2h8NHx8YXZhdGFyfGVufDB8fDB8&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60"),
                  title: Text(
                    "Edson Raul Cepeda Marquez",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                  subtitle: Text("Mexico\n" + "+52 8122942626"),
                  isThreeLine: true,
                  trailing: IconButton(
                    icon: Icon(Icons.favorite_border),
                    onPressed: () {},
                  ),
                );
              },
              itemCount: 10,
              separatorBuilder: (context, index) => Divider(),
            ),
          )
        ],
      ),
    );
  }
}