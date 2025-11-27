INCLUDE Irvine32.inc
NAME_LEN  EQU 32
PHONE_LEN EQU 16
ADDR_LEN  EQU 50
GREEN EQU 2
.data
    MaxUsers       DWORD 20
    UserCount      DWORD 5
    DefaultBalance DWORD 1000
    Total          DWORD 10
    Ids            DWORD 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
    Passwords1     DWORD 0, 11, 22, 33, 44, 55, 66, 77, 88, 99, 100, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
    Balances1      DWORD 1000, 1500, 2000, 2500, 3000, 3500, 4000, 4500, 5000, 5500, \
                   0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
    AdminPassword  DWORD 12345
    amountadded    DWORD 5 DUP(0)
    amountremoved  DWORD 5 DUP(0)
    TransCount     DWORD 0

    UserName       BYTE NAME_LEN * 20 DUP(0)
    UserPhone      BYTE PHONE_LEN * 20 DUP(0)
    UserAddr       BYTE ADDR_LEN * 20 DUP(0)
    AccountType    DWORD 0,1,1,1,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0
    DateJoined     DWORD 0,20250101,20250102,20250103,20250104,20250105,0,0,0,0,0,0,0,0,0,0,0,0,0,0

    DataWelcome    BYTE 0Dh,0Ah, "-----------------------------------------------Welcome to the ATM System!-----------------------------------------------", 0Dh,0Ah,"---------------------------------------------Made by Hammad,Abdullah,Majid----------------------------------------------", 0Dh,0Ah,0
    MainMenuMsg    BYTE "1. Login",0Dh,0Ah,"2. Sign Up",0Dh,0Ah,"3. Admin Mode",0Dh,0Ah,"4. Exit",0Dh,0Ah,"Enter your choice: ",0
    ChooseOpt      BYTE "Choose Your Option: ",0
    DataEnterID    BYTE 0Dh,0Ah,"Enter Your ID: ",0
    Dataid         BYTE 0Dh,0Ah,"Your ID: ",0
    PromptName     BYTE "Enter Full Name: ",0
    PromptPhone    BYTE "Enter Phone Number: ",0
    PromptAddr     BYTE "Enter Address: ",0
    PromptAcctType BYTE "Account Type (0=Current,1=Savings): ",0
    PromptDate     BYTE "Enter Date Joined (YYYYMMDD): ",0
    DataEnterPass  BYTE 0Dh,0Ah,"Enter Your Password: ",0
    DataAccessDeny BYTE 0Dh,0Ah,"Access Denied!",0
    DataBalance    BYTE 0Dh,0Ah,"Your Balance Is: $",0
    DataAmountWith BYTE 0Dh,0Ah,"Enter Amount To Withdraw (Multiple of 500): ",0
    DataAmountDep  BYTE 0Dh,0Ah,"Enter Amount To Deposit: ",0
    DataInsuff     BYTE 0Dh,0Ah,"Insufficient Balance.",0
    DataTransSuc   BYTE 0Dh,0Ah,"Transaction Successful.",0
    DataMainMenu   BYTE 0Dh,0Ah,"=== Main Menu ===",0Dh,0Ah,"1. Check Balance",0Dh,0Ah,"2. Withdraw",0Dh,0Ah,"3. Deposit",0Dh,0Ah,"4. Transfer",0Dh,0Ah,"5. Show History",0Dh,0Ah,"6. Reset PIN",0Dh,0Ah,"7. Exit",0Dh,0Ah,"Choose Your Option: ",0
    GoodbyeMsg     BYTE "Goodbye!",0Dh,0Ah,0
    DataSignupSuc  BYTE "Signup Successful!",0Dh,0Ah,0
    DataHistLog    BYTE "Transaction History: ",0
    DataHistEmpty  BYTE "No transaction history found.",0
    DataReciverID  BYTE "Enter receiver ID: ",0
    DataAmountTrans BYTE "Enter amount to transfer: ",0
    DataResetPIN   BYTE "Enter new PIN: ",0
    DataPINReset   BYTE "PIN has been reset successfully.",0
    DataEnterAdmin BYTE "Enter Admin Password: ",0
    DataAdminSuc   BYTE "Admin access granted.",0
    DataAdminFail  BYTE "Admin access denied.",0Dh,0Ah,0
    DataIdAssigned BYTE 0Dh,0Ah,"Your generated ID: ",0
    AcctCurrentMsg BYTE "Account Type: Current",0Dh,0Ah,0
    AcctSavingsMsg BYTE "Account Type: Savings",0Dh,0Ah,0
    DataAdminMenu  BYTE "=== Admin Menu ===",0Dh,0Ah,"1. View Balances",0Dh,0Ah,"2. Reset Accounts",0Dh,0Ah,"3. View Users",0Dh,0Ah,"4. Exit",0

    CurrentUserIdx DWORD 0
    Balance        DWORD 0

    InsufficientFundsMsg BYTE "Insufficient funds!",0
    inflow          BYTE "Deposit: $",0
    outflow         BYTE "Outflow: $",0
    TransLog        BYTE 500 DUP(0)
    TransMessage    BYTE "Transaction completed",0

.code
main PROC
    call Randomize
    mov eax , GREEN
    call SetTextColor
    mov edx, OFFSET DataWelcome
    call WriteString
    call Crlf
    mov eax , WHITE
    call SetTextColor
MainMenu:
    call Crlf
    mov edx, OFFSET MainMenuMsg
    call WriteString
    call ReadInt

    cmp eax, 1
    je Login

    cmp eax, 2
    je Signup

    cmp eax, 3
    je AdminMode

    cmp eax, 4
    je ExitProgram

    jmp MainMenu


Signup:
    mov eax, UserCount
    cmp eax, MaxUsers
    jge MaxUsersReached

TryRandomID:
    call RandomID
    mov esi, 0
CheckIDUnique:
    mov ecx, UserCount
    cmp esi, ecx
    je IDUniqueFound
    mov edx, [Ids + esi*4]
    cmp edx, eax
    je TryRandomID
    inc esi
    jmp CheckIDUnique

IDUniqueFound:
    mov esi, UserCount
    mov [Ids + esi*4], eax

    mov edx, OFFSET Dataid
    call WriteString
    mov eax, [Ids + esi*4]
    call WriteInt
    call Crlf

    mov edx, OFFSET PromptName
    call WriteString
    lea edx, UserName
    mov ebx, esi
    imul ebx, NAME_LEN
    add edx, ebx
    mov ecx, NAME_LEN
    call ReadString

    mov edx, OFFSET PromptPhone
    call WriteString
    lea edx, UserPhone
    mov ebx, esi
    imul ebx, PHONE_LEN
    add edx, ebx
    mov ecx, PHONE_LEN
    call ReadString

    mov edx, OFFSET PromptAddr
    call WriteString
    lea edx, UserAddr
    mov ebx, esi
    imul ebx, ADDR_LEN
    add edx, ebx
    mov ecx, ADDR_LEN
    call ReadString

    mov edx, OFFSET PromptAcctType
    call WriteString
    call ReadInt
    mov [AccountType + esi*4], eax

    mov edx, OFFSET PromptDate
    call WriteString
    call ReadInt
    mov [DateJoined + esi*4], eax

    mov edx, OFFSET DataEnterPass
    call WriteString
    call ReadInt
    mov [Passwords1 + esi*4], eax


    mov eax, DefaultBalance
    mov [Balances1 + esi*4], eax

    inc UserCount

    mov edx, OFFSET DataSignupSuc
    call WriteString
    call Crlf
    jmp MainMenu

MaxUsersReached:
    mov edx, OFFSET DataAccessDeny
    call WriteString
    call Crlf
    jmp MainMenu


UserMenu:
    mov edx, OFFSET DataMainMenu
    call WriteString
    call ReadInt

    cmp eax, 1
    je ShowBalance
    cmp eax, 2
    je Withdraw
    cmp eax, 3
    je Deposit
    cmp eax, 4
    je Transfer
    cmp eax, 5
    je ShowHistory
    cmp eax, 6
    je ResetPIN
    cmp eax, 7
    je MainMenu

    jmp UserMenu

Login:
    mov edx, OFFSET DataEnterID
    call WriteString
    call ReadInt
    mov ecx, eax

    mov esi, 0
    mov edi, -1

CheckIDLoop:
    mov eax, UserCount
    cmp esi, eax
    jge LoginFailed

    mov eax, [Ids + esi*4]
    cmp ecx, eax
    je IDFound

    inc esi
    jmp CheckIDLoop

IDFound:
    mov edi, esi

    mov edx, OFFSET DataEnterPass
    call WriteString
    call ReadInt

    mov ebx, [Passwords1 + edi*4]
    cmp eax, ebx
    jne LoginFailed

    mov CurrentUserIdx, edi
    mov eax, [Balances1 + edi*4]
    mov Balance, eax

    jmp UserMenu

LoginFailed:
    mov edx, OFFSET DataAccessDeny
    call WriteString
    call Crlf
    jmp MainMenu


RandomID PROC
    call Random32
    xor edx, edx
    mov ecx, 90
    div ecx
    mov eax, edx
    add eax, 11
    ret
RandomID ENDP

ShowBalance:
    mov eax, Balance
    mov edx, OFFSET DataBalance
    call WriteString
    call WriteInt
    call Crlf
    jmp UserMenu

Withdraw:
ValidateWithdraw:
    mov edx, OFFSET DataAmountWith
    call WriteString
    call ReadInt
    mov ebx, eax

    cmp ebx, 500
    jl InvalidWithdraw

    mov eax, ebx
    mov ecx, 500
    cdq
    div ecx
    cmp edx, 0
    jne InvalidWithdraw

    mov eax, Balance
    cmp ebx, eax
    ja InsufficientFunds

    sub eax, ebx            ; eax = new balance
    mov Balance, eax
    mov esi, CurrentUserIdx
    mov [Balances1 + esi*4], eax

    mov esi, TransCount
    mov [amountremoved + esi*4], ebx
    call LogTransaction

    mov edx, OFFSET DataTransSuc
    call WriteString
    jmp UserMenu

InvalidWithdraw:
    mov edx, OFFSET DataAccessDeny
    call WriteString
    jmp ValidateWithdraw

InsufficientFunds:
    mov edx, OFFSET DataInsuff
    call WriteString
    jmp UserMenu


Deposit:
    mov edx, OFFSET DataAmountDep
    call WriteString
    call ReadInt
    mov ebx, eax        ; amount to deposit

    mov eax, Balance
    add eax, ebx
    mov Balance, eax
    mov esi, CurrentUserIdx
    mov [Balances1 + esi*4], eax

    mov esi, TransCount
    mov [amountadded + esi*4], ebx
    call LogTransaction

    mov edx, OFFSET DataTransSuc
    call WriteString
    jmp UserMenu


Transfer:
    mov edx, OFFSET DataReciverID
    call WriteString
    call ReadInt
    mov ecx, eax            

    mov edx, OFFSET DataAmountTrans
    call WriteString
    call ReadInt
    mov ebx, eax            

    ; check enough balance
    mov eax, Balance
    cmp ebx, eax
    ja InsufficientFunds

    mov edi, 0
FindReceiver:
    mov eax, UserCount
    cmp edi, eax
    jge TransferFailed

    mov eax, [Ids + edi*4]
    cmp eax, ecx
    je UpdateReceiver
    inc edi
    jmp FindReceiver

UpdateReceiver:
    mov esi, CurrentUserIdx
    cmp edi, esi
    je TransferFailed

    mov eax, Balance
    sub eax, ebx
    mov Balance, eax
    mov esi, CurrentUserIdx
    mov [Balances1 + esi*4], eax

    mov eax, [Balances1 + edi*4]
    add eax, ebx
    mov [Balances1 + edi*4], eax

    mov esi, TransCount
    mov [amountremoved + esi*4], ebx
    call LogTransaction

    mov edx, OFFSET DataTransSuc
    call WriteString
    jmp UserMenu

TransferFailed:
    mov edx, OFFSET DataAccessDeny
    call WriteString
    jmp UserMenu


ShowHistory:
    mov edx, OFFSET DataHistLog
    call WriteString
    call Crlf

    mov ecx, TransCount
    cmp ecx, 0
    je NoHistory

    mov esi, 0
    mov edi, 0

PrintHistory:
    ; print inflow
    mov eax, green + (black*16)
    call SetTextColor
    mov edx, OFFSET inflow
    call WriteString
    mov eax, [amountadded + esi*4]
    call WriteDec
    call Crlf

    ; print outflow
    mov eax, red + (black*16)
    call SetTextColor
    mov edx, OFFSET outflow
    call WriteString
    mov eax, [amountremoved + edi*4]
    call WriteDec
    call Crlf

    inc esi
    inc edi
    loop PrintHistory

    mov eax, white + (black*16)
    call SetTextColor
    jmp UserMenu

NoHistory:
    mov edx, OFFSET DataHistEmpty
    call WriteString
    jmp UserMenu


ResetPIN:
    mov edx, OFFSET DataResetPIN
    call WriteString
    call ReadInt
    mov ebx, eax
    mov esi, CurrentUserIdx
    mov [Passwords1 + esi*4], ebx

    mov edx, OFFSET DataPINReset
    call WriteString
    jmp UserMenu


AdminMode:
    mov edx, OFFSET DataEnterAdmin
    call WriteString
    call ReadInt
    mov ebx, AdminPassword
    cmp eax, ebx
    jne AdminFail

AdminMenuLoop:
    mov edx, OFFSET DataAdminMenu
    call WriteString
    call Crlf
    mov edx, OFFSET ChooseOpt
    call WriteString
    call ReadInt

    cmp eax, 1
    mov esi, 0
    je ViewLoop
    ;je ViewBalances
    cmp eax, 2
    mov esi, 0
    mov ecx, UserCount
    je ResetLoop
    ;je ResetAccounts
    cmp eax, 3
    mov esi, 0
    je AdminViewUsers
    cmp eax, 4
    je MainMenu

    ;jmp AdminMenuLoop

;ViewBalances PROC
    ;mov esi, 0
ViewLoop:
    mov eax, UserCount
    cmp esi, eax
    jge EndView

    mov eax, [Ids + esi*4]
    mov edx, OFFSET Dataid
    call WriteString
    call WriteInt
    call Crlf

    mov eax, [Balances1 + esi*4]
    mov edx, OFFSET DataBalance
    call WriteString
    call WriteInt
    call Crlf

    inc esi
    jmp ViewLoop

EndView:
    jmp AdminMenuLoop
;    ret
;ViewBalances ENDP


;ResetAccounts PROC
    ;mov esi, 0
    ;mov ecx, UserCount

ResetLoop:
    cmp esi, ecx
    jge EndReset

    mov eax, DefaultBalance
    mov [Balances1 + esi*4], eax
    mov [Passwords1 + esi*4], 0
    inc esi
    jmp ResetLoop

EndReset:
    mov edx, OFFSET DataTransSuc
    call WriteString
    call Crlf
    jmp AdminMenuLoop
    ;ret
;ResetAccounts ENDP

AdminViewUsers:
    mov eax, UserCount
    cmp esi, eax
    jge AdminMenuLoop

    mov eax, [Ids + esi*4]
    mov edx, OFFSET DataIdAssigned
    call WriteString
    call WriteInt
    call Crlf

    lea edx, UserName
    mov ebx, esi
    imul ebx, NAME_LEN
    add edx, ebx
    call WriteString
    call Crlf

    mov eax, [AccountType + esi*4]
    cmp eax, 0
    je LIsCurrent
    mov edx, OFFSET AcctSavingsMsg
    call WriteString
    jmp LAfterAcct
LIsCurrent:
    mov edx, OFFSET AcctCurrentMsg
    call WriteString
LAfterAcct:

    mov eax, [Balances1 + esi*4]
    mov edx, OFFSET DataBalance
    call WriteString
    mov eax, [Balances1 + esi*4]
    call WriteInt
    call Crlf

    inc esi
    jmp AdminViewUsers


AdminFail:
    mov edx, OFFSET DataAdminFail
    call WriteString
    jmp MainMenu

LogTransaction PROC
    push eax
    push ebx
    push ecx
    push edx
    push esi
    push edi

    mov eax, TransCount
    mov edx, 100
    imul eax, edx
    lea edx, TransLog
    add edx, eax

    ; lea instead of OFFSET
    lea ecx, TransMessage
    call StringCopy

    mov eax, TransCount
    inc eax
    mov ebx, 5
    cmp eax, ebx
    jl LNoWrap
    mov eax, 0

LNoWrap:
    mov TransCount, eax
    pop edi
    pop esi
    pop edx
    pop ecx
    pop ebx
    pop eax
    ret
LogTransaction ENDP

StringCopy PROC
    push esi
    push edi

    mov esi, ecx
    mov edi, edx
CopyLoop:
    mov al, [esi]
    mov [edi], al
    inc esi
    inc edi
    test al, al
    jne CopyLoop

    pop edi
    pop esi
    ret
StringCopy ENDP

ExitProgram:
    mov edx, OFFSET GoodbyeMsg
    call WriteString
    call ExitProcess

main ENDP
END main