import 'package:flutter/material.dart';
import 'package:note_app/models/note.dart';
import 'package:note_app/screens/notes_page.dart';
import 'package:note_app/services/note_service.dart';

class CreateNotePage extends StatefulWidget {
  const CreateNotePage({Key? key}) : super(key: key);

  @override
  _CreateNotePageState createState() => _CreateNotePageState();
}

class _CreateNotePageState extends State<CreateNotePage> {
  String? title;

  String? description;

  final _formKey = GlobalKey<FormState>();

  final NoteService _noteService = NoteService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Note'),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(hintText: 'Title'),
                onSaved: (value) {
                  title = value;
                },
              ),
              TextFormField(
                decoration: InputDecoration(hintText: 'Description'),
                onSaved: (value) {
                  description = value;
                },
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                    onPressed: () async {
                      _formKey.currentState!.save();

                      setState(() {});

                      var newNote = Note(
                          title: title!,
                          description: description!,
                          createdAt: DateTime.now());

                      await _noteService.createNote(newNote);

                      Route<Object?> route =
                          MaterialPageRoute(builder: (ctx) => MyNotesPage());
                      Navigator.push(context, route);
                    },
                    child: Text('Save')),
              )
            ],
          ),
        ),
      ),
    );
  }
}
