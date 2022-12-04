import 'package:bgremover/cubit/cubit.dart';
import 'package:bgremover/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BgRemoverCubit(),
      child: BlocConsumer<BgRemoverCubit, BgRemoverStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = BgRemoverCubit.get(context);
          return Scaffold(
            body: SafeArea(
                child: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      if (state is BgRemoverSendLoadingState)
                        const SizedBox(height: 5),
                      if (state is BgRemoverSendLoadingState)
                        const LinearProgressIndicator(),
                      if (state is BgRemoverSendLoadingState)
                        const SizedBox(height: 5),
                      SizedBox(
                        width: double.infinity,
                        height: 400,
                        child: Card(
                          color: Colors.white,
                          child: cubit.file != null
                              ? Image.file(
                                  cubit.file!,
                                  fit: BoxFit.fill,
                                )
                              : const Center(
                                  child: Text(
                                    "Plz Upload Your Image",
                                    style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.black45,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                              child: Padding(
                            padding: const EdgeInsetsDirectional.only(end: 4.0),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(3),
                                color: Colors.black,
                              ),
                              child: MaterialButton(
                                highlightColor: Colors.transparent,
                                splashColor: Colors.transparent,
                                onPressed: () {
                                  cubit.sendPhoto();
                                },
                                child: const Text(
                                  "Generate",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          )),
                          Expanded(
                              child: Padding(
                            padding:
                                const EdgeInsetsDirectional.only(start: 4.0),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(3),
                                color: Colors.black,
                              ),
                              child: MaterialButton(
                                splashColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onPressed: () {
                                  cubit.pickImage();
                                },
                                child: const Text(
                                  "Upload",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ))
                        ],
                      ),
                      if (cubit.imageAfter != null)
                        const SizedBox(
                          height: 25,
                        ),
                      if (cubit.imageAfter != null)
                        SizedBox(
                          width: double.infinity,
                          height: 400,
                          child: Card(
                              color: Colors.white,
                              child: Image.memory(cubit.imageAfter!)),
                        ),
                      if (cubit.imageAfter != null)
                        const SizedBox(
                          height: 20,
                        ),
                    ],
                  ),
                ),
              ),
            )),
          );
        },
      ),
    );
  }
}
