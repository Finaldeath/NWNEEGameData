void main()
{
    object oPC = GetPCSpeaker();

    FadeToBlack(oPC);
    DelayCommand(2.0, FadeFromBlack(oPC));
}
