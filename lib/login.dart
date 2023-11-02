import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class loginScreen extends StatelessWidget {
  // const ({Key? key}) : super(key: key);
  var emailControl=TextEditingController();
  var passwordControl=TextEditingController();
  var formKey=GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Login",
                    style: TextStyle(
                      fontSize: 45,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: emailControl,
                    onFieldSubmitted: (String value){
                      print(value);
                    },
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: "Email Adress",
                      prefix: Icon(Icons.email),
                      border: OutlineInputBorder(),
                    ),
                    validator: (value){
                      if(value.isEmpty)
                      {
                        return "please enter your email";
                      }
                      return null ;
                    },

                  ),
                  SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    controller: passwordControl,
                    onFieldSubmitted: (String value){
                      print(value);
                    },
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: "Password",
                      prefix: Icon(Icons.lock),
                      border: OutlineInputBorder(),
                      suffix: Icon(Icons.remove_red_eye),
                    ),
                    validator: (value){
                      if(value.isEmpty)
                      {
                        return "please enter your password";
                      }
                      return null ;
                    },
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    width: double.infinity,
                    height: 50,
                    color: Colors.blueAccent,
                    child: MaterialButton(
                      onPressed:()
                      {
                        if(formKey.currentState.validate())
                        {
                          print(emailControl.text);
                          print(passwordControl.text);
                        }

                      },
                      child: Text("Login",
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                        ),),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Don't have an acount?"),
                      MaterialButton(onPressed:(){},
                        child: Text("Regester Now",
                          style: TextStyle(
                            color: Colors.blue,
                          ),
                        ),
                      ),
                    ],
                  )


                ],
              ),
            ),
          ),
        ),
      ),
    );

  }
}