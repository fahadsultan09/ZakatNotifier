
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:notifier/Login/Login.dart';
import 'package:notifier/Utilizations/Utilizations.dart';
import 'package:notifier/Donations/Donations.dart';
import 'package:notifier/Utils/Utils.dart';
class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  
  String _fullName = "";
  int amount = 0;
  @override
  void initState() {
    FirebaseAuth.instance.currentUser().then((user){
    
        Firestore.instance.collection("Users2").document(user.uid).get().then((doc){
          setState(() {
            _fullName = doc["Full Name"];
          amount = doc["Amount"];
          print(doc["Amount"]);

          });
        });
     
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        
        elevation: 1.0,
        child: Container(
          child: Stack(fit:StackFit.expand,children: <Widget>[

            Image.asset("assets/images/images.jpg",fit: BoxFit.cover,color: Colors.black54,colorBlendMode: BlendMode.darken,),
            ListView(

          padding: EdgeInsets.zero,
          children: <Widget>[
            
            DrawerHeader(
 
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    CircleAvatar(
                      radius: 40.0,
                      backgroundColor: Colors.white70,
                      child: Icon(Icons.perm_identity,size: 40,color: backgroundcolor,),
                    ),
                    Text(_fullName.toString(),style: TextStyle(color: Colors.white70,))
                  ],
                ),
            ),
            ListTile(
              
              leading: Icon(Icons.home,color: Colors.white70,),
              title: Text('Home',style: TextStyle(color: Colors.white70,)),
              onTap: () {
                
                
                
                Navigator.pop(context);
              },
            ),
            ListTile(
              
              leading: Icon(Icons.swap_horiz,color: Colors.white70,),
              title: Text('Donations',style: TextStyle(color: Colors.white70,)),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Zakat()));
              },
              
            ),
            ListTile(
              
              leading: Icon(Icons.account_balance_wallet,color: Colors.white70,),
              title: Text('Utilizations',style: TextStyle(color: Colors.white70,)),
              onTap: () {

            Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Utilizations()));

              },
            ),
            ListTile(
              
              leading: Icon(Icons.attach_money,color: Colors.white70,),
              title: Text('Balance',style: TextStyle(color: Colors.white70,)),
              trailing: Text(amount==0?"Rs. 0":"Rs.   "+amount.toString(),style: TextStyle(color: Colors.white70,)),
            ),
                        
            Divider(color: Colors.black87,height: 50,),
            ListTile(
              subtitle: Text("Exit",style: TextStyle(color: Colors.white70,) ),
              onTap: (){
                FirebaseAuth.instance.signOut();
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>LoginPage()));
              },
              
              leading: Icon(Icons.exit_to_app,color: Colors.white70,),
              title: Text("Sign Out",style: TextStyle(color: Colors.white70,fontSize: 15.0)),
              
                          ),
          ],
        ),
        ],)
        ),

      ),
      appBar: AppBar(
         backgroundColor: Colors.black,
        centerTitle: true,
        title: Text("Home"),
      ),
      body: Container(
        color: backgroundcolor,
        child: Center(child: Image.asset("assets/images/Logo.jpg"),)
      ),
    );
  }
}
