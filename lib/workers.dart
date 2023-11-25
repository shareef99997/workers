import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:workers/client.dart';

class workers extends StatefulWidget {
  const workers({super.key});

  @override
  State<workers> createState() => _employeesState();
}

class _employeesState extends State<workers> {

    List _employees = [
    // {'comp_id': '1', 'fullname': 'shareef', 'emp_cd': 'SWG', 'birth_dt': '2000/4/21','mobile_no':'0582635947'},
    // {'comp_id': '2', 'fullname': 'abdulrahman', 'emp_cd': 'ITC', 'birth_dt': '2000/4/21','mobile_no':'0582635947'},
    // {'comp_id': '3', 'fullname': 'ali', 'emp_cd': 'IT', 'birth_dt': '2000/4/21','mobile_no':'0582635947'},
    // {'comp_id': '4', 'fullname': 'mohammed', 'emp_cd': 'IT', 'birth_dt': '2000/4/21','mobile_no':'0582635947'},
    // {'comp_id': '5', 'fullname': 'omer', 'emp_cd': 'UI/UX', 'birth_dt': '2000/4/21','mobile_no':'0582635947'},
  ];
  
    List _foundusers = [];
    
      // This function is called whenever the text field changes
    void _runFilter(String enteredKeyword) {
      List results = [];
      if (enteredKeyword.isEmpty) {
        // if the search field is empty or only contains white-space, we'll display all users
        results = _employees;
      } else {
        results = _employees
        .where((user) =>
            user["fullname"].toLowerCase().contains(enteredKeyword.toLowerCase()) ||
            user["comp_id"].toString().toLowerCase().contains(enteredKeyword.toLowerCase())||
            user["emp_cd"].toString().toLowerCase().contains(enteredKeyword.toLowerCase()) )
        .toList();
        // we use the toLowerCase() method to make it case-insensitive
      }
      setState(() {
        _foundusers =results;
      });
    }
  
  var loading = true;
  
    Future<void> fetchData() async {
    var responseBody = await get();

    if (responseBody != null) {
      setState(() {
        _employees.addAll(responseBody);
        loading = false;
      });
    }
  }

  @override
  void initState() {
    _foundusers = _employees;

    Future.delayed(Duration(seconds: 1), () {
      fetchData();
    });
    // Future.delayed(Duration(seconds: 1), () {
    //   setState(() {
    //     loading = false;
    //   });
    // });
    super.initState();
  }

  



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 198, 198, 198),
      body: loading
          ? Center(
              child: LoadingAnimationWidget.staggeredDotsWave(
                color: Color.fromARGB(255, 39, 91, 203),
                size: 100,
              ),
            )
          : ListView(children: [
            //Search Bar
              Padding(
                padding: EdgeInsets.all(15),
                child:SizedBox(
                  height: 65,
                  width: 360,
                  child: TextField(
                    style: GoogleFonts.poppins(
                      color: Color(0xff020202),
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                      letterSpacing: 0.5,
                    ),
                    onChanged: (value) => _runFilter(value),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: const Color(0xfff1f1f1),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide.none,
                      ),
                      hintText: "Search for Employees",
                      hintStyle: GoogleFonts.poppins(
                        color: const Color(0xffb2b2b2),
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                        letterSpacing: 0.5,
                        decorationThickness: 6,
                      ),
                      prefixIcon: const Icon(Icons.search),
                      prefixIconColor: Colors.black,
                    ),
                  ),
                ),
                ),
            //Employees  
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                child: Column(
                  children: List.generate(_foundusers.length,(index) => Card(
                      child:Padding(
                        padding:EdgeInsets.all(10) ,
                        child:ExpandablePanel(
                              header: Row(
                              children: [
                                Icon(
                                  Icons.person_2_rounded,
                                  size: 30,
                                ),
                                SizedBox(width: 10,),
                                Text(' ${_foundusers[index]['fullname']}',style: TextStyle(fontSize: 20),),
                              ],
                            ),
                              collapsed: Text(
                                '',
                                softWrap: true,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                
                              ),
                              theme: ExpandableThemeData(
                                animationDuration: Duration(milliseconds: 500),
                                expandIcon: Icon(Icons.arrow_drop_down).icon,
                                collapseIcon: Icon(Icons.arrow_drop_up).icon,
                              ),
                              expanded: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SizedBox(width: 65,),

                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(height: 10,),
                                      Text('Position : ${_foundusers[index]['emp_cd']}', style: TextStyle(fontSize: 15)),
                                      SizedBox(height: 5,),
                                      Text('Phone number : ${_foundusers[index]['mobile_no']}', style: TextStyle(fontSize: 15)),
                                      SizedBox(height: 5,),
                                      Text('Birth Date : ${_foundusers[index]['birth_dt']}', style: TextStyle(fontSize: 15)),
                                      SizedBox(height: 5,),
                                      Text('comp_id : ${_foundusers[index]['id']}', style: TextStyle(fontSize: 15)),
                                    ],
                                  ),
                                ],
                              ) 

                            ),
                        ) ),
                      ),
                ),
              )
            ]
            ),
    );
  }
}
