// B W-Husey
// October 2005
// Use on enter of triggers that bring up detail to add flavour.
#include "cu_functions"

void main()
{
    object oTalker = GetNearestObjectByTag("Stallholder");
    string sString = "";
    object oPC = GetEnteringObject();
        if (GetIsDefPC(oPC)) //Only the PC triggers this
        {
            if (GetTag(OBJECT_SELF) == "TTGOneLine1") sString = "Best goods available here!";
            if (GetTag(OBJECT_SELF) == "TTGOneLine2") sString = "Come see my lovely apples!";
            if (GetTag(OBJECT_SELF) == "TTGOneLine3") sString = "Bargains here! Get your bargains here!";
            if (GetTag(OBJECT_SELF) == "TTGOneLine4") sString = "Step inside, ladies and gentlemen, for the best entertainment!";
            AssignCommand(oTalker,SpeakString(sString));
        }
}
