import 'package:farmasi/service/Auth.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';

import 'Loading.dart';

class Login extends StatefulWidget {
  final Function toggleView;
  Login({required this.toggleView});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = new GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  var rememberValue = false;
  final AuthService _auth = AuthService();
  bool loading = false;
  String email = "";
  String password = "";
  String error = "";
  bool isObscure = true;
  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            backgroundColor: Colors.blue[600],
            body: Container(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  FittedBox(
                    fit: BoxFit.fitWidth,
                    child: Text(
                      "Login Pasien",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 40.0),
                    ),
                  ),
                  SizedBox(
                    height: 45.0,
                  ),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: _emailController,
                          maxLines: 1,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Please entry your email";
                            }
                          },
                          decoration: InputDecoration(
                              hintText: "Masukan Nomor RM",
                              prefixIcon: Icon(Icons.email),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              )),
                          onChanged: (val) {
                            setState(() => email = val);
                          },
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        TextFormField(
                          controller: _passwordController,
                          maxLines: 1,
                          obscureText: isObscure,
                          validator: (value) {
                            if (value!.length < 6) {
                              return "Masukan password dengan ketentuan minimal 6 karakter";
                            }
                          },
                          decoration: InputDecoration(
                              hintText: "Masukan Password",
                              prefixIcon: Icon(Icons.lock),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  isObscure
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                ),
                                onPressed: () {
                                  setState(() {
                                    isObscure = !isObscure;
                                  });
                                },
                              ),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0))),
                          onChanged: (val) {
                            setState(() => password = val);
                          },
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        InkWell(
                          child: Text(
                            "Login Sebagai Apoteker? Klik Disini",
                            style: TextStyle(
                                color: Colors.amberAccent,
                                fontWeight: FontWeight.bold),
                          ),
                          onTap: () {
                            widget.toggleView();
                          },
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        //InkWell(
                        //child: Text("Belum Mempunyai Akun? Daftar Disini!",style: TextStyle(
                        //  color: Colors.amberAccent,
                        //fontWeight: FontWeight.bold
                        //),),
                        //onTap: () async{
                        //Navigator.pushNamed(context, '/RegistrasiPasien');
                        //},
                        //),
                        SizedBox(
                          height: 20.0,
                        ),
                        ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Colors.orangeAccent),
                            padding: MaterialStateProperty.all<EdgeInsets>(
                                EdgeInsets.fromLTRB(20, 10, 20, 10)),
                          ),
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              email = email + "@mail.com";
                              dynamic result = await _auth
                                  .signInWithEmailandPassword(email, password);
                              if (result != null) {
                                setState(() {
                                  loading = true;
                                });
                              } else {
                                _emailController.clear();
                                _passwordController.clear();
                              }
                            }
                          },
                          child: Text(
                            "Masuk",
                            style: TextStyle(
                                //fontWeight: FontWeight.bold,
                                fontSize: 25.0,
                                color: Colors.white,
                                fontFamily: 'Montserrat'),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
  }
}
