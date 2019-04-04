import "dart:async"; 

class GameCounter {

  int value; 
  int gameDuration; 
  bool timeout; 

  GameCounter({int initialValue: 0, int gameDuration: 60}){
    this.value = initialValue; 
    this.gameDuration = gameDuration;
    this.timeout = false;   

    assert((gameDuration > 0), 
      "Minimum initial game duration time is 30 seconds");
    }
  
  set timer(bool value) => timeout = value;

  Timer start() {
    print("Counter starting...");
    return new Timer(Duration(seconds: 1), () {
      print("Time is up");
      timeout = true;  
      return("Time is up!");
});
  }
  void increase(int increaseAmt) {
    if (timeout == true){
      print("Counter has timed out, increase() fails.");
      return; 
    }
    value += increaseAmt; 
    }

  void decrease(int decreaseAmt){
    if (timeout == true){
      print("Counter has timed out, decrease() fails.");
      return; 
    }
    
    if (decreaseAmt > value) {
      value = 0; 
    }
    else {
      value -= decreaseAmt;
    }
  }
  }