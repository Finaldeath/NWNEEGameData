// joe the farmer rewards the player for dealing with Loru the Slaad

void main()
{
    object oPC = GetFirstPC();
    GiveGoldToCreature(oPC, 50);
    SetLocalInt(OBJECT_SELF, "HF_ARG", 1);
}
