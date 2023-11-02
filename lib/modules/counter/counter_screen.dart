import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projects/modules/counter/cubit/cubit.dart';
import 'package:projects/modules/counter/cubit/states.dart';

 class counterScreen  extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context)=>counterCubit(),
      child:BlocConsumer<counterCubit,counterStatess>(
        listener: ( context ,state){},
          builder:(context, state)
          {
            return Scaffold(
              appBar: AppBar(
                title: Text(
                    "Counter"
                ),
              ),
              body: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(onPressed:(){
                      counterCubit.get(context).minus();
                    },
                      child: Text("MUNIS"),),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20.0,
                      ),
                      child: Text("${counterCubit.get(context).counter}",
                        style: TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: 30,
                        ),),
                    ),
                    TextButton(onPressed:(){
                     counterCubit.get(context).plus();
                    },
                      child: Text("PLUS"),),
                  ],
                ),
              ),
            );
          },
      ),
    );
  }
}