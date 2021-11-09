import 'package:note_app/models/note.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';

class NoteService {
  final String _dbPath = 'db/note.db';

  final DatabaseFactory dbFactory;

  NoteService() : dbFactory = databaseFactoryIo;

  Future createNote(Note newNote) async {
    Database db = await dbFactory.openDatabase(_dbPath);

    final store = StoreRef.main();

    await store.add(db, newNote.toJson());
  }

  Future<List<Note>> getAllNote() async {
    Database db = await dbFactory.openDatabase(_dbPath);

    final store = StoreRef.main();

    final records = await store.find(db);

    List<Note> notes = records.map((e) {
      Note note = Note.fromJson(e.value);
      note.id = e.key;

      return note;
    }).toList();

    return notes;
  }

  Future updateNote(int id, Note updatedNote) async {
    Database db = await dbFactory.openDatabase(_dbPath);

    final store = StoreRef.main();

    final finder = Finder(filter: Filter.byKey(id));

    await store.update(db, updatedNote.toJson(), finder: finder);
  }

  Future deleteNote(int id) async {
    Database db = await dbFactory.openDatabase(_dbPath);

    final store = StoreRef.main();

    final finder = Finder(filter: Filter.byKey(id));

    await store.delete(db, finder: finder);
  }
}
