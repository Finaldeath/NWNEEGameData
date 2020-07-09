// February 2006
// B W-Husey
// Give the PC back his henchmen (removed so they don't interfere with cutscene)

#include "cu_functions"
void main()
{
    object oPC = GetPCSpeaker();
    object oJonas = GetNearestObjectByTag("Jonas");
    object oGodfroy = OBJECT_SELF;
    SetDidQuit(oPC, oJonas, FALSE);
    SetDidQuit(oPC, oGodfroy, FALSE);

    //**********debug lines*********
//    if (GetIsObjectValid(oGodfroy)) SendMessageToPC(oPC,"Godfroy found");
//    else  SendMessageToPC(oPC,"Can't find Godfroy");
//    FloatingTextStringOnCreature("I AM GODFROY",oGodfroy);
//    FloatingTextStringOnCreature("Yes I found you GODFROY",GetNearestObjectByTag("Godfroy"));

//    ExecuteScript("dla_athenchjoin",oJonas);
//    ExecuteScript("dla_athenchjoin",oGodfroy);
/* Syrsnein - no need to use the DLA henchmen function at this time
    DLA_SetHenchman(oGodfroy, oPC); //Don't seem to be able to trust this function
    DLA_SetHenchman(oJonas, oPC); //Don't seem to be able to trust this function
*/
    AddHenchman(oPC, oGodfroy);
    AddHenchman(oPC, oJonas);
    LevelUpHenchman(oGodfroy);
    LevelUpHenchman(oJonas);
}



