int incomingByte = 0;   // for incoming serial data

void setup() {
        Serial.begin(9600);     // opens serial port, sets data rate to 9600 bps
}

void loop() {
        // send data only when you receive data:
                // read the incoming byte:
                incomingByte = Serial.read();
                Serial.print("I received: ");
                Serial.println(incomingByte, DEC);
                delay(1000);
        
}

/* From PowerShell
 *  $port= new-Object System.IO.Ports.SerialPort $( [System.IO.Ports.SerialPort]::getportnames()),9600,None,8,one
 *  $port.open()
 *  $port.WriteLine("Hello World!")
 */
