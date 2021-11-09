import 'package:flutter/material.dart';
import 'package:note_app/models/note.dart';
import 'package:note_app/screens/create_page.dart';
import 'package:note_app/services/note_service.dart';

class MyNotesPage extends StatefulWidget {
  const MyNotesPage({Key? key}) : super(key: key);

  @override
  _MyNotesPageState createState() => _MyNotesPageState();
}

class _MyNotesPageState extends State<MyNotesPage> {
  final NoteService _noteService = NoteService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notes'),
      ),
      body: FutureBuilder(
        future: _noteService.getAllNote(),
        builder: (ctx, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          } else if (snapshot.hasData) {
            var notes = snapshot.data as List<Note>;
            return ListView.builder(
                itemCount: notes.length,
                itemBuilder: (ctx, index) {
                  var note = notes[index];
                  return ListTile(
                    leading: Text("${note.id}"),
                    title: Text("${note.title}"),
                  );
                });
          }

          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Route<Object?> route =
              MaterialPageRoute(builder: (ctx) => CreateNotePage());
          Navigator.push(context, route);
        },
      ),
    );
  }
}
