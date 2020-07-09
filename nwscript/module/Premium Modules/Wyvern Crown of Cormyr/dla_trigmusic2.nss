// February 2006
// B W-Husey
// Change the ambient after defeating the WL
#include "cu_functions"
void main()
{
    object oPC = GetEnteringObject();
    if (GetIsDefPC(oPC))
    {
    MusicBackgroundChangeDay(GetArea(oPC),65);     // Change to rebel camp music
    MusicBackgroundChangeNight(GetArea(oPC),65);     // Change to rebel camp music
    DestroyObject(OBJECT_SELF);
    }
}
