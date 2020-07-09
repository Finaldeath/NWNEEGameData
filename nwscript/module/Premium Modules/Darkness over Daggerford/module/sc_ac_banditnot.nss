//::///////////////////////////////////////////////
//:: FileName sc_ac_banditnot
//:: Checks to see if PC has the bandit note.
//:://////////////////////////////////////////////
//:: Created By: Alan Tarrant
//:: Created On: 12/11/2005 6:52:14 PM
//:://////////////////////////////////////////////
int StartingConditional()
{
    if(!(GetLocalInt(GetPCSpeaker(),"ac_banditnote")==1))
    return FALSE;
    return TRUE;
}
