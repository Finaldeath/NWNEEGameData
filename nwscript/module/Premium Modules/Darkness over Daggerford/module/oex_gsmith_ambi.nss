//start making weapons
void main()
{
    object oPC=GetExitingObject();
    if(GetIsPC(oPC))
    {
        object oDerval = GetObjectByTag("bw_smith");
        SetLocalInt(oDerval,"iWorking",0);
    }
}
