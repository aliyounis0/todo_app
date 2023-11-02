//import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projects/layout/cubit/cubit.dart';
import 'package:projects/layout/cubit/states.dart';
import 'package:intl/intl.dart';


class  HomeLayout extends StatefulWidget
{


  const HomeLayout({Key key}) : super(key: key);

  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
  var keyScafold= GlobalKey<ScaffoldState>();

  var keyForm= GlobalKey<FormState>();

  var titleController=TextEditingController();

  var timeController=TextEditingController();

  var dateController=TextEditingController();

  @override
  Widget build(BuildContext context) {

    return BlocProvider(
      create: (BuildContext context) => AppCubit()..creatDatabase() ,
      child: BlocConsumer<AppCubit,Appstates>(
       listener: (context,state){
         if(state is insertDataState)
         {
           Navigator.pop(context);
         }
       },
        builder: (context,state)
        {
          AppCubit cubit=AppCubit.get(context);
          return  Scaffold(
            key: keyScafold,
            appBar: AppBar(
              title: Text(cubit.title[cubit.curentIndex]),
              actions: [
                IconButton(
                    onPressed: (){
                      cubit.changeMode();
                    },
                    icon: const Icon(Icons.dark_mode_outlined))
              ],

            ),
            floatingActionButton: FloatingActionButton(
              onPressed: ()
              {
                if(cubit.open){

                  if(keyForm.currentState.validate())
                  {
                    cubit.insertDataBase(title: titleController.text , date: dateController.text, time: timeController.text);

                    // insertDataBase(title: titleController.text, date: dateController.text, time: timeController.text).then((value)
                    // {
                    //   print(timeController.text);
                    //   Navigator.pop(context);
                    //   open=false;
                    //   //
                    //   // setState(() {
                    //   //   iconFab=Icons.edit;
                    //   // });
                    // });


                  }
                }
                else
                {
                  keyScafold.currentState.showBottomSheet((context) =>

                      Container(
                        padding: const EdgeInsetsDirectional.all(20) ,
                        color: Colors.grey[100],
                        child: Form(
                          key: keyForm,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              TextFormField(
                                controller:titleController ,
                                keyboardType: TextInputType.text,
                                validator: (String value)
                                {
                                  if(value.isEmpty)
                                  {
                                    return("please enter the title");
                                  }else
                                  {
                                    return null ;
                                  }
                                },
                                decoration: const InputDecoration(
                                  labelText:"Task Title" ,
                                  //hintText: "Task Title",
                                  prefixIcon:Icon(Icons.title),
                                  border: OutlineInputBorder(),
                                ),

                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              TextFormField(
                                controller:timeController,
                                keyboardType: TextInputType.datetime,
                                onTap: ()
                                {
                                  showTimePicker(
                                    context: context,
                                    initialTime:TimeOfDay.now(),
                                  ).then((value)
                                  {
                                    timeController.text=value.format(context).toString();
                                  });
                                },
                                validator: (String value)
                                {
                                  if(value.isEmpty)
                                  {
                                    return("please enter the time");
                                  }else
                                  {
                                    return null ;
                                  }
                                },
                                decoration: const InputDecoration(
                                  labelText:"Task Time" ,
                                  //hintText: "Task Title",
                                  prefixIcon:Icon(Icons.watch_later_outlined),
                                  border: OutlineInputBorder(),
                                ),

                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              TextFormField(
                                controller:dateController,
                                keyboardType: TextInputType.datetime,
                                onTap: ()
                                {
                                  showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate:  DateTime.now(),
                                    lastDate: DateTime.parse('2023-07-08'),
                                  ).then((value)
                                  {
                                    //print(DateFormat.yMMMd().format(value),);
                                    dateController.text= DateFormat.yMMMd().format(value);

                                  }).catchError((error)
                                  {
                                  //  print("Error is ${error.toString()}");

                                  });
                                },
                                validator: (String value)
                                {
                                  if(value.isEmpty)
                                  {
                                    return("please enter the date");
                                  }else
                                  {
                                    return null ;
                                  }
                                },
                                decoration: const InputDecoration(
                                  labelText:"Task Date" ,
                                  //hintText: "Task Title",
                                  prefixIcon:Icon(Icons.calendar_today_outlined),
                                  border: OutlineInputBorder(),
                                ),

                              ),
                            ],
                          ),
                        ),
                      ),
                    elevation: 20,
                  ).closed.then((value)
                  {
                   cubit.changeBottomSheet(
                        isShow: false,
                        icon: Icons.edit);

                  }) ;

                  cubit.changeBottomSheet(
                      isShow: true,
                      icon: Icons.add);
                }
              },
              child: Icon(cubit.iconFab),),
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: cubit.curentIndex,
              onTap: (index){
               cubit.changeIndex(index);
              },
              items: const [
                BottomNavigationBarItem(icon: Icon(Icons.menu),
                  label: "New tasks",
                ),
                BottomNavigationBarItem(icon: Icon(Icons.check_box_outlined),
                  label: "Done",
                ),
                BottomNavigationBarItem(icon: Icon(Icons.archive_outlined),
                  label: "Archived",
                ),

              ],
            ),
            body: cubit.curerntScreen[cubit.curentIndex],
          );
        },
      ),
    );


  }

  Future<String> getName() async
  {
    return "Ali younis";
  }
}




