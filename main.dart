// Abstract Class
abstract class Car {
  // Abstract Attribute
  abstract bool _isTurboActivated;
  // Concrete Attribute
  List<String> transmission = ["P", "N", "R", "D"];
  late String _engineVariant;
  late String _color;
  late String _shiftLevel;
  // Getters
  String get color => _color;
  bool get isTurboActivated => _isTurboActivated;
  String get shiftLevel => _shiftLevel;
  String get engineVarient => _engineVariant;

  // Methods
  void shift(String s) {
    if (transmission.contains(s)) {
      this._shiftLevel = s;
    } else {
      throw ShiftingException("Failed To Shift");
    }
  }

  String getState(String shift) {
    Map<String, String> state = {
      "P": "Parking",
      "D": "Forward",
      "R": "Reverse",
      "N": "Neutral",
    };
    return state['$shift'].toString();
  }
}

// Mixin Class : Use for do multiple inheritance that can expanded ability of ordinary class
/*
  For the example we've got some car's feature that has in specific model or variant you can
  mixed this feature to specific car that can give more car feature
*/
mixin class AWD {
  bool xmode = false;
  void toggleXmode() {
    this.xmode = !xmode;
    print('x-mode : ${xmode ? "Activated" : "Deactivated"}');
  }
}

// Interface  : Direct the flow method of class  use keyword "implements" for implement the interface
/*
  Example : A car with different model , variant or brand that has a mutual "Cruise Control" Feature 
  But the work different in specific model. So it has the same target , increase speed or reduce speed
*/
abstract class CruiseControl {
  void cruiseSpeedUp(int step);
  void cruiseSpeedDown(int step);
}

// Interface : Implementation
/*
  Example : When you implements the interface you must implement all method in inteface
*/
class ShiftingException implements Exception {
  final String message;
  ShiftingException(this.message);
  @override
  String toString() {
    return message;
  }
}

// Extension : Bound some functions or methods into the existing class give more power to the existing class,

extension on SubaruXV {
  void autoVehicleHold() {
    print('enable AVH');
  }
}

class SubaruXV extends Car with AWD implements CruiseControl {
  int currentSpeed = 0;
  @override
  bool _isTurboActivated = false;
  @override
  SubaruXV(String color) {
    this._engineVariant = "FB20";
    this._shiftLevel = "P";
    this._color = color;
  }

  @override
  String toString() {
    return "Current Speed : ${currentSpeed}\nEngine : ${this.engineVarient}\nCurrent Shift : ${this.shiftLevel}\nColor : ${this.color}\nState : ${getState(shiftLevel)}\nX-Mode : ${this.xmode}";
  }

  // implements interfaces
  @override
  void cruiseSpeedDown(int step) {
    if (currentSpeed - step <= 0) {
      currentSpeed = 0;
    } else {
      currentSpeed -= step;
    }
  }

  @override
  void cruiseSpeedUp(int step) {
    currentSpeed += step;
  }
}

// create new class from abstract
class SubaruWRX extends Car {
  @override
  bool _isTurboActivated = false;

//  define abstract method to concrete method
  void activateTurbo(bool status) {
    if (this.shiftLevel == "D") {
      this._isTurboActivated = status;
    } else {
      throw ShiftingException("Turbo only activate on D");
    }
  }

  @override
  String toString() {
    return "Engine : ${this.engineVarient}\nCurrent Shift : ${this.shiftLevel}\nColor : ${this.color}\nTurbo : ${this.isTurboActivated}\nState : ${getState(shiftLevel)}\n";
  }

  SubaruWRX(String color) {
    this._engineVariant = "FB25";
    this._color = color;
    this._shiftLevel = "P";
  }
}

void main() {
  SubaruXV myCar = SubaruXV("Tangerine");
  SubaruWRX my2ndCar = SubaruWRX("Blue");

  try {
    print("BEFORE\n");
    print(myCar.toString());
    myCar.autoVehicleHold();
    print("\nAFTER\n");
    myCar.cruiseSpeedUp(20);
    myCar.cruiseSpeedUp(20);
    myCar.toggleXmode();
    myCar.shift("D");
    print(myCar.toString());
    print('\n');
    print("BEFORE\n");
    print(my2ndCar.toString());
    my2ndCar.shift("D");
    my2ndCar.activateTurbo(true);
    print("\nAFTER\n");
    print(my2ndCar.toString());
  } catch (err) {
    if (err is ShiftingException) {
      print('${err.message}');
    }
  }
}
