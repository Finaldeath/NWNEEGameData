void main()
{
    //Prevent possessed familiars from activating them.
    object oUser = GetLastUsedBy();
    if (GetIsPossessedFamiliar(oUser) == TRUE)
    {
        string sMessage = "You'd best not touch anything until your master arrives.";
        FloatingTextStringOnCreature(sMessage, oUser);
    }
    else if (GetIsPC(oUser) == TRUE)
    {
        ActionStartConversation(oUser);
    }
}
