// February 2006
// B W-Husey
// Play battle music
#include "cu_functions"
void main()
{
    object oPC = GetEnteringObject();
    if (GetIsDefPC(oPC) && GetLocalInt(OBJECT_SELF,"nDone")<1)
    {
    MusicBattlePlay(GetArea(oPC));
    DelayCommand(90.0,MusicBackgroundPlay(GetArea(oPC)));
    SetLocalInt(OBJECT_SELF,"nDone",1);
    DestroyObject(OBJECT_SELF,90.1);
    }
}
