#!/usr/bin/env python
import subprocess

def command():
	command = raw_input("What bash command do you want to execute? ")
 	print "\nThank you..processing command\n\nOutput: \n"
 	subprocess.call(command, shell=True)

def main():
 	command()

main()
