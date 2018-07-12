#lang brag
zip-code : @digit{5} [/"-" digit{4}] ; splice and cut
digit : "0" | "1" | "2" | "3" | "4"
      | "5" | "6" | "7" | "8" | "9"