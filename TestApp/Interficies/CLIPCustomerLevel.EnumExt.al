enumextension 50140 "CLIP CLIP Customer Level" extends "CLIP Customer Level"
{
    value(50140; "CLIP Gold")
    {
        Caption = 'Gold', comment = 'ESP="Oro"';
        Implementation = "CLIP Customer Level" = "CLIP Gold Customer Level Ext";
    }
}