#include <HID.h>
#include <Keyboard.h>

// Init function
void setup()
{
  // Start Keyboard and Mouse
  Keyboard.begin();
  delay(500);
  Keyboard.press(KEY_LEFT_GUI);
  delay(900);
  Keyboard.press('r')cmd.exe
  ipconfig
  6;
  Keyboard.releaseAll();
  delay(900);
  Keyboard.println("cmd.exe");
  delay(1000);
  Keyboard.println("ipconfig");
  delay(1000);
  Keyboard.println(" \"C:\\Program Files\\Internet Explorer\\iexplore.exe\" -k http://fakeupdate.net/win10u/index.html ");

  Keyboard.end();
  
}

// Unused
void loop() 
{

}
