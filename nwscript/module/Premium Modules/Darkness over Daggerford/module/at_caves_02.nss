void AdvanceTime(object oPC)
{
    SetTime(GetTimeHour()+d3(), GetTimeMinute(), GetTimeSecond(), GetTimeMillisecond());
    FadeFromBlack(oPC);
}

void main()
{
    object oPC = GetPCSpeaker();
    FadeToBlack(oPC);
    DelayCommand(2.0, AdvanceTime(oPC));
}
