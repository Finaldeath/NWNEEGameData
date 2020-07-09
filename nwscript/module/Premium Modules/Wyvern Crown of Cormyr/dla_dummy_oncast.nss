void main()
{
    object oUser = GetLastSpellCaster();
    if(!GetLocalInt(oUser,"nDummyContestActive"))
    {
        return;
    }
    AssignCommand(oUser,ClearAllActions(TRUE));
    SetLocalInt(oUser,"nDummyDQ",TRUE);
}
