#lang brag

taco-program : /"\n"* taco-leaf* /"\n"*
taco-leaf: /"#" (not-a-taco | taco){7} /"$"
not-a-taco : /"#$"
taco : /"%"