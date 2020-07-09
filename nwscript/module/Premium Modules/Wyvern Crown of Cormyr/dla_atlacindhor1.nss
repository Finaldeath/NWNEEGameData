// February 2006
// B W-Husey
// Gives the PC Lacinda's horse and her favour.
// 6/17/2006 - Deva B. Winblood - Made adjustments to counter mantis #1519

#include "dla_i0_lacinda"
#include "cu_functions"
void main()
{
    object oPC = GetPCSpeaker();
    object oHorse = GetObjectByTag("LacHorse");
    object oLacinda = GetObjectByTag("Lacinda");
    LacDebug("dla_atlacidhor1(oHorse:"+GetName(oHorse)+", oLacinda:"+GetName(oLacinda)+")");
    AssignCommand(oLacinda,ActionMoveToObject(oPC,FALSE,0.6));
    AssignCommand(oLacinda,ActionPlayAnimation(ANIMATION_LOOPING_GET_MID,1.0,4.0));
    CreateItemOnObject("ladysfavor",oPC);
    if (!GetIsObjectValid(oHorse))
    { // horse not found - create it
        LacDebug("  Horse not found create it");
        oHorse=CreateObject(OBJECT_TYPE_CREATURE,"dla_hvywarhorse3",GetLocation(oLacinda),FALSE,"LacHorse");
        ChangeToStandardFaction(oHorse,STANDARD_FACTION_COMMONER);
        SetLocalInt(oHorse,"bLacindasOwnedHorse",1);
        SetLocalString(oHorse,"DLA_TAG_HORSE_NPC_OWNER","Lacinda");
        DelayCommand(1.0,AssignCommand(oHorse,ActionForceFollowObject(oPC,2.0)));
    } // horse not found - create it
    else
    { // make sure to move horse here
        LacDebug("  Horse found move it to PC.");
        if (DLA_GetIsTied(oHorse)) DLA_UntieHorse(oHorse);
        AssignCommand(oHorse,ClearAllActions(TRUE));
        AssignCommand(oHorse,JumpToObject(oPC));
        DelayCommand(1.0,AssignCommand(oHorse,ActionForceFollowObject(oPC,2.0)));
    } // make sure to move horse here
    DLA_SetHenchman(oHorse,oPC,TRUE,FALSE);
    DelayCommand(1.0,DLA_GiveLacindasHorse(oPC));
    //Set variable for PC or partywide
    AllParty("nLady",oPC,1);                                    //Just sets variable
    AddJournalQuestEntry("QLady",10,oPC,TRUE);                      //Update the journal

}
