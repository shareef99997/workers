import 'package:flutter/material.dart';
import 'package:workers/workers.dart';
import 'client.dart';
class HomePage extends StatefulWidget {
  const HomePage({super.key, required String title });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final _formKey = GlobalKey<FormState>();
  final _idController = TextEditingController();
  final _nameController = TextEditingController();
  final _professionController = TextEditingController();
  final _phoneController = TextEditingController();
  final _birthController = TextEditingController();
  var register ='';

  void clear() {
    _idController.clear();
    _nameController.clear();
    _professionController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 198, 198, 198),
      appBar: AppBar(
        title: Text('Employee Registeration'),
        backgroundColor: Colors.black,
      ),
      body: ListView(
        children: [Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                
                controller: _idController,
                decoration: InputDecoration(
                  labelStyle: TextStyle(color: Colors.black),
                  focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                ),
                  labelText: 'Company ID',
                ),
                
                validator: (value) {
                  if (value != null && value.isEmpty) {
                    return 'Please enter your Company Id';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelStyle: TextStyle(color: Colors.black),
                  focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                ),
                  labelText: 'Name',
                ),
                validator: (value) {
                  if (value != null && value.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _professionController,
                decoration: InputDecoration(
                  labelStyle: TextStyle(color: Colors.black),
                  focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                ),
                  labelText: 'Employee CD',
                ),
                validator: (value) {
                  if (value != null && value.isEmpty) {
                    return 'Please enter your profession';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _phoneController,
                decoration: InputDecoration(
                  labelStyle: TextStyle(color: Colors.black),
                  focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                ),
                  labelText: 'Phone Number',
                ),
                validator: (value) {
                  if (value != null && !RegExp(r'^05\d{8}$').hasMatch(value)) {
                    return 'Please enter a valid phone number';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _birthController,
                decoration: InputDecoration(
                  labelStyle: TextStyle(color: Colors.black),
                  focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                ),
                  labelText: 'Birth Date',
                ),
                validator: (value) {
                  if (value != null && value.isEmpty) {
                    return 'Please enter your Birth Date';
                  }
                  return null;
                },
              ),
              SizedBox(height: 26.0),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.black),
                ),
                onPressed: () async {
                  if (_formKey.currentState?.validate() ?? false) {
                    var result = await post(_idController.text, _nameController.text, _professionController.text,_birthController.text,_phoneController.text);
                    if (result == 'success') {
                      setState(() {
                        register = 'User Registered Successfully ✅';
                        clear();
                      });
                    } else if (result == 'failed') {
                      setState(() {
                        register = 'User Registration Failed ❌';
                      });
                    }
                  }
                },
                child: Text('Register'),
              ),
              SizedBox(height: 20),
              Text(register,
              style: TextStyle(
                color: Colors.black
              ),
              ),
              SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 200.0,
                    height: 60.0,
                    child:ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        primary: Color.fromARGB(255, 67, 43, 133),
                        ),
                        onPressed: () {     
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => workers(),
                              ),
                            );
                        },
                        child: Text('Display Workers '),
                  ), 
                  ),  
            ],
              )
              ],
          ),
        ),
      ),],
      ) 
    );
  }
}

