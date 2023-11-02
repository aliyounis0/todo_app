import 'package:flutter/material.dart';
import 'package:projects/layout/cubit/cubit.dart';

Widget buildItem(Map model,context )=> Dismissible(
  key: Key(model['id'].toString()),
  child:   Padding(

    padding: const EdgeInsets.all(20.0),

    child: Row(

        children: [

          CircleAvatar(

            radius: 40,

            child: Text("${model['time']}"),



          ),

          const SizedBox(

            width: 20,

          ),



          Expanded(

            child: Column(

              mainAxisSize: MainAxisSize.min,

              crossAxisAlignment: CrossAxisAlignment.start,

              children: [

                Text("${model['title']}",

                  style: const TextStyle(

                    fontSize: 20,

                    fontWeight: FontWeight.bold,

                  ),),

                const SizedBox(

                  height: 5,

                ),

                Text("${model['date']}",

                  style: TextStyle(

                    fontSize: 15,

                    color: Colors.grey[400],

                  ),),

              ],

            ),

          ),

          const SizedBox(

            width: 20,

          ),



          IconButton(

            onPressed:()

          {

            AppCubit.get(context).updateData(

                status: "done",

                id: model["id"]);



          },

              icon:const Icon( Icons.check_box),

          color: Colors.green,),





          IconButton(onPressed:()

          {

            AppCubit.get(context).updateData(status: "archive", id:model["id"]);


          },

              icon:const Icon( Icons.archive_outlined),

          color: Colors.black45,),











        ]),

  ),
  onDismissed: (direction)
  {
    AppCubit.get(context).deleteData(id: model["id"]);
  },
);