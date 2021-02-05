VERSION 5.00
Object = "{648A5603-2C6E-101B-82B6-000000000014}#1.1#0"; "mscomm32.ocx"
Begin VB.Form frmMain 
   Caption         =   "Form1"
   ClientHeight    =   9165
   ClientLeft      =   60
   ClientTop       =   405
   ClientWidth     =   9030
   LinkTopic       =   "Form1"
   ScaleHeight     =   9165
   ScaleWidth      =   9030
   StartUpPosition =   3  'Windows Default
   Begin VB.Timer Timer1 
      Interval        =   500
      Left            =   2760
      Top             =   840
   End
   Begin MSCommLib.MSComm MSComm1 
      Left            =   2760
      Top             =   120
      _ExtentX        =   1005
      _ExtentY        =   1005
      _Version        =   393216
      DTREnable       =   -1  'True
   End
   Begin VB.Label Label3 
      BorderStyle     =   1  'Fixed Single
      Caption         =   "Invert"
      Height          =   2295
      Left            =   120
      TabIndex        =   2
      Top             =   6000
      Width           =   8655
   End
   Begin VB.Label Label2 
      BorderStyle     =   1  'Fixed Single
      Caption         =   "Near"
      Height          =   2415
      Left            =   120
      TabIndex        =   1
      Top             =   3360
      Width           =   8535
   End
   Begin VB.Label Label1 
      BorderStyle     =   1  'Fixed Single
      Caption         =   "True"
      Height          =   3015
      Left            =   120
      TabIndex        =   0
      Top             =   120
      Width           =   8535
   End
End
Attribute VB_Name = "frmMain"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Public str, colCode, R, G, B As String
Public lPos As Integer

Private Sub Form_Load()
    On Error Resume Next
    With MSComm1
        .RThreshold = 3
        .Settings = "9600,n,8,1"
        .CommPort = 4
        .PortOpen = True
        .DTREnable = False
    End With
    lPos = 1
    colCode = ""
End Sub

Private Sub Timer1_Timer()
    Label1.Caption = ""
    str = MSComm1.Input
    
    If Not str = "" Then
        For i = 1 To Len(str)
            If Mid(str, i, 1) = "#" Then
                getCode (i)
            Else
               colCode = colCode & Mid(str, i, 1)
            End If
        Next i
    End If
    
    If R = "" Then R = 0
    If G = "" Then G = 0
    If B = "" Then B = 0
    
    'Me.Caption = R & "," & G & "," & B
    Label1.BackColor = RGB(R, G, B)
    Label3.BackColor = RGB(B, G, R)
    
    If R > B And R > G Then Label2.BackColor = RGB(R, 0, 0)
    If G > B And G > R Then Label2.BackColor = RGB(0, G, 0)
    If B > R And B > G Then Label2.BackColor = RGB(0, 0, B)
End Sub

Private Function getCode(chrPos As Integer)
    Select Case lPos
        Case 1
            R = colCode
            lPos = lPos + 1
        Case 2
            G = colCode
            lPos = lPos + 1
        Case 3
            B = colCode
            lPos = 1
    End Select
    colCode = ""
End Function
