//Determine whether Lyressa's background explanation dialog should appear
//dependent on state of Dragoth the Bone Mage quest
int StartingConditional()
{
    object oPC = GetPCSpeaker();

    if(GetLocalInt(oPC, "NW_JOURNAL_ENTRYDragothTheBoneMage") <= 20)
    {
        return TRUE;
    }
    else
    {
        return FALSE;
    }
}
