void main()
{
object oPC=GetPCSpeaker();
FadeToBlack(oPC);
DelayCommand(1.0,FadeFromBlack(oPC));
}
