

����һ���򵥵�ʾ������ʼ�ְ�����ʾ�����CE�޸��ڴ�

�����Լ��ȱ�д��һ��ʾ������



![](pic_temp1\http_imgload1.png)

 

�������Ϊ:

 

```visual basic
Dim a As Long
Private Sub Form_Load()  '''��ʼ������
a = 0
End Sub

Private Sub Command1_Click() '''�����Լ�
a = a + 11
End Sub

Private Sub Timer1_Timer() '''Ϊ�����ñ���������ʾ��Ӧ����Ϊ10ms
Label1.Caption = a
End Sub
```





���ˣ�һ���򵥵�ʾ����������������

��ô����ôȥ���ұ����ĵ�ַ�أ�������CE(Cheat Engine)



  ����ʾ�������CE



![](pic_temp1\http_imgload2.png)




Ȼ����CE���ұ������ڴ�

�򿪽���



![](pic_temp1\http_imgload3.png)



��������



![](pic_temp1\http_imgload4.png)



��ͼ�е� First Scan ����

���



![](pic_temp1\http_imgload5.png)



����ô����ڴ��ַ�У�������һ����������Ҫ�ҵ���?

���ǿ���ͨ���鿴�ĸ��ڴ��ַ�е����ݱ��ı���ȷ��������Ҫ�ĵ�ַ

(������Ҫʱ���ϸ��...)

����ҵ��ĵ�ַ��:1C804C

![](pic_temp1\http_imgload6.png)

Ȼ�������������򣬷��ֳ�����ڴ��ַ��û�иı䣬��ô�����һ����̬���ڴ��ַ

![](pic_temp1\http_imgload7.png)

��һ������ʼ�Լ���д��������ȡ���޸��������ı�������

Ϊ�˷��㣬���Ѿ����ȱ�д����һ�����ڴ��VB��,��Ի:ReadMemory

 

```visual basic
Private Declare Function FindWindow Lib "user32" Alias "FindWindowA" (ByVal lpClassName As String, ByVal lpWindowName As String) As Long
Private Declare Function GetWindowThreadProcessId Lib "user32" (ByVal Hwnd As Long, lpdwProcessId As Long) As Long
Private Declare Function CloseHandle Lib "kernel32" (ByVal hObject As Long) As Long
Private Declare Function OpenProcess Lib "kernel32" (ByVal dwDesiredAccess As Long, ByVal bInheritHandle As Long, ByVal dwProcessId As Long) As Long
Private Const PROCESS_ALL_ACCESS = &H1F0FFF 'ȫȨ�򿪽���
Private Declare Function ReadProcessMemory Lib "kernel32" ( _
 ByVal hProcess As Long, _
 ByVal pvAddressRemote As Any, _
 ByVal pvBufferLocal As Any, _
 ByVal dwSize As Long, _
 ByVal pdwNumBytesRead As Long) As Long
Private Declare Function WriteProcessMemory Lib "kernel32" (ByVal hProcess As Long, ByVal lpBaseAddress As Any, ByVal lpBuffer As Long, ByVal nSize As Long, lpNumberOfBytesWritten As Long) As Long

 

Dim ProcToken As Long ''''ָ���Ĵ��ڽ������Ȩ��

Function InitModuleA(ByVal WindowTitle As String) As Boolean
Dim Hwnd As Long
Hwnd = FindWindow(vbNullString, WindowTitle)
If Hwnd > 0 Then
Dim PID As Long
GetWindowThreadProcessId Hwnd, PID
 If InitModuleB(PID) Then
 InitModuleA = True
 Else
 InitModuleA = False
 End If
Else
InitModuleA = False
End If
End Function

Function InitModuleB(ByVal WindowPID As Long) As Boolean
Dim Token As Long
Token = GetMaxPrilivageToProcess(WindowPID)
If Token > 0 Then
ProcToken = Token
InitModuleB = True
Else
InitModuleB = False
End If
End Function

Sub ClearModule()
ProcToken = 0
End Sub

Private Function GetMaxPrilivageToProcess(ByVal ProcessID As Long) As Long
GetMaxPrilivageToProcess = OpenProcess(PROCESS_ALL_ACCESS, False, ProcessID)
End Function

Public Function GetMemory(ByVal MemoryBaseAddr As Long) As Long
Dim GetValue As Long
 ReadProcessMemory ProcToken, MemoryBaseAddr, VarPtr(GetValue), 4, 0
GetMemory = GetValue
End Function

Public Function SetMemory(ByVal MemoryBaseAddr As Long, ByVal Value As Long) As Boolean
If ProcToken > 0 And WriteProcessMemory(ProcToken, MemoryBaseAddr, VarPtr(Value), 4, 0) <> 0 Then
SetMemory = True
Else
SetMemory = False
End If
End Function
```





�򵥵��޸��ڴ湤�ߴ�������:



![](pic_temp1\http_imgload8.png)

 

```visual basic
Private Sub Form_Load()
ReadMemory.InitModuleA "1"
End Sub

Private Sub Command1_Click()
Dim m As Long
m = InputBox("����һ������")
ReadMemory.SetMemory &H1C804C, m
End Sub

Private Sub Timer1_Timer()
Label1.Caption = "��ǰ������: " & ReadMemory.GetMemory(&H1C804C)
End Sub
```



Ч������:


![](pic_temp1\http_imgload9.png)



![](pic_temp1\http_imgload10.png)



���ˣ��Ѿ������������޸��ڴ��С�����ˣ���ô���ȥ���������?��ʵ��������Ҹ��޸��ڴ���

ֻ�������޸��ڴ�ʱ�����ڴ�ƫ�ƶ��ѣ��Ժ��л����ٸ���ҷ���.....

 

