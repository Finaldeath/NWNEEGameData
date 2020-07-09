// January 2006
// B W-Husey
// PC sees their father's grave has been vandalised. Only triggers if PC has not
// already been told about it.
#include "cu_functions"
void main()
{
    object oPC = GetEnteringObject();
    if (GetIsDefPC(oPC))
    {
        if (GetLocalInt(oPC,"nNoGrave")==1 && GetLocalInt(oPC,"nGrave")==4)
        {
            AddJournalQuestEntry("Grave",40,oPC);
            FloatingTextStringOnCreature("Your father's grave has been vandalized",oPC);
            AllParty("nGrave",oPC,5);
            DestroyObject(OBJECT_SELF);
        }
    }
}
