//::///////////////////////////////////////////////
//:: FileName sc_ac_lizardcut
//:: Checks to see if Lizardman cut-scene occurred in Gillian's Hill.
//:://////////////////////////////////////////////
//:: Created By: Alan Tarrant
//:: Created On: 4/30/2006 6:52:14 PM
//:://////////////////////////////////////////////
int StartingConditional()
{
    if(!(GetLocalInt(GetArea(OBJECT_SELF),"nCut2Played")==1))
    return FALSE;
    return TRUE;
}
