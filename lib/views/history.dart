import 'package:asbeza/model/item.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/asbeza_bloc.dart';
import '../bloc/asbeza_event.dart';
import '../bloc/asbeza_state.dart';

class MyHistoryPage extends StatefulWidget {
  const MyHistoryPage({super.key});

  @override
  State<MyHistoryPage> createState() => _MyHistoryPageState();
}

class _MyHistoryPageState extends State<MyHistoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<AsbezaBloc, AsbezaState>(
        builder: (context, state) {
          if (state is AsbezaInitialState) {
            return const Center(
                child: Text(
              "Welcome!",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ));
          } else if (state is AsbezaLoadingState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is AsbezaSuccessState) {
            if (state.history.isEmpty) {
              return const Center(
                  child: Text(
                "No History \n TOTAL: 0\$",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ));
            } else {
              num TotalPrice = 0;
              void _incrementCounter() {
                for (var element in state.history) {
                  TotalPrice += (element.price * element.quantity);
                }
              }

              _incrementCounter();
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "TOTAL: ${TotalPrice.toStringAsFixed(2)}\$",
                      style: const TextStyle(
                          fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 5),
                    height: MediaQuery.of(context).size.height * .7,
                    child: ListView.builder(
                      itemCount: state.history.length,
                      itemBuilder: (BuildContext context, int index) {
                        final value = state.history[index];
                        return Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Divider(),
                                const SizedBox(
                                height: 30,
                                ),
                                Row(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                              fit: BoxFit.contain,
                                              image:
                                                  NetworkImage(value.image))),
                                      height:
                                          MediaQuery.of(context).size.height *
                                              .1,
                                      width: MediaQuery.of(context).size.width *
                                          .3,
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 11, vertical: 5),
                                    ),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          .4,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(value.title),
                                          Text(
                                            "${value.price}\$",
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                        Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              IconButton(
                                                  onPressed: () {
                                                    if (value.quantity <=
                                                        1) {
                                                      Fluttertoast.showToast(
                                                          msg: 'Item removed',
                                                          toastLength: Toast
                                                              .LENGTH_SHORT,
                                                          gravity: ToastGravity
                                                              .BOTTOM,
                                                          backgroundColor:
                                                              Colors.red,
                                                          textColor:
                                                              Colors.white);
                                                    }
                                                    BlocProvider.of<AsbezaBloc>(
                                                            context)
                                                        .add(QunatityDecEvent(
                                                            index));
                                                    setState(() {});
                                                  },
                                                  icon: const Icon(
                                                    Icons.remove_circle,
                                                    color: Colors.red,
                                                  )),
                                              Text(
                                                "${value.quantity}",
                                                style: const TextStyle(
                                                    fontWeight:
                                                        FontWeight.w900),
                                              ),
                                              IconButton(
                                                  onPressed: () {
                                                    BlocProvider.of<AsbezaBloc>(
                                                            context)
                                                        .add(QunatityIncEvent(
                                                            index));
                                                    setState(() {});
                                                  },
                                                  icon: const Icon(
                                                    Icons.add_circle,
                                                    color: Colors.greenAccent,
                                                  )),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                IconButton(
                                    onPressed: () {
                                      setState(() {
                                          BlocProvider.of<AsbezaBloc>(context)
                                            .add(ItemRemoveEvent(index));
                                      });
                                      Fluttertoast.showToast(
                                          msg: 'Item removed',
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.BOTTOM,
                                          backgroundColor: Colors.red,
                                          textColor: Colors.white);
                                    },
                                    icon: const Icon(
                                      Icons.delete,
                                      color: Colors.redAccent,
                                    )),
                              ],
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            Divider(),
                          ],
                        );
                      },
                    ),
                  ),
                ],
              );
            }
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
                      // color: Colors.red,
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

                      
                            // const SizedBox(
                            //   height: 30,
                            // )
        return Container();
        },
      ),
    );
  }
}


