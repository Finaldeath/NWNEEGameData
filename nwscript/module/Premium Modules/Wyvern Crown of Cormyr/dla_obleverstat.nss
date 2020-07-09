// November 2005
// B W-Husey
// Statue gives the same message as the others unless the lever is found.

void main()
{
    object oPC = GetLastUsedBy();
    if (GetLocalInt(oPC,"nSpy")>2) //you can use the lever either: having spotted it, or finished the quest (unlikely to check again)
    {
        ActionStartConversation(oPC,"secretstat");
    }
    else
    {
        string sMessage = GetLocalString (OBJECT_SELF,"A heavy, immobile statue");
        FloatingTextStringOnCreature(sMessage,oPC, FALSE);
    }
}
