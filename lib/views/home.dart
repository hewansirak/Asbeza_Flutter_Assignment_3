import 'package:asbeza/bloc/asbeza_state.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import '../bloc/asbeza_bloc.dart';
import '../bloc/asbeza_event.dart';
import '../main.dart';
import '../model/item.dart';

// void main() {
//   runApp(const MyApp());
// }

class HomePage extends StatefulWidget {
  const HomePage({super.key});

@override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
 // int addedItems = 0;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Asbeza',
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
      home: const MyHomePage(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int addedItems = 0;
  //TextEditingController nameController = TextEditingController();

  //@override
  //void initState() {
  //  search.text = ""; //innitail value of text field
  //  super.initState();
  //}

  //@override
  //void dispose() {
  //  _controller.dispose();
  //  super.dispose();
  //}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(96, 237, 127, 215),
      body: BlocBuilder<AsbezaBloc, AsbezaState>(
        builder: (context, state) {
          if (state is AsbezaInitialState) {
            BlocProvider.of<AsbezaBloc>(context).add(const AsbezaFetchEvent());
          } else if (state is AsbezaLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is AsbezaSuccessState) {
            addedItems = state.history.length;
            return Column(
              children: [
                Container(
                    padding: const EdgeInsets.all(10),
                    child: Column(children: const [
                      SizedBox(
                        child: TextField(
                          decoration: InputDecoration(
                            icon: Icon(Icons.search),
                          ),
                        ),
                      )
                    ])),
                Container(
                  margin: const EdgeInsets.only(top: 25),
                  height: MediaQuery.of(context).size.height * .68,
                  child: ListView.builder(
                    itemCount: state.item.length,
                    itemBuilder: (BuildContext context, int index) {
                      final value = state.item[index];
                      return Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            fit: BoxFit.contain,
                                            image: NetworkImage(value.image))),
                                    height:
                                        MediaQuery.of(context).size.height * .1,
                                    width:
                                        MediaQuery.of(context).size.width * .3,
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 11, vertical: 5),
                                  ),
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * .4,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(value.title),
                                        Text(
                                          "${value.price}\$",
                                          style: const TextStyle(
                                              fontWeight: FontWeight.w900),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              IconButton(
                                onPressed: () {
                                setState(() {
                                    for (var element in state.history) {
                                      if (element.id == value.id) {
                                        value.itemAdded = 1;
                                        continue;
                                      }
                                    }
                                  });
                                  
                                  if (value.itemAdded == 0) {
                                    BlocProvider.of<AsbezaBloc>(context)
                                        .add(HistoryEvent(item: value));
                                    Fluttertoast.showToast(
                                        msg: 'Item added!',
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.BOTTOM,
                                        backgroundColor: Colors.green,
                                        textColor: Colors.white);
                                  } else {
                                    Fluttertoast.showToast(
                                        msg:
                                            'Item already added!\n Try adding the quantity in the history page',
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.BOTTOM,
                                        backgroundColor: Colors.blue,
                                        textColor: Colors.white);
                                  }
                                },
                                icon: const Icon(Icons.shopping_cart))
                          ],
                        ),]
                      );
                    },
                  ),
                ),
              ],
            );
          } else if (state is AsbezaFailedState) {
            return Center(
              child: InkWell(
                onTap: () {
                  BlocProvider.of<AsbezaBloc>(context)
                      .add(const AsbezaFetchEvent());
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                  decoration: const BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: const Text(
                    "FAILED TO CONECT\nTRY AGAIN!",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            );
          }
                          //         onPressed: () {
                          //           BlocProvider.of<AsbezaBloc>(context)
                          //               .add(HistoryEvent(item: value));
                          //         },
                          //         icon: const Icon(Icons.shopping_cart))
                          //   ],
                          // ),
                          const SizedBox(
                            height: 10,
                          );
                  return Container();
        },
      ),
    );
  }
}
