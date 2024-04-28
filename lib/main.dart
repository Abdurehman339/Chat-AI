import 'package:chat_ai/domain/repository/api_repository.dart';
import 'package:chat_ai/presentation/cubit/chat/chat_cubit.dart';
import 'package:chat_ai/presentation/cubit/chat/chat_state.dart';
import 'package:flutter/material.dart';
import 'package:chat_ai/locator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDependecies();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: BlocProvider(
        create: (context) {
          return ChatCubit(
            locator<ApiRepository>(),
          );
        },
        child: const MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late final TextEditingController _controller;
  late final ScrollController _scrollController;
  bool showLoading = false;
  @override
  void initState() {
    _controller = TextEditingController();
    _scrollController = ScrollController();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: const Color.fromRGBO(225, 240, 218, 20),
      body: BlocBuilder<ChatCubit, ChatSuccessState>(
        builder: (context, state) {
          return Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.15,
                decoration: const BoxDecoration(
                  color: Color.fromRGBO(153, 188, 133, 1),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Text(
                        "Chat AI",
                        style: GoogleFonts.montserratAlternates(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 48,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.topCenter,
                  child: ListView.separated(
                    shrinkWrap: true,
                    reverse: true,
                    controller: _scrollController,
                    itemCount: state.messages.length,
                    separatorBuilder: (context, index) => const Divider(
                      color: Colors.transparent,
                    ),
                    itemBuilder: (context, index) {
                      // _scrollController.animateTo(
                      //   _scrollController.position.maxScrollExtent,
                      //   duration: const Duration(milliseconds: 300),
                      //   curve: Curves.easeInOut,
                      // );
                      final message = state.messages[index];
                      return Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        child: Row(
                          mainAxisAlignment: message.role == 'user'
                              ? MainAxisAlignment.end
                              : MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (message.role == 'model')
                              const CircleAvatar(
                                backgroundColor:
                                    Color.fromRGBO(153, 188, 133, 1),
                                child: Icon(
                                  Icons.android,
                                  color: Colors.white,
                                ),
                              ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: message.role == 'user'
                                      ? Colors.blue.shade50
                                      : Colors.grey.shade100,
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      message.parts.first.text,
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: message.role == 'user'
                                            ? Colors.black
                                            : Colors.black87,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            if (message.role == 'user')
                              const CircleAvatar(
                                backgroundColor:
                                    Color.fromRGBO(153, 188, 133, 1),
                                child: Icon(
                                  Icons.person,
                                  color: Colors.white,
                                ),
                              ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
              if (state.isLoading)
                Lottie.network(
                  "https://lottie.host/241490da-8abc-452f-88c0-d59b334dc8db/E4YaERAabY.json",
                  height: 100,
                  width: 100,
                ),
              Container(
                height: MediaQuery.of(context).size.height * 0.15,
                decoration: const BoxDecoration(color: Colors.transparent),
                child: Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: TextField(
                          controller: _controller,
                          autofocus: false,
                          decoration: const InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            focusColor: Colors.white,
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(50),
                              ),
                              borderSide: BorderSide(
                                color: Colors.transparent,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(50),
                              ),
                              borderSide: BorderSide(
                                color: Colors.transparent,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: CircleAvatar(
                        radius: 32,
                        backgroundColor: const Color.fromRGBO(225, 240, 218, 1),
                        child: Padding(
                          padding: const EdgeInsets.all(2),
                          child: InkWell(
                            onTap: () {
                              // _scrollController.animateTo(
                              //   _scrollController.position.maxScrollExtent,
                              //   duration: const Duration(milliseconds: 300),
                              //   curve: Curves.easeInOut,
                              // );
                              final text = _controller.text;
                              _controller.text = '';
                              BlocProvider.of<ChatCubit>(context)
                                  .getAnswer(text);
                            },
                            child: const CircleAvatar(
                              radius: 28,
                              backgroundColor: Color.fromRGBO(153, 188, 133, 1),
                              child: Icon(
                                Icons.send_rounded,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
