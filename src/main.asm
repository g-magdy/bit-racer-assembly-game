; last updated: 03/12/2023 17:00
; currently runs only page 0, 
; you enter name1, pts1, name2, pts2 
; then press enter then names and points are printed as a check
; points are not yet converted

;* this file is just a suggestion
;* no specific convention was used.
;? I don't know if we need .386

.model small
.stack 64
.data
    include consts.inc

    ; strings to print
    str_enter_usrname1      db "User1's Name:", '$'
    str_initial_points1     db "User1's Initial Points: ", '$'

    str_enter_usrname2      db "User2's Name:", '$'
    str_initial_points2     db "User2's Initial Points: ", '$'

    str_press_enter_key     db "Press Enter Key To Continue", '$'
    
    ; variables
    currentColumn           db 0
    currentRow              db 0
    currentColor            db BLACK

    ; User 1 data
    usernameBuffer1         label byte
    usrMaxSize1             db 16
    usrActualSize1          db ?
    username1               db 17 DUP ('$')
    
    pointsBuffer1           label byte
    ptsMaxSize1             db 4
    ptsActualSize1          db ?
    pointsString1           db 5 DUP ('$')

    ; User 2 data
    usernameBuffer2         label byte
    usrMaxSize2             db 16
    usrActualSize2          db ?
    username2               db 17 DUP ('$')
    
    pointsBuffer2           label byte
    ptsMaxSize2             db 4
    ptsActualSize2          db ?
    pointsString2           db 5 DUP ('$')

.code
include procs.inc
include macros.inc
;right now it has only page 0 : username and points of both users
main PROC
    mov ax, @data
    mov ds, ax
    
    call enterVideoMode
    mov currentColor, CYAN
    call fillScreen

    mov currentColumn, 1
    mov currentRow, 1
    call moveCursor
    
    ; Read username1
    readData str_enter_usrname1, usernameBuffer1

    ; leave a space
    add currentRow, 4
    call moveCursor
    
    ; Read points1
    readData str_initial_points1, pointsBuffer1
    
    ; leave a space
    add currentRow, 4
    call moveCursor

    ;;;;;;;;;;;;;;;;;;;;;;;;; promt and wait for enter key
    mov dx, offset str_press_enter_key
    call printmsg

    waiting:
        mov ah, 0
        int 16h ; wait for keypress from user: ah = scancode
        cmp ah, ENTER_KEY
        je nextScreen
    jmp waiting


    nextScreen:
    mov currentColor, LIGHT_GREEN
    call fillScreen
;?;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;SCREEN SEPARATOR;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    mov currentColumn, 1
    mov currentRow, 1
    call moveCursor

    ; Read username2
    readData str_enter_usrname2, usernameBuffer2

    ; leave a space
    add currentRow, 4
    call moveCursor
    
    ; Read points1
    readData str_initial_points2, pointsBuffer2
    
    ; leave a space
    add currentRow, 4
    call moveCursor

    ;;;;;;;;;;;;;;;;;;;;;;;;; promt and wait for enter key
    mov dx, offset str_press_enter_key
    call printmsg

    waiting2:
        mov ah, 0
        int 16h ; wait for keypress from user: ah = scancode
        cmp ah, ENTER_KEY
        je nextScreen2
    jmp waiting2


    nextScreen2:
    mov currentColor, YELLOW
    call fillScreen
;?;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;SCREEN SEPARATOR;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    mov currentColumn, 1
    mov currentRow, 1
    call moveCursor

    ; print both data to make sure    
    printData username1, pointsString1
    
    ; leave a space
    add currentRow, 4
    call moveCursor
    
    printData username2, pointsString2

    ;;;;;;;;;;;;;;;;;;;;;;;;; End 
    byebye:
    mov ax ,4c00h
    int 21h
main ENDP
end main