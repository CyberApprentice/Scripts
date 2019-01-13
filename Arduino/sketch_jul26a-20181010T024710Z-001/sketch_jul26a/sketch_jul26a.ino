#include <HID.h>
#include <Keyboard.h>

void setup()
{
  // Start Keyboard and Mouse
  Keyboard.begin();
  delay(500);
  Keyboard.press(KEY_LEFT_GUI);
  delay(900);
  Keyboard.press('r');
  delay(100);
  Keyboard.releaseAll();
  delay(1000);
  Keyboard.println("powershell.exe");
  delay(1000);

  int x = 0;
  char[ ] windows_version = Keyboard.println("$winVersion = Get-WmiObject -Class Win32_OperatingSystem | ForEach-Object -MemberName Caption");
  printf(%c, &windows_version);
}

 // Unused
void loop() 
{

}
