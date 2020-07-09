// February 2006
// B W-Husey
// Set nLady to 3, Lacinda's horse returned, remove favour, give xp.

//Modified Gale 28 April 2006: Returns the horse on party that is owned by lacinda.
//used on quest where PC borrows her horse.
//If it's currently being mounted by someone, returns the creature mounting it.
//Returns OBJECT_INVALID if not found.

#include "cu_functions"
#include "dla_i0_lacinda"





void main()
{
    object oPC = GetPCSpeaker();
    object oLacinda = OBJECT_SELF;

    //Pick Variable Type and rename

    string sName = "Ladyj20"+GetTag(oLacinda);   //Unique tag

    LacDebug("dla_atwangh3()");

    //Give rewards once only
    if (GetLocalInt(oPC,sName)<1) //once only
    {

        //First, set the once only variable for this conversation node.
        string sName = "Var1"+GetTag(oLacinda);      //Set variable to object's tag + extra bit
        AllParty(sName,oPC,TRUE);
        sName = "Var11"+GetTag(oLacinda);      //Set variable to object's tag + extra bit
        AllParty(sName,oPC,TRUE);

        object oItem = GetObjectByTag("LadysFavor");

        //Remove horse
        //DLA_ReturnLacindasHorse(oPC, oLacinda);
        DLA_GiveLacindasHorse(oPC);

        // Remove from the player the favour
        SetPlotFlag(oItem,FALSE);
        DestroyObject(oItem);

        //Alignment consequences of action
        AligXP("AligXPFav1", oPC, "GOOD", 50, 0);        //Shift/reward any alignment

        //XP reward (non-alignment based) - quest, skill, class, ability use
    //    GiveXPToCreature (GetPCSpeaker(), 50);
    //    FloatingTextStringOnCreature("XP Gained - use of skill",GetPCSpeaker());

        //Set variable for PC or partywide
        AllParty("nLady",oPC,3);          //update the quest variable
        PartyGotEntry(sName,oPC,250,"XP Gain - gained honor for a Lady");  //This comes with XP & message + sets the variable
        AddJournalQuestEntry("QLady",20,oPC,TRUE);                      //Update the journal
    }

}


