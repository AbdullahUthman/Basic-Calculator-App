# Basic-Calculator

A basic calculator in Flutter that performs +,-,* and / operations and handles decimal values.


## Features
* Allows full expressions (e.g. "2+2") and discards incomplete expressions (e.g."2+" or "5")
* Converts String input to double, evaluates it, then converts it back to String, for output
* Converts infix input expressions to postfix for output (using a basic implementation of the shunting yard algorithm)
* Shows precision upto 10 decimal places for floating numbers and discards decimal points for integer answers
* Rounds off decimal answers
* Handles division by 0 with an "Undefined" error message
* Does not allow alteration of the error message through user input
* Does not allow any operator input without preceding operand
* Resets input to "0" when all input is removed (with clear or remove button)
* Does not allow more than one leading "0"s in input
* Does not allow multiple "."s for one operand in the input expression