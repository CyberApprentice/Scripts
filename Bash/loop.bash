#!/usr/bin/env bash
#bash loop

function shfunc()
{
	printf "Hello function\n"
}

for ((i=0; i<5; i++))
	do
		{
			shfunc
		}
	done
