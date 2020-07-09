//::///////////////////////////////////////////////
//:: FileName con_ac_mabdatele
//:: Teleport player, associates, and Callaway to Mabda
//:://////////////////////////////////////////////
//:: Created By: Anya Clancy
//:: Created On: 11/13/2005 11:59:20 PM
//:://////////////////////////////////////////////

void ahcJumpAssociateToLocation(object oPC)
{
    object oAnimal = GetAssociate(ASSOCIATE_TYPE_ANIMALCOMPANION, oPC);
    object oDominated = GetAssociate(ASSOCIATE_TYPE_DOMINATED, oPC);
    object oFamiliar = GetAssociate(ASSOCIATE_TYPE_FAMILIAR, oPC);
    object oSummoned = GetAssociate(ASSOCIATE_TYPE_SUMMONED, oPC);
    if(oAnimal != OBJECT_INVALID)
    {
        AssignCommand(oAnimal, ClearAllActions());
        AssignCommand(oAnimal, ActionJumpToLocation(GetLocation(oPC)));
    }
    if(oDominated != OBJECT_INVALID)
    {
        AssignCommand(oDominated, ClearAllActions());
        AssignCommand(oDominated, ActionJumpToLocation(GetLocation(oPC)));
    }
    if(oFamiliar != OBJECT_INVALID)
    {
        AssignCommand(oFamiliar, ClearAllActions());
        AssignCommand(oFamiliar, ActionJumpToLocation(GetLocation(oPC)));
    }
    if(oSummoned != OBJECT_INVALID)
    {
        AssignCommand(oSummoned, ClearAllActions());
        AssignCommand(oSummoned, ActionJumpToLocation(GetLocation(oPC)));
    }
        int i = 1;
    object oHench = GetHenchman(oPC, i);
    while(oHench != OBJECT_INVALID)
    {
        AssignCommand(oHench, ClearAllActions());
        AssignCommand(oHench, ActionJumpToLocation(GetLocation(oPC)));
        i++;
        oHench = GetHenchman(oPC, i);
    }
}

void main()
{
object oMabdaWP = GetObjectByTag("wp_ac_mabda");
object oPC = GetPCSpeaker();
object oCallawayWP = GetObjectByTag("wp_ac_callaway_tele");
SetLocalInt(OBJECT_SELF, "no_banter", 1);
SetLocalInt(OBJECT_SELF, "no_hb", 1);
FadeToBlack(oPC,FADE_SPEED_FAST);

DelayCommand(1.0,AssignCommand(oPC,ActionJumpToObject(oMabdaWP)));
DelayCommand(1.0,ActionJumpToObject(oCallawayWP));
DelayCommand(1.5,ahcJumpAssociateToLocation(oPC));
DelayCommand(2.0, ActionDoCommand(SetFacingPoint(GetPosition(oPC))));
DelayCommand(4.0,FadeFromBlack(oPC));
DestroyObject(GetObjectByTag("ac_mabda_bar2"));
DestroyObject(GetObjectByTag("ac_mabda_bar1"));
DestroyObject(GetObjectByTag("ac_tree1"));
DestroyObject(GetObjectByTag("ac_tree2"));
DestroyObject(GetObjectByTag("ac_tree3"));
}
