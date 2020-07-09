// B W-Husey
// October 2005
// Use on enter of triggers that bring up detail to add flavour.
#include "cu_functions"

void main()
{
    object oTalk = OBJECT_SELF;
    string sString = "";
    object oPC = GetEnteringObject();
    if (GetLocalInt(oTalk, "nOnce") <1)
    {
        if (GetIsDefPC(oPC)) //Only the PC triggers this
        {
            if (GetTag(OBJECT_SELF) == "PFITalk1") sString = "Though clearly old and uncared for, there are signs that this house has recently been cleared of most of the dust and is in use once more.";
            if (GetTag(OBJECT_SELF) == "TFCTalk1") sString = "Once abandoned, the cellar of this farmhouse smells musty but lived in.";
            if (GetTag(OBJECT_SELF) == "CWTTalker1") sString = "Once probably a store, this musty room has not seen use for ages.";
            if (GetTag(OBJECT_SELF) == "CWCTalker1") sString = "This area is dry and obviously kept sealed when the castle sinks.";
            if (GetTag(OBJECT_SELF) == "CWCTalker2") sString = "The smell of damp and mustiness pervades in this area.";
            if (GetTag(OBJECT_SELF) == "CWCTalker3") sString = "The smell of damp and mustiness pervades in this area.";
            if (GetTag(OBJECT_SELF) == "CWCTalker4") sString = "Judging by the mess, this is a temporary storage area.";
            if (GetTag(OBJECT_SELF) == "CWCTalker5") sString = "This area is sodden, clearly underwater most of the time.";
            if (GetTag(OBJECT_SELF) == "PFULTalker1") sString = "It is much colder on this floor.";
            if (GetTag(OBJECT_SELF) == "PFBTalker1") sString = "The dust on the floor gets thicker as you progress down the corridor...";
            if (GetTag(OBJECT_SELF) == "CWTalker1") sString = "The castle walls are wet and barnacles and seeweed dot the stones. Only the banner above the gate is dry.";
            if (GetTag(OBJECT_SELF) == "CWBTalker1") sString = "The castle basement is wet and flooded in some places.";
            if (GetTag(OBJECT_SELF) == "CWBTalker2") sString = "This section of the castle has obviously collapsed over the years. It looks like attempts are being made to clear it.";
            if (GetTag(OBJECT_SELF) == "CWBTalker3") sString = "The floor is wet and very slippery here.";
            if (GetTag(OBJECT_SELF) == "CWLLTalker1") sString = "There is a strong stench in this enormous room; dragon perhaps, though the dragon is away.";
            if (GetTag(OBJECT_SELF) == "CWLLTalker2") sString = "Above you rotates the enormous crystal, the power of the mythallar.";
            if (GetTag(OBJECT_SELF) == "CWLLTalker3") sString = "Despite the decay elsewhere, this room is clean and well-loved, with books lining the walls.";
            if (GetTag(OBJECT_SELF) == "CWBCTalker1") sString = "A heavy, musty smell, like moldy bread, fills the air.";
            if (GetTag(OBJECT_SELF) == "LWCTalker1") sString = "The floor of this cave is wet and slimey.";
            if (GetTag(OBJECT_SELF) == "TFSTalker1") sString = "The air is very hot here.";
            if (GetTag(OBJECT_SELF) == "OTRCTalker1") sString = "This looks like a temporary encampment.";
            if (GetTag(OBJECT_SELF) == "OTRCTalker2") sString = "The ground has become marshy, and the air smells.";
            if (GetTag(OBJECT_SELF) == "TFETalker1") sString = "If you leave this area, you will not be able to find your way back.";
            if (GetTag(OBJECT_SELF) == "PFUTalker1") sString = "The darkness thickens... whatever lives here likes the dark.";
            if (GetTag(OBJECT_SELF) == "LWSTalker1") sString = "There is barely a mist on the lake... perhaps you should return later?";
            AssignCommand(oPC,SpeakString(sString));
            SetLocalInt(oTalk, "nOnce",1);
        }
    }
}
