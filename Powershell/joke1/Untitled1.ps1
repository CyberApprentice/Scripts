Add-Type -AssemblyName System.speech
$speak = New-Object System.Speech.Synthesis.SpeechSynthesizer
$speak.Speak('Your computer has been hacked. Warning! Initializing destruction sequence in 3... 2... 1...')

(New-Object Media.SoundPlayer ".\futherbackups\Siren.wav").PlaySync()

$speak.Speak('Can you hear this sound?')
