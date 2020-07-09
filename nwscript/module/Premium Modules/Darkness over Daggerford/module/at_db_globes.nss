//SUMMON FRAGMENT OF SHADOW CREATURES WHEN THE MIRROR GLOBES ARE USED
//RUN FROM THEIR CONVERSATIONS RATHER THAN ON USE EVENT

#include "hf_in_spawn"
void main()
{
    //set the machine to disactivated
    SetLocalInt(OBJECT_SELF,"deactivated",1);
    //destroy the relevant mist and light column
    object oMist;
    object oLight;
    if(GetTag(OBJECT_SELF)=="hom_mc1")
    {
        oMist=GetObjectByTag("fog_hom_1");
        oLight=GetObjectByTag("hom_red_1");
    }
    else if(GetTag(OBJECT_SELF)=="hom_mc2")
    {
        oMist=GetObjectByTag("fog_hom_2");
        oLight=GetObjectByTag("hom_red_2");
    }
    else if(GetTag(OBJECT_SELF)=="hom_mc3")
    {
        oMist=GetObjectByTag("fog_hom_3");
        oLight=GetObjectByTag("hom_red_3");
    }
    else if(GetTag(OBJECT_SELF)=="hom_mc4")
    {
        oMist=GetObjectByTag("fog_hom_4");
        oLight=GetObjectByTag("hom_red_4");
    }
    DestroyObject(oMist);
    DestroyObject(oLight);

    //NEW CODE ADDED 1st AUGUST 2006 BY LUSPR
    //safety check in case the death events don't fire properly on the fragments
    //keep track of the number of globes activated
    int nInt;
    nInt = GetLocalInt(GetModule(),"hom_globes_activated");
    nInt += 1;
    SetLocalInt(GetModule(),"hom_globes_activated",nInt);
    //END NEW CODE
    //should now count up to 4

    //the following section deals with the creature spawns **to be improved**
    location lSpawn=GetLocation(GetNearestObjectByTag("db_spawn_hom"));
    //using pj spawn now so no need for tests
    //CreateObject(OBJECT_TYPE_CREATURE,"db_fragment_1",lSpawn);
    //**add more creatures here**
    object oGrunt=CreateObject(OBJECT_TYPE_CREATURE,"db_fragment_rev1",lSpawn,TRUE);
    object oMage=CreateObject(OBJECT_TYPE_CREATURE,"db_fragment_rev2",lSpawn,TRUE);
    object oType;
    object oPC=GetPCSpeaker();
    SpawnLevelupCreature(oGrunt, SpawnGetPartyCR(oPC, 50));
    SpawnLevelupCreature(oMage, SpawnGetPartyCR(oPC, 50));
    //variable extra boss per group
    if(GetTag(OBJECT_SELF)=="hom_mc1")
    {
        object oType=CreateObject(OBJECT_TYPE_CREATURE,"db_fragment_rev3",lSpawn,TRUE);
    }
    else if(GetTag(OBJECT_SELF)=="hom_mc2")
    {
        object oType=CreateObject(OBJECT_TYPE_CREATURE,"db_fragment_rev4",lSpawn,TRUE);
    }
    else if(GetTag(OBJECT_SELF)=="hom_mc3")
    {
        object oType=CreateObject(OBJECT_TYPE_CREATURE,"db_fragment_rev5",lSpawn,TRUE);
    }
    else if(GetTag(OBJECT_SELF)=="hom_mc4")
    {
        object oType=CreateObject(OBJECT_TYPE_CREATURE,"db_fragment_rev6",lSpawn,TRUE);
    }
    SpawnLevelupCreature(oType, SpawnGetPartyCR(oPC, 40));
}
