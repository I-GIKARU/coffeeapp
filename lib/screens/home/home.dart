import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:coffee/services/database.dart';
import '../../models/brew.dart';
import 'brew_list.dart';
import 'settings_form.dart';
import '../../services/auth.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Home',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.brown[400],
        elevation: 0, // Removes the shadow
        leading: IconButton(
          icon: Icon(Icons.exit_to_app),
          onPressed: () async {
            await AuthService().signOut();
          },
        ),
      ),
      backgroundColor: Colors.brown[100],
      body: StreamProvider<List<Brew>?>.value(
        value: DatabaseService(uid: '').brews,
        initialData: null,
        child: BrewList(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (context) {
              return Container(
                padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
                ),
                child: SettingsForm(
                  onSettingsUpdated: () {
                    Provider.of<DatabaseService>(context, listen: false).reloadData();
                  },
                ),
              );
            },
          );
        },
        backgroundColor: Colors.brown[400],
        child: const Icon(Icons.settings),
      ),
    );
  }
}
