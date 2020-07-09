// this bookcase contains the illefarn book; make a note that the player
// .. has seen the illefarn book

void main()
{
    object oPC = GetLastOpenedBy();
    if (GetIsPC(oPC))
    {
        object oMod = GetModule();
        if (GetLocalInt(oMod, "knows_illefarn") == 0)
        {
            SetLocalInt(oMod, "knows_illefarn", 1);
        }
    }
}
