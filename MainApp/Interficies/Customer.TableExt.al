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
                UnknownLevelErr: Label 'Unknown Level %1', Comment = 'ESP="Nivel desconocido %1"';
                Handled: Boolean;
            begin
                case Rec."CLIP Level" of
                    "CLIP Customer Level"::" ":
                        Rec.Validate("CLIP Discount", 0);
                    "CLIP Customer Level"::Bronze:
                        Rec.Validate("CLIP Discount", 5);
                    "CLIP Customer Level"::Silver:
                        Rec.Validate("CLIP Discount", 10);
                    else begin
                        CLIPOnValidateCustomerLevelOnBeforeUnknownLevelError(Rec, Handled);
                        if not Handled then
                            Error(UnknownLevelErr, Rec."CLIP Level");
                    end;
                end;
            end;
        }
    }

    [IntegrationEvent(false, false)]
    local procedure CLIPOnValidateCustomerLevelOnBeforeUnknownLevelError(var Customer: Record Customer; var Handled: Boolean)
    begin
    end;
}