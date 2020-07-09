#include "cu_cutscenes"
int StartingConditional()
{
    object oPC = GetPCSpeaker();
    ClearForCut(oPC);
    if(GetLocalInt(GetPCSpeaker(),"nPlayingDarts") &&
       GetLocalObject(oPC,"oMyDartOpponent")!=OBJECT_SELF)
    {
        return TRUE;
    }
    return FALSE;
}
