#include "hf_in_xp"
void main()
{
    //wrap up the metastakixx quest
    //open the door!
    object oDoor = GetObjectByTag("metadoor");
    SetLocked(oDoor, FALSE);
    //player receives a reward
    //this is the bard reward
    object oPC=GetPCSpeaker();
    CreateItemOnObject("db_metabard", oPC, 1);
    GiveQuestXPToCreature(oPC, "j35", 100.0);
    SetLocalInt(oPC, "meta_end_bard", 1);
    SetLocalInt(GetModule(),"meta_quest",3);
}
