.MODEL small
.386
.stack 
.data

string1 db 10,10,"******************* what you want to donate with? *******************" , "$"
money db "1- with money" ,"$"
books db "2- with books","$"
teacher db "3- Volunteering as a classroom assistant or working as a private teacher ","$"
donation db "enter the amount you want to donate with" , "$"
thanks db 10,"******************* thank you for your donation *******************",10,10,10,10,"$"
again db "Do you want to donate something else? enter y or n","$" 
sname db 20 dup(?)
exit db "good bye have a nice day","$"
wrongInput db "wrong input enter a valid input",10,10,"$"
bookDonate db 10,10,"********** in which school year do you want to donate your books? ***********",10,"************************ enter number from 1-9 ************************",10,"$"
array db 31h,32h,33h,34h,35h,36h,37h,38h,39h ;for check if entered number 1-9 grades
array2 db 31h,32h ;for check if enterded number from 1-3
decorate db "*************************************************","$"
subjects db 10,"**********************************************",10,\
"((Math, Scince, Arabic, English ,ComputerScience))",10,\
"1-Choose one or more than one subject",10,\
"2-All of them","$"
subjects2 db 10,\
"1-Math",10,\
"2-Scince",10,\
"3-Arabic",10,\
"4-English",10,\
"5-ComputerScience",10,"$"
math db "Math ","$"
science db "Science ","$"
arabic db "Arabic ","$"
english db "English ","$"
computerScience db "ComputerScience ","$"
choose db 10,"you choose : ","$"
askChooseMore db 10,"do you want to choose another subject?",10,"please enter y or n","$"
communication db 10,"******************* we will contact you shortly *********************** ","$"
chooseAll db 10,10,"******************* all the subjects has been choosen *********************** ","$"
teacherChoises db 10,"*******************how do you want to participate?*******************",10,\
"1- as an assistant",10,\
"2- as a private teacher",10,"$"
assistantMessage db 10, " thank you. We will contact you in order to determine the right date for you","$"
privateTeacherMessage db 10, " choose the subject that you want to teach ","$"

.code
   main PROC FAR
   .startup
start:
        lea bx , string1
        call print
        
        call newLine
        call newLine
   
        lea bx, money
       
        call print
        
        call newLine
        
        lea bx,books
        call print
        
        call newLine
        
        lea bx , teacher
        call print
        call newLine
       
        call recChar
       
        cmp al,31h
        je moneyL
        cmp al,32h
        je booksL
        jne teacherL
        jmp exitL
       
    moneyL:
        ;money
        call erase
        lea bx , donation
        
        call print
        call newLine
        
        
        mov byte ptr sname, 21    
        mov dx, OFFSET sname
        mov ah,0Ah
        int 21h
    
        lea bx , thanks
        call print
    y:
        lea bx,again
        call print
        
       
       
        call recChar  
        cmp al,"y" ;here we compare the entered character with y or n
        call erase
        je start
        cmp al,"n" ; compare with n
        je exitF
        lea bx , wrongInput ;if the entered value not n or y
        call print
        jne y
        
        
        
        ;books
        
    booksL:  
        call erase
    b:
        lea bx,bookDonate
        call print
        call recChar
        mov cx ,9
        lea si , array
        
    z:
        ;make sure that we entered a valid input from 1-9
        cmp al, [si]
        je c
        inc si
        loop z
        call erase
        lea bx ,wrongInput
        call print
        jmp b
    c:
        lea bx, subjects
        call print
      
        call newLine 
        
        mov ah,10h
        int 16h
        
        cmp al, 31h
        mov cx,0000h
        je chooseOneOrMore
        lea bx,chooseAll
        call print
        jmp endOfChooseAll
        
    chooseOneOrMore:
        
        lea bx,decorate
        call print
        
        lea bx,subjects2
        call print
        call recChar
        
        cmp al,31h
        je _1
        cmp al,32h
        je _2
        cmp al,33h
        je _3
        cmp al,34h
        je _4
        cmp al,35h
        je _5
        call erase
        call newLine
        lea bx , wrongInput ;if the entered value not n or y
        call print
        jne chooseOneOrMore
   
    _1: 
        lea si,math
        push si
        inc cx
        jmp below
    _2:
       lea si,science
        push si
        inc cx
        jmp below
    _3:
        lea si,arabic
        push si
        inc cx
        jmp below
    _4:
        lea si,english
        push si
        inc cx
        jmp below
    _5:
        lea si,computerScience
        push si
        inc cx
    below: 
        
        lea bx , askChooseMore
        call print
        mov ah,10h
        int 16h
        cmp al,"y"
        call newLine
        je chooseOneOrMore
        
        
        lea bx,choose
        call print
    printAllChoosenSubjects:
        pop bx
        call print
        loop printAllChoosenSubjects
    endOfChooseAll:
        lea bx,communication
        call print
       
        lea bx , thanks
        call print
    n:
        lea bx,again
        call print
        
       
       
        call recChar  
        cmp al,"y" ;here we compare the entered character with y or n
        call erase
        je start
        cmp al,"n" ; compare with n
        je exitF
        
        lea bx , wrongInput ;if the entered value not n or y
        call print
        jne n
        
        
        
     
        
    exitL: 
   .exit
   main ENDP
   
   print proc near
        mov dx,bx
        mov ah,09h
        int 21h
        ret 
   print endp 
   
   newLine proc near
        mov ah,02h
        mov dl,10
        int 21h
        ret
   newLine endp
   
   
   erase proc near
        pusha
        mov ah, 0h
        mov al, 03h 
        int 10h
        popa
        ret
   erase endp
   
   recChar proc near
        mov ah,01h
        int 21h
        ret
   recChar endp
   
   teacherL proc near
        call erase
        lea bx,teacherChoises
        call print
        
        mov ah,10h
        int 16h
        
        cmp al,31h
        jne privateTeacher
        lea bx,assistantMessage
        call print
        call newLine
        call newLine
        call newLine
        
    Again2:
        lea bx,again
        call print
        
        call recChar  
        cmp al,"y" ;here we compare the entered character with y or n
        call erase
        je start
        cmp al,"n" ; compare with n
        je exitF
        lea bx , wrongInput ;if the entered value not n or y
        call print
        jne Again2
        ret
    privateTeacher:
        lea bx,privateTeacherMessage
        call print
        lea bx , subjects2
        call print
        
        call recChar
        lea bx,assistantMessage
        call print
        call newLine
        call newLine
        call newLine
        
    Again:
        lea bx,again
        call print
        
        call recChar  
        cmp al,"y" ;here we compare the entered character with y or n
        call erase
        je start
        cmp al,"n" ; compare with n
        je exitF
        lea bx , wrongInput ;if the entered value not n or y
        call print
        jne Again
        ret
   teacherL endp     
   
  
   exitF proc near
        lea bx,exit
        call print
        ret
   exitF endp
  
 END main
   