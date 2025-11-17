import 'package:flutter/material.dart';
import 'ExpressionEvaluator.dart';

void main(){
  runApp(MaterialApp(home:Calculator(), debugShowCheckedModeBanner: false,));
}

class Calculator extends StatefulWidget{
  @override
  CalculatorState createState()=> CalculatorState();
}


class CalculatorState extends State<Calculator>{
  String display = "0";
  String op = "";
  bool _hasPoint = false; // keep track of decimal point in the display (allows a decimal point if false otherwise not)

  void changeDisplay(String val){ //update the display when a number or operator button is pressed
    if (display == "0"){
      setState((){
        display = val; //replace "0" by the value
      }
      );
    }
    else{
      setState((){
        display += val;
      });
    }
  }


  @override

  Widget build(BuildContext context){
    double deviceWidth = MediaQuery.of(context).size.width;
    double deviceHeight = MediaQuery.of(context).size.height;

    Widget numberButton(String val){
      return ElevatedButton(
        onPressed: () {
          if(display == "Undefined") {//override error message
           setState(() {
             display = "0";
           });
          }
          changeDisplay(val);
        },
        child: Text(val, style: TextStyle(color: Colors.white, fontSize: 20)),
        style: ElevatedButton.styleFrom(
          minimumSize: Size(deviceWidth/5,deviceHeight/13),
          elevation: 0,
          backgroundColor: Colors.blue,
        ),
      );
    }

    Widget operatorButton(String val){
      return ElevatedButton(
        child: Text(val, style: TextStyle(color: Colors.white, fontSize: 20)),
        style: ElevatedButton.styleFrom(
            minimumSize: Size(deviceWidth/5,deviceHeight/16),
            elevation: 0,
            backgroundColor: Colors.blue
        ),
        onPressed: (){
          setState((){
            if(display == "Undefined") //override error message
              display = "0";

            if(ExpressionEvaluator().isOperator(display[display.length-1])){ //if the last digit is an operator, replace it
              display = display.substring(0,display.length-1) + val;
            }
            else{
              op = val;
              display += op;
              _hasPoint = false; //reset the decimal point rule since a new number has started
            }
          });
        },
      );
    }

    return Scaffold(
        backgroundColor: Colors.grey[800],
        appBar: AppBar( title: Text("Calculator App", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)), backgroundColor: Colors.blue,),
        body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                  children: [
                    Container(
                        height: 90,
                        width: deviceWidth,
                        child:FittedBox(
                          fit: BoxFit.scaleDown,
                          alignment: Alignment.centerLeft,
                          child: Text(display, style: TextStyle(fontSize: 90, color: Colors.white)),
                        )
                    )
                  ]
              ),
              Container(
                  child: Column(
                      children: [
                        SizedBox(height: 80),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              ElevatedButton(
                                child: Text("C", style: TextStyle(color: Colors.white, fontSize: 20)),
                                onPressed: (){
                                  setState((){
                                    display = "0";
                                    _hasPoint = false;
                                  }
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  minimumSize: Size(deviceWidth/5,deviceHeight/16),
                                  backgroundColor: Colors.blue,
                                ),
                              ),
                              operatorButton("x"),
                              operatorButton("/"),
                              ElevatedButton(
                                child: Icon(Icons.cancel, color: Colors.white, size: 20),
                                onPressed: (){
                                  if(display == "0"){
                                    return;
                                  }
                                  else{
                                    setState((){
                                      if(display == "Undefined"){ //remove error message
                                        display = "0";
                                        return;
                                      }

                                      if(display[display.length-1] == "."){
                                        _hasPoint = false; //reset _hasPoint after deleting decimal point
                                      }
                                      display = display.substring(0,display.length - 1);

                                      if(display == "-" || display.length == 0) { //prevent a - operator without and preceeding operand and reset display
                                        display = "0";
                                      }
                                    }
                                    );
                                  }
                                }
                                ,
                                style: ElevatedButton.styleFrom(
                                  minimumSize: Size(deviceWidth/5,deviceHeight/16),                                  elevation: 0,
                                  backgroundColor: Colors.blue,
                                ),
                              ),
                            ]
                        ),
                        SizedBox(
                            height: 3
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            numberButton("7"),
                            numberButton("8"),
                            numberButton("9"),
                            operatorButton("+"),
                          ],
                        ),
                        SizedBox(
                            height: 3
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            numberButton("4"),
                            numberButton("5"),
                            numberButton("6"),
                            operatorButton("-"),
                          ],
                        ),
                        SizedBox(
                            height: 3
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            numberButton("1"),
                            numberButton("2"),
                            numberButton("3"),
                ElevatedButton(
                  child: Text(".", style: TextStyle(color: Colors.white, fontSize: 20)),
                  style: ElevatedButton.styleFrom(
                      minimumSize: Size(deviceWidth/5,deviceHeight/16),
                      elevation: 0,
                      backgroundColor: Colors.blue
                  ),
                  onPressed: (){
                    setState((){
                      if((_hasPoint) || (ExpressionEvaluator().isOperator(display[display.length-1]))){
                        return;
                      }
                      else{
                        op = ".";
                        display += op;
                        _hasPoint = true; //do not allow more decimal points for the same number
                      }
                    });
                  },
                ),

                          ],
                        ),
                        SizedBox(
                            height: 3
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            ElevatedButton(
                              child: Text("0", style: TextStyle(color: Colors.white, fontSize: 20)),
                              onPressed: (){
                                setState((){
                                  if(display == "Undefined") { //override error message
                                    display = "0";
                                    return;
                                  }

                                  if(display != "0"){
                                    display += "0";
                                  }
                                });
                              },
                              style: ElevatedButton.styleFrom(
                                minimumSize: Size(deviceWidth/1.5,deviceHeight/14),
                                elevation: 0,
                                backgroundColor: Colors.blue,
                              ),
                            ),
                            ElevatedButton(
                              child: Text("=", style: TextStyle(color: Colors.blue, fontSize: 20)),
                              onPressed: (){
                                if((display == "0")  || (ExpressionEvaluator().isOperator(display[display.length-1]))){
                                  return;
                                }
                                setState(() {
                                  display = ExpressionEvaluator().evaluate(display);
                                });
                              },
                              style: ElevatedButton.styleFrom(
                                minimumSize: Size(deviceWidth/4,deviceHeight/16),
                                elevation: 0,
                                backgroundColor: Colors.white,
                              ),
                            ),

                          ],
                        ),
                      ]
                  )
              )
            ]
        )
    );
  }
}

