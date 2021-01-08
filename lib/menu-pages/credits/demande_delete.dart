import 'package:flutter/material.dart';

class DemandeDelete extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Attention!"),
      content: Text("Etes-vous sur de vouloir supprimer cette Demande?"),
      actions: [
        FlatButton(
            onPressed: () {
              Navigator.of(context).pop(true);
            },
            child: Text("OUI")),
        FlatButton(
            onPressed: () {
              Navigator.of(context).pop(false);
            },
            child: Text("NON")),
      ],
    );
  }
}
