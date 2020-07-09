void main()
{
    object oPC = GetPCSpeaker();
    object oSkin=GetItemPossessedBy(oPC,"x3_it_pchide");
    if(GetIsObjectValid(oSkin))
    {
        SendMessageToPC(oPC,"Valid skin " + IntToString(GetDroppableFlag(oSkin)));
    }
}
