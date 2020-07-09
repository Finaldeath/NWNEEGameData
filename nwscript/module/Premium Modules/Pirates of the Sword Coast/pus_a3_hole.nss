//::///////////////////////////////////////////////
//:: pus_a3_hole
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    The player has plugged a hole in the ship.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith Hayward
//:: Created On: January 2005
//:://////////////////////////////////////////////

const string S_WATERTOOHIGH = "The water's too high to make repairs. You'll have to pump it out.";
const string S_PLUGHOLE = "You hammer the repair planking into place, patching the hole.";
const string S_INSTRUCT_01 = "You need repair planking to patch this hole!";
const string S_INSTRUCT_02 = "Check the storeroom for supplies...";

const string S_SAHAUGIN_FLEE = "They've repaired the ship, glub glub! We must escape!";

void main()
{
    object oPC = GetLastUsedBy();
    object oSmallHole = OBJECT_SELF;
    object oArea = GetArea(oSmallHole);
    object oBoard = GetItemPossessedBy(oPC, "a3_wdnbrds");
    object oWPLadder = GetWaypointByTag("A3_SEIGELADDER_SWPN");
    object oCursor;

    object oWPShgn1 = GetObjectByTag("A3_SEIGESAHAUGIN1");
    object oWPShgn2 = GetObjectByTag("A3_SEIGESAHAUGIN2");
    object oWPShgn3 = GetObjectByTag("A3_SEIGESAHAUGIN3");

    vector vPosition = GetPosition(oSmallHole);
    location lTarg;
    float fOrientation = GetFacing(oSmallHole);
    float fDelay = 0.0f;
    effect eShgnFlee = EffectDisappear();

    int iHoles = GetLocalInt(oArea, "A3_WATERHOLES") + 1;
    int iWater = GetLocalInt(oArea, "A3_WATERLEVEL");
    int iDoOnce = GetLocalInt(oSmallHole, "pus_a3_hole");
    int iCounter = 0;

    vPosition.z = -0.80f;
    lTarg = Location(oArea, vPosition, fOrientation);

    // Does the player have a board to block the hole?
    if (GetIsObjectValid(oBoard) == TRUE)
    {
        if (iDoOnce == FALSE)
        {
            if (iWater > 60)
            {
                // ship is more then half full.
                FloatingTextStringOnCreature(S_WATERTOOHIGH, oPC);
            }
            else
            {
                SetLocalInt(oSmallHole, "pus_a3_hole", TRUE);
                DestroyObject(oBoard);
                CreateObject(OBJECT_TYPE_PLACEABLE, "a3_holeplug", lTarg);


                PlaySound("as_cv_hammering1");
                AssignCommand(oPC, PlayAnimation(ANIMATION_LOOPING_GET_LOW, 1.0f, 5.0f));
                AssignCommand(oArea, DelayCommand(0.1f, SetCommandable(FALSE, oPC)));
                AssignCommand(oArea, DelayCommand(5.1f, SetCommandable(TRUE, oPC)));

                FloatingTextStringOnCreature(S_PLUGHOLE, oPC);
                SetLocalInt(oArea, "A3_WATERHOLES", iHoles);

                if (iHoles >= 4)
                {
                    SetLocalInt(oArea, "A3_SEIGE_FISH", 25);
                    SetLocalInt(oArea, "A3_WATERLEVEL", 0);

                    // create the boss fish
                    ExecuteScript("exe_a3_seige50", oPC);

                    iCounter = 0;
                    oCursor = GetObjectByTag("a3_seigefish", iCounter);
                    while (GetIsObjectValid(oCursor) == TRUE)
                    {
                        fDelay = IntToFloat(iCounter);
                        DelayCommand(fDelay + 2.0f, AssignCommand(oCursor,
                            SpeakString(S_SAHAUGIN_FLEE)));
                        DelayCommand(fDelay + 4.5f, AssignCommand(oCursor,
                            ClearAllActions(TRUE)));
                        DelayCommand(fDelay + 5.0f, ApplyEffectToObject(
                            DURATION_TYPE_PERMANENT, eShgnFlee, oCursor));

                        iCounter++;
                        oCursor = GetObjectByTag("a3_seigefish", iCounter);
                    }

                    CreateObject(OBJECT_TYPE_PLACEABLE, "a3_escape",
                        GetLocation(oWPLadder), FALSE, "a3_seigeladder");

                    //ExecuteScript("exe_a3_seige40", oPC);
                }

                DestroyObject(oSmallHole, 0.5f);
            }
        }
    }
    else
    {
        FloatingTextStringOnCreature(S_INSTRUCT_01, oPC);
        FloatingTextStringOnCreature(S_INSTRUCT_02, oPC);
    }
}
