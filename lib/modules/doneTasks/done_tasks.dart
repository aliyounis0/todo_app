import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projects/layout/cubit/cubit.dart';
import 'package:projects/layout/cubit/states.dart';

import '../../shared/copments.dart';

class DoneTasks extends StatelessWidget {
  const DoneTasks({Key key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,Appstates>(
      listener: (context,state){},
      builder: (context,state){
        if(AppCubit.get(context).doneeTasks.isEmpty)
        {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(Icons.menu,
                  size: 100,
                  color: Colors.grey,),
                Text("There is no tasks yet ..",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                  ),),
              ],
            ),
          );
        }
       else {
          return ListView.separated(
          itemBuilder:(context, index)=> buildItem(AppCubit.get(context).doneeTasks[index],context),
          separatorBuilder:(context, index)=>Container(
            width: double.infinity,
            height: 1,
            color: Colors.grey[200],
          ),
          itemCount:AppCubit.get(context).doneeTasks.length,);
        }
      },
    );


  }
}
