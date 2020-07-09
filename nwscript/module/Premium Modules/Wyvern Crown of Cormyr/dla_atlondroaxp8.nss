// April 2004
// B W-Husey
// One of 5 scripts used for scoring The Apprentice slave resolutions on Mondro (axp6 to 9)
// All of them use the same variable for the scoring, so it is the first action the PC takes that
// determines whether they acted in character (succeed or fail, it doesn't matter)

/*
script axp6     Intimidated for money, CN and evil only score.
script axp7     Persuaded for money, All score, or Bluffed for oath (it's a bit mean but also justified)
script axp8     Destroyed the doc, Neutral and evil only score.
script axp9 or dla_allondroj5    Neutral and good only score. Gave the doc or Intimidated/persuaded for oath (evil don't care)
script dla_atlondros10    Gave up, LN & LE do not score as that is too much injustice.
*/

#include "cu_functions"
void main()
{
object oPC = GetPCSpeaker();

if (GetAlignmentGoodEvil(oPC)==ALIGNMENT_GOOD)  AligXP("AligXPSp", oPC, "EVIL", 0, 1);        //Shift/reward any alignment
AligXP("AligXPSp", oPC, "EVIL", 25, 0);        //Shift/reward any alignment

DestroyObject(GetObjectByTag("WitnessDoc"));
//Pick Variable Type and rename
string sName = "AligXPEnd"+GetTag(OBJECT_SELF);

//Give rewards once only
if (GetLocalInt(oPC,sName)<1) //once only
    {
    //Alignment consequences of action
    ScoreAlign(oPC,1,0,0,0,1,1,1,1,1,1);
    AllParty(sName,oPC,1);
    }
}






