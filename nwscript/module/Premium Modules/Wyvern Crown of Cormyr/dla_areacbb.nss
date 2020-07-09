//April 2006 - Crown Barrow: Battlefield area enter script
// B W-Husey
// Sets the main plot variable to 8.
// Is a check for parachute testing.

#include "cu_functions"

void private_FixKathryn(object oPC)
{ // PURPOSE: To fix faction issues with Kathryn in this area
  // Scripter: Deva B. Winblood    8/9/2006
  object oKat=GetNearestObjectByTag("Kathryn",oPC);
  object oEnemy;
  int nN;
  object oDefender=GetObjectByTag("cr_deffact");
  int bReset=FALSE;

  if (GetIsObjectValid(oKat))
  { // Kathryn is in this area
      nN=1;
      oEnemy=GetNearestCreature(CREATURE_TYPE_IS_ALIVE,TRUE,oKat,nN,CREATURE_TYPE_REPUTATION,REPUTATION_TYPE_ENEMY);
      while(GetIsObjectValid(oEnemy))
      { // check for defender faction enemies
          if (GetFactionEqual(oEnemy,oDefender))
          { // this is a defender and should not be hostile
              bReset=TRUE;
              AssignCommand(oEnemy,ClearAllActions(TRUE));
              SetIsTemporaryFriend(oEnemy,oKat);
              SetIsTemporaryFriend(oKat,oEnemy);
              AdjustReputation(oKat,oEnemy,100);
          } // this is a defender and should not be hostile
          nN++;
          oEnemy=GetNearestCreature(CREATURE_TYPE_IS_ALIVE,TRUE,oKat,nN,CREATURE_TYPE_REPUTATION,REPUTATION_TYPE_ENEMY);
      } // check for defender faction enemies
      if (bReset) AssignCommand(oKat,ClearAllActions(TRUE));
  } // Kathryn is in this area

} // private_FixKathryn()


void main()
{
object oPC = GetEnteringObject();

if (GetIsDefPC(oPC)==FALSE) return; //only interested in PCs

private_FixKathryn(oPC);

//Pick Variable Type and rename
string sName = "nMainPlot";

//Give rewards once only
if (GetLocalInt(oPC,sName)<8) //once only
    {
    // Give the speaker the items

    //XP reward (non-alignment based) - quest, skill, class, ability use
    //Set variable for PC or partywide
    AllParty("nMainPlot",oPC,8);
//    AddJournalQuestEntry("MainPlot",30,oPC,TRUE);
//    PartyGotEntry(sName,oPC,500, "XP gain - plot furthered");  //Reward whole party, tell all party members what XP is for, and set the variable so the XP cannot be gained again.
    }


}







