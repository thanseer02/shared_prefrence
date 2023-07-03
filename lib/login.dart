import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shared_prefrence/homepage.dart';
import 'package:shared_prefrence/register.dart';
class login extends StatefulWidget {
  const login({super.key});

  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {
  var visible_password=true;
  var mobile_no;
  var password;
  var _mobilenoController=TextEditingController();
  var _passwordController=TextEditingController();

  void login() async{
    profile(mobile_no, password);
    if (mobile_no==_mobilenoController.text) {
      print('inside login');
      print(_mobilenoController.text);
      print(_passwordController.text);
      print('mobile_no :$mobile_no');
      print('password : $password');
      print('inside login');
      Navigator.push(context, MaterialPageRoute(builder: (context)=>home()));

    }

}

Future<Map<String, String?>> getdata()async{
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? mobile_no = prefs.getString('mobile_no');
  String? password = prefs.getString('password');
  return {
    'mobile_no': mobile_no,
    'password':password,
  };
}
  Future<Map<String, String?>> profile(mobile_no,password) async{
      Map<String?,String?>data=await getdata();
      String? mobile_no=data['mobile_no'];
      String? password=data['password'];
      print('mobile_no :$mobile_no');
      print('password : $password');
      if (mobile_no==_mobilenoController.text &&password==_passwordController.text) {
        print('inside login');
        // print(_mobilenoController.text);
        // print(_passwordController.text);
        print('mobile_no :$mobile_no');
        print('password : $password');
        print('inside login');
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Login success')));
        Navigator.push(context, MaterialPageRoute(builder: (context)=>home()));

      }
      else
        {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error')));
        }
      return {
        'mobile_no':mobile_no,
        'password':password
      };

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 100,),
                Icon(Icons.tips_and_updates_rounded,size: 150,color: Colors.teal,),
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
                  padding: const EdgeInsets.symmetric(vertical:0.0,horizontal: 18),
                  child: TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your password';
                      }
                      return null;
                    },
                    controller: _passwordController,
                    style: TextStyle(color: Colors.black,fontSize: 18),
                    obscureText: visible_password,
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
                        login();
                      }, child: Text('Login')),
                ),

                TextButton(onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>register()));
                }, child: Text('SignUp?',style:TextStyle(color: Colors.black),)),
              ],
            ),
          )

      ),
    );
  }
}
