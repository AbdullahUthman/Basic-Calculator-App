class ExpressionEvaluator {
  List<String> _ops;
  String result; //to return the evaluated postfix expression
  String _pfexp; //to store the postfix expression

  ExpressionEvaluator()
      : _ops = [],
        result = "",
        _pfexp = "";


   bool isOperator(String val) {
    if (val == "+" || val == "x" || val == "-" || val == "/") {
      return true;
    }
    else {
      return false;
    }
  }

  int _precedance(String op) {
    switch (op) {
      case "+":
        return 1;
        break;
      case "-":
        return 1;
        break;
      case "x":
        return 2;
        break;
      case "/":
        return 2;
        break;
      default:
        return 0;
        break;
    }
  }

  double _calculate(double n1, String op, double n2) {
    switch (op) {
      case "+":
        return n1 + n2;
        break;
      case "x":
        return n1 * n2;
        break;
      case "-":
        return n1 - n2;
        break;
      case "/":
        if (n2 == 0) {
          return double.nan; //for division by zero
        }
        return n1 / n2;
        break;
      default:
        return 0;
    }
  }

  void _toPostfix(String exp) {
    for (int i = 0; i < exp.length; i++) {
      if (isOperator(exp[i])) {
        _pfexp += " "; //add space when an operator is found i.e., when a number ends (which may be multi-digit)
        if ((_ops.isNotEmpty) && (_precedance(_ops.last) >= _precedance(exp[i]))) { //to check if there are any operators of greater precadance in the stack
          _pfexp += _ops.last;
          _pfexp += " ";
          _ops.removeLast();
        }
        _ops.add(exp[i]); //push the operator (current character) to the stack
      }
      else {
        _pfexp += exp[i]; //add numbers to the postfix expression
      }
    }

    while (_ops.isNotEmpty) {
      _pfexp += " ";
      _pfexp += _ops.last; //add any remaining operators until the stack is empty
      _ops.removeLast();
    }
  }

  String _clean(double val){
     if(val == val.roundToDouble()){ //if the value is same as it is rounded off, convert to int, then to string and return
       int t = val.toInt();
       return t.toString();
     }
     return val.toStringAsFixed(10); //return double to string upto 10 decimal value precision
  }

    String evaluate(String exp) {
    _toPostfix(exp);
    String _op = "";
    String _n1S = "";
    String _n2S = "";
    double _n1, _n2, _r;
    List<String> nums = [];
    int i = 0;
    while (i < _pfexp.length) {
      if (_pfexp[i] == " ") {
        _n1S = ""; // resetting _n1S after the last loop
        i++;
        continue;
      }
      if (isOperator(_pfexp[i])) {
        _n2S = nums.last;
        nums.removeLast();
        _op = _pfexp[i];
        _n1S = nums.last;
        nums.removeLast();
        _n1 = double.parse(_n1S);
        _n2 = double.parse(_n2S);
        _r = _calculate(_n1, _op, _n2);
        if (_r.isNaN) {  //handling division by zero
          return "Undefined";
        }
        nums.add(_r.toString());
        i++;
      }

      else {
        while (_pfexp[i] != " " && i < _pfexp.length) {
          _n1S += _pfexp[i]; //using n1S to store the number
          i++;
        }
        nums.add(_n1S);
      }
    }
    result = _clean(double.parse(nums.last));
    return result;
  }
}









