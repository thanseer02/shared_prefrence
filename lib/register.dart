import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shared_prefrence/login.dart';
class register extends StatefulWidget {
  const register({super.key});

  @override
  State<register> createState() => _registerState();
}

class _registerState extends State<register> {
  var visible_password=true;
  var visible_confirmpassword=true;
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  var _mobilenoController = TextEditingController();
  var passwordctrl=TextEditingController();
  var confirm_passwordctrl=TextEditingController();
  var mobile_no;
  var password;


    // var response = await post(Uri.parse("${con.url}login.php"),body:data );
    // print(response.body);
    //
    //
    // if (jsonDecode(response.body)['result']=='Login success') {
    //   profile(jsonDecode(response.body)['log_id']);
    //
    //   Navigator.push(context, MaterialPageRoute(builder: (context)=>home()));
    //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Login success')));
    // }
    // else
    // {
    //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Login failed')));
    //
    // }



  void savedata(String mobile_no,password) async {
    SharedPreferences prefs =await SharedPreferences.getInstance();
    prefs.setString('mobile_no', mobile_no);
    prefs.setString('password', password);
  }

  void profile() async{
    mobile_no=_mobilenoController.text;
    password=passwordctrl.text;
    print(mobile_no);
    print(password);
    print('mobile_no : $mobile_no');
    print('password : $password');
    if (mobile_no!=null  )
    {
      savedata(mobile_no,password);
      print('inside saved data');
      Navigator.push(context, MaterialPageRoute(builder: (context)=>login()));
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  SizedBox(height: 100,),
                  Icon(Icons.app_registration,size: 150,color: Colors.teal,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18.0,vertical: 30),
                    child: TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your mobilenumber';
                        }
                        return null;
                      },
                      controller: _mobilenoController,
                      style: TextStyle(color: Colors.black,fontSize: 18),
                      decoration: InputDecoration(
                          suffixIcon: Icon(Icons.person,color: Colors.teal,),
                          filled: true,
                          fillColor: Color(0xffDCDADA),
                          hintText: 'Mobile number',
                          border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(20)
                          )
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all( 10),
                    child: TextFormField(
                      validator: (val){
                        if (val!.length<=6 && val.isEmpty){
                          return 'password reqired or too short';
                        }
                      },
                      obscureText: visible_password,
                      controller: passwordctrl,
                      style: TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                          suffixIcon: IconButton(onPressed: (){
                            setState(() {
                              visible_password=!visible_password;
                              print(visible_password);
                            });
                          }, icon:(visible_password)?Icon(Icons.visibility_off):Icon(Icons.visibility)),

                          filled: true,
                          fillColor: Color(0xffDCDADA),
                          hintText: 'Password',
                          border: OutlineInputBorder(
                              borderSide: BorderSide.none,

                              borderRadius: BorderRadius.circular(20)
                          )
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all( 10),
                    child: TextFormField(
                      controller: confirm_passwordctrl,
                      obscureText: visible_confirmpassword,
                      style: TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                          suffixIcon: IconButton(onPressed: (){
                            setState(() {
                              visible_confirmpassword=!visible_confirmpassword;
                            });
                          },
                              icon:(visible_confirmpassword) ? Icon(Icons.visibility_off_outlined) :Icon(Icons.visibility)
                          ),
                          filled: true,
                          fillColor: Color(0xffDCDADA),
                          hintText: 'Confirm Password',
                          border: OutlineInputBorder(
                              borderSide: BorderSide.none,

                              borderRadius: BorderRadius.circular(20)
                          )
                      ),
                    ),
                  ),
                  SizedBox(height: 20,),
                  Container(
                    height: 50,
                    width: 150,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)
                            ),
                            backgroundColor: Color(0xff068DA9)),
                        onPressed: (){
                          // print(first_namectrl.text);
                          // print(last_namectrl.text);
                          // print(mobile_noctrl.text);
                          // print(passwordctrl.text);
                          // if (registerkey.currentState!.validate()) {
                            if (passwordctrl.text==confirm_passwordctrl.text) {
                              // sentdata();
                              // savedata(mobile_no, password)
                              profile();

                              // login();
                            }
                            else
                            {
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Password missmatch')));
                            }
                          // }
                        }, child: Text('Login')),
                  ),

                  TextButton(onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>register()));
                  }, child: Text('SignUp?',style:TextStyle(color: Colors.black),)),
                ],
              ),
            ),
          )),
    );
  }
}
