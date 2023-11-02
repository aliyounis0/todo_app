import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projects/layout/cubit/states.dart';
import 'package:sqflite/sqflite.dart';

import '../../modules/archivedTasks/archived_tasks.dart';
import '../../modules/doneTasks/done_tasks.dart';
import '../../modules/newTasks/new_tasks.dart';

class AppCubit extends Cubit<Appstates>
{
  AppCubit():super(AppIntinialState());
  static AppCubit get(context)=>BlocProvider.of(context);
  List<Map> newwTasks=[];
  List<Map> doneeTasks=[];
  List<Map> archiveddTasks=[];
  int curentIndex=0;
  bool open=false;
  IconData iconFab=Icons.edit;

  List<Widget> curerntScreen=[
    const NewTasks(),
    const DoneTasks(),
    const ArchivedTasks(),
  ];
  List<String> title=[
    "New Tasks",
    "Done Tasks" ,
    "Archived Tasks",
  ];
 void changeIndex ( int index){
   curentIndex=index;
   emit( changeBottomNavIndex());
 }
  Database  database;
  void creatDatabase ()
  {
    openDatabase(
        "toDo.db",
        version: 1,
        onCreate: (database,version)
        {
          //print("data created");

          database.execute("CREATE TABLE tasks (id INTEGER PRIMARY KEY , title TEXT , date TEXT , time TEXT, status TEXT)").then((value){
           // print("create table");
          }).catchError((error){
           // print('Error is ${error.toString()}');
          });
        },
        onOpen: (database)
        {
          getData(database);
        //  print("open database");
        }
    ).then((value)
    {
      database=value;
      emit(createDataState());
    }) ;
  }

   insertDataBase ({
    @required String title,
    @required String date,
    @required String time,

  }) async
  {
     await database.transaction((txn)
    {
      txn.rawInsert("INSERT INTO tasks (title,date,time,status) VALUES('$title','$date','$time','NEW')").then((value)
      {
      //  print("$value done insert");
        emit(insertDataState());
        getData(database);
      }).catchError((error)
      {
       // print("error is ${error.toString()}");
      });
      return null;
    });
  }

 void getData (database)
  {
     emit(getDataState());
     database.rawQuery('SELECT * FROM tasks').then((value)
     {
       newwTasks=[];
       doneeTasks=[];
       archiveddTasks=[];

       value.forEach((element)
       {
         if(element["status"]=="NEW") {
           newwTasks.add(element);
         } else if(element["status"]=="done") {
           doneeTasks.add(element);
         } else {
           archiveddTasks.add(element);
         }
        //print(element);
       });

       emit(getDataState());
     });

  }
  void changeBottomSheet (
  {
  @required bool isShow,
  @required IconData icon,
}){
    open=isShow;
    iconFab=icon;
    emit(changeBootomSheetState());

  }

  void updateData ({
    @required String status,
    @required int id,
  }) async
  {
    database.rawUpdate("UPDATE tasks SET status = ? WHERE id = ? ",
        [status,id]).then((value)
    {
      getData(database);
      emit(updateDataState());
      //print(database);

    }) ;
  }
  void deleteData ({
    @required int id,
  }) async
  {
    database.rawDelete("DELETE FROM tasks  WHERE id = ? ",
        [id]).then((value)
    {
      getData(database);
      emit(deleteDataState());
      //print(database);

    }) ;
  }


  ThemeMode mode= ThemeMode.dark;

  void changeMode(){
    if(mode==ThemeMode.dark) {
      mode =ThemeMode.light;
    }else if(mode==ThemeMode.light){
      mode=ThemeMode.dark;
    }
    print(mode);
    emit(ChangeMode());
  }



}