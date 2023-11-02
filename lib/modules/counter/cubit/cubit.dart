import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projects/modules/counter/cubit/states.dart';

class counterCubit extends Cubit<counterStatess>
{
  counterCubit(): super(counterInitialState());

  static counterCubit get(context)=> BlocProvider.of(context);
  int counter=0;
  void minus()
  {
    counter--;
    emit(counterMinusState());
  }
  void plus()
  {
    counter++;
    emit(counterPlusState());
  }
}