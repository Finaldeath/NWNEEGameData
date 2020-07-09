void main()
{
FadeToBlack(GetPCSpeaker());
SetTime(8,0,0,0);
DelayCommand(1.0,FadeFromBlack(GetPCSpeaker()));
}
