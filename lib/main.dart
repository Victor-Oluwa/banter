import 'package:banter/core/local_database/hive_boxes.dart';
import 'package:banter/core/services/injection/auth_injection.dart';
import 'package:banter/core/services/injection/note_manager/note_manager_injection.dart';
import 'package:banter/src/auth_manager/presentation/bloc/auth_bloc.dart';
import 'package:banter/src/auth_manager/presentation/view/login.dart';
import 'package:banter/src/auth_manager/presentation/view/sign_up.dart';
import 'package:banter/src/auth_manager/presentation/view/verification_screen.dart';
import 'package:banter/src/note_manager/domain/entity/note_entity.dart';
import 'package:banter/src/note_manager/presentation/bloc/note_manager_bloc.dart';
import 'package:banter/src/note_manager/presentation/listeners/auth_global_listener.dart';
import 'package:banter/src/note_manager/presentation/listeners/notes_global_listener.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'src/note_manager/presentation/view/note_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  Hive.registerAdapter(NoteEntityAdapter());
  Hive.registerAdapter(FolderEntityAdapter());

  await Hive.openBox<NoteEntity>('notes');
  await Hive.openBox<NoteEntity>('deletedNotes');
  await Hive.openBox<FolderEntity>('folder');
  await Hive.openBox<String>('accessToken');
  await Hive.openBox<String>('refreshToken');
  await Hive.openBox<String>('userHash');
  await Hive.openBox<DateTime>('lastSyncTime');

  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<NoteManagerBloc>(create: (context) => ref.read(noteManagerBlocProvider)),
        BlocProvider<AuthBloc>(create: (context) => ref.read(authBlocProvider)),
      ],
      child: MultiBlocListener(
        listeners: [
          BlocListener<NoteManagerBloc, NoteManagerState>(
            listener: (context, state) {
              NotesGlobalListener().noteBlocListener(
                context: context,
                state: state,
                ref: ref,
              );
            },
          ),
          BlocListener<AuthBloc, AuthState>(listener: (context, state) {
            AuthGlobalListener().authBlocListener(
              context: context,
              state: state,
              ref: ref,
            );
          }),
        ],
        child: GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Banter',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          home: const VerificationScreen(),
        ),
      ),
    );
  }
}
