string MakeTextRed(string sText);
string MakeTextGreen(string sText);
string MakeTextYellow(string sText);
string MakeTextOrange(string sText);
string AddLineBreak(string sText);

string MakeTextRed(string sText)
{
    return "<c�  >" + sText + "</c>";
}

string MakeTextGreen(string sText)
{
    return "<c � >" + sText + "</c>";
}

string MakeTextYellow(string sText)
{
    return "<c�� >" + sText + "</c>";
}

string MakeTextOrange(string sText)
{
    return "<c�d >" + sText + "</c>";
}

string AddLineBreak(string sText)
{
    return sText + "\n";
}

//void main(){}

