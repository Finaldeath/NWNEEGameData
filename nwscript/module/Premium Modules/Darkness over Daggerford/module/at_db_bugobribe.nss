void main()
{
    object oPC=GetPCSpeaker();
    if(GetLevelByClass(CLASS_TYPE_PALADIN,oPC)==0)
    AdjustAlignment(oPC,ALIGNMENT_CHAOTIC,2);
    else
    {
    AdjustAlignment(oPC,ALIGNMENT_CHAOTIC,5);
    SendMessageToPC(oPC,"This is not the paladin's way.");
    }
}
