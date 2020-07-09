// B W-Husey
// October 2005
// If the PC has Edgar with them, now is the time to set the nMainPlot variable to 3:
// the PC is about to return to Thunderstone with them. Destroy the trigger once it has been used.
// I used a trigger because it makes it easy to fire up and test section 3 of the module without going through all the
// previous sections (i.e. for modularisation)
#include "cu_functions"
//include the library for variable setting command AllParty()

void main()
{
    object oPC = GetEnteringObject();
    if (GetIsDefPC(oPC))
    {
        object oAssoc = GetAssociate(ASSOCIATE_TYPE_HENCHMAN,oPC,1);
        if (GetIsObjectValid(oAssoc)) // don't bother continuing if no henchmen
        {
        if (GetTag(oAssoc)!="Edgar") oAssoc = GetAssociate(ASSOCIATE_TYPE_HENCHMAN,oPC,2);
        if (GetTag(oAssoc)!="Edgar") oAssoc = GetAssociate(ASSOCIATE_TYPE_HENCHMAN,oPC,3); //just in case a horse uses a slot
        if (GetTag(oAssoc)!="Edgar") oAssoc = GetAssociate(ASSOCIATE_TYPE_HENCHMAN,oPC,4); //and one for luck!
        if (GetIsObjectValid(oAssoc) && GetTag(oAssoc)=="Edgar") // don't bother continuing if we ended up with no Tag, or the wrong hench
        {
            AllParty("nMainPlot",oPC,3);
            DestroyObject(OBJECT_SELF,0.2);
        }//end of object valid if
        }//end of object valid if (there are 2 of these to stop irrelevant calls)
    }// end of is PC if
}
