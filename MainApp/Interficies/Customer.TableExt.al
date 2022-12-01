tableextension 50106 "CLIP Customer" extends Customer
{
    fields
    {
        field(50100; "CLIP Discount"; Decimal)
        {
            Caption = 'Discount', comment = 'ESP="Descuento"';
            DataClassification = CustomerContent;
        }
        field(50101; "CLIP Level"; Enum "CLIP Customer Level")
        {
            Caption = 'Customer Level', comment = 'ESP="Nivel cliente"';
            DataClassification = CustomerContent;

            trigger OnValidate()
            var
                CustomerLevel: Interface "CLIP Customer Level";
            begin
                CustomerLevel := Rec."CLIP Level";
                Rec.Validate("CLIP Discount", CustomerLevel.GetDiscount());
            end;
        }
    }
}