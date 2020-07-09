#include "hf_in_xp"
void main()
{
    //wrap up the metastakixx quest
    //open the door!
    object oDoor = GetObjectByTag("metadoor");
    SetLocked(oDoor, FALSE);
    //player receives a reward
    //this is the non bard reward
    object oPC=GetPCSpeaker();
    CreateItemOnObject("db_mistcape", oPC, 1);
    GiveQuestXPToCreature(oPC, "j35", 100.0);
    SetLocalInt(GetModule(),"meta_quest",3);
}
