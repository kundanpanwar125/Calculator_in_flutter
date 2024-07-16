import 'package:function_tree/function_tree.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget{
  const Home({super.key});

  @override
  State<Home> createState() => HomeState();
}

class HomeState extends State<Home> {
  var btn=["7","8","9","/","4","5","6","*","1","2","3","+","C","0",".","-","CC","%","=","^"];
  var output="0";
  bool write=false;
  bool rev=true;


  @override
  Widget build (BuildContext context){

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blueAccent,
          title: Text("Calculator", style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30),),

        ),
        backgroundColor: const Color.fromRGBO(225, 255, 255, 100),
        body: Center(
          child: Container(
              margin: EdgeInsets.all(10),
              width: 370,
              decoration: BoxDecoration(
                  color: Colors.black12,
                  boxShadow: [BoxShadow(
                      color: Colors.black12,
                      spreadRadius: 8,
                       blurRadius: 8,
                       offset:Offset(8,8)
                  )],
                borderRadius: BorderRadius.circular(20),
              ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // output window
                Expanded(
                  flex: 2,

                  child:  Center(
                    child: Container(
                      height: 130,
                      margin: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                      padding: const EdgeInsets.all(10),
                      alignment: Alignment.centerRight,
                      decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: const [BoxShadow(
                              color: Colors.black38,
                              spreadRadius: 2,
                              blurRadius: 8,
                              offset: Offset(0,7)
                          )]
                      ),
                      child:  SingleChildScrollView(

                        scrollDirection: Axis.horizontal,
                        reverse: rev,

                        child: Text(
                          output,

                          style: const TextStyle(
                            fontSize: 60,

                            fontWeight: FontWeight.bold,
                            color: Colors.greenAccent,
                            fontFamily: "clock1",
                          ),
                        ),
                      ),
                    ) ,
                  ),
                ),

                // buttons
                Expanded(
                  flex: 7,
                  child:  Container(
                    margin: const EdgeInsets.all(20),
                    child: GridView.builder(
                      shrinkWrap: true,
                      primary: true ,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4 ,mainAxisSpacing: 15 , crossAxisSpacing: 10),
                      itemBuilder: (context , index ){
                        return GestureDetector(onTap: (){
                          setState(() {
                            rev=true;
                            if(index==3 || index == 7 || index==11 || index==15 || index==17 || index==19){
                              // math_operator
                              if(write) {
                                output += btn[index];
                                write = false;
                              }
                            }
                            else if(index==12){
                              //  (c) clear button logic
                              if(output.length>1){
                                // tmp contain last second value of string
                                var tmp = output.substring(output.length-2,output.length-1);
                                // check whether the value removed is no. or operator_
                                try{
                                  // value is no
                                  int v= int.parse(tmp);
                                  write=true;
                                }
                                catch(e){
                                  // value is operator or dot
                                  write=false;
                                }
                                output=output.substring(0,output.length-1);
                              }
                              else{
                                output="0";
                                write=false;
                              }
                            }
                            else if (index==16){
                              // (CC) button logic or all clear
                              output="0";
                              write=false;
                            }
                            else if (index==18){
                              // result operation
                              if(write){
                                rev=false;
                                // float to int
                                var v1= output.interpret();
                                var v2 = v1.toInt();
                                if(v1>v2){
                                  // means result must be float
                                  output=v1.toString();
                                }
                                else{
                                  // means result must be decimal
                                  output=v2.toString();
                                }
                              }
                            }
                            else if (index==14){
                              // dot operator
                              if(output=="0"){
                                output=btn[index];
                              }
                              else{
                                int len=output.length;
                                var a ="";
                                while(len>=0){
                                  try{
                                    a= output[len-1];
                                    var a1= int.parse(a);
                                    len--;
                                  }
                                  catch(e){
                                    if(a=="."){
                                      break;
                                    }
                                    else{
                                      output+=btn[index].toString();
                                      write=false;
                                      break;
                                    }
                                  }
                                }
                              }
                            }
                            else {
                              // numbers
                              if(output=="0"){
                                output=btn[index];
                              }
                              else{
                                output+=btn[index];
                              }
                              write=true;
                            }
                          });
                        },
                          child: Container(
                            height: 45,
                            width: 45,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: Colors.black26,
                                borderRadius: BorderRadius.circular(30),
                                boxShadow: const [BoxShadow(
                                    color: Colors.black38,
                                    spreadRadius: 2,
                                    blurRadius: 8,
                                    offset: Offset(0,5)
                                )]
                            ),
                            child: Text(btn[index],
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 45,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        );
                      },
                      itemCount: btn.length,

                    ),
                  ) ,
                ),

              ],
            ),
          ),
        )
    );

  }
}


