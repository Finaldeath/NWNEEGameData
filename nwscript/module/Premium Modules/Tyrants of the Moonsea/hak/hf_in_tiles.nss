// decide if a tile is valid
int TileGetIsTileValid(object oArea, int nColumn, int nRow)
{
    vector vTile = Vector(IntToFloat(nColumn), IntToFloat(nRow));
    location lTile = Location(oArea, vTile, 0.0);
    if (GetTileMainLight1Color(lTile) == 517)
    {
        return FALSE;
    }
    return TRUE;
}

// return the width of an area (max area size is 16x16)
int TileGetAreaWidth(object oArea = OBJECT_SELF)
{
    int n;
    for(n = 0; n < 16; n++)
    {
        if (TileGetIsTileValid(oArea, n, 0) == FALSE)
        {
            return n;
        }
    }
    return 16;
}

// return the height of an area (max area size is 16x16)
int TileGetAreaHeight(object oArea = OBJECT_SELF)
{
    int n;
    for(n = 0; n < 16; n++)
    {
        if (TileGetIsTileValid(oArea, 0, n) == FALSE)
        {
            return n;
        }
    }
    return 16;
}

// return the tile column of an object
int TileGetColumn(object oMarker)
{
    vector v = GetPosition(oMarker);
    return FloatToInt(v.x) / 10;
}

// return the tile row of an object
int TileGetRow(object oMarker)
{
    vector v = GetPosition(oMarker);
    return FloatToInt(v.y) / 10;
}

// draw a tile at the specified coordinates
void TileDraw(object oArea, int nTile, int nRow, int nCol, float fZ)
{
    float fX = 10.0 * nCol + 5.0;
    float fY = 10.0 * nRow + 5.0;
    location lLoc = Location(oArea, Vector(fX, fY, fZ), 0.0);
    object oTile = CreateObject(OBJECT_TYPE_PLACEABLE, "plc_invisobj", lLoc, FALSE, "x2_tmp_tile");
    effect eTile = EffectVisualEffect(nTile);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eTile, oTile);
    SetPlotFlag(oTile, TRUE);
}

// convet an object to a tile
void TileConvert(object oMarker = OBJECT_SELF)
{
    int nRow = TileGetRow(oMarker);
    int nCol = TileGetColumn(oMarker);
    object oArea = GetArea(oMarker);
    int nTile = GetLocalInt(oMarker, "HF_TILE_TYPE");
    float fPos = GetLocalFloat(oMarker, "HF_TILE_Z");
    TileDraw(oArea, nTile, nRow, nCol, fPos);
    SetPlotFlag(oMarker, FALSE);
    DestroyObject(oMarker, 0.3);
}

/*
Dungeon Lava               = 350
Grass Floor                = 402
Cave Floor                 = 406
Ice Floor                  = 426
Water 1                    = 401
Water 2                    = 437
Sewer Water                = 461
Underdark Floor            = 506

City; Gazebo               = 457
City; House, lg            = 449
City; House, sm            = 438
City; Marble arch          = 347
City; Market               = 432
City; Market               = 455
City; Wall, rubble         = 433
City; House, ruins         = 451
City; Arch, ruins          = 452
City; Burned, ruins        = 450
City; Burned, ruins        = 454
City; Wagon                = 458
Interior; kitchen lamp     = 436
Rural; Caravan             = 439
Rural; Graves              = 440
Rural; Ant hill            = 404
Rural; Crystal             = 405
Ice; bump/lump             = 442
Ice; castle wall west      = 443
Ilithid; pillar            = 427
Ilithid; transporter       = 429
Dungeon; lave fountain     = 349
Underdark; waterfall west  = 428
Caves; Pile of dirt        = 434
Caves; stone column        = 435
*/

// void main(){}
