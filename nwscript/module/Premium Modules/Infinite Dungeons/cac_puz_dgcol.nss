//::////////////////////////////////////////////////////////////////////////////
//:: cac_puz_dgcol
//:: Copyright (c) 2005 Bioware Corp.
//::////////////////////////////////////////////////////////////////////////////
/*
    Action taken in conversation with the arrow placeables in the direction
    grid placeable when the column should be rotated.
*/
//::////////////////////////////////////////////////////////////////////////////
//:: Created By: Grant Mackay
//:: Created On: July 27, 2005
//::////////////////////////////////////////////////////////////////////////////

#include "inc_puz_drctngrd"

void main()
{
    object oInteract = OBJECT_SELF;

    RotateSection(oInteract, N_COL);
}
